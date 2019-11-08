package com.temp.service;

import java.util.Map;

import com.temp.dao.User;

public interface UserService {

	// 로그인 시 유저 ID, PW 비교용 쿼리
	public User userLoginCheck(String inputID);
	
	// 유저 등록 메소드
	public int userRegister(Map<String, Object> tempMap);
	
	// 유저 아이디 중복 검사
	public User userIdCheck(String regId);
}
