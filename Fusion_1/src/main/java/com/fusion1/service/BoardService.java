package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.BoardVO;
import com.fusion1.dao.PagenationVO;

public interface BoardService {

	// 게시글 목록 불러오기
	public List<BoardVO> getBoardList(PagenationVO page);
	
	// 게시글 갯수 불러오기
	public int getBoardCount();
	
	// 게시글 하나 불러오기
	public BoardVO getBoardOne(int board_no);
	
	// 특정 검색어 게시글 검색결과 불러오기
	public List<BoardVO> getBoardSearch(PagenationVO page);
}
