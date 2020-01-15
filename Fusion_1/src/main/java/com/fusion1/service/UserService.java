package com.fusion1.service;

import java.util.List;
import java.util.Map;

import com.fusion1.dao.IndividualVO;
import com.fusion1.dao.UserVO;

public interface UserService {

	// 로그인
	public UserVO userExistCheck(String inputID);
	
	// 유저 등록
	public int userRegister(UserVO userVO);
	
	// 관리자 재 확인
	public UserVO adminCheck(UserVO userVO);
	
	// 유저 1명의 정보 불러오기
	public UserVO getUserInfo(String userID); 
	
	// 유저리스트 불러오기
	public List<UserVO> getUserList();
	
	// 유저 정보 업데이트
	public int userInfoUpdate(UserVO userVO);
	
	// 유저 개인 페이지용 메서드
	// 유저 개인이 쓴 게시글 리스트 불러오기
	public List<IndividualVO> getUserIndividualInfoList(UserVO userVO);
	
	// 게시글 넘버에 따라 글 리스트 불러오기
	public List<IndividualVO> getUserIndividualInfoListByBoardNo(Map<String, Object> infoMap);
	
}
