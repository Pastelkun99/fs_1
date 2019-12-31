package com.fusion1.dao;

import java.io.Serializable;

public class UserVO implements Serializable {

	private int userno;
	private String userid;
	private String userpw;
	private String username;
	private int user_admin;
	private int user_aval;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpw() {
		return userpw;
	}

	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public int getUser_admin() {
		return user_admin;
	}

	public void setUser_admin(int user_admin) {
		this.user_admin = user_admin;
	}

	public int getUser_aval() {
		return user_aval;
	}

	public void setUser_aval(int user_aval) {
		this.user_aval = user_aval;
	}

	@Override
	public String toString() {
		return "UserVO [userno=" + userno + ", userid=" + userid + ", userpw=" + userpw + ", username=" + username
				+ "]";
	}

}
