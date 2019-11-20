package com.fusion1.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.ReplyVO;
import com.fusion1.service.ReplyServiceImpl;


@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	ReplyServiceImpl rs;
	
	// 댓글 작성 프로세스
	@RequestMapping(value="/writeReplyAction")
	@ResponseBody
	public String writeReplyAction(@ModelAttribute ReplyVO reply) {
		// 현재 날짜 정보
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
		Date currentTime = new Date();
		String date = formatter.format(currentTime);
		reply.setReply_date(date);
		
		int result = rs.replyWrite(reply);
		return String.valueOf(result);
	}
	
	// 댓글 리스트 불러오기
	@RequestMapping(value="/getReplyList", method=RequestMethod.GET)
	@ResponseBody
	public List<ReplyVO> getReplyList(@ModelAttribute ReplyVO reply) {
		List<ReplyVO> reply_list = rs.getReplyList(reply);
		return reply_list;
	}
	
	// 댓글 삭제
	@RequestMapping(value="/deleteReply", method=RequestMethod.GET)
	@ResponseBody
	public String deleteReply(@ModelAttribute ReplyVO reply, HttpServletRequest request) {
		int result = rs.deleteReply(reply);
		return String.valueOf(result);
	}
	
	// 댓글 수정 확인
	@RequestMapping(value="/updateReplyConfirm", method=RequestMethod.POST)
	@ResponseBody
	public String updateReplyConfirm(@ModelAttribute ReplyVO reply, HttpServletRequest request) {
		int result = rs.updateReplyConfirm(reply);
		return String.valueOf(result);
	}
}
