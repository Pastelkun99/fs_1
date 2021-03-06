package com.fusion1.dao;


public class MultiBoardVO {

	private int board_no;
	private String board_name;
	private int board_type;
	private String board_reboardyn;
	private String board_replyyn;
	private String board_secretyn;
	private int cnt;
	private int board_order;
	private int menu_no;
	private int board_maintanence;
	private String board_url;
	
	private String user_id;

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public int getBoard_type() {
		return board_type;
	}

	public void setBoard_type(int board_type) {
		this.board_type = board_type;
	}

	public String getBoard_reboardyn() {
		return board_reboardyn;
	}

	public void setBoard_reboardyn(String board_reboardyn) {
		this.board_reboardyn = board_reboardyn;
	}

	public String getBoard_replyyn() {
		return board_replyyn;
	}

	public void setBoard_replyyn(String board_replyyn) {
		this.board_replyyn = board_replyyn;
	}

	public String getBoard_secretyn() {
		return board_secretyn;
	}

	public void setBoard_secretyn(String board_secretyn) {
		this.board_secretyn = board_secretyn;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public int getBoard_order() {
		return board_order;
	}

	public void setBoard_order(int board_order) {
		this.board_order = board_order;
	}
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	
	public int getBoard_maintanence() {
		return board_maintanence;
	}

	public void setBoard_maintanence(int board_maintanence) {
		this.board_maintanence = board_maintanence;
	}

	public String getBoard_url() {
		return board_url;
	}

	public void setBoard_url(String board_url) {
		this.board_url = board_url;
	}

	@Override
	public String toString() {
		return "MultiBoardVO [board_no=" + board_no + ", board_name=" + board_name + ", board_type=" + board_type
				+ ", board_reboardyn=" + board_reboardyn + ", board_replyyn=" + board_replyyn + ", board_secretyn="
				+ board_secretyn + ", cnt=" + cnt + ", board_order=" + board_order + ", menu_no=" + menu_no
				+ ", board_maintanence=" + board_maintanence + ", board_url=" + board_url + ", user_id=" + user_id
				+ "]";
	}


}
