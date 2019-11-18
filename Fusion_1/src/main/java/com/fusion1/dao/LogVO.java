package com.fusion1.dao;

public class LogVO {

	int log_no;
	String log_userid;
	String log_date;
	String log_userip;
	String log_userbrowser;
	String log_bversion;
	String log_osversion;
	String log_userreferrer;
	int cnt;
	int time;

	public int getLog_no() {
		return log_no;
	}

	public void setLog_no(int log_no) {
		this.log_no = log_no;
	}

	public String getLog_userid() {
		return log_userid;
	}

	public void setLog_userid(String log_userid) {
		this.log_userid = log_userid;
	}
	
	public String getLog_date() {
		return log_date;
	}

	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}

	public String getLog_userip() {
		return log_userip;
	}

	public void setLog_userip(String log_userip) {
		this.log_userip = log_userip;
	}

	public String getLog_userbrowser() {
		return log_userbrowser;
	}

	public void setLog_userbrowser(String log_userbrowser) {
		this.log_userbrowser = log_userbrowser;
	}

	public String getLog_bversion() {
		return log_bversion;
	}

	public void setLog_bversion(String log_bversion) {
		this.log_bversion = log_bversion;
	}

	public String getLog_osversion() {
		return log_osversion;
	}

	public void setLog_osversion(String log_osversion) {
		this.log_osversion = log_osversion;
	}

	public String getLog_userreferrer() {
		return log_userreferrer;
	}

	public void setLog_userreferrer(String log_userreferrer) {
		this.log_userreferrer = log_userreferrer;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "LogVO [log_no=" + log_no + ", log_userid=" + log_userid + ", log_date=" + log_date + ", log_userip="
				+ log_userip + ", log_userbrowser=" + log_userbrowser + ", log_bversion=" + log_bversion
				+ ", log_osversion=" + log_osversion + ", log_userreferrer=" + log_userreferrer + ", cnt=" + cnt
				+ ", time=" + time + "]";
	}

	
}
