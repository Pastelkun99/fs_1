package com.fusion1.service;

import java.util.List;

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
}
