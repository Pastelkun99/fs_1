package com.fusion1.dao;

public class ArticleVO {

	private int article_no;
	private int board_no;
	private String article_writer;
	private String article_userid;
	private String article_title;
	private String article_content;
	private String article_secretyn;
	private String article_password;
	private int article_parentsno;
	private int article_grouporder;
	private int article_groupdepth;
	private int article_hit;
	private String article_date;
	private String article_deleteyn;
	private String article_noticeyn;
	private int cnt;
	private String menu_name;
	
	private String board_name;
	private int reply_cnt;

	public int getArticle_no() {
		return article_no;
	}

	public void setArticle_no(int article_no) {
		this.article_no = article_no;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getArticle_writer() {
		return article_writer;
	}

	public void setArticle_writer(String article_writer) {
		this.article_writer = article_writer;
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

	public String getArticle_secretyn() {
		return article_secretyn;
	}

	public void setArticle_secretyn(String article_secretyn) {
		this.article_secretyn = article_secretyn;
	}

	public String getArticle_password() {
		return article_password;
	}

	public void setArticle_password(String article_password) {
		this.article_password = article_password;
	}

	public int getArticle_parentsno() {
		return article_parentsno;
	}

	public void setArticle_parentsno(int article_parentsno) {
		this.article_parentsno = article_parentsno;
	}

	public int getArticle_grouporder() {
		return article_grouporder;
	}

	public void setArticle_grouporder(int article_grouporder) {
		this.article_grouporder = article_grouporder;
	}

	public int getArticle_groupdepth() {
		return article_groupdepth;
	}

	public void setArticle_groupdepth(int article_groupdepth) {
		this.article_groupdepth = article_groupdepth;
	}

	public int getArticle_hit() {
		return article_hit;
	}

	public void setArticle_hit(int article_hit) {
		this.article_hit = article_hit;
	}

	public String getArticle_date() {
		return article_date;
	}

	public void setArticle_date(String article_date) {
		this.article_date = article_date;
	}

	public String getArticle_deleteyn() {
		return article_deleteyn;
	}

	public void setArticle_deleteyn(String article_deleteyn) {
		this.article_deleteyn = article_deleteyn;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getArticle_noticeyn() {
		return article_noticeyn;
	}

	public void setArticle_noticeyn(String article_noticeyn) {
		this.article_noticeyn = article_noticeyn;
	}
	
	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	
	public int getReply_cnt() {
		return reply_cnt;
	}

	public void setReply_cnt(int reply_cnt) {
		this.reply_cnt = reply_cnt;
	}

	@Override
	public String toString() {
		return "ArticleVO [article_no=" + article_no + ", board_no=" + board_no + ", article_writer=" + article_writer
				+ ", article_userid=" + article_userid + ", article_title=" + article_title + ", article_content="
				+ article_content + ", article_secretyn=" + article_secretyn + ", article_password=" + article_password
				+ ", article_parentsno=" + article_parentsno + ", article_grouporder=" + article_grouporder
				+ ", article_groupdepth=" + article_groupdepth + ", article_hit=" + article_hit + ", article_date="
				+ article_date + ", article_deleteyn=" + article_deleteyn + ", article_noticeyn=" + article_noticeyn
				+ ", cnt=" + cnt + ", menu_name=" + menu_name + ", board_name=" + board_name + ", reply_cnt="
				+ reply_cnt + "]";
	}

}
