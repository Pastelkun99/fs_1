package com.fusion1.dao;

public class InfoVO {

	int a_no;
	String a_name;
	String a_collector;
	String a_submitter;
	String a_fromdate;
	String a_todate;
	String a_deploydate;
	int a_aval;
	int cnt;

	public int getA_no() {
		return a_no;
	}

	public void setA_no(int a_no) {
		this.a_no = a_no;
	}

	public String getA_name() {
		return a_name;
	}

	public void setA_name(String a_name) {
		this.a_name = a_name;
	}

	public String getA_collector() {
		return a_collector;
	}

	public void setA_collector(String a_collector) {
		this.a_collector = a_collector;
	}

	public String getA_submitter() {
		return a_submitter;
	}

	public void setA_submitter(String a_submitter) {
		this.a_submitter = a_submitter;
	}

	public String getA_fromdate() {
		return a_fromdate;
	}

	public void setA_fromdate(String a_fromdate) {
		this.a_fromdate = a_fromdate;
	}

	public String getA_todate() {
		return a_todate;
	}

	public void setA_todate(String a_todate) {
		this.a_todate = a_todate;
	}

	public String getA_deploydate() {
		return a_deploydate;
	}

	public void setA_deploydate(String a_deploydate) {
		this.a_deploydate = a_deploydate;
	}

	public int getA_aval() {
		return a_aval;
	}

	public void setA_aval(int a_aval) {
		this.a_aval = a_aval;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "InfoVO [a_no=" + a_no + ", a_name=" + a_name + ", a_collector=" + a_collector + ", a_submitter="
				+ a_submitter + ", a_fromdate=" + a_fromdate + ", a_todate=" + a_todate + ", a_deploydate="
				+ a_deploydate + ", a_aval=" + a_aval + ", cnt=" + cnt + "]";
	}


}
