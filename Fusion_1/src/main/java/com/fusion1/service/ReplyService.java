package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.ReplyVO;

public interface ReplyService {
	
	// 댓글 작성
	public int replyWrite(ReplyVO reply);
	
	// 댓글 리스트
	public List<ReplyVO> getReplyList(ReplyVO reply);
	
	public List<ReplyVO> getReplyList2(int boardno);
	
	// 댓글 삭제
	public int deleteReply(ReplyVO reply);
	
	// 댓글 수정 확인
	public int updateReplyConfirm(ReplyVO reply);

}