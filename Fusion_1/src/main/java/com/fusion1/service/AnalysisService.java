package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.AnswerVO;
import com.fusion1.dao.InfoVO;
import com.fusion1.dao.QuestionVO;
import com.fusion1.dao.SelectVO;

public interface AnalysisService {

	// 설문조사 정보를 불러온다.
	public InfoVO getAnalysisInfo(int no);
	
	// 설문조사 정보 리스트를 불러온다.
	public List<InfoVO> getAnalysisInfoList();
	
	// 현재 설문 가능한 리스트만 불러온다.
	public List<InfoVO> getAnalysisInfoAvalList();
	
	// 설문지 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisQuestionList(int a_no);
	
	// 현재 설문지를 삭제한다.
	public int infoDelete(InfoVO infoVO);
	
	// 설문지가 삭제되었다면, 그 문제에 걸려있는 문항도 함께 삭제한다.
	public int infoDeleteTrigger(InfoVO infoVO);
	
	// 문항 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisSelectList();
	
	// 미리 체크한 정답 리스트를 갖고 온다.
	public List<AnswerVO> getAnalysisAnswerList(AnswerVO answerVO);
	
	// 미리 체크한 정답 리스트를 갖고 온다(복수 문항)
	public List<AnswerVO> getAnalysisAnswerMulti(AnswerVO answerVO);
	
	// 설문조사 정보를 업데이트 한다.
	public int infoUpdate(InfoVO infoVO);
	
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
	
	// 문항 리스트를 불러온다.
	public List<SelectVO> getSelectList();
	
	// 현재 설문조사가 몇개 있는가?
	public InfoVO getAnalysisCount();
	
	// 설문 조사를 등록한다.
	public int inputAnalysisInfo(InfoVO infoVO);
	
	// 문제 하나의 상세 정보
	public QuestionVO getQuestionInfo(QuestionVO questionVO);
	
	// 문제를 신규 등록
	public int appendQuestion(QuestionVO questionVO);
	
	// 문제를 업데이트 한다.
	public int updateQuestion(QuestionVO questionVO);
	
	// 문항 목록을 불러온다.
	public List<SelectVO> getSelectionList();
	
	// 문항을 등록한다.
	public int selectionAppend(SelectVO selectVO);
	
	// 문항을 등록할때 order 판단
	public SelectVO getSelectionInfoCount(int q_selection);
	
	// 문제의 총 갯수를 가져온다.
	public QuestionVO getQuestionCount(int a_no);
	
	// 문제를 삭제한다.
	public int deleteQuestion(QuestionVO questionVO);
	
	// 타입에 맞는 문항 리스트를 가져온다.
	public List<SelectVO> getSelectionInfo(int q_selection);
	
	// 객관식 단수 문항 그룹 생성을 위해 가능한 번호를 불러온다.
	public SelectVO getSelectionOddCount();
	
	// 복수문항
	public SelectVO getSelectionEvenCount();
	
	// 문항 그룹을 db에 등록함.
	public int inputSelectionGroup(SelectVO selectVO);
	
	// 수정할 문항의 정보를 불러온다 (복수 조건)
	public SelectVO getSelectionInfoValue(SelectVO selectVO);
	
	// 문항을 업데이트 한다.
	public int updateSelect(SelectVO selectVO);
	
	// 문항을 삭제한다.
	public int deleteSelection(SelectVO selectVO);
}
