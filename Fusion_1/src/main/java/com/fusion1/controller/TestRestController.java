package com.fusion1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fusion1.dao.UserVO;
import com.fusion1.service.RestServiceImpl;

@RestController
public class TestRestController {
	
	@Autowired
	RestServiceImpl us;

	@RequestMapping(value="/main/UserList.do", method=RequestMethod.GET)
	public List<UserVO> getUserList() {
		return us.getUserList();
	}
	
	@RequestMapping(value="/main/UserList2.do/{id}", method=RequestMethod.GET)
	public List<UserVO> getUserList2(@PathVariable String id) {
		return us.getUserList2(id);
	}
	
	@RequestMapping(value="/main/userAppend.do", method=RequestMethod.POST)
	public int userAppend(@RequestBody UserVO userVO) {
		int result = us.userAppend(userVO);
		return result;
	}
	
	@RequestMapping(value="/main/userModify.do", method=RequestMethod.PUT)
	public int userModify(@RequestBody UserVO userVO) {
		int result = us.userModify(userVO);
		return result;
	}
	
	@RequestMapping(value="/main/userDelete.do/{id}", method=RequestMethod.DELETE)
	public int userDelete(@PathVariable String id) {
		int result = us.userDelete(id);
		return result;
	}
	
}
