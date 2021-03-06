package com.fusion1.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.AnswerVO;
import com.fusion1.dao.BoardVO;
import com.fusion1.dao.InfoVO;
import com.fusion1.dao.LogVO;
import com.fusion1.dao.PagenationVO;
import com.fusion1.dao.PopupVO;
import com.fusion1.service.AdminServiceImpl;
import com.fusion1.service.AnalysisServiceImpl;
import com.fusion1.service.BoardServiceImpl;
import com.fusion1.service.LogServiceImpl;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.nhncorp.lucy.security.xss.XssPreventer;

import eu.bitwalker.useragentutils.UserAgent;

@Controller
public class BoardController {
	
	@Autowired
	BoardServiceImpl bs;
	
	@Autowired
	LogServiceImpl ls;
	
	@Autowired
	AdminServiceImpl ads;
	
	
	@RequestMapping(value="/test.do")
	public String test() {
		return "test";
	}
	
	@RequestMapping(value="/testPage.do")
	public String testPage() {
		return "test.page";
	}
	
	@RequestMapping("/testPart.do")
	public String testPart() {
		return "test.part";
	}
	
	
	@RequestMapping(value="/alert.do")
	public String alert(Model model) {
		model.addAttribute("msg", "로그인 후 이용 가능합니다.");
		model.addAttribute("href", "/");
		return "alert";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, HttpServletRequest request, Model model) {
		String currentUser = (String)session.getAttribute("userid");
		if(currentUser == null || currentUser.equals("")) {
			return "home";
		} else {
			model.addAttribute("msg", "이미 로그인 되어 있습니다.");
			model.addAttribute("href", "multi/boardList.do?board_no=-1&page_no=1&pageSize=10");
			return "alert";
		}
		
	}
	
	@RequestMapping(value="/boardList.do")
	public String boardList(HttpSession session, Model model, PagenationVO page) {
		if(page.getKeyword() == null || page.getKeyword().equals("")) {
			
			PopupVO popup = ads.getPopupAval();
			//System.out.println(" 뿌려지는 팝업 : " + popup.toString());
			model.addAttribute("pop_id", popup.getPop_id());
			model.addAttribute("pop_title", popup.getPop_title());
			model.addAttribute("pop_fromdate", popup.getPop_fromdate());
			model.addAttribute("pop_todate", popup.getPop_todate());
			model.addAttribute("pop_height", popup.getPop_height());
			model.addAttribute("pop_width", popup.getPop_width());
			model.addAttribute("pop_content", popup.getPop_content());
			model.addAttribute("pop_imageurl", popup.getPop_imageurl());
			model.addAttribute("pop_url", popup.getPop_url());
			model.addAttribute("pop_aval", popup.getPop_aval());
			
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
			return "boardList.page";
		}
	}
	
	// 글 상세 보기
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
	
	// 글쓰기 (빈칸)
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
	
	// 글쓰기 포스트
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
		bs.updateBoardParent(parents_no);
		
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
		bs.reWriteGroupOrder(parentsVO);
		
		// 이후 답글을 등록한다.
		int result = bs.reWriteBoard(boardVO);
		 
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/log.do", method=RequestMethod.POST)
	@ResponseBody
	public String log(LogVO logVO, HttpServletRequest request) {
		
		// Maven에 추가했던 라이브러리를 이용함.
		UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
		
		// 데이터 타입 변환을 위해 String 객체에 올바른 형태로 넣어줌.
		String osVersion = userAgent.getOperatingSystem().toString();
		String userBrowser = userAgent.getBrowser().toString();
		String userBrowserVersion = userAgent.getBrowserVersion().toString();
		String userIP = request.getRemoteAddr();		
		
		String userReferrer = logVO.getLog_userreferrer();
		if(userReferrer.contains("localhost")) {
			logVO.setLog_userreferrer("로컬호스트");
		}
		    
		logVO.setLog_osversion(osVersion);
		logVO.setLog_userbrowser(userBrowser);
		logVO.setLog_bversion(userBrowserVersion);
		logVO.setLog_userip(userIP);
		
		int result = ls.logWrite(logVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/Chart.do")
	public String chart(Model model, HttpServletRequest request, 
						@RequestParam("fromDate") String fromDate, @RequestParam("toDate") String toDate,
						HttpSession session) {
		
		// 차트 페이지를 띄우기 이전에 먼저 로그인 여부와 관리자 여부를 체크
		String currentUser = (String)session.getAttribute("userid");
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "관리자만 접근 가능합니다.");
			model.addAttribute("href", request.getContextPath() + "/");
			return "alert";
		} else if (!currentUser.equals("admin")) {
			model.addAttribute("msg", "관리자만 접근 가능합니다.");
			model.addAttribute("href", request.getContextPath() + "/");
			return "alert";
		}
		
		// 임의적으로 이상한 값을 입력하는 것을 방지하기 위해 format 형식에 맞는지 아닌지 점검
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date todayTime = new Date();
		String today = format.format(todayTime);
		Map<String, Object> dateMap = new HashMap<String, Object>();
		
		// 날짜값이 입력되지 않았을 경우 모두 오늘 날짜로 치환함.
		if(fromDate == null || fromDate.equals("")) {
			fromDate = today;
		}
		
		if(toDate == null || toDate.equals("")) {
			toDate = today;
		}
		format.setLenient(false);
		
		try {
			format.parse(fromDate);
			format.parse(toDate);
		} catch (Exception e) {
			// 오류가 발생하였을 경우(올바른 날짜값이 아닌 경우) 접속 불가. 원래 default 페이지로 돌아감.
			model.addAttribute("msg", "올바른 날짜 형식이 아닙니다.");
			model.addAttribute("href", request.getContextPath() + "/Chart.do?fromDate=&toDate=");
			return "alert";
		}
		
		// sql 검색을 위해 fromDate ~ toDate에 시간 데이터 입력
		dateMap.put("fromDate", fromDate + " 00:00:00");
		dateMap.put("toDate", toDate + " 23:59:59");
		
		
		// 해당 dateMap을 통해 로그를 테이블에 뿌려주기 위함
		
		// ***** 리스트 로드 작업 시작 *****
		List<LogVO> logList = ls.getLogList(dateMap);
		model.addAttribute("logList", logList);
		
		// 유저 아이디별 리스트
		List<LogVO> logNameList = ls.getLogNameList(dateMap);
		
		// 운영체제별 리스트
		List<LogVO> logOSList = ls.getLogOSList(dateMap);
		
		// 브라우저별 리스트
		List<LogVO> logBrowserList = ls.getBrowserList(dateMap);
		
		// 접속 시간별 리스트
		List<LogVO> logTimeList = ls.getTimeList(dateMap);
		
		// 시간별 리스트 토탈
		List<LogVO> logTimeTotalList = ls.getTimeTotalList();
		
		// 접속경로별 리스트
		List<LogVO> logReferrerList = ls.getReferrerList(dateMap);
		
		// 요일별 리스트
		List<LogVO> logWeekOfDaysList = ls.getWeekOfDaysList(dateMap);
		
		// ***** 리스트 load 작업 끝 *****
		
		
		// 이름별 접속횟수 로직
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<LogVO> it = logNameList.iterator();
		while(it.hasNext()) {
			LogVO curVO = it.next();
			JsonObject object = new JsonObject();
			String userid = curVO.getLog_userid();
			int cnt = curVO.getCnt();
			
			object.addProperty("ID", userid);
			object.addProperty("Count", cnt);
			jArray.add(object);
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		// 유저별 접속 횟수 로직 끝
		
		// 운영제체별 접속 횟수 로직
		Gson gson2 = new Gson();
		JsonArray jArrayOS = new JsonArray();
		
		Iterator<LogVO> itOS = logOSList.iterator();
		while(itOS.hasNext()) {
			LogVO osVO = itOS.next();
			JsonObject objectOS = new JsonObject();
			String os = osVO.getLog_osversion();
			int cnt = osVO.getCnt();
			
			objectOS.addProperty("OS", os);
			objectOS.addProperty("Count", cnt);
			jArrayOS.add(objectOS);
		}
		
		String jsonOS = gson2.toJson(jArrayOS);
		//System.out.println("OS별 제이슨 데이터 정보 : " + jsonOS);
		model.addAttribute("jsonOS", jsonOS);
		// 운영체제별 접속 횟수 로직 끝
		
		// 브라우저별 접속 횟수 로직
		Gson gson3 = new Gson();
		JsonArray jArrayBrowser = new JsonArray();
		
		Iterator<LogVO> itBrowser = logBrowserList.iterator();
		while(itBrowser.hasNext()) {
			LogVO browserVO = itBrowser.next();
			JsonObject objectBrowser = new JsonObject();
			String browser = browserVO.getLog_userbrowser();
			int cnt = browserVO.getCnt();
			
			objectBrowser.addProperty("Browser", browser);
			objectBrowser.addProperty("Count", cnt);
			jArrayBrowser.add(objectBrowser);
		}

		String jsonBrowser = gson3.toJson(jArrayBrowser);
		//System.out.println("브라우저별 제이슨 데이터 정보 : " + jsonBrowser);
		model.addAttribute("jsonBrowser", jsonBrowser);
		// 브라우저별 접속 횟수 로직 끝
		
		// 접속 시간별 카운트 로직
		Gson gson4 = new Gson();
		JsonArray jArrayTime = new JsonArray();
		
		Iterator<LogVO> itTime = logTimeList.iterator();
		while(itTime.hasNext()) {
			LogVO timeVO = itTime.next();
			//System.out.println(timeVO.toString());
			JsonObject objectTime = new JsonObject();
			String time = timeVO.getTime() + "시";
			int cnt = timeVO.getCnt();
			
			objectTime.addProperty("DateTime", time);
			objectTime.addProperty("Count", cnt);
			jArrayTime.add(objectTime);
		}
		
		String jsonTime = gson4.toJson(jArrayTime);
		//System.out.println("시간 별 접속자 정보 : " + jsonTime);
		model.addAttribute("jsonTime", jsonTime);
		// 접속 시간별 카운트 로직 끝
		
		// 날짜별 카운트 횟수 추출
		Gson gson5 = new Gson();
		JsonArray jArrayDate = new JsonArray();
		
		Iterator<LogVO> itDate = logTimeTotalList.iterator();
		while(itDate.hasNext()) {
			LogVO dateVO = itDate.next();
			JsonObject objectDate = new JsonObject();
			String log_date = dateVO.getLog_date();
			int cnt = dateVO.getCnt();
			
			objectDate.addProperty("Date", log_date);
			objectDate.addProperty("Count", cnt);
			jArrayDate.add(objectDate);
		}
		
		String jsonDate = gson5.toJson(jArrayDate);
		//System.out.println("날짜별 접속자 카운트 : " + jsonDate);
		model.addAttribute("jsonDate", jsonDate);
		
		// 접속 경로별 설정
		Gson gson6 = new Gson();
		JsonArray jArrayRefer = new JsonArray();
		
		Iterator<LogVO> itRefer = logReferrerList.iterator();
		while(itRefer.hasNext()) {
			LogVO referVO = itRefer.next();
			JsonObject objectRefer = new JsonObject();
			String refer = referVO.getLog_userreferrer();
			int cnt = referVO.getCnt();
			
			objectRefer.addProperty("Refer", refer);
			objectRefer.addProperty("Count", cnt);
			jArrayRefer.add(objectRefer);
		}

		String jsonRefer = gson6.toJson(jArrayRefer);
		model.addAttribute("jsonRefer", jsonRefer);
		// 접속 경로 횟수 로직 끝
		
		// 요일별 접속자 수
		Gson gson7 = new Gson();
		JsonArray jArrayWeekOfDays = new JsonArray();
		
		Iterator<LogVO> itWeek = logWeekOfDaysList.iterator();
		while(itWeek.hasNext()) {
			LogVO weekVO = itWeek.next();
			JsonObject objectWeek = new JsonObject();
			String weekOfDays = weekVO.getLog_date();
			int cnt = weekVO.getCnt();
			
			objectWeek.addProperty("WeekOfDays", weekOfDays);
			objectWeek.addProperty("Count", cnt);
			jArrayWeekOfDays.add(objectWeek);
		}
		
		String jsonWeek = gson7.toJson(jArrayWeekOfDays);
		model.addAttribute("jsonWeek", jsonWeek);
		// 요일별 접속자 수 끝

		return "chart";
	}
	
	@RequestMapping(value="/logDelete.do")
	@ResponseBody
	public String logDelete(LogVO logVO) {
		
		int result = ls.logDelete(logVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/logExcelDownload.do")
	public void excelDown(HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date todayTime = new Date();
		String today = format.format(todayTime);
		
		HashMap<String, Object> dateMap = new HashMap<String, Object>();
		String fromDate = (String)request.getParameter("fromDate");
		String toDate = (String)request.getParameter("toDate");
		
		if(fromDate == null || fromDate.equals("")) {
			fromDate = today;
		}
		
		if(toDate == null || toDate.equals("")) {
			toDate = today;
		}
		
		dateMap.put("fromDate", fromDate + " 00:00:00");
		dateMap.put("toDate", toDate + " 23:59:59");
		
//		System.out.println("리퀘스트파라미터 fromdate : " + fromDate);
//		System.out.println("리퀘스트파라미터 todate : " + toDate);
		
		// 목록 조회
		List<LogVO> logList = ls.getLogExcel(dateMap);
//		Iterator<LogVO> it = logList.iterator();
//		while(it.hasNext()) {
//			System.out.println(it.next().toString());
//		}
		
		Workbook wb = new HSSFWorkbook();
		Sheet sheet = wb.createSheet("로그 목록");
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		// 테이블 헤더 용 스타일
		CellStyle headStyle = wb.createCellStyle();
		
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 배경 스타일
		headStyle.setFillForegroundColor(HSSFColorPredefined.CORAL.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// 데이터 가운데 정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		
		// 데이터용 경계 스타일 테두리만 지정
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);

	    // 헤더 생성
		row = sheet.createRow(rowNo++);
		cell = row.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("번호");
		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("아이디");
		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("날짜");
		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("IP");
		cell = row.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("브라우저");
		cell = row.createCell(5);
		cell.setCellStyle(headStyle);
		cell.setCellValue("브라우저버전");
		cell = row.createCell(6);
		cell.setCellStyle(headStyle);
		cell.setCellValue("운영체제");
		cell = row.createCell(7);
		cell.setCellStyle(headStyle);
		cell.setCellValue("접속 경로");

	    // 데이터 부분 생성
	    for(LogVO vo : logList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_no());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_userid());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_date());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_userip());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_userbrowser());
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_bversion());
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_osversion());
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getLog_userreferrer());
	    }
	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=Log.xls");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	
	
	@Autowired
	AnalysisServiceImpl as;
	
	// 설문조사 선택 페이지
	@RequestMapping(value="/anal.do")
	public String anal(Model model) {
		
		List<InfoVO> analList = as.getAnalysisInfoAvalList();
		model.addAttribute("analList", analList);
		return "analSelect";
	}
	
	// 설문조사 입장 페이지
	@RequestMapping(value="/analysis.do")
	public String analysis(Model model, HttpSession session, InfoVO info) {
		
		String curId = (String)session.getAttribute("userid");
		System.out.println(info.toString());
		// 로그인 하지 않은 유저는 설문조사에 참여할 수 없음.
		if(curId == null || curId.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			// 진행중인 설문조사 리스트를 불러온다.
			List<InfoVO> analList = as.getAnalysisInfoList();
			model.addAttribute("analList", analList);
			
			int n = info.getA_no();
			System.out.println("들어온 n의 값 : " + n);
			// 현재 진행중인 설문의 정보를 불러온다.
			if(n == 0) {
				n = 1;
			}
			InfoVO infoList = as.getAnalysisInfo(n);
			System.out.println(infoList.toString());
			model.addAttribute("infoList", infoList);
			
			AnswerVO usevo = new AnswerVO();
			usevo.setQ_id(curId);
			usevo.setA_no(n);
			
			// 현재 접속한 사람이 이미 설문을 진행한 결과가 있는지 갖고 온다.
			List<AnswerVO> answerList = as.getAnalysisAnswerList(usevo);
			int answerListSize = answerList.size();
			//System.out.println("사이즈 " + answerListSize);
			model.addAttribute("answerListSize", answerListSize);
			
			return "suzip";
		}
	}
	
	// 설문조사 리스트 페이지
	@RequestMapping(value="/analysisList.do")
	public String analysisList(Model model, HttpSession session, HttpServletRequest request, @RequestParam("page") int page, @RequestParam("a_no") int a_no) throws ParseException {
		
		// 현재 진행중인 설문을 불러온다.
		InfoVO info = as.getAnalysisInfo(a_no);
		if(info == null) {
			model.addAttribute("msg", "잘못된 페이지 이동입니다.");
			model.addAttribute("href", request.getContextPath() + "/anal.do");
			return "alert";
		}
		
		// 현재 진행중인 설문의 시작 날짜와 끝 날짜를 받아 처리함.
		// 조건에 부합하지 않는 경우 설문을 진행할 수 없음.
		SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
		Date fromDate = sm.parse(info.getA_fromdate());
		Date toDate = sm.parse(info.getA_todate());
		
		Date today = new Date();
		Date nowDate = sm.parse(sm.format(today).toString());
		
		if(fromDate.getTime() >= nowDate.getTime() || toDate.getTime() <= nowDate.getTime()) {
			model.addAttribute("msg", "설문조사 기간이 아닙니다.");
			model.addAttribute("href", request.getContextPath() + "/analysis.do");
			return "alert";
		}
		
		// 날짜 조건을 통과하면, 로그인 여부를 체크한다.
		String curUserId = (String)session.getAttribute("userid");
		//System.out.println("현재 아이디 : " + curUserId);
		
		if(curUserId == null || curUserId.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			
			AnswerVO usevo = new AnswerVO();
			usevo.setA_no(a_no);
			usevo.setQ_id(curUserId);
			// 현재 접속한 사람이 설문조사에 참여한 이력이 있는지 조사한다.
			List<AnswerVO> answerList = as.getAnalysisAnswerList(usevo);
			int answerListSize = answerList.size();
			
			// 또한 문항 정보와 문제에 따른 문항 정보를 가져온다.
			List<AnalysisDAO> analList = as.getAnalysisQuestionList(a_no);
			List<AnalysisDAO> selectList = as.getAnalysisSelectList();
			
			// 접속중인 유저가 응답한 복수 문항 처리
			AnswerVO temp = new AnswerVO();
			temp.setQ_id(curUserId);
			List<AnswerVO> answerListMulti = as.getAnalysisAnswerMulti(temp);
			
			/*Iterator<AnswerVO> it = answerList.iterator();
			while(it.hasNext()) {
				System.out.println("정보 : " + it.next().toString());
			}*/
			
			model.addAttribute("questionList", analList);
			model.addAttribute("selectList", selectList);
			model.addAttribute("answerList", answerList);
			model.addAttribute("answerListMulti", answerListMulti);
			model.addAttribute("answerListSize", answerListSize);
			
			return "analysisList";
		}
	}
	
	// 사용자가 단수 응답 문제에 응답했을때, ajax 통신을 처리한다.
	@RequestMapping(value="/analysisUpdate.do")
	@ResponseBody
	public String analysisUpdate(AnswerVO answerVO) {
		//System.out.println(answerVO.toString());
		List<AnswerVO> check = as.getAnalysisAnswer(answerVO);
		int result = 0;
		if(check.size() > 0) {
			// 문항에 이미 체크했다면, 이미 체크된 값을 update 처리한다.
			AnswerVO vo = new AnswerVO();
			vo.setQ_no(answerVO.getQ_no());
			vo.setA_isetc(1);
			result = as.deleteAnswer(vo);
			result = as.inputAnalysisUpdate(answerVO);
		} else {
			// 해당 문제에 응답한 적이 없다면, insert로 처리한다.
			AnswerVO vo = new AnswerVO();
			vo.setQ_no(answerVO.getQ_no());
			vo.setA_isetc(1);
			result = as.deleteAnswer(vo);
			result = as.inputAnalysisAnswer(answerVO);
		}
		// 쿼리 결과가 올바르지 않으면 error 발생.
		return String.valueOf(result);
	}
	
	// 사용자가 복수 문항에 응답했을때 처리되는 로직
	@RequestMapping(value="/analysisUpdateMulti.do")
	@ResponseBody
	public String analysisUpdateMulti(AnswerVO answerVO) {
		//System.out.println(answerVO.toString());
		
		// 기타 문항에 여러번 체크했을 경우, 이전에 입력했던 값은 삭제한다.
		List<AnswerVO> check = as.getAnalysisAnswer(answerVO);
		Iterator<AnswerVO> it = check.iterator();
		while(it.hasNext()) {
			AnswerVO vo = it.next();
			int etc = vo.getA_isetc();
			//System.out.println("isetc 있냐 : " + vo.toString());
			if(etc == 1) {
				as.deleteAnswer(answerVO);
			}
		}
		
		// 복수문항은 '/' separator를 통해 추가되어 전송되므로, 해당 값을 분리하는 작업을 한다.
		String conflictedValue = answerVO.getQ_value();
		String conflictedAnswer = answerVO.getA_value();
		String[] converted = conflictedValue.split("/");
		String[] convertedAnswer = conflictedAnswer.split("/");
		
		if(check.size() == 1) {
			as.deleteAnswer(answerVO);
		}
		
		int result = 0;
		// 그 외에 복수문항에 체크한 이력이 있을 경우, 경우에 따라 update로 처리하거나,
		// 그렇지 않은 경우 insert로 처리한다.
		if(check.size() > 1) {
			for(int i = 0; i<converted.length; i++) {
				AnswerVO vo = new AnswerVO();
				vo.setQ_no(answerVO.getQ_no());
				vo.setA_isetc(1);
				as.deleteAnswer(vo);
				
				answerVO.setQ_value(converted[i]);
				answerVO.setA_value(convertedAnswer[i]);
				answerVO.setA_order(i);
				result = as.inputAnalysisUpdate(answerVO);
			}
		} else {
			if(converted.length == 2) {
				for(int i = 0; i<converted.length; i++) {
					AnswerVO vo = new AnswerVO();
					vo.setQ_no(answerVO.getQ_no());
					vo.setA_isetc(1);
					as.deleteAnswer(vo);
					
					answerVO.setQ_value(converted[i]);
					answerVO.setA_value(convertedAnswer[i]);
					answerVO.setA_order(i);
					result = as.inputAnalysisAnswer(answerVO);
				}
			}
		}
		
		// 만약 사용자가 없음에 체크했을 경우 원래 값을 삭제한다.
		if(conflictedAnswer.contains("없음")) {
			as.deleteAnswer(answerVO);
			answerVO.setQ_value(converted[0]);
			answerVO.setA_value(convertedAnswer[0]);
			as.inputAnalysisAnswer(answerVO);
		}
		
		return String.valueOf(result);
	}
	
	// 사용자가 기타에 값을 입력했을때 처리하는 로직.
	@RequestMapping(value="/etcInput.do")
	@ResponseBody
	public String etcInput(AnswerVO answerVO) {
		//System.out.println(answerVO.toString());
		
		// 기타에 체크한 값이 있을 경우, 경우에 따라 update 혹은 insert로 처리한다.
		List<AnswerVO> checkTemp = as.getAnalysisAnswer(answerVO);
		int result = 0;
		if(checkTemp.size() >= 1) {
			result = as.inputAnalysisUpdate(answerVO);
		} else {
			result = as.inputAnalysisAnswer(answerVO);
		}
		return String.valueOf(result);
	}
	
	// 주관식 문제에 응답했을 경우 처리하는 로직.
	@RequestMapping(value="/subjectInput.do")
	@ResponseBody
	public String subjectInput(AnswerVO answerVO) {
		System.out.println(answerVO.toString());
		List<AnswerVO> check = as.getAnalysisAnswer(answerVO);
		int result = 0;
		
		// 경우에 맞게 insert 또는 update로 처리한다.
		if(check.size() >= 1) {
			result = as.inputAnalysisUpdate(answerVO);
		} else {
			result = as.inputAnalysisAnswer(answerVO);
		}
		return String.valueOf(result);
	}
	
	// 설문을 완료했을 경우
	@RequestMapping(value="/analysisComplete.do")
	public String analysisComplete(Model model, HttpServletRequest request, HttpSession session) {
		
		String curId = (String)session.getAttribute("userid");
		AnswerVO comVO = new AnswerVO();
		comVO.setQ_id(curId);
		
		// 설문조사 완료 테이블에 해당 정보를 입력하고, 원래 게시판 페이지로 이동시킨다.
		as.userAnalysisComplete(comVO);
		model.addAttribute("msg", "설문조사가 완료되었습니다.");
		model.addAttribute("href", request.getContextPath() + "/boardList.do?page_no=1&pageSize=10");
		return "alert";
	}
}
