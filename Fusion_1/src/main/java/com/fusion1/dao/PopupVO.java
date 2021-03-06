package com.fusion1.dao;

public class PopupVO {

	int pop_id;
	String pop_title;
	String pop_fromdate;
	String pop_todate;
	int pop_height;
	int pop_width;
	String pop_content;
	String pop_imageurl;
	String pop_url;
	int pop_aval;

	public int getPop_id() {
		return pop_id;
	}

	public void setPop_id(int pop_id) {
		this.pop_id = pop_id;
	}

	public String getPop_title() {
		return pop_title;
	}

	public void setPop_title(String pop_title) {
		this.pop_title = pop_title;
	}

	public String getPop_fromdate() {
		return pop_fromdate;
	}

	public void setPop_fromdate(String pop_fromdate) {
		this.pop_fromdate = pop_fromdate;
	}

	public String getPop_todate() {
		return pop_todate;
	}

	public void setPop_todate(String pop_todate) {
		this.pop_todate = pop_todate;
	}

	public int getPop_height() {
		return pop_height;
	}

	public void setPop_height(int pop_height) {
		this.pop_height = pop_height;
	}

	public int getPop_width() {
		return pop_width;
	}

	public void setPop_width(int pop_width) {
		this.pop_width = pop_width;
	}

	public String getPop_content() {
		return pop_content;
	}

	public void setPop_content(String pop_content) {
		this.pop_content = pop_content;
	}

	public String getPop_imageurl() {
		return pop_imageurl;
	}

	public void setPop_imageurl(String pop_imageurl) {
		this.pop_imageurl = pop_imageurl;
	}

	public String getPop_url() {
		return pop_url;
	}

	public void setPop_url(String pop_url) {
		this.pop_url = pop_url;
	}
	
	public int getPop_aval() {
		return pop_aval;
	}

	public void setPop_aval(int pop_aval) {
		this.pop_aval = pop_aval;
	}

	@Override
	public String toString() {
		return "PopupVO [pop_id=" + pop_id + ", pop_title=" + pop_title + ", pop_fromdate=" + pop_fromdate
				+ ", pop_todate=" + pop_todate + ", pop_height=" + pop_height + ", pop_width=" + pop_width
				+ ", pop_content=" + pop_content + ", pop_imageurl=" + pop_imageurl + ", pop_url=" + pop_url
				+ ", pop_aval=" + pop_aval + "]";
	}

}
