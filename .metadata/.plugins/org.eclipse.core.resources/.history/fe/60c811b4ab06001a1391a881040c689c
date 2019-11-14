package com.temp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.dao.Reply;
import com.temp.dao.ReplyDAOImpl;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	ReplyDAOImpl dao;

	@Override
	public int replyWrite(Reply reply) {
		return dao.replyWrite(reply);
	}

	@Override
	public List<Reply> getReplyList(Reply reply) {
		return dao.getReplyList(reply);
	}

	@Override
	public int deleteReply(Reply reply) {
		return dao.deleteReply(reply);
	}

	@Override
	public List<Reply> getReplyList2(int boardno) {
		return dao.getReplyList2(boardno);
	}

	@Override
	public int updateReplyConfirm(Reply reply) {
		return dao.updateReplyConfirm(reply);
	}

}
