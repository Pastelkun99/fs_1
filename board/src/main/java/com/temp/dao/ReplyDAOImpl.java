package com.temp.dao;

import java.util.List;
import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlSession;

	@Override
	public int replyWrite(Reply reply) {
		return sqlSession.insert("replyMapper.replyWrite", reply);
	}

	@Override
	public List<Reply> getReplyList(Reply reply) {
		return sqlSession.selectList("replyMapper.getReplyList", reply);
	}

	@Override
	public int deleteReply(Reply reply) {
		return sqlSession.delete("replyMapper.deleteReply", reply);
	}

	@Override
	public List<Reply> getReplyList2(int boardno) {
		return sqlSession.selectList("replyMapper.getReplyList2", boardno);
	}

	@Override
	public int updateReplyConfirm(Reply reply) {
		return sqlSession.update("replyMapper.updateReplyConfirm", reply);
	}

}
