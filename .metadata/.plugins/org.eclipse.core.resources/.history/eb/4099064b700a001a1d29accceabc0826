package com.fusion1.service;

import java.util.List;
import java.util.Map;

import com.fusion1.dao.LogVO;

public interface LogService {
	
	// 로그 리스트 불러오기
	public List<LogVO> getLogList(Map<String, Object> dateMap);
	
	// 이름별 접속횟수 로직
	public List<LogVO> getLogNameList(Map<String, Object> dateMap);
	
	// 운영체제별 접속횟수 로직
	public List<LogVO> getLogOSList(Map<String, Object> dateMap);
	
	// 브라우저별 접속횟수 로직
	public List<LogVO> getBrowserList(Map<String, Object> dateMap);
	
	// 접속 시간대별 횟수 로직
	public List<LogVO> getTimeList(Map<String, Object> dateMap);
	
	// 접속 날짜별 리스트 추출
	public List<LogVO> getTimeTotalList();
	
	// 접속 경로별 리스트 추출
	public List<LogVO> getReferrerList(Map<String, Object> dateMap);
	
	// 로그 입력
	public int logWrite(LogVO logVO);
	
	// 로그 삭제
	public int logDelete(LogVO logVO);
	
	// 엑셀 출력을 위한 리스트 불러오기
	public List<LogVO> getLogExcel(Map<String, Object> dateMap);
}
