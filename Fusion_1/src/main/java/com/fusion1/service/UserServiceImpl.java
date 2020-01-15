package com.fusion1.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.IndividualVO;
import com.fusion1.dao.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	private static final String NAMESPACE = "userMapper.";

	@Autowired
	@Resource(name="sqlSession")
	SqlSession sqlsession;

	@Override
	public UserVO userExistCheck(String inputID) {
		return sqlsession.selectOne(NAMESPACE + "userExistCheck", inputID);
	}

	@Override
	public int userRegister(UserVO userVO) {
		return sqlsession.insert(NAMESPACE + "userRegister", userVO);
	}

	@Override
	public UserVO adminCheck(UserVO userVO) {
		return sqlsession.selectOne(NAMESPACE + "getAdminInfo", userVO);
	}

	@Override
	public List<UserVO> getUserList() {
		return sqlsession.selectList(NAMESPACE + "getUserList");
	}

	@Override
	public UserVO getUserInfo(String userId) {
		return sqlsession.selectOne(NAMESPACE + "getUserInfo", userId);
	}

	@Override
	public int userInfoUpdate(UserVO userVO) {
		return sqlsession.update(NAMESPACE + "userInfoUpdate", userVO);
	}

	@Override
	public List<IndividualVO> getUserIndividualInfoList(UserVO userVO) {
		return sqlsession.selectList(NAMESPACE + "getUserIndividualInfoList", userVO);
	}

	@Override
	public List<IndividualVO> getUserIndividualInfoListByBoardNo(Map<String, Object> infoMap) {
		return sqlsession.selectList(NAMESPACE + "getUserIndividualInfoListByBoardNo", infoMap);
	}
	

}
