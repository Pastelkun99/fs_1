package com.fusion1.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.BoardVO;
import com.fusion1.dao.PagenationVO;
import com.fusion1.service.BoardServiceImpl;
import com.nhncorp.lucy.security.xss.XssPreventer;

@Controller
public class BoardController {
	
	@Autowired
	BoardServiceImpl bs;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, HttpServletRequest request, Model model) {
		String currentUser = (String)session.getAttribute("userid");
		if(currentUser == null || currentUser.equals("")) {
			return "home";
		} else {
			model.addAttribute("msg", "이미 로그인 되어 있습니다.");
			model.addAttribute("href", "/boardList.do?page_no=1&pageSize=10");
			return "alert";
		}
		
	}
	
	@RequestMapping(value="/boardList.do")
	public String boardList(HttpSession session, Model model, PagenationVO page) {
		String currentID = (String)session.getAttribute("userid");
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			if(page.getKeyword() == null || page.getKeyword().equals("")) {
				
				// 검색어를 지정하지 않았을 때의 게시글 총 갯수
				int totalCount = bs.getBoardCount();
				
				// 페이지에서 지정한 갯수 (몇 개씩 보여줄 것인가)
				int getPageSize = page.getPageSize();
				
				int getPage_no = page.getPage_no();
				
				// 끝 페이지가 될 숫자. 
				int endPage = totalCount / getPageSize;
				
				// 나누어 떨어지지 않으면 1을 추가한다.
				if(totalCount % getPageSize > 0) {
					endPage++;
				}
				
				// 보내기 위한 페이지네이션 VO 객체
				PagenationVO pageVO = new PagenationVO();
				pageVO.setStartPage(1);
				pageVO.setEndPage(endPage);
				pageVO.setPageList(getPageSize);
				pageVO.setPageSize(getPageSize);
				pageVO.setTotalCount(totalCount);
				
				// page_no = 1 일때 0, 2일때 10, 3일때 20 ...
				int pageCon = (getPage_no*getPageSize) - getPageSize;
				pageVO.setPageCon(pageCon);
				
				int pageBoardNo = (getPage_no*getPageSize);
				pageVO.setPageBoardNo(pageBoardNo);
				
				// 검색어가 없을때 
				List<BoardVO> list = bs.getBoardList(pageVO);
				
				// 공지사항 리스트
				List<BoardVO> noticeList = bs.getBoardNotice(1);
				if(!noticeList.isEmpty()) {
					BoardVO notice = noticeList.get(0);
					model.addAttribute("notice", notice);
				}
				
				model.addAttribute("boardlist", list);
				model.addAttribute("noticeList", noticeList);
				model.addAttribute("page", pageVO);
				return "boardList";
				
			} else {
				// 검색어가 있다는 것 외에는 앞의 로직과 같음.
				int totalCount = bs.getBoardSearchCount(page);
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
				
				// 페이지 검색 조건과 검색어, 해당 조건에 맞는 게시글 수를 지정해줌.
				pageSearch.setSearchCon(searchCon);
				pageSearch.setKeyword(keyword);
				pageSearch.setTotalCount(totalCount);
				
				int pageCon = (getPage_no*getPageSize) - getPageSize;
				pageSearch.setPageCon(pageCon);
				
				List<BoardVO> list = bs.getBoardSearchList(pageSearch);
				
				List<BoardVO> noticeList = bs.getBoardNotice(1);
				if(!noticeList.isEmpty()) {
					BoardVO notice = noticeList.get(0);
					model.addAttribute("notice", notice);
				}
				model.addAttribute("boardlist", list);
				model.addAttribute("noticeList", noticeList);
				model.addAttribute("page", pageSearch);
				return "boardList";
			}
		}
	}
	
	@RequestMapping(value="/board.do", method=RequestMethod.GET)
	public String board(HttpSession session, @RequestParam("board_no") int board_no, Model model) {
		String currentID = (String)session.getAttribute("userid");
		
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			// 게시글 정보 불러옴
			BoardVO boardvo = bs.getBoardOne(board_no);
			
			// 줄바꿈 처리
			String convertedContents = boardvo.getBoard_content();
			convertedContents = XssPreventer.unescape(convertedContents);
			boardvo.setBoard_content(convertedContents);
			
			// 조회수 up
			bs.updateBoardHit(board_no);
			
			model.addAttribute("board", boardvo);
			return "board";
		}
	}
	
	@RequestMapping(value="/boardWrite.do", method=RequestMethod.GET)
	public String boardWrite(Model model, HttpSession session) {
		String currentUser = (String)session.getAttribute("userid");
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			// 게시글 작성 일자 표시를 위해 전달 (다른 방법 있음)
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
			Date currentTime = new Date();
			String date = formatter.format(currentTime);
			model.addAttribute("date", date);
			return "boardw";
		}
		
	}
	
	@RequestMapping(value="/boardWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardWrite(BoardVO boardVO, Model model, HttpServletRequest request) {
		
		// 원글을 등록할 경우, parentsno를 함께 등록하기 위해 insert 및 update 처리를 함께 진행함.
		String noTagContents = boardVO.getBoard_content();
		//System.out.println("수정 전 : " + noTagContents);
		
		noTagContents = XssPreventer.unescape(noTagContents);
		//System.out.println("수정 후 : " + noTagContents);
		boardVO.setBoard_content(noTagContents);
		int result = bs.insertBoardOne(boardVO);
		int parents_no = boardVO.getBoard_no();
		int result2 = bs.updateBoardParent(parents_no);
		
		return String.valueOf(result);
	}
	
	
	@RequestMapping(value="/boardedit.do", method=RequestMethod.GET)
	public String updateBoardOne(@RequestParam("board_no") int board_no, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("userid");
		BoardVO board = bs.getBoardOne(board_no);
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board_no);
			return "alert";
		} else if(currentUser.equals("admin")) {
			// 관리자의 경우 어떤 글이든 수정 가능하도록 처리
			model.addAttribute("board", board);
			return "boarde";
		} else if(currentUser.equals(board.getBoard_userid())) {
			// 글 쓴 사람의 아이디와, 해당 글을 작성한 사람의 아이디가 같아야만 글을 수정할 수 있음.
			model.addAttribute("board", board);
			return "boarde";
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board_no);
			return "alert";
		}
	}

	@ResponseBody
	@RequestMapping(value="/boardedit.do", method=RequestMethod.POST)
	public String updateBoardOne(BoardVO board, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("userid");
		
		// 수정한 글을 보낼 때 한 번 더 로그인 관련 처리를 함.
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board.getBoard_no());
			return "alert";
		} else if(currentUser.equals("admin")) {
			// 관리자는 모든 글을 수정 가능함.
			int result = bs.updateBoardOne(board);
			return String.valueOf(result);
		} else if(currentUser.equals(board.getBoard_userid())) {
			// 글을 작성한 사람의 아이디와 현재 접속자 아이디가 같아야만 수정이 가능함.
			int result = bs.updateBoardOne(board);
			return String.valueOf(result);
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board.getBoard_no());
			return "alert";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/boardDelete.do", method=RequestMethod.GET)
	public String deleteBoardOne(BoardVO board, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("userid");
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board.getBoard_no());
			return "alert";
		} else if(currentUser.equals("admin")) {
			// 관리자는 모든 게시물을 삭제할 수 있음.
			int result = bs.deleteBoardOne(board);
			return String.valueOf(result);
		} else if(currentUser.equals(board.getBoard_userid())) {
			// 게시글을 작성한 사람의 아이디와 현재 접속자 아이디가 일치해야 삭제가 가능함.
			int result = bs.deleteBoardOne(board);
			return String.valueOf(result);
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?board_no=" + board.getBoard_no());
			return "alert";
		}
	}
	
	@RequestMapping(value="/reBoardWrite.do", method=RequestMethod.GET)
	public String reBoardWrite(@RequestParam("board_no") int board_no, Model model, HttpSession session) {
		String currentUser = (String)session.getAttribute("userid");
		
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			// 답글을 달고자 하는 게시글의 정보를 불러와, View페이지에 Re : 를 뿌려주기위함.
			BoardVO boardVO = bs.getBoardOne(board_no);
			
			// 현재 날짜-시간 처리
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
			Date currentTime = new Date();
			String date = formatter.format(currentTime);
			
			model.addAttribute("date", date);
			model.addAttribute("board", boardVO);
			return "reBoard";
			
		}
	}
	
	@RequestMapping(value="/reBoardWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public String reBoardWrite(BoardVO boardVO) {
		
		//System.out.println("폼에서 넘어온 vo의 값 : " + boardVO.toString());
		
		// 답글을 달고자 하는 글의 board_grouporder와 board_groupdepth가 필요하다.
		// 답글이 될 글의 grouporder와 groupdepth를 먼저 +1해준다.
		boardVO.setBoard_grouporder(boardVO.getBoard_grouporder() + 1);
		boardVO.setBoard_groupdepth(boardVO.getBoard_groupdepth() + 1);
		
		// 답글을 달고자 하는 글의 정보를 불러온다. 
		BoardVO parentsVO = bs.getBoardOne(boardVO.getBoard_no());
		
		// 답글을 달고자 하는 글과 해당 글의 상위 글의 grouporder를 +1하는 쿼리를 실행한다.
		int result2 = bs.reWriteGroupOrder(parentsVO);
		
		// 이후 답글을 등록한다.
		int result = bs.reWriteBoard(boardVO);
		 
		return String.valueOf(result);
	}
	
}