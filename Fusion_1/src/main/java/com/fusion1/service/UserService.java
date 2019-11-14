package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.UserVO;

public interface UserService {

	// 로그인
	public UserVO userLogin(String inputID);
	
	// 유저 등록
	public int userRegister(UserVO uservo);
	
	// 유저 아이디 확인
	public UserVO userIdCheck(String inputId);
	
}