package com.fusion1.dao;

import java.util.List;

public interface ReplyDAO {

	// 댓글 작성
	public int replyWrite(ReplyVO reply);

	// 댓글 리스트
	public List<ReplyVO> getReplyList(ReplyVO reply);

	public List<ReplyVO> getReplyList2(int boardno);

	// 댓글 삭제
	public int deleteReply(ReplyVO reply);

	// 댓글 수정
	public int updateReplyConfirm(ReplyVO reply);
	
	// 댓글 parentsno 업데이트
	public int updateReplyParentsNo(ReplyVO reply);
	
	// 댓글 정보 가져오기
	public ReplyVO getReplyOne();
	
	// 댓글 정보 가져오기
	public ReplyVO getReplyOneByNo(int reply_no);
	
	// 댓글 정보 재정렬
	public int reReplyGroupOrder(ReplyVO reply);
	
	// 대댓글 작성하기
	public int reReplyWriteAction(ReplyVO reply);
	
}
