package com.fusion1.dao;

public class SelectVO {

	int select_no;
	String q_type;
	int q_selection;
	String q_svalue;
	int q_order;
	int cnt;

	public int getSelect_no() {
		return select_no;
	}

	public void setSelect_no(int select_no) {
		this.select_no = select_no;
	}

	public String getQ_type() {
		return q_type;
	}

	public void setQ_type(String q_type) {
		this.q_type = q_type;
	}

	public int getQ_selection() {
		return q_selection;
	}

	public void setQ_selection(int q_selection) {
		this.q_selection = q_selection;
	}

	public String getQ_svalue() {
		return q_svalue;
	}

	public void setQ_svalue(String q_svalue) {
		this.q_svalue = q_svalue;
	}

	public int getQ_order() {
		return q_order;
	}

	public void setQ_order(int q_order) {
		this.q_order = q_order;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "SelectVO [select_no=" + select_no + ", q_type=" + q_type + ", q_selection=" + q_selection
				+ ", q_svalue=" + q_svalue + ", q_order=" + q_order + ", cnt=" + cnt + "]";
	}

	

}
