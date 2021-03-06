package com.temp.dao;

public class Board {

	int board_no;
	String board_writer;
	String board_id;
	String board_title;
	String board_content;
	int board_hit;
	String board_date;
	int board_deletecon;
	
	
	public Board() {
		super();
	}

	public Board(int board_no, String board_writer, String board_id, String board_title, String board_content, int board_hit, String board_date,
			int board_deletecon) {
		super();
		this.board_no = board_no;
		this.board_writer = board_writer;
		this.board_id = board_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_hit = board_hit;
		this.board_date = board_date;
		this.board_deletecon = board_deletecon;
	}

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
	
	public String getBoard_id() {
		return board_id;
	}
	
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
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
	
	public int getBoard_hit() {
		return board_hit;
	}
	
	public void setBoard_hit(int board_hit) {
		this.board_hit = board_hit;
	}
	
	public String getBoard_date() {
		return board_date;
	}
	
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	
	public int getBoard_deletecon() {
		return board_deletecon;
	}
	
	public void setBoard_deletecon(int board_deletecon) {
		this.board_deletecon = board_deletecon;
	}

	@Override
	public String toString() {
		return "Board [board_no=" + board_no + ", board_writer=" + board_writer + ", board_id="+ board_id + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", board_hit=" + board_hit + ", board_date=" + board_date
				+ ", board_deletecon=" + board_deletecon + "]";
	}

	
}
