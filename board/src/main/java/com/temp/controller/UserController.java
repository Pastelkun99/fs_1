package com.temp.controller;

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

import com.temp.dao.User;
import com.temp.service.BoardServiceImpl;
import com.temp.service.UserServiceImpl;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserServiceImpl us;
	
	@Autowired
	BoardServiceImpl bs;
	
	@RequestMapping(value="/userlogin.do", method=RequestMethod.GET)
	public String userLogin() {
		return "";
	}

	@RequestMapping(value="/userlogin.do", method=RequestMethod.POST)
	public String userLogin(@RequestParam String inputID, @RequestParam String inputPassword, HttpServletRequest request,
							Model model, HttpSession session) {
		try {
			User user = us.userLoginCheck(inputID);
			if(inputPassword.equals(user.getUser_password())) {
				model.addAttribute("msg", "로그인에 성공하였습니다.");
				model.addAttribute("href", request.getContextPath()+"/main.do?page=1");
				session.setAttribute("username", user.getUser_name());
				session.setAttribute("user_id", user.getUser_id());
				return "alert";
			}
			else {
				model.addAttribute("msg", "로그인 정보가 잘못되었습니다.");
				model.addAttribute("href", request.getContextPath() + "/");
				return "alert";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "로그인 정보가 잘못되었습니다.");
			model.addAttribute("href", request.getContextPath() + "/");
			return "alert";
		}
	}
	
	@RequestMapping(value="/userSignUp.do", method=RequestMethod.GET)
	public String userSignUp() {
		return "user/userSignUp";
	}
	
	@RequestMapping(value="/userSignUp.do", method=RequestMethod.POST)
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
				Map<String, Object> tempMap = new HashMap<String, Object>();
				tempMap.put("regID", regID);
				tempMap.put("regPassword", regPassword);
				tempMap.put("regName", regName);
				int result = us.userRegister(tempMap);
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
	
	@RequestMapping(value="/userIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String userIdCheck(HttpServletRequest request, Model model) {
		String regId = request.getParameter("regId");
		int result = 0;
		if(regId == null || regId.equals("")) {
			result = 0;
		} else {
			User userCheck = us.userIdCheck(regId);
			if(userCheck == null) {
				result = 1;
			} else {
				result = 0;
			}
		}
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/userSignOut.do", method=RequestMethod.GET)
	public String userSignOut(Model model, HttpSession session, HttpServletRequest request) {
		session.invalidate();
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("href", request.getContextPath()+"/");
		return "alert";
	}
}
