package com.fusion1.controller;

import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.ArticleVO;
import com.fusion1.dao.BoardVO;
import com.fusion1.dao.IndividualVO;
import com.fusion1.dao.MenuVO;
import com.fusion1.dao.MultiBoardVO;
import com.fusion1.dao.PagenationVO;
import com.fusion1.dao.ReadNoticeVO;
import com.fusion1.dao.ReplyVO;
import com.fusion1.dao.UserVO;
import com.fusion1.service.AdminServiceImpl;
import com.fusion1.service.BoardServiceImpl;
import com.fusion1.service.MultiBoardServiceImpl;
import com.fusion1.service.ReplyServiceImpl;
import com.fusion1.service.UserServiceImpl;
import com.nhncorp.lucy.security.xss.XssPreventer;

@Controller
public class MultiBoardController {
	
	@Autowired
	BoardServiceImpl bs;
	
	@Autowired
	MultiBoardServiceImpl ms;
	
	@Autowired
	AdminServiceImpl as;
	
	@RequestMapping(value="/multi/exit.do")
	public String exit() {
		return "multi/exit";
	}
	
	
	// form 테스트를 위한 컨트롤러 메서드. 실제 구동에서는 필요없음.
	@RequestMapping(value="/multi/testForm.do")
	public String testForm(Model model) {
		PagenationVO page = new PagenationVO();
		page.setPageCon(0);
		page.setPageList(10);
		List<BoardVO> boardList = bs.getBoardList(page);
		model.addAttribute("boardList", boardList);
		return "multi/testForm";
	}
	
	@RequestMapping(value="/multi/testFormArticle.do")
	public String testFormArticle(BoardVO boardVO, Model model) {
		int board_no = boardVO.getBoard_no();
		BoardVO thisArticle = bs.getBoardOne(board_no);
		model.addAttribute("article", thisArticle);
		
		return "multi/testFormArticle";
	}
	
	// 신 게시판의 리스트를 불러온다.
	@RequestMapping(value="/multi/boardList.do")
	public String multiBoard(Model model, @RequestParam("board_no") int board_no, PagenationVO page, HttpSession session) {
		
		// 유저 확인
		String currentId = (String)session.getAttribute("userid");
		List<MultiBoardVO> multiList = as.getMultiBoardList();
		model.addAttribute("boardList", multiList);
		
		// 게시판 메인 화면. -1로 넘버를 주었으나 이는 개선이 필요하다.
		// post로 줄 수는 없는지 확인 바람.
		if(board_no == -1) {
			
			MultiBoardVO supertemp = new MultiBoardVO();
			supertemp.setUser_id(currentId);
			
			ReadNoticeVO info = new ReadNoticeVO();
			info.setUser_id(currentId);
			ArticleVO cntOnly = ms.nonReadNoticeArticle(info);
			int nonReadCount = cntOnly.getCnt();
			model.addAttribute("nonReadCount", nonReadCount);
			
			List<ArticleVO> nonReadList = ms.getNonReadNoticeList(supertemp);
			model.addAttribute("nonReadList", nonReadList);
			
			List<MenuVO> menuList = as.getMenuList();
			model.addAttribute("menuList", menuList);
			return "multi/boardList";
		}
		
		// 게시판 정보를 불러왔는데 게시판이 존재하지 않는 경우에 대한 예외처리(null)
		MultiBoardVO thistemp = new MultiBoardVO();
		thistemp.setBoard_no(board_no);
		MultiBoardVO thisboardVO = as.getMultiBoardOne(thistemp);
		if(thisboardVO == null || thisboardVO.equals(null)) {
			model.addAttribute("msg", "해당 게시판은 존재하지 않습니다.");
			model.addAttribute("href", "/multi/boardList.do?board_no=-1&page_no=1&pageSize=10");
			return "alert";
		}
		
		
		MultiBoardVO test = new MultiBoardVO();
		test.setBoard_no(board_no);
		
		// 검색어 및 검색 조건 미지정 상태
		if(page.getKeyword() == null || page.getKeyword().equals("")) {
			//System.out.println("얘 뭐임 : " + page.toString());
			MultiBoardVO temp = new MultiBoardVO();
			temp.setBoard_no(board_no);
			temp.setUser_id(currentId);
			
			// 해당 게시판의 설정 정보를 불러온다.
			// (view에서 jstl을 사용해 댓글, 비밀글, 답글 처리를 하기 위함.)
			MultiBoardVO config = as.getMultiBoardOne(temp);
			model.addAttribute("boardConfig", config);
			
			ReadNoticeVO info = new ReadNoticeVO();
			info.setUser_id(currentId);
			ArticleVO cntOnly = ms.nonReadNoticeArticle(info);
			int nonReadCount = cntOnly.getCnt();
			model.addAttribute("nonReadCount", nonReadCount);
			
			cntOnly = ms.nonReadNoticeArticleThisBoard(temp);
			int nonReadCountThisBoard = cntOnly.getCnt();
			model.addAttribute("nonReadCountThisBoard", nonReadCountThisBoard);
			
			// 해당 게시판의 게시글 총 갯수
			ArticleVO articleCount = ms.getArticleCountByBoardNo(temp);
			int totalCount = articleCount.getCnt();
			int pageSize = page.getPageSize();
			int page_no = page.getPage_no();
			
			int endPage = totalCount / pageSize;
			if (endPage % pageSize > 0) {
				endPage++;
			}
			
			// 페이지네이션
			PagenationVO pageVO = new PagenationVO();
			pageVO.setStartPage(1);
			pageVO.setEndPage(endPage);
			pageVO.setPageList(pageSize);
			pageVO.setPageSize(pageSize);
			pageVO.setTotalCount(totalCount);
			pageVO.setPageCon((page_no*pageSize) - pageSize);
			pageVO.setPageBoardNo((page_no*pageSize));
			pageVO.setBoard_no(board_no);
			
			model.addAttribute("page", pageVO);
			
			List<ArticleVO> articleList = ms.getArticleListByBoardNo2(pageVO);
			model.addAttribute("articleList", articleList);
			
			List<MenuVO> menuList = as.getMenuList();
			model.addAttribute("menuList", menuList);
			
			return "multi/boardList";
		} else  {
			//System.out.println(page.toString());
			
			MultiBoardVO temp = new MultiBoardVO();
			temp.setBoard_no(board_no);
			
			MultiBoardVO config = as.getMultiBoardOne(temp);
			model.addAttribute("boardConfig", config);
			
			ReadNoticeVO info = new ReadNoticeVO();
			info.setUser_id(currentId);
			ArticleVO cntOnly = ms.nonReadNoticeArticle(info);
			int nonReadCount = cntOnly.getCnt();
			model.addAttribute("nonReadCount", nonReadCount);
			
			cntOnly = ms.nonReadNoticeArticleThisBoard(temp);
			int nonReadCountThisBoard = cntOnly.getCnt();
			model.addAttribute("nonReadCountThisBoard", nonReadCountThisBoard);
			
			ArticleVO articleInfo = ms.getArticleSearchCount(page);
			int totalCount = articleInfo.getCnt(); 
			int getPageSize = page.getPageSize();
			int getPage_no = page.getPage_no();
			int searchCon = page.getSearchCon();
			int endPage = totalCount / getPageSize;
			String keyword = page.getKeyword();
			
			if(totalCount % page.getPageSize() > 0) {
				endPage++;
			}
			
			PagenationVO pageSearch = new PagenationVO();
			pageSearch.setStartPage(1);
			pageSearch.setEndPage(endPage);
			pageSearch.setPageList(page.getPageSize());
			pageSearch.setPageSize(getPageSize);
			pageSearch.setBoard_no(board_no);
			
			// 페이지 검색 조건과 검색어, 해당 조건에 맞는 게시글 수를 지정해줌.
			pageSearch.setSearchCon(searchCon);
			pageSearch.setKeyword(keyword);
			pageSearch.setTotalCount(totalCount);
			
			int pageCon = (getPage_no*getPageSize) - getPageSize;
			pageSearch.setPageCon(pageCon);
			
			List<ArticleVO> articleList = ms.getArticleSearchList(pageSearch);
			model.addAttribute("articleList", articleList);
			
			List<MenuVO> menuList = as.getMenuList();
			model.addAttribute("menuList", menuList);
			
			model.addAttribute("page", pageSearch);
			return "multi/boardList";
		}
	}
	
	// 게시글 보기. 비밀글 처리를 위해 url을 2개로 나누었다.
	// 만약 가능하다면 url을 하나로 줄이는 것도 좋을 듯 하다.
	@RequestMapping(value="/multi/board.do", method=RequestMethod.GET)
	public String board(HttpSession session, @RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpServletRequest request) {
		String currentID = (String)session.getAttribute("userid");
		
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			
			MultiBoardVO thisBoard = new MultiBoardVO();
			thisBoard.setBoard_no(board_no);
			
			thisBoard = as.getMultiBoardOne(thisBoard);
			model.addAttribute("boardConfig", thisBoard);
			
			// 해당 글 읽음 처리
			ReadNoticeVO read = new ReadNoticeVO();
			read.setArticle_no(article_no);
			read.setUser_id(currentID);
			ms.writeNoticeInfo(read);
			
			
			// 게시글 정보 불러옴
			ArticleVO article = ms.getArticleOne(article_no);
			
			// 줄바꿈 처리
			String convertedContents = article.getArticle_content();
			convertedContents = XssPreventer.unescape(convertedContents);
			article.setArticle_content(convertedContents);
			
			// 날짜 처리
			
			
			// 비밀글에 대한 처리
			if(article.getArticle_secretyn().equals("Y") || article.getArticle_secretyn() == "Y") {
				
				String encoded = article.getArticle_password();
				byte[] encodedByte = encoded.getBytes();
				
				Decoder decoder = Base64.getDecoder();
				byte[] decodeByte = decoder.decode(encodedByte);
				//System.out.println("디코딩된 것 : " + new String(decodeByte));
				String decoded = new String(decodeByte);
				article.setArticle_password(decoded);
				
				model.addAttribute("article", article);
				model.addAttribute("OrderedUrl", request.getRequestURI());
				UserVO userInfo = us.getUserInfo(currentID);
				model.addAttribute("userInfo", userInfo);
				
				return "/multi/ownerCheck";
			}
			
			// 조회수 up
			ms.articleHitUpdate(article_no);
			
			model.addAttribute("article", article);
			return "/multi/board";
		}
	}
	
	@RequestMapping(value="/multi/articleRead.do", method=RequestMethod.GET)
	public String articleRead(HttpSession session, @RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpServletRequest request) {
		String currentID = (String)session.getAttribute("userid");
		
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			
			MultiBoardVO thisBoard = new MultiBoardVO();
			thisBoard.setBoard_no(board_no);
			
			thisBoard = as.getMultiBoardOne(thisBoard);
			model.addAttribute("boardConfig", thisBoard);
			
			// 게시글 정보 불러옴
			ArticleVO article = ms.getArticleOne(article_no);
			
			// 줄바꿈 처리
			String convertedContents = article.getArticle_content();
			convertedContents = XssPreventer.unescape(convertedContents);
			article.setArticle_content(convertedContents);
			
			// 조회수 up
			ms.articleHitUpdate(article_no);
			
			model.addAttribute("article", article);
			return "/multi/articleRead";
		}
	}
	
	@Autowired
	UserServiceImpl us;
	
	
	// 암호를 읽어보자.
	@RequestMapping(value="/multi/ownerCheck.do", method=RequestMethod.POST)
	public String ownerCheckPost(@RequestParam("inputPassword") String inputPassword, @RequestParam("article_no") int article_no, 
								 @RequestParam("OrderedUrl") String url, Model model, HttpServletRequest request, HttpSession session) {
		//System.out.println("넘어온 패스워드 : " + inputPassword + " 넘어온 아티클넘버 : " + article_no + " 넘어온 url : " + url);
		
		ArticleVO article = ms.getArticleOne(article_no);
		int board_no = article.getBoard_no();
		String encoded = article.getArticle_password();
		byte[] encodedByte = encoded.getBytes();
		
		Decoder decoder = Base64.getDecoder();
		byte[] decodeByte = decoder.decode(encodedByte);
		//System.out.println("디코딩된 것 : " + new String(decodeByte));
		String decoded = new String(decodeByte);
		
		if(inputPassword.equals(decoded)) {
			//System.out.println("비밀번호 일치");
			
			if(url.indexOf("board") != -1) {
				model.addAttribute("article", article);
				return "redirect:/multi/articleRead.do?board_no=" + board_no + "&article_no=" + article_no; 
			}
			
			if(url.indexOf("Edit") != -1) {
				model.addAttribute("article_no", article_no);
				return "redirect:/multi/articleEdit.do?board_no=" + board_no + "&article_no=" + article_no;
			}
			
			if(url.indexOf("Delete") != -1) {
				request.setAttribute("delete_aval", 1);
				return "redirect:/multi/articleDelete.do?board_no=" + board_no + "&article_no=" + article_no;
			}
			
			model.addAttribute("article", article);
			return "/multi/readArticle";
		} else {
			model.addAttribute("msg", "비밀번호가 다릅니다.");
			return "/multi/exit";
		}
	}
	
	@RequestMapping(value="/multi/articleWrite.do", method=RequestMethod.GET)
	public String articleWrite(HttpSession session, Model model, @RequestParam("board_no") int board_no) {
		String currentUser = (String)session.getAttribute("userid");
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			
			MultiBoardVO thistemp = new MultiBoardVO();
			thistemp.setBoard_no(board_no);
			MultiBoardVO thisboardVO = as.getMultiBoardOne(thistemp);
			if(thisboardVO == null || thisboardVO.equals(null)) {
				model.addAttribute("msg", "해당 게시판은 존재하지 않습니다.");
				model.addAttribute("href", "/multi/boardList.do?board_no=-1&page_no=1&pageSize=10");
				return "alert";
			}
			
			MultiBoardVO thisBoard = new MultiBoardVO();
			thisBoard.setBoard_no(board_no);
			
			thisBoard = as.getMultiBoardOne(thisBoard);
			model.addAttribute("boardConfig", thisBoard);
			
			// 게시글 작성 일자 표시를 위해 전달 (다른 방법 있음)
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
			Date currentTime = new Date();
			String date = formatter.format(currentTime);
			model.addAttribute("date", date);
			return "/multi/articleWrite";
		}
	}
	
	@RequestMapping(value="/multi/articleWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public String articleWritePost(ArticleVO article) {
		//System.out.println(article.toString());
		
		if(article.getArticle_secretyn() == null || article.getArticle_secretyn().equals("")) {
			article.setArticle_secretyn("N");
		}
		
		if(article.getArticle_secretyn().equals("Y") || article.getArticle_secretyn() == "Y") {
			String articlePassword = article.getArticle_password();
			byte[] passwordToByte = articlePassword.getBytes();
			Encoder encoder = Base64.getEncoder();
			byte[] encodedBytes = encoder.encode(passwordToByte);
			article.setArticle_password(new String(encodedBytes));
		}
		
		String noTagContent = article.getArticle_content();
		noTagContent = XssPreventer.unescape(noTagContent);
		article.setArticle_content(noTagContent);
		
		int result = ms.articleInsert(article);
		
		ArticleVO temp = ms.getPreventInsertedArticle();
		int parent_no = temp.getArticle_no();
		ms.articleParentsnoUpdate(parent_no);
		
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/multi/articleDeleteCheck.do")
	public String articleDeleteCheck(HttpSession session, @RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpServletRequest request) {
		
		String currentID = (String)session.getAttribute("userid");
		
		ArticleVO article = ms.getArticleOne(article_no);
		
		if(article.getArticle_secretyn().equals("Y") || article.getArticle_secretyn() == "Y") {
			
			// 비밀글 처리
			String encoded = article.getArticle_password();
			byte[] encodedByte = encoded.getBytes();
			
			Decoder decoder = Base64.getDecoder();
			byte[] decodeByte = decoder.decode(encodedByte);
			//System.out.println("디코딩된 것 : " + new String(decodeByte));
			String decoded = new String(decodeByte);
			article.setArticle_password(decoded);
			
			model.addAttribute("article", article);
			model.addAttribute("OrderedUrl", request.getRequestURI());
			UserVO userInfo = us.getUserInfo(currentID);
			model.addAttribute("userInfo", userInfo);
			return "/multi/ownerCheck";
		} else {
			return "redirect:/multi/articleDelete.do?board_no=" + board_no + "&article_no=" + article_no;
		}
	}
	
	@RequestMapping(value="/multi/articleDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteBoardOne(Model model, HttpSession session, HttpServletRequest request, ArticleVO articleVO) {
		//System.out.println("ordered : " + articleVO.toString());
		int result = ms.articleDelete(articleVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/multi/articleEditCheck.do")
	public String articleEditCheck(HttpSession session, @RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpServletRequest request) {
		
		ArticleVO article = ms.getArticleOne(article_no);
		String currentID = (String)session.getAttribute("userid");
		
		if(article.getArticle_secretyn().equals("Y") || article.getArticle_secretyn() == "Y") {
			
			//비밀글 처리
			
			String encoded = article.getArticle_password();
			byte[] encodedByte = encoded.getBytes();
			
			Decoder decoder = Base64.getDecoder();
			byte[] decodeByte = decoder.decode(encodedByte);
			//System.out.println("디코딩된 것 : " + new String(decodeByte));
			String decoded = new String(decodeByte);
			article.setArticle_password(decoded);
			
			model.addAttribute("article", article);
			model.addAttribute("OrderedUrl", request.getRequestURI());
			UserVO userInfo = us.getUserInfo(currentID);
			model.addAttribute("userInfo", userInfo);
			return "/multi/ownerCheck";
		} else {
			return "redirect:/multi/articleEdit.do?board_no=" + board_no + "&article_no=" + article_no;
		}
	}
	
	@RequestMapping(value="/multi/articleEdit.do", method=RequestMethod.GET)
	public String updateBoardOne(@RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("userid");
		ArticleVO article = ms.getArticleOne(article_no);
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/multi/board.do?board_no=" + request.getParameter("board_no") + "&article_no=" + article.getBoard_no());
			return "alert";
		} else if(currentUser.equals("admin")) {
			// 관리자의 경우 어떤 글이든 수정 가능하도록 처리
			model.addAttribute("article", article);
			return "/multi/articleEdit";
		} else if(currentUser.equals(article.getArticle_userid())) {
			// 글 쓴 사람의 아이디와, 해당 글을 작성한 사람의 아이디가 같아야만 글을 수정할 수 있음.
			model.addAttribute("article", article);
			return "/multi/articleEdit";
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/multi/board.do?board_no=" + request.getParameter("board_no") + "&article_no=" + article.getBoard_no());
			return "alert";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/multi/articleEdit.do", method=RequestMethod.POST)
	public String updateBoardOne(ArticleVO article, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("userid");
		
		// 수정한 글을 보낼 때 한 번 더 로그인 관련 처리를 함.
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/multi/board.do?board_no=" + request.getParameter("board_no") + "&article_no=" + article.getBoard_no());
			return "alert";
		} else if(currentUser.equals("admin")) {
			// 관리자는 모든 글을 수정 가능함.
			int result = ms.articleUpdate(article);
			return String.valueOf(result);
		} else if(currentUser.equals(article.getArticle_userid())) {
			// 글을 작성한 사람의 아이디와 현재 접속자 아이디가 같아야만 수정이 가능함.
			int result = ms.articleUpdate(article);
			return String.valueOf(result);
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/multi/board.do?board_no=" + request.getParameter("board_no") + "&article_no=" + article.getBoard_no());
			return "alert";
		}
	}
	
	
	// 신 게시판 답글 처리
	@RequestMapping(value="/multi/reArticleWrite.do", method=RequestMethod.GET)
	public String reBoardWrite(@RequestParam("board_no") int board_no, @RequestParam("article_no") int article_no, Model model, HttpSession session) {
		String currentUser = (String)session.getAttribute("userid");
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			MultiBoardVO temp = new MultiBoardVO();
			temp.setBoard_no(board_no);
			temp.setUser_id(currentUser);
			
			MultiBoardVO config = as.getMultiBoardOne(temp);
			model.addAttribute("boardConfig", config);
			
			// 답글을 달고자 하는 게시글의 정보를 불러와, View페이지에 Re : 를 뿌려주기위함.
			ArticleVO articleVO = ms.getArticleOne(article_no);
			// 현재 날짜-시간 처리
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
			Date currentTime = new Date();
			String date = formatter.format(currentTime);
			
			model.addAttribute("date", date);
			model.addAttribute("article", articleVO);
			return "/multi/reArticle";
			
		}
	}
	
	@RequestMapping(value="/multi/reArticleWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public String reBoardWritePost(ArticleVO articleVO) {
		
		//System.out.println(articleVO.toString());
		//System.out.println("폼에서 넘어온 vo의 값 : " + boardVO.toString());
		
		// 답글을 달고자 하는 글의 board_grouporder와 board_groupdepth가 필요하다.
		// 답글이 될 글의 grouporder와 groupdepth를 먼저 +1해준다.
		//boardVO.setBoard_grouporder(boardVO.getBoard_grouporder() + 1);
		//boardVO.setBoard_groupdepth(boardVO.getBoard_groupdepth() + 1);
		articleVO.setArticle_grouporder(articleVO.getArticle_grouporder() + 1);
		articleVO.setArticle_groupdepth(articleVO.getArticle_groupdepth() + 1);
		
		// 답글을 달고자 하는 글의 정보를 불러온다. 
		ArticleVO parentsVO = ms.getArticleOne(articleVO.getArticle_no());
		
		// 답글을 달고자 하는 글과 해당 글의 상위 글의 grouporder를 +1하는 쿼리를 실행한다.
		ms.reWriteGroupOrder(parentsVO);
		
		if(articleVO.getArticle_secretyn() == null || articleVO.getArticle_secretyn().equals("")) {
			articleVO.setArticle_secretyn("N");
		}
		
		if(articleVO.getArticle_secretyn().equals("Y") || articleVO.getArticle_secretyn() == "Y") {
			String articlePassword = articleVO.getArticle_password();
			byte[] passwordToByte = articlePassword.getBytes();
			Encoder encoder = Base64.getEncoder();
			byte[] encodedBytes = encoder.encode(passwordToByte);
			articleVO.setArticle_password(new String(encodedBytes));
		}
		
		// 이후 답글을 등록한다.
		int result = ms.reArticleInsert(articleVO);
		 
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/multi/individualInfo.do")
	public String individualInfo(HttpSession session, Model model) {
		String currentUserId = (String)session.getAttribute("userid");
		System.out.println("넘어온 아이디 : " + currentUserId);
		
		// 새로운 객체 생성
		UserVO userVO = new UserVO();
		userVO.setUserid(currentUserId);
		List<IndividualVO> indiList = us.getUserIndividualInfoList(userVO);
		Iterator<IndividualVO> indiListIt = indiList.iterator();
		while(indiListIt.hasNext()) {
			IndividualVO info = indiListIt.next();
			String tag = info.getArticle_content();
			tag = tag.replaceAll("img", "");
			String nor = XssPreventer.unescape(tag);
			info.setArticle_content(nor);
		}
		
		model.addAttribute("indiList", indiList);
		
		return "/multi/individualInfo";
	}
	
	
	
	
	// 댓글 처리 관련
	@Autowired
	ReplyServiceImpl rs;
	
	// 댓글 작성 프로세스
	@RequestMapping(value="/multi/writeReplyAction")
	@ResponseBody
	public String writeReplyAction(@ModelAttribute ReplyVO reply) {
		// 현재 날짜 정보
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
		Date currentTime = new Date();
		String date = formatter.format(currentTime);
		reply.setReply_date(date);
		
		int result = rs.replyWrite(reply);
		
		//ReplyVO updatedReply = rs.getReplyOne();
		//rs.updateReplyParentsNo(updatedReply);
		
		return String.valueOf(result);
	}
	
	// 댓글 리스트 불러오기
	@RequestMapping(value="/multi/getReplyList", method=RequestMethod.GET)
	@ResponseBody
	public List<ReplyVO> getReplyList(@ModelAttribute ReplyVO reply) {
		reply.setOrderType("new");
		List<ReplyVO> reply_list = rs.getReplyList(reply);
		if(reply_list.size() == 1 && reply_list.get(0).getReply_writer() == null) {
			return null;
		}
		return reply_list;
	}
	
	// 최신순 리스트 불러오기
	@RequestMapping(value="/multi/getReplyListNew", method=RequestMethod.POST)
	@ResponseBody
	public List<ReplyVO> getReplyListNew(ReplyVO replyVO) {
		System.out.println(replyVO.toString());
		replyVO.setOrderType("new");
		List<ReplyVO> result = rs.getReplyList(replyVO);
		if(result == null) {
			return null;
		}
		return result;
	}
	
	// 등록순 리스트 불러오기
	@RequestMapping(value="/multi/getReplyListOld", method=RequestMethod.POST)
	@ResponseBody
	public List<ReplyVO> getReplyListOld(ReplyVO replyVO) {
		System.out.println(replyVO.toString());
		replyVO.setOrderType("old");
		List<ReplyVO> result = rs.getReplyList(replyVO);
		return result;
	}
		
	// 점수순 리스트 불러오기
	@RequestMapping(value="/multi/getReplyListScore", method=RequestMethod.POST)
	@ResponseBody
	public List<ReplyVO> getReplyListScore(ReplyVO replyVO) {
		System.out.println(replyVO.toString());
		replyVO.setOrderType("score");
		List<ReplyVO> result = rs.getReplyList(replyVO);
		return result;
	}
	
	// 댓글 삭제
	@RequestMapping(value="/multi/deleteReply", produces="application/text; charset=utf8")
	@ResponseBody
	public String deleteReply(@ModelAttribute ReplyVO reply, HttpServletRequest request, HttpSession session) {
		System.out.println(reply.toString());
		String currentUserid = (String)session.getAttribute("userid");
		System.out.println(currentUserid);
		int thisReplyNo = reply.getReply_no();
		ReplyVO thisReplyVO = rs.getReplyOneByNo(thisReplyNo);
		
		int queryValue = 0;
		if(thisReplyVO.getReply_userid() == null) {
			return "그런 댓글은 존재하지 않습니다.";
		} else  {
			queryValue = rs.deleteReply(thisReplyVO);
		}
		
		if(queryValue == 1) {
			String result = "success";
			return result;
		} else {
			String result = "fail";
			return result;
		}
	}

	
	// 댓글 수정 확인
	@RequestMapping(value="/multi/updateReplyConfirm", method=RequestMethod.POST)
	@ResponseBody
	public String updateReplyConfirm(@ModelAttribute ReplyVO reply, HttpServletRequest request) {
		int result = rs.updateReplyConfirm(reply);
		return String.valueOf(result);
	}
	
	// 대댓글 쓰기
	@RequestMapping(value="/multi/reReplyWriteAction", method=RequestMethod.GET)
	public String reReplyWriteAction(@ModelAttribute ReplyVO reply, HttpServletRequest request, Model model) {
		System.out.println(reply.toString());
		ReplyVO thisReply = rs.getReplyOneByNo(reply.getReply_no());
		model.addAttribute("thisReply", thisReply);
		return "/multi/reReplyAction";
	}
	
	// 대댓글 쓰기
	@RequestMapping(value="/multi/reReplyWriteAction", method=RequestMethod.POST)
	@ResponseBody
	public String reReplyWriteActionPost(ReplyVO replyVO) {
		System.out.println("포스트 : " + replyVO.toString());
		int result = rs.reReplyWriteAction(replyVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/multi/replyLikeAndHate", method=RequestMethod.POST)
	@ResponseBody
	public ReplyVO replyListAndHate(ReplyVO replyVO) {
		System.out.println(replyVO.toString());
		
		ReplyVO likeInfo = rs.replyLikeAndHateConfirm(replyVO);
		int result = 0;
		if(likeInfo.getCnt() == 0) {
			// 정보가 없는 경우 신규 등록
			result = rs.replyLikeAndHateAction(replyVO);
			rs.replyLikeAndHateScoreAdjust(replyVO);
			return new ReplyVO();
		} else {
			// db에 있는 값이 Y인 경우.
			if(likeInfo.getOrderType().equals("Y")) {
				// 여기서 replyVO의 ordertype이 Y인 경우, 좋아요 했는데 또 좋아요를 하려는 경우고, n인 경우 싫어요로 바꾸려는 것.
				if(replyVO.getOrderType().equals("Y")) {
					// 에러 처리
					ReplyVO resultVO = new ReplyVO();
					resultVO.setOrderType("Y");
					return resultVO;
				} else {
					// 그대로 처리. 점수와 로그를 교체한다.
					rs.replyLikeAndHateLogAdjust(replyVO);
					rs.replyLikeAndHateScoreAdjust2(replyVO);
					replyVO.setOrderType("N");
					return replyVO;
				}
			} else {
				// db에 있는 값이 N인 경우.
				// 여기서 replyVO의 ordertype이 N인 경우, 싫어요 했는데 또 싫어요를 하려는 경우고, Y인 경우 좋아요로 바꾸려는 것.
				if(replyVO.getOrderType().equals("N")) {
					ReplyVO resultVO = new ReplyVO();
					resultVO.setOrderType("Y");
					return resultVO;
				} else {
					// 누른 값이 Y인 경우, 좋아요로 교체 한다.
					rs.replyLikeAndHateLogAdjust(replyVO);
					rs.replyLikeAndHateScoreAdjust2(replyVO);
					replyVO.setOrderType("N");
					return replyVO;
				}
			}
		}
	}
}
