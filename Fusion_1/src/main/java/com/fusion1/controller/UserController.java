package com.fusion1.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.UserVO;
import com.fusion1.service.UserServiceImpl;

@Controller
public class UserController {
	
	@Autowired
	UserServiceImpl us;
	
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.POST)
	public String userLogin(@RequestParam("inputID") String inputID, @RequestParam("inputPassword") String inputPW,
							HttpServletRequest request, Model model,
							HttpSession session) {
		
		UserVO uservo = us.userLogin(inputID);
		if(uservo == null) {
			model.addAttribute("msg", "로그인 정보가 일치하지 않습니다.");
			model.addAttribute("href", request.getContextPath() + "/");
			return "alert";
		} else {
			if(inputPW.equals(uservo.getUserpw())) {
				session.setAttribute("userid", uservo.getUserid());
				session.setAttribute("username", uservo.getUsername());
				model.addAttribute("msg", "로그인에 성공했습니다.");
				model.addAttribute("href", "/boardList.do?pageno=1&pageSize=10");
				return "alert";
			} else {
				model.addAttribute("msg", "로그인 정보가 일치하지 않습니다.");
				model.addAttribute("href", request.getContextPath() + "/");
				return "alert";
			}
		}
	}
	
	@RequestMapping(value="/user/userSignOut.do", method=RequestMethod.GET)
	public String userSignOut(Model model, HttpSession session, HttpServletRequest request) {
		session.invalidate();
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("href", request.getContextPath()+"/");
		return "alert";
	}
	
	@RequestMapping(value="/user/userSignUp.do", method=RequestMethod.GET)
	public String userSignUp() {
		return "userSignUp";
	}
	
	@RequestMapping(value="/user/userIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String userIdCheck(HttpServletRequest request, Model model) {
		String regId = request.getParameter("regId");
		int result = 0;
		if(regId == null || regId.equals("")) {
			result = 0;
		} else {
			UserVO userCheck = us.userIdCheck(regId);
			if(userCheck == null) {
				result = 1;
			} else {
				result = 0;
			}
		}
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/user/userSignUp.do", method=RequestMethod.POST)
	public String userSignUp(@RequestParam("regID") String regID, @RequestParam("regPassword") String regPassword,
							 @RequestParam("regName") String regName, @RequestParam("regPasswordConfirm") String regPasswordConfirm, 
							 Model model, HttpServletRequest request) {

		// 특수문자는 공백 처리
		final String specialCharsRegex = "['\"\\-#()@;=*/+<>]";
		final String sqlRegex = "(union|select|from|where|admin)";
		final Pattern pattern = Pattern.compile(specialCharsRegex, Pattern.CASE_INSENSITIVE);
		final Pattern patterns = Pattern.compile(sqlRegex, Pattern.CASE_INSENSITIVE);
		final Matcher matcher = pattern.matcher(regID);
		final Matcher matcher2 = patterns.matcher(regID);
		
		if(matcher.find() || matcher2.find()) {
			model.addAttribute("msg", "부적절한 아이디를 사용하였습니다. 다시 입력해주십시오.");
			model.addAttribute("href", request.getContextPath() + "/user/userSignUp.do");
			return "alert";
		} else {
			if(regPassword.equals(regPasswordConfirm)) {
				UserVO uservo = new UserVO();
				uservo.setUserid(regID);
				uservo.setUserpw(regPassword);
				uservo.setUsername(regName);
				int result = us.userRegister(uservo);
				if(result != 1) {
					model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
					model.addAttribute("href", request.getContextPath()+"/user/userSignUp.do");
					return "alert";
				} else {
					model.addAttribute("msg", "회원 등록에 성공하였습니다. 등록한 아이디로 로그인해 주십시오.");
					model.addAttribute("href", request.getContextPath() + "/");
					return "alert";
				}
			} else {
				model.addAttribute("msg", "회원등록에 실패하였습니다.");
				model.addAttribute("href", request.getContextPath()+"/user/userSignUp.do");
				return "alert";
			}
		}
	}
}
