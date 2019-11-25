package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.AnswerVO;
import com.fusion1.dao.InfoVO;

public interface AnalysisService {

	// 설문조사 정보를 불러온다.
	public InfoVO getAnalysisInfo(int no);
	
	// 설문지 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisQuestionList();
	
	// 문항 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisSelectList();
	
	// 미리 체크한 정답 리스트를 갖고 온다.
	public List<AnswerVO> getAnalysisAnswerList(String userid);
	
	// 미리 체크한 정답 리스트를 갖고 온다(복수 문항)
	public List<AnswerVO> getAnalysisAnswerMulti(AnswerVO answerVO);
	
	// 없음에 체크한 경우 원래 값을 지운다
	public int deleteAnswer(AnswerVO answerVO);
	
	// 정답을 체크하면 그 값을 데이터베이스에 삽입한다.
	public int inputAnalysisAnswer(AnswerVO answerVO);
	
	// 정답을 삽입하기 전, 해당 문항에 체크한 답안이 있는지 불러온다.
	public List<AnswerVO> getAnalysisAnswer(AnswerVO answerVO);
	
	// 미리 체크한 답안이 있다면, 다시 클릭했을때 업데이트로 처리한다.
	public int inputAnalysisUpdate(AnswerVO answerVO);
	
	// 설문조사가 완료된다.
	public int userAnalysisComplete(AnswerVO answerVO);
	
	// 설문 조사 재입장시 해당 유저의 입장 여부를 파악한다.
	public List<AnswerVO> userAnalysisConfirm(AnswerVO answerVO);
	
}
