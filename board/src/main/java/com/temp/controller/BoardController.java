package com.temp.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.temp.dao.Board;
import com.temp.dao.PagenationVO;
import com.temp.dao.Reply;
import com.temp.service.BoardServiceImpl;
import com.temp.service.ReplyServiceImpl;

@Controller()
public class BoardController {
	
	@Autowired
	BoardServiceImpl bs;
	
	@Autowired
	ReplyServiceImpl rs;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main(HttpSession session, Model model, HttpServletRequest request) {
		/*try {
			if(session.getAttribute("user_id") != null) {
				model.addAttribute("msg", "이미 로그인 되어 있습니다. 게시판 페이지로 돌아갑니다.");
				model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
				return "alert";
			} else {
				return "main";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "이미 로그인 되어 있습니다. 게시판 페이지로 돌아갑니다.");
			model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
			return "alert";
		}*/
		String currentUser = (String)session.getAttribute("user_id");
		if(currentUser == null || currentUser.equals("")) {
			return "main";
		} else {
			model.addAttribute("msg", "이미 로그인 되어 있습니다. 게시판 페이지로 돌아갑니다.");
			model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
			return "alert";
		}
	}
	
	@RequestMapping(value="/main.do", method=RequestMethod.GET)
	public String selectBoardList(@RequestParam(value="page", defaultValue="1") int page_no, Model model) {
		
		int totalCount = bs.selectBoardCount();
		int listCount = 10;
		int totalPage = totalCount / listCount;
		if(totalCount % listCount > 0) {
			totalPage++;
		}
		
		PagenationVO page = new PagenationVO();
		page.setPage_no(page_no);
		page.setTotalCount(totalCount);
		page.setPageList(listCount);
		page.setStartPage(1);
		page.setEndPage(totalPage);
		
		// 페이지가 1일 때, totalcount = 총 게시글 수 고정
		// pageList = 10 고정
		// endpage = 게시글 수에 따른 max페이지
		
		List<Board> boardlist = bs.selectBoardList(page);
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("totalPage", totalPage);
		return "boardList";
	}
	
	@RequestMapping(value="/board.do", method=RequestMethod.GET)
	public String selectBoardOne(@RequestParam("boardno") int boardno, Model model, HttpSession session) {
		Board board = bs.selectBoardOne(boardno);
		String convertedContent = board.getBoard_content().replaceAll("\n", "</br>");
		board.setBoard_content(convertedContent);
		model.addAttribute("board", board);
		model.addAttribute("user_id", session.getAttribute("user_id"));
		
		bs.updateBoardHit(boardno);
		
		List<Reply> reply_list = rs.getReplyList2(boardno);
		model.addAttribute("reply_list", reply_list);
		return "board";
	}
	
	@RequestMapping(value="/boardedit.do", method=RequestMethod.GET)
	public String updateBoardOne(@RequestParam int boardno, Model model, HttpSession session, HttpServletRequest request) {
		String currentUser = (String)session.getAttribute("user_id");
		Board board = bs.selectBoardOne(boardno);
		if(currentUser == null || currentUser.equals("")) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?boardno=" + boardno);
			return "alert";
		} else if(currentUser.equals("admin")) {
			model.addAttribute("board", board);
			return "boarde";
		} else if(currentUser.equals(board.getBoard_id())) {
			model.addAttribute("board", board);
			return "boarde";
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?boardno=" + boardno);
			return "alert";
		}
		/*if(session.getAttribute("user_id").equals("admin")) {
			model.addAttribute("board", board);
			return "boarde";
		} else if(board.getBoard_id().equals(session.getAttribute("user_id"))) {
			model.addAttribute("board", board);
			return "boarde";
		} else {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/board.do?boardno=" + boardno);
			return "alert";
		}*/
	}
	
	@RequestMapping(value="/boardedit.do", method=RequestMethod.POST)
	public String updateBoardOne(@RequestParam("boardno") int board_no, @RequestParam("board_title") String board_title,
								 @RequestParam("board_content") String board_content, Model model, 
								 HttpServletRequest request, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("board_title", board_title);
		map.put("board_content", board_content);
		bs.updateBoardOne(map);			
		model.addAttribute("msg", "게시글 수정이 완료되었습니다.");
		model.addAttribute("href", request.getContextPath()+"/board.do?boardno="+board_no);
		return "alert";
	}
	
	@RequestMapping(value="/boardDelete.do", method=RequestMethod.GET)
	public String deleteBoardOne(@RequestParam("boardno") int board_no, Model model, HttpServletRequest request, HttpSession session) {
		Board board = bs.selectBoardOne(board_no);
		try {
			if(session.getAttribute("user_id").equals("admin")) {
				int result = bs.deleteBoardOne(board_no);
				if(result != 1) {
					model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
					model.addAttribute("href", "board.do?boardno=" + board_no);
					return "alert";
				} else {
					model.addAttribute("msg", "게시글 삭제에 성공했습니다.");
					model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
					return "alert";
				}
			} else if(board.getBoard_id().equals(session.getAttribute("user_id"))) {
				int result = bs.deleteBoardOne(board_no);
				if(result != 1) {
					model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
					model.addAttribute("href", "board.do?boardno=" + board_no);
					return "alert";
				} else {
					model.addAttribute("msg", "게시글 삭제에 성공했습니다.");
					model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
					return "alert";
				}
			} else {
				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("href", request.getContextPath() + "/board.do?boardno=" + board_no);
				return "alert";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "로그인 후 다시 시도해주세요.");
			model.addAttribute("href", request.getContextPath() + "/");
			return "alert";
		}
	}
	
	@RequestMapping(value="/boardWrite.do", method=RequestMethod.GET)
	public String writeBoardOne(Model model) {
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
		Date currentTime = new Date();
		String date = formatter.format(currentTime);
		model.addAttribute("date", date);
		return "boardw";
	}
	
	@RequestMapping(value="/boardWrite.do", method=RequestMethod.POST)
	public String writeBoardOne(Model model, HttpServletRequest request, HttpSession session,
								@RequestParam("board_title") String board_title,
								@RequestParam("board_content") String board_content) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_writer", session.getAttribute("username"));
		map.put("board_id", session.getAttribute("user_id"));
		map.put("board_title", board_title);
		map.put("board_content", board_content);
		int result = bs.writeBoardOne(map);
		if(result != 1) {
			model.addAttribute("msg", "게시글 등록에 실패했습니다..");
			model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
		} else {
			model.addAttribute("msg", "게시글 등록이 완료되었습니다.");
			model.addAttribute("href", request.getContextPath() + "/main.do?page=1");
		}
		return "alert";
	}
	
	@RequestMapping(value="/boardSearch.do", method=RequestMethod.GET)
	public String boardSearch(@RequestParam("keyword") String keyword, @RequestParam("page") int page_no, Model model) {

		int totalCount = bs.selectBoardCountSearch(keyword);
		int listCount = 10;
		int totalPage = totalCount / listCount;
		if(totalCount == 0) {
			totalPage = 1;
		}
		if(totalCount % listCount > 0) {
			totalPage++;
		}
		
		PagenationVO page = new PagenationVO();
		page.setPage_no(page_no);
		page.setTotalCount(totalCount);
		page.setPageList(listCount);
		page.setStartPage(1);
		page.setEndPage(totalPage);
		page.setKeyword(keyword);
		
		List<Board> searchBoardList = bs.searchBoardList(page);
		/*Iterator<Board> it = searchBoardList.iterator();
		while(it.hasNext()) {
			System.out.println(it.next().toString());
		}*/
		model.addAttribute("boardlist", searchBoardList);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("keyword", keyword);
		model.addAttribute("totalCount", totalCount);
		return "boardSearchList";
	}
}
