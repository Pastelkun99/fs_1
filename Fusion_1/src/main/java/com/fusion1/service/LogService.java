package com.fusion1.service;

import java.util.List;
import java.util.Map;

import com.fusion1.dao.LogVO;

public interface LogService {
	
	// 로그 리스트 불러오기
	public List<LogVO> getLogList();
	
//	// 로그에 남은 이름 불러오기
//	public Map<String, Object> getLogNameList();
	
	public List<LogVO> getTempList();
	
	// 로그 입력
	public int logWrite(LogVO logVO);
	
	// 로그 삭제
	public int logDelete(LogVO logVO);
}
