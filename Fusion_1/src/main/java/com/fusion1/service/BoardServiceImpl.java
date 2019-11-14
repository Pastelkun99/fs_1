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

	@Override
	public List<BoardVO> getBoardList(PagenationVO page) {
		return sqlsession.selectList("boardMapper.getBoardList", page);
	}

	@Override
	public BoardVO getBoardOne(int board_no) {
		return sqlsession.selectOne("boardMapper.getBoardOne", board_no);
	}
	
	@Override
	public int updateBoardHit(int board_no) {
		return sqlsession.update("boardMapper.updateBoardHit", board_no);
	}

	@Override
	public int getBoardCount() {
		return sqlsession.selectOne("boardMapper.getBoardCount");
	}

	@Override
	public List<BoardVO> getBoardSearchList(PagenationVO page) {
		return sqlsession.selectList("boardMapper.getBoardSearchList", page);
	}

	@Override
	public int getBoardSearchCount(PagenationVO page) {
		return sqlsession.selectOne("boardMapper.getBoardSearchCount", page);
	}

	@Override
	public int updateBoardOne(BoardVO boardVO) {
		return sqlsession.update("boardMapper.updateBoardOne", boardVO);
	}

	@Override
	public int deleteBoardOne(BoardVO boardVO) {
		return sqlsession.update("boardMapper.deleteBoardOne", boardVO);
	}

	@Override
	public int insertBoardOne(BoardVO boardVO) {
		return sqlsession.insert("boardMapper.insertBoardOne", boardVO);
	}

	@Override
	public int reWriteBoard(BoardVO boardVO) {
		return sqlsession.insert("boardMapper.reWriteBoard", boardVO);
	}

	@Override
	public int updateBoardParent(int parents_no) {
		return sqlsession.update("boardMapper.updateBoardParent", parents_no);
	}

	@Override
	public int reWriteGroupOrder(BoardVO boardVO) {
		return sqlsession.update("boardMapper.reWriteGroupOrder", boardVO);
	}

	@Override
	public int reWriteGroupingAvailable(BoardVO boardVO) {
		return sqlsession.selectOne("boardMapper.reWriteGroupingAvailable", boardVO);
	}

	@Override
	public List<BoardVO> getBoardNotice(int notice) {
		return sqlsession.selectList("boardMapper.getBoardNotice", notice);
	}

	
	
}
