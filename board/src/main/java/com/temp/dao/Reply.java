package com.temp.dao;

public class Reply {

	int reply_no;
	int reply_board;
	String reply_writer;
	String reply_userid;
	String reply_date;
	String reply_content;
	
	
	public Reply() {
		super();
	}

	public Reply(int reply_no, int reply_board, String reply_writer, String reply_userid, String reply_date, String reply_content) {
		super();
		this.reply_no = reply_no;
		this.reply_board = reply_board;
		this.reply_writer = reply_writer;
		this.reply_userid = reply_userid;
		this.reply_date = reply_date;
		this.reply_content = reply_content;
	}

	public int getReply_no() {
		return reply_no;
	}
	
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	
	public int getReply_board() {
		return reply_board;
	}
	
	public void setReply_board(int reply_board) {
		this.reply_board = reply_board;
	}
	
	public String getReply_writer() {
		return reply_writer;
	}
	
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	
	public String getReply_userid() {
		return reply_userid;
	}
	
	public void setReply_userid(String reply_userid) {
		this.reply_userid = reply_userid;
	}
	
	public String getReply_date() {
		return reply_date;
	}
	
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	
	public String getReply_content() {
		return reply_content;
	}
	
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	@Override
	public String toString() {
		return "Reply [reply_no=" + reply_no + ", reply_board=" + reply_board + ", reply_writer=" + reply_writer
				+ ", reply_userid=" + reply_userid + ", reply_date=" + reply_date + ", reply_content=" + reply_content
				+ "]";
	}


}
