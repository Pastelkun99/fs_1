package com.temp.dao;

public class User {

	int user_no;
	String user_id;
	String user_password;
	String user_name;
	String user_regdate;
	
	public User() {
		super();
	}

	public User(int user_no, String user_id, String user_password, String user_name, String user_regdate) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_name = user_name;
		this.user_regdate = user_regdate;
	}

	public int getUser_no() {
		return user_no;
	}
	
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	public String getUser_id() {
		return user_id;
	}
	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public String getUser_password() {
		return user_password;
	}
	
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getUser_regdate() {
		return user_regdate;
	}
	
	public void setUser_regdate(String user_regdate) {
		this.user_regdate = user_regdate;
	}

	@Override
	public String toString() {
		return "User [user_no=" + user_no + ", user_id=" + user_id + ", user_password=" + user_password + ", user_name="
				+ user_name + ", user_regdate=" + user_regdate + "]";
	}
	
}
