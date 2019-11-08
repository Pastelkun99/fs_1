package com.temp.service;

import java.util.List;

import com.temp.dao.Reply;

public interface ReplyService {
	
	// 댓글 작성
	public int replyWrite(Reply reply);
	
	// 댓글 리스트
	public List<Reply> getReplyList(Reply reply);
	
	public List<Reply> getReplyList2(int boardno);
	
	// 댓글 삭제
	public int deleteReply(Reply reply);
	
	// 댓글 수정 확인
	public int updateReplyConfirm(Reply reply);

}
