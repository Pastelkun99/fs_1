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
	public List<LogVO> getLogList() {
		return sqlSession.selectList("logMapper.getLogList");
	}
	
//	@Override
//	public Map<String, Object> getLogNameList() {
//		return sqlSession.selectList("logMapper.getLogNameList");
//	}
	
	@Override
	public int logWrite(LogVO logVO) {
		return sqlSession.insert("logMapper.logWrite", logVO);
	}

	@Override
	public int logDelete(LogVO logVO) {
		return sqlSession.delete("logMapper.logDelete", logVO);
	}

	@Override
	public List<LogVO> getTempList() {
		return sqlSession.selectList("logMapper.tempLogList");
	}


	
}
