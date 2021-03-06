package com.temp.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.dao.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	@Override
	public User userLoginCheck(String inputID) {
		return sqlSession.selectOne("userMapper.userLoginCheck", inputID);
	}

	@Override
	public int userRegister(Map<String, Object> tempMap) {
		return sqlSession.insert("userMapper.userRegister", tempMap);
	}

	@Override
	public User userIdCheck(String regId) {
		return sqlSession.selectOne("userMapper.userIdCheck", regId);
	}

}
