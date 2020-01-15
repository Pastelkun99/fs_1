package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.BoardVO;
import com.fusion1.dao.PagenationVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlsession;
	
	private static final String NAMESPACE = "boardMapper";

	@Override
	public List<BoardVO> getBoardList(PagenationVO page) {
		return sqlsession.selectList(NAMESPACE + ".getBoardList", page);
	}

	@Override
	public BoardVO getBoardOne(int board_no) {
		return sqlsession.selectOne(NAMESPACE + ".getBoardOne", board_no);
	}
	
	@Override
	public int updateBoardHit(int board_no) {
		return sqlsession.update(NAMESPACE + ".updateBoardHit", board_no);
	}

	@Override
	public int getBoardCount() {
		return sqlsession.selectOne(NAMESPACE + ".getBoardCount");
	}

	@Override
	public List<BoardVO> getBoardSearchList(PagenationVO page) {
		return sqlsession.selectList(NAMESPACE + ".getBoardSearchList", page);
	}

	@Override
	public int getBoardSearchCount(PagenationVO page) {
		return sqlsession.selectOne(NAMESPACE + ".getBoardSearchCount", page);
	}

	@Override
	public int updateBoardOne(BoardVO boardVO) {
		return sqlsession.update(NAMESPACE + ".updateBoardOne", boardVO);
	}

	@Override
	public int deleteBoardOne(BoardVO boardVO) {
		return sqlsession.update(NAMESPACE + ".deleteBoardOne", boardVO);
	}

	@Override
	public int insertBoardOne(BoardVO boardVO) {
		return sqlsession.insert(NAMESPACE + ".insertBoardOne", boardVO);
	}

	@Override
	public int reWriteBoard(BoardVO boardVO) {
		return sqlsession.insert(NAMESPACE + ".reWriteBoard", boardVO);
	}

	@Override
	public int updateBoardParent(int parents_no) {
		return sqlsession.update(NAMESPACE + ".updateBoardParent", parents_no);
	}

	@Override
	public int reWriteGroupOrder(BoardVO boardVO) {
		return sqlsession.update(NAMESPACE + ".reWriteGroupOrder", boardVO);
	}

	@Override
	public int reWriteGroupingAvailable(BoardVO boardVO) {
		return sqlsession.selectOne(NAMESPACE + ".reWriteGroupingAvailable", boardVO);
	}

	@Override
	public List<BoardVO> getBoardNotice(int notice) {
		return sqlsession.selectList(NAMESPACE + ".getBoardNotice", notice);
	}

	
	
}
