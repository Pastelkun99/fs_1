package com.fusion1.dao;

public class AnalysisDAO {

	int q_no;
	int a_no;
	String q_subject;
	String q_value;
	String q_type;
	int q_selection;
	int q_page;
	String q_svalue;
	String q_order;
	String q_id;
	int q_parentno;
	int q_depth;

	public int getQ_no() {
		return q_no;
	}

	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}

	public int getA_no() {
		return a_no;
	}

	public void setA_no(int a_no) {
		this.a_no = a_no;
	}

	public String getQ_subject() {
		return q_subject;
	}

	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}

	public String getQ_value() {
		return q_value;
	}

	public void setQ_value(String q_value) {
		this.q_value = q_value;
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

	public int getQ_page() {
		return q_page;
	}

	public void setQ_page(int q_page) {
		this.q_page = q_page;
	}

	public String getQ_svalue() {
		return q_svalue;
	}

	public void setQ_svalue(String q_svalue) {
		this.q_svalue = q_svalue;
	}

	public String getQ_order() {
		return q_order;
	}

	public void setQ_order(String q_order) {
		this.q_order = q_order;
	}

	public String getQ_id() {
		return q_id;
	}

	public void setQ_id(String q_id) {
		this.q_id = q_id;
	}

	public int getQ_parentno() {
		return q_parentno;
	}

	public void setQ_parentno(int q_parentno) {
		this.q_parentno = q_parentno;
	}

	public int getQ_depth() {
		return q_depth;
	}

	public void setQ_depth(int q_depth) {
		this.q_depth = q_depth;
	}

	@Override
	public String toString() {
		return "AnalysisDAO [q_no=" + q_no + ", a_no=" + a_no + ", q_subject=" + q_subject + ", q_value=" + q_value
				+ ", q_type=" + q_type + ", q_selection=" + q_selection + ", q_page=" + q_page + ", q_svalue="
				+ q_svalue + ", q_order=" + q_order + ", q_id=" + q_id + ", q_parentno=" + q_parentno + ", q_depth="
				+ q_depth + "]";
	}

}
