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
	
	// 게시글 하나 조회수 up
	public int updateBoardHit(int board_no);
	
	// 게시글 검색 결과 갯수 불러오기
	public int getBoardSearchCount(PagenationVO page);
	
	// 특정 검색어 게시글 검색결과 불러오기
	public List<BoardVO> getBoardSearchList(PagenationVO page);
	
	// 게시글 업데이트 하기
	public int updateBoardOne(BoardVO boardVO);
	
	// 게시글 날려버리기
	public int deleteBoardOne(BoardVO boardVO);

	// 게시글 등록하기
	public int insertBoardOne(BoardVO boardVO);
	
	// 게시글 등록 시 parentsno를 바꾸기 위한 메소드
	public int updateBoardParent(int parents_no);
	
	// 답글 쓰기
	public int reWriteBoard(BoardVO boardVO);
	
	// 그룹핑 여부 체크
	public int reWriteGroupingAvailable(BoardVO boardVO);
	
	// 답글 작성 시 그룹핑
	public int reWriteGroupOrder(BoardVO boardVO);
	
	// 공지사항 불러오기
	public List<BoardVO> getBoardNotice(int notice);
}
