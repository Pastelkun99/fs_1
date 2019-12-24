package com.fusion1.dao;

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
	public int replyWrite(ReplyVO reply) {
		return sqlSession.insert("replyMapper.replyWrite", reply);
	}

	@Override
	public List<ReplyVO> getReplyList(ReplyVO reply) {
		return sqlSession.selectList("replyMapper.getReplyList", reply);
	}

	@Override
	public int deleteReply(ReplyVO reply) {
		return sqlSession.delete("replyMapper.deleteReply", reply);
	}

	@Override
	public List<ReplyVO> getReplyList2(int boardno) {
		return sqlSession.selectList("replyMapper.getReplyList2", boardno);
	}

	@Override
	public int updateReplyConfirm(ReplyVO reply) {
		return sqlSession.update("replyMapper.updateReplyConfirm", reply);
	}

	@Override
	public int updateReplyParentsNo(ReplyVO reply) {
		return sqlSession.update("replyMapper.updateReplyParentsNo", reply);
	}

	@Override
	public ReplyVO getReplyOne() {
		return sqlSession.selectOne("replyMapper.getReplyOne");
	}

	@Override
	public ReplyVO getReplyOneByNo(int reply_no) {
		return sqlSession.selectOne("replyMapper.getReplyOneByNo", reply_no);
	}

	@Override
	public int reReplyGroupOrder(ReplyVO reply) {
		return sqlSession.update("replyMapper.reReplyGroupOrder", reply);
	}

	@Override
	public int reReplyWriteAction(ReplyVO reply) {
		return sqlSession.insert("replyMapper.reReplyWriteAction", reply);
	}
}
