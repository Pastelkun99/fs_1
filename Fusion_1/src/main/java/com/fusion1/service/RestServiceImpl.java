package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.UserVO;

@Service
public class RestServiceImpl implements RestService {
	
	private static final String NAMESPACE = "restMapper";
	
	
	@Autowired
	@Resource(name="sqlSession")
	SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList() {
		return sqlSession.selectList(NAMESPACE + ".getUserList");
	}

	@Override
	public List<UserVO> getUserList2(String id) {
		return sqlSession.selectList(NAMESPACE + ".getUserList2", id);
	}

	@Override
	public int userAppend(UserVO userVO) {
		return sqlSession.insert(NAMESPACE + ".userAppend", userVO);
	}

	@Override
	public int userModify(UserVO userVO) {
		return sqlSession.update(NAMESPACE + ".userModify", userVO);
	}

	@Override
	public int userDelete(String id) {
		return sqlSession.delete(NAMESPACE + ".userDelete", id);
	}

}
