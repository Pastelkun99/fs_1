package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.MultiBoardVO;
import com.fusion1.dao.PopupVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	@Resource(name = "sqlSession")
	SqlSession sqlSession;

	@Override
	public List<PopupVO> getPopupInfoList() {
		return sqlSession.selectList("adminMapper.getPopupInfoList");
	}

	@Override
	public PopupVO getPopupInfo(PopupVO popupVO) {
		return sqlSession.selectOne("adminMapper.getPopupInfo", popupVO);
	}

	@Override
	public PopupVO getPopupAval() {
		return sqlSession.selectOne("adminMapper.getPopupAval");
	}

	@Override
	public int updatePopupInfo(PopupVO popupVO) {
		return sqlSession.update("adminMapper.updatePopupInfo", popupVO);
	}

	@Override
	public int insertPopupInfo(PopupVO popupVO) {
		return sqlSession.insert("adminMapper.insertPopupInfo", popupVO);
	}

	@Override
	public int deletePopupInfo(PopupVO popupVO) {
		return sqlSession.delete("adminMapper.deletePopupInfo", popupVO);
	}

	@Override
	public List<MultiBoardVO> getMultiBoardList() {
		return sqlSession.selectList("adminMapper.getMultiBoardList");
	}

	@Override
	public int newBoardAppend(MultiBoardVO multiBoardVO) {
		return sqlSession.insert("adminMapper.newBoardAppend", multiBoardVO);
	}

	@Override
	public MultiBoardVO getMultiBoardOne(MultiBoardVO multiBoardVO) {
		return sqlSession.selectOne("adminMapper.getMultiBoardOne", multiBoardVO);
	}

	@Override
	public int boardInfoUpdate(MultiBoardVO multiBoardVO) {
		return sqlSession.update("adminMapper.boardInfoUpdate", multiBoardVO);
	}

	@Override
	public int boardInfoDelete(MultiBoardVO multiBoardVO) {
		return sqlSession.delete("adminMapper.boardInfoDelete", multiBoardVO);
	}

	@Override
	public int boardOrderUpdate(MultiBoardVO multiBoardVO) {
		return sqlSession.update("adminMapper.boardOrderUpdate", multiBoardVO);
	}

}
