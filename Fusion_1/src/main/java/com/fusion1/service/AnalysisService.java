package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.InfoVO;

public interface AnalysisService {

	// 설문조사 정보를 불러온다.
	public InfoVO getAnalysisInfo(int no);
	
	// 설문지 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisQuestionList();
	
	// 문항 리스트를 불러온다.
	public List<AnalysisDAO> getAnalysisSelectList();
	
	// 미리 체크한 정답 리스트를 갖고 온다.
	public List<AnalysisDAO> getAnalysisAnswerList(String userid);
	
}
