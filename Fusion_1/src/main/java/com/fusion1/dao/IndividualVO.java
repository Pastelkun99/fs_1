package com.fusion1.dao;

public class IndividualVO {

	private String menu_name;
	private int board_no;
	private int article_no;
	private String article_userid;
	private String article_title;
	private String article_content;
	private int cnt;
	
	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getArticle_no() {
		return article_no;
	}

	public void setArticle_no(int article_no) {
		this.article_no = article_no;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getArticle_userid() {
		return article_userid;
	}

	public void setArticle_userid(String article_userid) {
		this.article_userid = article_userid;
	}

	public String getArticle_title() {
		return article_title;
	}

	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}

	public String getArticle_content() {
		return article_content;
	}

	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "IndividualVO [menu_name=" + menu_name + ", board_no=" + board_no + ", article_no=" + article_no
				+ ", article_userid=" + article_userid + ", article_title=" + article_title + ", article_content="
				+ article_content + ", cnt=" + cnt + "]";
	}

	

}
