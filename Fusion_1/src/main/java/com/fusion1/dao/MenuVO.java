package com.fusion1.dao;

public class MenuVO {

	private int menu_no;
	private String menu_name;
	private int menu_order;
	private String menu_url;
	private String menu_useyn;

	public int getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public int getMenu_order() {
		return menu_order;
	}

	public void setMenu_order(int menu_order) {
		this.menu_order = menu_order;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getMenu_useyn() {
		return menu_useyn;
	}

	public void setMenu_useyn(String menu_useyn) {
		this.menu_useyn = menu_useyn;
	}

	@Override
	public String toString() {
		return "MenuVO [menu_no=" + menu_no + ", menu_name=" + menu_name + ", menu_order=" + menu_order + ", menu_url="
				+ menu_url + ", menu_useyn=" + menu_useyn + "]";
	}

	
}
