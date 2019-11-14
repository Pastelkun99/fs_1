package com.fusion1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.ReplyDAOImpl;
import com.fusion1.dao.ReplyVO;


@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	ReplyDAOImpl dao;

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

}
