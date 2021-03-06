package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.ReplyDAOImpl;
import com.fusion1.dao.ReplyVO;


@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	ReplyDAOImpl dao;
	
	@Autowired
	@Resource(name="sqlSession")
	SqlSession sqlSession;

	private static final String NAMESPACE = "replyMapper";
	
	@Override
	public int replyWrite(ReplyVO reply) {
		return dao.replyWrite(reply);
	}

	@Override
	public List<ReplyVO> getReplyList(ReplyVO reply) {
		return dao.getReplyList(reply);
	}

	@Override
	public int deleteReply(ReplyVO reply) {
		return dao.deleteReply(reply);
	}

	@Override
	public List<ReplyVO> getReplyList2(int boardno) {
		return dao.getReplyList2(boardno);
	}

	@Override
	public int updateReplyConfirm(ReplyVO reply) {
		return dao.updateReplyConfirm(reply);
	}

	@Override
	public int updateReplyParentsNo(ReplyVO reply) {
		return dao.updateReplyParentsNo(reply);
	}

	@Override
	public ReplyVO getReplyOne() {
		return dao.getReplyOne();
	}

	@Override
	public ReplyVO getReplyOneByNo(int reply_no) {
		return dao.getReplyOneByNo(reply_no);
	}

	@Override
	public int reReplyGroupOrder(ReplyVO replyVO) {
		return dao.reReplyGroupOrder(replyVO);
	}

	@Override
	public int reReplyWriteAction(ReplyVO replyVO) {
		return dao.reReplyWriteAction(replyVO);
	}

	@Override
	public int replyLikeAndHateAction(ReplyVO replyVO) {
		return sqlSession.insert(NAMESPACE + ".replyLikeAndHateAction", replyVO);
	}

	@Override
	public int replyLikeAndHateScoreAdjust(ReplyVO replyVO) {
		return sqlSession.update(NAMESPACE + ".replyLikeAndHateScoreAdjust", replyVO);
	}

	@Override
	public ReplyVO replyLikeAndHateConfirm(ReplyVO replyVO) {
		return sqlSession.selectOne(NAMESPACE + ".replyLikeAndHateConfirm", replyVO);
	}

	@Override
	public int replyLikeAndHateLogAdjust(ReplyVO replyVO) {
		return sqlSession.update(NAMESPACE + ".replyLikeAndHateLogAdjust", replyVO);
	}

	@Override
	public int replyLikeAndHateScoreAdjust2(ReplyVO replyVO) {
		return sqlSession.update(NAMESPACE + ".replyLikeAndHateScoreAdjust2", replyVO);
	}
	
	

}
