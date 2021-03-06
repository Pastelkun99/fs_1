package com.fusion1.dao;

public class BoardVO {
	
	private int board_no;
	private String board_writer;
	private String board_userid;
	private String board_title;
	private String board_content;
	private int board_deletecon;
	private String board_date;
	private int board_hit;
	private int board_parentsno;
	private int board_grouporder;
	private int board_groupdepth;
	private int board_isnotice;
	
	public int getBoard_no() {
		return board_no;
	}
	
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	
	public String getBoard_writer() {
		return board_writer;
	}
	
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	
	public String getBoard_userid() {
		return board_userid;
	}
	
	public void setBoard_userid(String board_userid) {
		this.board_userid = board_userid;
	}
	
	public String getBoard_title() {
		return board_title;
	}
	
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	
	public String getBoard_content() {
		return board_content;
	}
	
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	
	public int getBoard_deletecon() {
		return board_deletecon;
	}
	
	public void setBoard_deletecon(int board_deletecon) {
		this.board_deletecon = board_deletecon;
	}
	
	public String getBoard_date() {
		return board_date;
	}
	
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	
	public int getBoard_hit() {
		return board_hit;
	}

	public void setBoard_hit(int board_hit) {
		this.board_hit = board_hit;
	}

	public int getBoard_parentsno() {
		return board_parentsno;
	}
	
	public void setBoard_parentsno(int board_parentsno) {
		this.board_parentsno = board_parentsno;
	}
	
	public int getBoard_grouporder() {
		return board_grouporder;
	}
	
	public void setBoard_grouporder(int board_grouporder) {
		this.board_grouporder = board_grouporder;
	}
	
	public int getBoard_groupdepth() {
		return board_groupdepth;
	}
	
	public void setBoard_groupdepth(int board_groupdepth) {
		this.board_groupdepth = board_groupdepth;
	}
	
	public int getBoard_isnotice() {
		return board_isnotice;
	}

	public void setBoard_isnotice(int board_isnotice) {
		this.board_isnotice = board_isnotice;
	}

	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_writer=" + board_writer + ", board_userid=" + board_userid
				+ ", board_title=" + board_title + ", board_content=" + board_content + ", board_deletecon="
				+ board_deletecon + ", board_date=" + board_date + ", board_hit=" + board_hit + ", board_parentsno="
				+ board_parentsno + ", board_grouporder=" + board_grouporder + ", board_groupdepth=" + board_groupdepth
				+ ", board_isnotice=" + board_isnotice + "]";
	}

	
}
