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
	
	// 댓글 작성시 parentsno 업데이트
	public int updateReplyParentsNo(ReplyVO reply);
	
	// 방금쓴 댓글 정보 가져오기
	public ReplyVO getReplyOne();
	
	// 번호에 따른 댓글 정보 불러오기
	public ReplyVO getReplyOneByNo(int reply_no);
	
	// 대댓글 처리를 위한 오더 정렬
	public int reReplyGroupOrder(ReplyVO replyVO);
	
	// 대댓글 작성
	public int reReplyWriteAction(ReplyVO replyVO);
	
	// 댓글 좋아요 싫어요 이력 등록
	public int replyLikeAndHateAction(ReplyVO replyVO);
	
	// 좋아요 싫어요 이력 확인
	public ReplyVO replyLikeAndHateConfirm(ReplyVO replyVO);
	
	// 좋아요 싫어요 처리에 관한 score column 조정
	public int replyLikeAndHateScoreAdjust(ReplyVO replyVO);
	
	// 하나의 사용자가 좋아요를 취소하고 싫어요를 누를 경우, 원래 점수를 rollback하고 다시 -1을 해야하므로 -2점의 차이가 발생.
	// 마찬가지로 싫어요를 누른 상태에서 다시 좋아요를 누르는 경우, 원래 -1을 rollback하고 다시 +1 하므로 +2점을 가산해야함.
	public int replyLikeAndHateScoreAdjust2(ReplyVO replyVO);
	
	// 좋아요 싫어요 이력이 있는 경우 해당 정보 업데이트
	public int replyLikeAndHateLogAdjust(ReplyVO replyVO);
	
}
