package com.fusion2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	
	@RequestMapping(value="/user/userSignUp.do", method=RequestMethod.GET)
	public String userSignUp() {
		return "user/userSignUp";
	}
	
	@RequestMapping(value="/user/userIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String userIdCheck() {
		return "";
	}

}
