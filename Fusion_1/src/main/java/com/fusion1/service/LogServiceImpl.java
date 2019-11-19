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

	@Override
	public List<LogVO> getLogList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogList", dateMap);
	}
	
	@Override
	public List<LogVO> getLogNameList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogNameList", dateMap);
	}
	
	@Override
	public List<LogVO> getLogOSList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogOSList", dateMap);
	}
	
	@Override
	public List<LogVO> getBrowserList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogBrowserList", dateMap);
	}
	
	@Override
	public List<LogVO> getTimeList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getTimeList", dateMap);
	}
	
	@Override
	public List<LogVO> getTimeTotalList() {
		return sqlSession.selectList("logMapper.getTimeTotalList");
	}
	
	@Override
	public List<LogVO> getReferrerList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogReferList", dateMap);
	}
	
	@Override
	public List<LogVO> getWeekOfDaysList(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getWeekOfDaysList", dateMap);
	}
	
	@Override
	public int logWrite(LogVO logVO) {
		return sqlSession.insert("logMapper.logWrite", logVO);
	}

	@Override
	public int logDelete(LogVO logVO) {
		return sqlSession.delete("logMapper.logDelete", logVO);
	}

	@Override
	public List<LogVO> getLogExcel(Map<String, Object> dateMap) {
		return sqlSession.selectList("logMapper.getLogExcel", dateMap);
	}


	
}
