package com.fusion1.dao;

public class ReadNoticeVO {

	private int read_no;
	private String user_id;
	private int article_no;

	public int getRead_no() {
		return read_no;
	}

	public void setRead_no(int read_no) {
		this.read_no = read_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getArticle_no() {
		return article_no;
	}

	public void setArticle_no(int article_no) {
		this.article_no = article_no;
	}

	@Override
	public String toString() {
		return "ReadNoticeVO [read_no=" + read_no + ", user_id=" + user_id + ", article_no=" + article_no + "]";
	}

}
