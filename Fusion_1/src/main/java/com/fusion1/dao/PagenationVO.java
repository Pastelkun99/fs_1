package com.fusion1.dao;

public class PagenationVO {

	// 페이지 번호
	private int page_no;
	
	// URL에서 받아오기 위한 변수 (몇 개씩 보일 것인가?)
	private int pageSize;
	
	// 총 게시물의 수
	private int totalCount;
	
	// 몇개씩 보여주고 싶은가?
	private int pageList;
	
	// 시작 페이지
	private int startPage;
	
	// 끝 페이지
	private int endPage;
	
	// mysql 수식용
	private int pageCon;
	
	// 검색용 검색어
	private String keyword;
	
	// 검색 형태 
	//1 - 제목
	//2 - 내용
	//3 - 글쓴이
	//4 - 전체
	private int searchCon;
	
	// 게시물 번호를 처리하기 위함
	private int pageBoardNo;
	
	private int board_no;
	
	
	public int getPage_no() {
		return page_no;
	}

	public void setPage_no(int page_no) {
		this.page_no = page_no;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public int getPageList() {
		return pageList;
	}
	
	public void setPageList(int pageList) {
		this.pageList = pageList;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getPageCon() {
		return pageCon;
	}

	public void setPageCon(int pageCon) {
		this.pageCon = pageCon;
	}
	
	public int getSearchCon() {
		return searchCon;
	}

	public void setSearchCon(int searchCon) {
		this.searchCon = searchCon;
	}
	
	public int getPageBoardNo() {
		return pageBoardNo;
	}

	public void setPageBoardNo(int pageBoardNo) {
		this.pageBoardNo = pageBoardNo;
	}
	
	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	@Override
	public String toString() {
		return "PagenationVO [page_no=" + page_no + ", pageSize=" + pageSize + ", totalCount=" + totalCount
				+ ", pageList=" + pageList + ", startPage=" + startPage + ", endPage=" + endPage + ", pageCon="
				+ pageCon + ", keyword=" + keyword + ", searchCon=" + searchCon + ", pageBoardNo=" + pageBoardNo
				+ ", board_no=" + board_no + "]";
	}
	
}
