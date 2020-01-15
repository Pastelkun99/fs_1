package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.AnswerVO;
import com.fusion1.dao.InfoVO;
import com.fusion1.dao.QuestionVO;
import com.fusion1.dao.SelectVO;

@Service
public class AnalysisServiceImpl implements AnalysisService {

	@Autowired
	@Resource(name = "sqlSession")
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "analysisMapper";

	@Override
	public InfoVO getAnalysisInfo(int no) {
		return sqlSession.selectOne(NAMESPACE + ".getAnalysisInfo", no);
	}
	
	@Override
	public List<InfoVO> getAnalysisInfoAvalList() {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisInfoAvalList");
	} 
	
	@Override
	public List<InfoVO> getAnalysisInfoList() {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisInfoList");
	}

	@Override
	public List<AnalysisDAO> getAnalysisQuestionList(int a_no) {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisQuestionList", a_no);
	}

	@Override
	public List<AnalysisDAO> getAnalysisSelectList() {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisSelectList");
	}

	@Override
	public List<AnswerVO> getAnalysisAnswerList(AnswerVO answerVO) {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisAnswerList", answerVO);
	}

	@Override
	public List<AnswerVO> getAnalysisAnswer(AnswerVO answerVO) {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisAnswer", answerVO);
	}

	@Override
	public int inputAnalysisAnswer(AnswerVO answerVO) {
		return sqlSession.insert(NAMESPACE + ".inputAnalysisAnswer", answerVO);
	}

	@Override
	public int inputAnalysisUpdate(AnswerVO answerVO) {
		return sqlSession.update(NAMESPACE + ".inputAnalysisUpdate", answerVO);
	}

	@Override
	public List<AnswerVO> getAnalysisAnswerMulti(AnswerVO answerVO) {
		return sqlSession.selectList(NAMESPACE + ".getAnalysisAnswerMulti", answerVO);
	}

	@Override
	public int deleteAnswer(AnswerVO answerVO) {
		return sqlSession.delete(NAMESPACE + ".deleteAnswer", answerVO);
	}

	@Override
	public int userAnalysisComplete(AnswerVO answerVO) {
		return sqlSession.delete(NAMESPACE + ".userAnalysisComplete", answerVO);
	}

	@Override
	public List<AnswerVO> userAnalysisConfirm(AnswerVO answerVO) {
		return sqlSession.selectList(NAMESPACE + ".userAnalysisConfirm", answerVO);
	}

	@Override
	public List<SelectVO> getSelectList() {
		return sqlSession.selectList(NAMESPACE + ".getSelectList");
	}

	@Override
	public QuestionVO getQuestionInfo(QuestionVO questionVO) {
		return sqlSession.selectOne(NAMESPACE + ".getQuestionInfo", questionVO);
	}

	@Override
	public int updateQuestion(QuestionVO questionVO) {
		return sqlSession.update(NAMESPACE + ".updateQuestion", questionVO);
	}

	@Override
	public List<SelectVO> getSelectionList() {
		return sqlSession.selectList(NAMESPACE + ".getSelectionList");
	}

	@Override
	public int appendQuestion(QuestionVO questionVO) {
		return sqlSession.insert(NAMESPACE + ".appendQuestion", questionVO);
	}

	@Override
	public QuestionVO getQuestionCount(int a_no) {
		return sqlSession.selectOne(NAMESPACE + ".getQuestionCount", a_no);
	}

	@Override
	public int deleteQuestion(QuestionVO questionVO) {
		return sqlSession.delete(NAMESPACE + ".deleteQuestion", questionVO);
	}

	@Override
	public List<SelectVO> getSelectionInfo(int q_selection) {
		return sqlSession.selectList(NAMESPACE + ".getSelectionInfo", q_selection);
	}

	@Override
	public SelectVO getSelectionOddCount() {
		return sqlSession.selectOne(NAMESPACE + ".getSelectionOddCount");
	}

	@Override
	public SelectVO getSelectionEvenCount() {
		return sqlSession.selectOne(NAMESPACE + ".getSelectionEvenCount");
	}

	@Override
	public int inputSelectionGroup(SelectVO selectVO) {
		return sqlSession.insert(NAMESPACE + ".inputSelectionGroup", selectVO);
	}

	@Override
	public SelectVO getSelectionInfoValue(SelectVO selectVO) {
		return sqlSession.selectOne(NAMESPACE + ".getSelectionInfoValue", selectVO);
	}

	@Override
	public int updateSelect(SelectVO selectVO) {
		return sqlSession.update(NAMESPACE + ".updateSelect", selectVO);
	}

	@Override
	public InfoVO getAnalysisCount() {
		return sqlSession.selectOne(NAMESPACE + ".getAnalysisCount");
	}

	@Override
	public int inputAnalysisInfo(InfoVO infoVO) {
		return sqlSession.insert(NAMESPACE + ".inputAnalysisInfo", infoVO);
	}

	@Override
	public int infoUpdate(InfoVO infoVO) {
		return sqlSession.update(NAMESPACE + ".infoUpdate", infoVO);
	}

	@Override
	public int infoDelete(InfoVO infoVO) {
		return sqlSession.delete(NAMESPACE + ".infoDelete", infoVO);
	}

	@Override
	public int infoDeleteTrigger(InfoVO infoVO) {
		return sqlSession.delete(NAMESPACE + ".infoDeleteTrigger", infoVO);
	}

	@Override
	public int selectionAppend(SelectVO selectVO) {
		return sqlSession.insert(NAMESPACE + ".selectionAppend", selectVO);
	}

	@Override
	public SelectVO getSelectionInfoCount(int q_selection) {
		return sqlSession.selectOne(NAMESPACE + ".getSelectionInfoCount", q_selection);
	}

	@Override
	public int deleteSelection(SelectVO selectVO) {
		return sqlSession.delete(NAMESPACE + ".deleteSelection", selectVO);
	}

}
