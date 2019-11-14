package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	@Resource(name="sqlSession")
	SqlSession sqlsession;

	@Override
	public UserVO userLogin(String inputID) {
		return sqlsession.selectOne("userMapper.userLogin", inputID);
	}

	@Override
	public int userRegister(UserVO uservo) {
		return sqlsession.insert("userMapper.userRegister", uservo);
	}

	@Override
	public UserVO userIdCheck(String inputID) {
		return sqlsession.selectOne("userMapper.userLogin", inputID);
	}

	
	

}