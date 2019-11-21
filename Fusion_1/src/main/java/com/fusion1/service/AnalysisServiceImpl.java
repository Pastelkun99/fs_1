package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.InfoVO;

@Service
public class AnalysisServiceImpl implements AnalysisService{
	
	@Autowired
	@Resource(name="sqlSession")
	SqlSession sqlSession;

	@Override
	public InfoVO getAnalysisInfo(int no) {
		return sqlSession.selectOne("analysisMapper.getAnalysisInfo", no);
	}

	@Override
	public List<AnalysisDAO> getAnalysisQuestionList() {
		return sqlSession.selectList("analysisMapper.getAnalysisQuestionList");
	}

	@Override
	public List<AnalysisDAO> getAnalysisSelectList() {
		return sqlSession.selectList("analysisMapper.getAnalysisSelectList");
	}

	@Override
	public List<AnalysisDAO> getAnalysisAnswerList(String userid) {
		return sqlSession.selectList("analysisMapper.getAnalysisAnswerList", userid);
	}
	
}
