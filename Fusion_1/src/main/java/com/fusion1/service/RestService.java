package com.fusion1.service;

import java.util.List;

import com.fusion1.dao.UserVO;

public interface RestService {

	// 유저 리스트 불러오기
	public List<UserVO> getUserList();
	
	// parameter가 있는 유저 리스트를 불러오기
	public List<UserVO> getUserList2(String id);
	
	// 유저 추가
	public int userAppend(UserVO userVO);

	// 유저 수정
	public int userModify(UserVO userVO);
	
	// 유저 삭제
	public int userDelete(String id);
	                                                                                                                                                                               
}
