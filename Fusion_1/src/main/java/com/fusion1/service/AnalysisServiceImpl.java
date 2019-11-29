package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@Override
	public InfoVO getAnalysisInfo(int no) {
		return sqlSession.selectOne("analysisMapper.getAnalysisInfo", no);
	}
	
	@Override
	public List<InfoVO> getAnalysisInfoAvalList() {
		return sqlSession.selectList("analysisMapper.getAnalysisInfoAvalList");
	}
	
	@Override
	public List<InfoVO> getAnalysisInfoList() {
		return sqlSession.selectList("analysisMapper.getAnalysisInfoList");
	}

	@Override
	public List<AnalysisDAO> getAnalysisQuestionList(int a_no) {
		return sqlSession.selectList("analysisMapper.getAnalysisQuestionList", a_no);
	}

	@Override
	public List<AnalysisDAO> getAnalysisSelectList() {
		return sqlSession.selectList("analysisMapper.getAnalysisSelectList");
	}

	@Override
	public List<AnswerVO> getAnalysisAnswerList(AnswerVO answerVO) {
		return sqlSession.selectList("analysisMapper.getAnalysisAnswerList", answerVO);
	}

	@Override
	public List<AnswerVO> getAnalysisAnswer(AnswerVO answerVO) {
		return sqlSession.selectList("analysisMapper.getAnalysisAnswer", answerVO);
	}

	@Override
	public int inputAnalysisAnswer(AnswerVO answerVO) {
		return sqlSession.insert("analysisMapper.inputAnalysisAnswer", answerVO);
	}

	@Override
	public int inputAnalysisUpdate(AnswerVO answerVO) {
		return sqlSession.update("analysisMapper.inputAnalysisUpdate", answerVO);
	}

	@Override
	public List<AnswerVO> getAnalysisAnswerMulti(AnswerVO answerVO) {
		return sqlSession.selectList("analysisMapper.getAnalysisAnswerMulti", answerVO);
	}

	@Override
	public int deleteAnswer(AnswerVO answerVO) {
		return sqlSession.delete("analysisMapper.deleteAnswer", answerVO);
	}

	@Override
	public int userAnalysisComplete(AnswerVO answerVO) {
		return sqlSession.delete("analysisMapper.userAnalysisComplete", answerVO);
	}

	@Override
	public List<AnswerVO> userAnalysisConfirm(AnswerVO answerVO) {
		return sqlSession.selectList("analysisMapper.userAnalysisConfirm", answerVO);
	}

	@Override
	public List<SelectVO> getSelectList() {
		return sqlSession.selectList("analysisMapper.getSelectList");
	}

	@Override
	public QuestionVO getQuestionInfo(QuestionVO questionVO) {
		return sqlSession.selectOne("analysisMapper.getQuestionInfo", questionVO);
	}

	@Override
	public int updateQuestion(QuestionVO questionVO) {
		return sqlSession.update("analysisMapper.updateQuestion", questionVO);
	}

	@Override
	public List<SelectVO> getSelectionList() {
		return sqlSession.selectList("analysisMapper.getSelectionList");
	}

	@Override
	public int appendQuestion(QuestionVO questionVO) {
		return sqlSession.insert("analysisMapper.appendQuestion", questionVO);
	}

	@Override
	public QuestionVO getQuestionCount(int a_no) {
		return sqlSession.selectOne("analysisMapper.getQuestionCount", a_no);
	}

	@Override
	public int deleteQuestion(QuestionVO questionVO) {
		return sqlSession.delete("analysisMapper.deleteQuestion", questionVO);
	}

	@Override
	public List<SelectVO> getSelectionInfo(int q_selection) {
		return sqlSession.selectList("analysisMapper.getSelectionInfo", q_selection);
	}

	@Override
	public SelectVO getSelectionOddCount() {
		return sqlSession.selectOne("analysisMapper.getSelectionOddCount");
	}

	@Override
	public SelectVO getSelectionEvenCount() {
		return sqlSession.selectOne("analysisMapper.getSelectionEvenCount");
	}

	@Override
	public int inputSelectionGroup(SelectVO selectVO) {
		return sqlSession.insert("analysisMapper.inputSelectionGroup", selectVO);
	}

	@Override
	public SelectVO getSelectionInfoValue(SelectVO selectVO) {
		return sqlSession.selectOne("analysisMapper.getSelectionInfoValue", selectVO);
	}

	@Override
	public int updateSelect(SelectVO selectVO) {
		return sqlSession.update("analysisMapper.updateSelect", selectVO);
	}

	@Override
	public InfoVO getAnalysisCount() {
		return sqlSession.selectOne("analysisMapper.getAnalysisCount");
	}

	@Override
	public int inputAnalysisInfo(InfoVO infoVO) {
		return sqlSession.insert("analysisMapper.inputAnalysisInfo", infoVO);
	}

	@Override
	public int infoUpdate(InfoVO infoVO) {
		return sqlSession.update("analysisMapper.infoUpdate", infoVO);
	}

	@Override
	public int infoDelete(InfoVO infoVO) {
		return sqlSession.delete("analysisMapper.infoDelete", infoVO);
	}

	@Override
	public int infoDeleteTrigger(InfoVO infoVO) {
		return sqlSession.delete("analysisMapper.infoDeleteTrigger", infoVO);
	}

	@Override
	public int selectionAppend(SelectVO selectVO) {
		return sqlSession.insert("analysisMapper.selectionAppend", selectVO);
	}

	@Override
	public SelectVO getSelectionInfoCount(int q_selection) {
		return sqlSession.selectOne("analysisMapper.getSelectionInfoCount", q_selection);
	}

	@Override
	public int deleteSelection(SelectVO selectVO) {
		return sqlSession.delete("analysisMapper.deleteSelection", selectVO);
	}

	
	

}
