package com.temp.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.dao.Board;
import com.temp.dao.PagenationVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlSession;

	@Override
	public List<Board> selectBoardList(PagenationVO page) {
		return sqlSession.selectList("boardMapper.selectBoardList", page);
	}

	@Override
	public int selectBoardCount() {
		return sqlSession.selectOne("boardMapper.selectBoardCount");
	}
	
	@Override
	public int selectBoardCountSearch(String keyword) {
		return sqlSession.selectOne("boardMapper.selectBoardCountSearch", keyword);
	}
	
	@Override
	public Board selectBoardOne(int boardno) {
		return sqlSession.selectOne("boardMapper.selectBoardOne", boardno);
	}

	@Override
	public int updateBoardHit(int boardno) {
		return sqlSession.update("boardMapper.updateBoardHit", boardno);
	}

	@Override
	public int updateBoardOne(Map<String, Object> map) {
		return sqlSession.update("boardMapper.updateBoardOne", map);
	}

	@Override
	public int deleteBoardOne(int boardno) {
		return sqlSession.update("boardMapper.deleteBoardOne", boardno);
	}

	@Override
	public int writeBoardOne(Map<String, Object> map) {
		return sqlSession.insert("boardMapper.writeBoardOne", map);
	}

	@Override
	public int countReply(int board_no) {
		return sqlSession.selectOne("boardMapper.countReply", board_no);
	}

	@Override
	public List<Board> searchBoardList(PagenationVO page) {
		return sqlSession.selectList("boardMapper.boardSearch", page);
	}


}
