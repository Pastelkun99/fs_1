package com.fusion1.dao;

public class AnswerVO {

	int a_number;
	int q_no;
	String q_id;
	String q_type;
	String q_value;

	public int getA_number() {
		return a_number;
	}

	public void setA_number(int a_number) {
		this.a_number = a_number;
	}

	public int getQ_no() {
		return q_no;
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

	public String getQ_type() {
		return q_type;
	}

	public void setQ_type(String q_type) {
		this.q_type = q_type;
	}

	public String getQ_value() {
		return q_value;
	}

	public void setQ_value(String q_value) {
		this.q_value = q_value;
	}

	@Override
	public String toString() {
		return "AnswerVO [a_number=" + a_number + ", q_no=" + q_no + ", q_id=" + q_id + ", q_type=" + q_type
				+ ", q_value=" + q_value + "]";
	}

}