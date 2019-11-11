package com.fusion1.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fusion1.dao.BoardVO;
import com.fusion1.dao.PagenationVO;
import com.fusion1.service.BoardServiceImpl;
import com.temp.dao.Board;


@Controller
public class BoardController {
	
	@Autowired
	BoardServiceImpl bs;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value="/boardList.do", method=RequestMethod.GET)
	public String boardList(HttpSession session, Model model, @RequestParam("pageno") int page_no, @RequestParam("pageSize") int pageSize) {
		String currentID = (String)session.getAttribute("userid");
		
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			int totalBoardCount = bs.getBoardCount();
			int pageCount = totalBoardCount / pageSize;
			if(totalBoardCount % pageSize > 0) {
				pageCount++;
			}
			
			PagenationVO page = new PagenationVO();
			page.setPage_no(page_no);
			page.setTotalCount(totalBoardCount);
			page.setPageList(pageSize);
			page.setStartPage(1);
			page.setPageCon((page_no*pageSize)-pageSize);
			page.setEndPage(pageCount);
			
			//System.out.println(page.toString());
			List<BoardVO> list = bs.getBoardList(page);
			model.addAttribute("boardlist", list);
			model.addAttribute("page", page);
			model.addAttribute("pageSize", pageSize);
			return "boardList";
		}
	}
	
	@RequestMapping(value="/board.do", method=RequestMethod.GET)
	public String board(HttpSession session, @RequestParam("boardno") int board_no, Model model) {
		String currentID = (String)session.getAttribute("userid");
		
		if(currentID == null || currentID.equals("")) {
			model.addAttribute("msg", "로그인 후 이용할 수 있는 서비스 입니다.");
			model.addAttribute("href", "/");
			return "alert";
		} else {
			int totalcount = bs.getBoardCount();
			BoardVO boardvo = bs.getBoardOne(board_no);
			model.addAttribute("board", boardvo);
			model.addAttribute("totalCnt", totalcount);
			return "board";
		}
	}
	
	@RequestMapping(value="/boardSearch.do", method=RequestMethod.GET)
	public String boardSearch(@RequestParam("keyword") String keyword, @RequestParam("pageno") int page_no, @RequestParam("pageSize") int pageSize,
							  @RequestParam("searchKeyword") String searchKeyword, Model model) {

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
