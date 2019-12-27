package com.fusion1.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.MenuVO;
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

	@Override
	public List<MenuVO> getMenuList() {
		return sqlSession.selectList("adminMapper.getMenuList");
	}
	
	@Override
	public int newMenuAppend(MenuVO menuVO) {
		return sqlSession.insert("adminMapper.newMenuAppend", menuVO);
	}

	@Override
	public MenuVO getMenuInfo(int menu_no) {
		return sqlSession.selectOne("adminMapper.getMenuInfo", menu_no);
	}

	@Override
	public int menuInfoUpdate(MenuVO menuVO) {
		return sqlSession.update("adminMapper.menuInfoUpdate", menuVO);
	}

	@Override
	public int menuInfoDelete(int menu_no) {
		return sqlSession.delete("adminMapper.menuInfoDelete", menu_no);
	}

	@Override
	public int menuOrderUpdate(MenuVO menuVO) {
		return sqlSession.update("adminMapper.menuOrderUpdate", menuVO);
	}

	@Override
	public List<?> getExcelUpload(String excelFile) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	        
        try {
        	// excelFile 변수에는 엑셀 파일의 절대경로가 들어와야 정상.
            Workbook wbs = ExcelUtil.getWorkbook(excelFile);
            Sheet sheet = (Sheet) wbs.getSheetAt(0);
            int firstRow = sheet.getFirstRowNum();
            System.out.println("firstrownum : " + firstRow);
            int lastRow = sheet.getLastRowNum();
            System.out.println("lastrownum : " + lastRow);
 
            //excel file 세번째줄부터 시작
            for (int i = sheet.getFirstRowNum() + 2; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                //map.put("IDCOL", ""+ExcelUtil.cellValue(row.getCell(0)));
                String idcol = ""+ExcelUtil.cellValue(row.getCell(1));
                idcol = idcol.toLowerCase();
                String IDregex = "^[a-zA-Z]{1}[a-zA-Z0-9_]{4,17}$";
                if(!Pattern.matches(IDregex, idcol)) {
                	// 에러 발생 시키면 됨
                	return null;
                }
                
                String pwcol = ""+ExcelUtil.cellValue(row.getCell(2));
                String PWregex = "[a-zA-Z0-9]{4,17}$";
                if(!Pattern.matches(PWregex, pwcol)) {
                	// 에러 발생 시키면 됨
                	return null;
                }
                
                String namecol = ""+ExcelUtil.cellValue(row.getCell(3));
                String NAMEregex = "^[a-zA-Z가-힣]*{4,17}$";
                if(!Pattern.matches(NAMEregex, namecol)) {
                	// 에러 발생 시키면 됨
                	return null;
                }
                
                map.put("IDCOL", idcol);
                map.put("PWCOL", pwcol);
                map.put("NAMECOL", namecol);
                
                //신규삽입
                list.add(map);
                insertExcelData(map);
            }
            
            
            
        } catch(Exception e) {
        	// 파일이 잘못 들어오면 여기에 걸립니다.
        	return null;
        }
        
        return list;
	}

	@Override
	public int insertExcelData(Map<String, Object> map) {
		return sqlSession.insert("adminMapper.insertExcelData", map);
	}



}
