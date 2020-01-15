package com.fusion1.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.LogVO;

@Service
public class LogServiceImpl implements LogService {

	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "logMapper";

	@Override
	public List<LogVO> getLogList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogList", dateMap);
	}
	
	@Override
	public List<LogVO> getLogNameList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogNameList", dateMap);
	}
	
	@Override
	public List<LogVO> getLogOSList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogOSList", dateMap);
	}
	
	@Override
	public List<LogVO> getBrowserList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogBrowserList", dateMap);
	}
	
	@Override
	public List<LogVO> getTimeList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getTimeList", dateMap);
	}
	
	@Override
	public List<LogVO> getTimeTotalList() {
		return sqlSession.selectList(NAMESPACE + ".getTimeTotalList");
	}
	
	@Override
	public List<LogVO> getReferrerList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogReferList", dateMap);
	}
	
	@Override
	public List<LogVO> getWeekOfDaysList(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getWeekOfDaysList", dateMap);
	}
	
	@Override
	public int logWrite(LogVO logVO) {
		return sqlSession.insert(NAMESPACE + ".logWrite", logVO);
	}

	@Override
	public int logDelete(LogVO logVO) {
		return sqlSession.delete(NAMESPACE + ".logDelete", logVO);
	}

	@Override
	public List<LogVO> getLogExcel(Map<String, Object> dateMap) {
		return sqlSession.selectList(NAMESPACE + ".getLogExcel", dateMap);
	}


	
}
