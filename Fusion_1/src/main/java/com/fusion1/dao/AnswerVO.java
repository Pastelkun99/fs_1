package com.fusion1.dao;

public class AnswerVO {

	int a_number;
	int q_no;
	int a_no;
	String q_id;
	String q_selection;
	String q_value;
	int a_order;
	String a_value;
	int a_isetc;

	public int getA_number() {
		return a_number;
	}

	public void setA_number(int a_number) {
		this.a_number = a_number;
	}

	public int getQ_no() {
		return q_no;
	}

	public int getA_no() {
		return a_no;
	}

	public void setA_no(int a_no) {
		this.a_no = a_no;
	}

	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}

	public String getQ_id() {
		return q_id;
	}

	public void setQ_id(String q_id) {
		this.q_id = q_id;
	}

	public String getQ_selection() {
		return q_selection;
	}

	public void setQ_selection(String q_selection) {
		this.q_selection = q_selection;
	}

	public String getQ_value() {
		return q_value;
	}

	public void setQ_value(String q_value) {
		this.q_value = q_value;
	}
	
	public int getA_order() {
		return a_order;
	}

	public void setA_order(int a_order) {
		this.a_order = a_order;
	}
	
	public String getA_value() {
		return a_value;
	}

	public void setA_value(String a_value) {
		this.a_value = a_value;
	}
	

	public int getA_isetc() {
		return a_isetc;
	}

	public void setA_isetc(int a_isetc) {
		this.a_isetc = a_isetc;
	}

	@Override
	public String toString() {
		return "AnswerVO [a_number=" + a_number + ", q_no=" + q_no + ", q_id=" + q_id + ", q_selection=" + q_selection
				+ ", q_value=" + q_value + ", a_order=" + a_order + ", a_value=" + a_value + ", a_isetc=" + a_isetc
				+ "]";
	}

	
	
}
