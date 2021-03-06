package com.fusion1.service;

import java.util.List;
import java.util.Map;

import com.fusion1.dao.MenuVO;
import com.fusion1.dao.MultiBoardVO;
import com.fusion1.dao.PopupVO;

public interface AdminService {

	// 팝업을 불러오자!
	public List<PopupVO> getPopupInfoList();
	
	// 하나의 팝업만 불러온다.
	public PopupVO getPopupInfo(PopupVO popupVO);
	
	// 출력 가능한 가장 최근 팝업만 불러온다.
	public PopupVO getPopupAval();
	
	// 팝업을 업데이트 한다.
	public int updatePopupInfo(PopupVO popupVO);
	
	// 팝업을 새로 등록한다.
	public int insertPopupInfo(PopupVO popupVO);
	
	// 팝업 정보를 삭제한다.
	public int deletePopupInfo(PopupVO popupVO);
	
	// 게시판 관리를 위해 게시판 정보를 가져온다.
	public List<MultiBoardVO> getMultiBoardList();
	
	// 게시판을 새롭게 등록한다.
	public int newBoardAppend(MultiBoardVO multiBoardVO);
	
	// 게시판을 하나 불러온다.
	public MultiBoardVO getMultiBoardOne(MultiBoardVO multiBoardVO);
	
	// 게시판 정보를 업데이트한다.
	public int boardInfoUpdate(MultiBoardVO multiBoardVO);
	
	// 게시판을 날려버린다.
	public int boardInfoDelete(MultiBoardVO multiBoardVO);
	
	// 게시판의 order를 업데이트한다
	public int boardOrderUpdate(MultiBoardVO multiBoardVO);
	
	// 메뉴 리스트를 불러온다.
	public List<MenuVO> getMenuList();
	
	// 메뉴를 추가한다.
	public int newMenuAppend(MenuVO menuVO);
	
	// 메뉴를 가져온다.
	public MenuVO getMenuInfo(int menu_no);
	
	// 메뉴를 수정한다.
	public int menuInfoUpdate(MenuVO menuVO);
	
	// 메뉴를 삭제한다.
	public int menuInfoDelete(int menu_no);
	
	// 메뉴 순서를 업데이트한다.
	public int menuOrderUpdate(MenuVO menuVO);
	
	// 엑셀 업로드 처리
	public List<?> getExcelUpload(String excelFile);
	
	// db 처리
	public int insertExcelData(Map<String, Object> map);
	
}
