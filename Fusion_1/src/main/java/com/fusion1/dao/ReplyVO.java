package com.fusion1.dao;

public class ReplyVO {

	int reply_no;
	int article_no;
	String reply_writer;
	String reply_userid;
	String reply_date;
	String reply_content;
	int reply_parentsno;
	int reply_score;
	String orderType;
	int level;
	int cnt;
	
	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getArticle_no() {
		return article_no;
	}

	public void setArticle_no(int article_no) {
		this.article_no = article_no;
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

	public int getReply_parentsno() {
		return reply_parentsno;
	}

	public void setReply_parentsno(int reply_parentsno) {
		this.reply_parentsno = reply_parentsno;
	}


	public int getReply_score() {
		return reply_score;
	}

	public void setReply_score(int reply_score) {
		this.reply_score = reply_score;
	}
	
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "ReplyVO [reply_no=" + reply_no + ", article_no=" + article_no + ", reply_writer=" + reply_writer
				+ ", reply_userid=" + reply_userid + ", reply_date=" + reply_date + ", reply_content=" + reply_content
				+ ", reply_parentsno=" + reply_parentsno + ", reply_score=" + reply_score + ", orderType=" + orderType
				+ ", level=" + level + ", cnt=" + cnt + "]";
	}


}
