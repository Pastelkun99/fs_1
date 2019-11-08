package com.temp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/errors")
public class ErrorController {

	@RequestMapping("/")
	public String getErrorPage() {
		return "error";
	}
}
