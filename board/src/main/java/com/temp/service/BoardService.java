package com.temp.service;

import java.util.List;
import java.util.Map;

import com.temp.dao.Board;
import com.temp.dao.PagenationVO;

public interface BoardService {

	// 게시판 목록 받아오기
	public List<Board> selectBoardList(PagenationVO page);
	
	// 게시글 갯수 받아오기
	public int selectBoardCount();
	
	// 해당 게시글 댓글 갯수 불러오기
	public int countReply(int board_no);
	
	// 게시글 검색하기
	public List<Board> searchBoardList(PagenationVO page);
	
	// 검색 데이터의 게시글 갯수
	public int selectBoardCountSearch(String keyword);
	
	// 특정 글 상세보기
	public Board selectBoardOne(int boardno);
	
	// 조회수 up
	public int updateBoardHit(int boardno);
	
	// 게시글 수정
	public int updateBoardOne(Map<String, Object> map);
	
	// 게시글 삭제
	public int deleteBoardOne(int boardno);
	
	// 게시글 등록
	public int writeBoardOne(Map<String, Object> map);
	
}
