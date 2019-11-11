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
	public int getBoardCount() {
		return sqlsession.selectOne("boardMapper.getBoardCount");
	}

	@Override
	public List<BoardVO> getBoardSearch(PagenationVO page) {
		return sqlsession.selectList("boardMapper.getBoardSearchList", page);
	}

	
}
