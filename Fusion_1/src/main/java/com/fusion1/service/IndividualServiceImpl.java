package com.fusion1.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.TraceVO;

@Service
public class IndividualServiceImpl implements IndividualService {
	
	private static final String NAMESPACE = "individualMapper";
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlSession;

	@Override
	public TraceVO getCount(Map<String, Object> info) {
		return sqlSession.selectOne(NAMESPACE + ".getCount", info);
	}

}
