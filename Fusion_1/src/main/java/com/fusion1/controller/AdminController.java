package com.fusion1.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.multi.MultiRootPaneUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.InfoVO;
import com.fusion1.dao.MenuVO;
import com.fusion1.dao.MultiBoardVO;
import com.fusion1.dao.PopupVO;
import com.fusion1.dao.QuestionVO;
import com.fusion1.dao.SelectVO;
import com.fusion1.dao.UserVO;
import com.fusion1.service.AdminServiceImpl;
import com.fusion1.service.AnalysisServiceImpl;
import com.fusion1.service.FileUploadService;
import com.fusion1.service.MultiBoardServiceImpl;
import com.fusion1.service.UserServiceImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import net.sf.json.JSONObject;

@Controller
public class AdminController {
	
	@Autowired
	UserServiceImpl us;
	
	@Autowired
	AdminServiceImpl as;
	
	@Autowired
	AnalysisServiceImpl ans;
	
	@Autowired
	MultiBoardServiceImpl ms;
	
	// 테스트 메소드
	@RequestMapping(value="/mng/somethingEvent.do", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String somethingEventMethod(@RequestBody UserVO multiboardVO) {
		System.out.println(multiboardVO.toString());
		return "됐어!";
	}

	// 관리자를 체크하기 위한 메소드
	@RequestMapping(value="/mng/adminCheck.do", method=RequestMethod.GET)
	public String adminCheck(HttpSession session, Model model, HttpServletRequest request) {
		try {
			int logAdmin = (int)session.getAttribute("LoginAdminPage");
			if(logAdmin == 1) {
				// 현재 로그인한 아이디는 관리자 권한이 있어야 하고, 해당 ID의 비밀번호를 입력해야만 로그인 가능
				model.addAttribute("msg", "관리자님 환영합니다.");
				model.addAttribute("href", request.getContextPath() + "/mng/adminManagement.do?mode=user");
				return "alert";
			} else {
				// 누군가 로그인을 했지만, 해당 사람이 관리자가 아니면 접근 불가.
				int isAdmin = (int)session.getAttribute("isAdmin");
				if(isAdmin == 0) {
					model.addAttribute("msg", "허가되지 않은 사용자는 접근할 수 없습니다.");
					model.addAttribute("href", request.getContextPath() + "/boardList.do?page_no=1&pageSize=10");
					return "alert";
				}
				return "adminCheck";
			}
		} catch (Exception e) {
			// 권한이 있는 경우가 아니면 모두 접근 불허한다.
			model.addAttribute("msg", "허가되지 않은 사용자는 접근할 수 없습니다.");
			model.addAttribute("href", request.getContextPath() + "/boardList.do?page_no=1&pageSize=10");
			return "alert";
		}
		
	}
	
	// 관리자 페이지에 초회 접속하면 session정보를 생성한다. 이후 로그인 시엔 해당 메소드를 통해 로그인을 검사한다.
	@RequestMapping(value="/mng/adminCheck.do", method=RequestMethod.POST)
	public String adminCheck(@RequestParam("inputPassword") String pw, Model model, HttpServletRequest request, HttpSession session) {
		
		String curId = (String)session.getAttribute("userid");
		UserVO temp = new UserVO();
		temp.setUserid(curId);
		UserVO adminCheck = us.adminCheck(temp);
		String inputPW = pw;
		String adminPW = adminCheck.getUserpw();
		if(inputPW.equals(adminPW)) {
			// 접속한 이력이 있는 관리자는 재접속시 비밀번호를 체크하지 않는다.
			model.addAttribute("msg", "관리자 모드 ON");
			model.addAttribute("href", request.getContextPath() + "/mng/adminManagement.do?mode=user");
			session.setAttribute("LoginAdminPage", 1);
			return "alert";
		} else  {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("href", request.getContextPath() + "/boardList.do?page_no=1&pageSize=10");
			return "alert";
		}
	}
	
	@RequestMapping(value="/mng/adminManagement.do", method=RequestMethod.GET)
	public String adminManagement(Model model, HttpServletRequest request, @RequestParam(defaultValue="user") String mode) {
		
		// 관리자페이지의 mode 값을 통해 어디로 접속할 것인지를 분기한다.
		// 해당 페이지에서 필요한 리스트를 호출하여 model을 통해 View 페이지에 뿌려준다.
		
		if(mode.equals("user")) {
			// 유저관리
			List<UserVO> userList = us.getUserList();
			model.addAttribute("userList", userList);
			return "adminManageUser";
		} else if(mode.equals("analysis")) {
			
			// 설문 관리 페이지는 a_no 파라미터와 q_selection 파라미터가 필요하다.
			int requestNo = Integer.parseInt(request.getParameter("a_no"));
			int requestSelection = Integer.parseInt(request.getParameter("q_selection"));
			List<InfoVO> infoList = ans.getAnalysisInfoList();
			List<SelectVO> selectList = ans.getSelectList();
			List<AnalysisDAO> questionList = ans.getAnalysisQuestionList(requestNo);
			List<SelectVO> selectionList = ans.getSelectionList();
			List<SelectVO> selectionInfoList = ans.getSelectionInfo(requestSelection);
			
			// 홀수문항 그룹의 갯수를 보낸다.
			SelectVO temp = ans.getSelectionOddCount();
			int oddCount = temp.getCnt();
			
			// 복수선택이 가능한 문항 그룹의 갯수를 보낸다.
			temp = ans.getSelectionEvenCount();
			int evenCount = temp.getCnt();
			
			// 만약 생성된 문항 그룹이 존재하지 않는다면 카운트를 1로 만들고 해당 정보를 전달한다.
			InfoVO tempInfo = ans.getAnalysisCount();
			int infoCount = 0;
			if(tempInfo == null) {
				infoCount = 1;
			}
			
			model.addAttribute("infoList", infoList);
			model.addAttribute("selectList", selectList);
			model.addAttribute("questionList", questionList);
			model.addAttribute("selectionList", selectionList);
			model.addAttribute("selectionInfoList", selectionInfoList);
			model.addAttribute("oddCount", oddCount);
			model.addAttribute("evenCount", evenCount);
			model.addAttribute("infoCount", infoCount);
			return "adminManageAnalysis";
			
		} else if(mode.equals("popup")) {
			// 팝업 관리 모드
			int requestPopup = Integer.parseInt(request.getParameter("pop_id"));
			
			// 팝업 정보를 불러온다.
			List<PopupVO> popList = as.getPopupInfoList();
			PopupVO temp = new PopupVO();
			temp.setPop_id(requestPopup);
			PopupVO popup = as.getPopupInfo(temp);
			if(popup == null) {
				// 조건을 만족하는 팝업이 없는 경우 테스트
				System.out.println("조건에 맞는 팝업이 없습니다.");
			} else {
				// 팝업이 있는 경우 model을 통해 View에 전달
				model.addAttribute("popupInfo", popup);
			}
			model.addAttribute("popList", popList);
			return "adminManagePopup";
			
		} else if(mode.equals("board")) {
			// 게시판 관리모드
			List<MultiBoardVO> multiList = as.getMultiBoardList();
			List<MenuVO> menuList = as.getMenuList();
			model.addAttribute("multiList", multiList);
			model.addAttribute("menuList", menuList);
			return "adminManageBoard";
		} else if(mode.equals("menu")) {
			// 메뉴 관리 모드
			List<MenuVO> menuList = as.getMenuList();
			model.addAttribute("menuList", menuList);
			return "adminManageMenu";
		} else {
			// 그 외 다른 url로 접속하려고 할 시 이를 불허한다.
			model.addAttribute("msg", "허용되지 않은 페이지 이동입니다.");
			model.addAttribute("href", request.getContextPath() + "/mng/adminManagement.do?mode=user");
			return "alert";
		}
		
	}
	
	// 유저관리 페이지에서 유저 아이디를 클릭했을 때, 새 창을 띄워 정보를 표시해준다.
	@RequestMapping(value="/mng/userInfo.do", method=RequestMethod.GET)
	public String userInfo(@RequestParam("userid") String userid, Model model) {
		UserVO userInfo = us.getUserInfo(userid);
		model.addAttribute("userInfo", userInfo);
		return "userinfo";
	}
	
	// 유저의 정보를 수정하기위해 ajax를 통해 명령을 보낸다.
	// 유저를 삭제하는 명령은 만들지 않음.
	@RequestMapping(value="/mng/userInfoUpdate.do")
	@ResponseBody
	public String updateUserInfo(UserVO userVO) {
		System.out.println(userVO.toString());
		int result = us.userInfoUpdate(userVO);
		return String.valueOf(result);
	}
	
	// Excel을 통해 유저를 db에 등록할 수 있도록 한다.
	@RequestMapping(value="/mng/excelUpload.do", method=RequestMethod.GET)
	public String excelUpload() {
		return "/multi/excelUpload";
	}
	
	@Autowired
	FileUploadService fileUploadService;
	
	@RequestMapping(value="/mng/excelUpload.do", method=RequestMethod.POST, produces="application/text; charset=utf8")
	@ResponseBody
	public String excelUploadPost(@RequestParam("excelFile") MultipartFile file, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		String result = fileUploadService.restore(file);
		
		// 익셉션이 발생하지 않았다면 일단 null 값을 가지지는 않을 것이다.
		if(result == null || result.equals("")) {
			// 뭔가 에러가 발생한 경우
			return "파일이 업로드 되지 못했습니다.";
		} else {
			// 정상적으로 수행 된 경우
			return "파일이 정상적으로 업로드 되었습니다.";
		}
		
		/*try {
			String result = fileUploadService.restore(file);
			Map returnObject = new HashMap();
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)request;
			Iterator iter = mhsr.getFileNames();
			MultipartFile mfile = null;
			String fieldName = "";
			
			// 값이 나올때까지
            while (iter.hasNext()) { 
                fieldName = iter.next().toString(); // 내용을 가져와서 
                mfile = mhsr.getFile(fieldName); 
                String origName;
                //origName = new String(mfile.getOriginalFilename().getBytes("8859_1"), "UTF-8"); //한글꺠짐 방지 // 파일명이 없다면
                origName = mfile.getOriginalFilename();
                returnObject.put("params", mhsr.getParameterMap());
                
                //위치 및 파일
                List<?> testList = as.getExcelUpload("C:\\upload\\" + origName);
                if(testList == null) {
                	
                	// 문제가 있을 때
                	String msg = "올바른 파일 형식이 아니거나, 정합성을 만족하지 않습니다.\n정합성을 만족하는 일부 행만 데이터에 추가되었을 수 있습니다.\n새로고침된 페이지에서 등록된 데이터를 확인하세요.";
                	request.setCharacterEncoding("UTF-8");
                	return msg;
                }
            }
            return "정상적으로 업로드 되었습니다.";
            
            } catch (UnsupportedEncodingException e) {  
                e.printStackTrace();
                return "파일 형식이 올바르지 않습니다.";
            }catch (IllegalStateException e) {  
                e.printStackTrace();
                return "파일 형식이 올바르지 않습니다.";
            } catch (IOException e) {  
                e.printStackTrace();
                return "파일 형식이 올바르지 않습니다.";
            } catch (StringIndexOutOfBoundsException e) {
            	e.printStackTrace();
            	return "파일 형식이 올바르지 않습니다.";
			}*/
	}
	
	@RequestMapping(value = "/mng/excelDownload.do")
	public void fileDownload(HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String, String> paramMap) {

		String path = paramMap.get("filePath"); 	// full경로
		String fileName = paramMap.get("fileName"); // 파일명

		File file = new File(path);

		FileInputStream fileInputStream = null;
		ServletOutputStream servletOutputStream = null;

		try {
			String downName = null;
			String browser = request.getHeader("User-Agent");
			// 파일 인코딩
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {// 브라우저, 확인, 파일명, encode
				downName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			} else {
				downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			}

			response.setHeader("Content-Disposition", "attachment;filename=\"" + downName + "\"");
			response.setContentType("application/octer-stream");
			response.setHeader("Content-Transfer-Encoding", "binary;");

			fileInputStream = new FileInputStream(file);
			servletOutputStream = response.getOutputStream();

			byte b[] = new byte[1024];
			int data = 0;

			while ((data = (fileInputStream.read(b, 0, b.length))) != -1) {
				servletOutputStream.write(b, 0, data);
			}

			servletOutputStream.flush();// 출력

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (servletOutputStream != null) {
				try {
					servletOutputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fileInputStream != null) {
				try {
					fileInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	// 팝업을 수정하려고 할 때, 해당 팝업의 DB값을 화면에 보여주고, 이를 수정 가능하도록 한다.
	@RequestMapping(value="/mng/popupModify.do")
	public String popupModify(Model model, @RequestParam("pop_id") int pop_id) {
		PopupVO temp = new PopupVO();
		temp.setPop_id(pop_id);
		PopupVO popup = as.getPopupInfo(temp);
		model.addAttribute("popupInfo", popup);
		return "popupModify";
	}
	
	// 팝업 정보를 수정하고 이를 update한다.
	@RequestMapping(value="/mng/popupInfoUpdate.do")
	@ResponseBody
	public String popupInfoUpdate(PopupVO popupVO) {
		//System.out.println(popupVO.toString());
		int result = as.updatePopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	// 팝업을 새로 등록할 때, 새 창을 띄워 처리한다.
	@RequestMapping(value="/mng/popupInsert.do", method=RequestMethod.GET)
	public String popupInsert(Model model, PopupVO popupVO) {
		return "popupInsert";
	}
	
	// 내용을 작성하고 완료 버튼을 누르면, 해당 정보를 저장하고 DB에 등록한다.
	@RequestMapping(value="/mng/popupInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupInsertPost(Model model, PopupVO popupVO) {
		int result = as.insertPopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	// 팝업을 띄운다.
	// 팝업의 정보는 DB에 저장되어 있고, BoardList 로딩이 완료되면 새창을 띄우고 이 url로 이동시킨다.
	// DB에 있는 팝업의 정보 중 팝업을 보일 조건을 만족하는 가장 최근의 팝업을 불러와 View에 뿌려주는 것 
	@RequestMapping(value="/mng/showPopup.do")
	public String showPopup(Model model) {
		PopupVO popup = as.getPopupAval();
		model.addAttribute("pop_id", popup.getPop_id());
		model.addAttribute("pop_title", popup.getPop_title());
		model.addAttribute("pop_fromdate", popup.getPop_fromdate());
		model.addAttribute("pop_todate", popup.getPop_todate());
		model.addAttribute("pop_height", popup.getPop_height());
		model.addAttribute("pop_width", popup.getPop_width());
		model.addAttribute("pop_content", popup.getPop_content());
		model.addAttribute("pop_imageurl", popup.getPop_imageurl());
		model.addAttribute("pop_url", popup.getPop_url());
		model.addAttribute("pop_aval", popup.getPop_aval());
		return "popup";
	}
	
	// 중복된 컨트롤러 메소드 주석처리함
	/*@RequestMapping(value="/mng/popupInfoInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupInfoInsert(PopupVO popupVO) {
		//System.out.println(popupVO.toString());
		int result = as.insertPopupInfo(popupVO);
		return String.valueOf(result);
	}*/
	
	// 팝업 정보를 삭제한다.
	@RequestMapping(value="/mng/popupDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupDeletePost(PopupVO popupVO) {
		int result = as.deletePopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	
	// 질문 정보를 불러온다.
	@RequestMapping(value="/mng/questionInfo.do")
	public String questionInfo(Model model, @RequestParam("a_no") int a_no, @RequestParam("q_no") int q_no) {
		
		QuestionVO temp = new QuestionVO();
		temp.setA_no(a_no);
		temp.setQ_no(q_no);
		
		// 특정 문제의 정보를 불러온다.
		QuestionVO question = ans.getQuestionInfo(temp);
		// 해당 문제에 엮인 문항을 불러온다.
		List<SelectVO> selectionList = ans.getSelectionList();
		
		// 질문 정보와 그에 대한 문항 정보를 전송한다.
		model.addAttribute("question", question);
		model.addAttribute("selectionList", selectionList);
		return "questionInfo";
	}
	
	
	// 수정한 질문 내용을 DB에 업데이트한다.
	@RequestMapping(value="/mng/questionUpdate.do")
	@ResponseBody
	public String questionUpdate(QuestionVO questionVO) {
		//System.out.println(questionVO.toString());
		int result = ans.updateQuestion(questionVO);
		return String.valueOf(result);
	}
	
	// 질문을 새롭게 추가한다.
	@RequestMapping(value="/mng/questionAppend.do")
	public String questionAppend(@RequestParam("a_no") int a_no, Model model) {
		List<SelectVO> selectionList = ans.getSelectionList();
		QuestionVO count = ans.getQuestionCount(a_no);
		int cnt = count.getCnt() + 1;
		model.addAttribute("selectionList", selectionList);
		// 질문을 추가할때 어떤 번호에 추가될 것인지 지정.
		model.addAttribute("count", cnt);
		return "questionAppend";
	}
	
	// 질문을 추가했을때 DB에 반영한다.
	@RequestMapping(value="/mng/questionAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String questionAppendForm(QuestionVO questionVO) {
		System.out.println(questionVO.toString());
		int result = ans.appendQuestion(questionVO);
		return String.valueOf(result);
	}
	
	// 질문을 삭제한다.
	@RequestMapping(value="/mng/questionDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String questionDelete(QuestionVO questionVO) {
		System.out.println(questionVO.toString());
		int result = ans.deleteQuestion(questionVO);
		return String.valueOf(result);
	}
	
	// 객관식 단수 선택 문항을 추가할 때 몇번에 추가될지 판단한다.
	@RequestMapping(value="/mng/newOddGroup.do", method=RequestMethod.POST)
	@ResponseBody
	public String newOddGroup(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.inputSelectionGroup(selectVO);
		return String.valueOf(result);
	}
	
	// 객관식 복수 선택 문항을 추가할 때 몇번에 추가될지 판단한다.
	@RequestMapping(value="/mng/newEvenGroup.do", method=RequestMethod.POST)
	@ResponseBody
	public String newEvenGroup(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.inputSelectionGroup(selectVO);
		return String.valueOf(result);
	}
	
	// 문항정보를 업데이트 하고자 할 때 사용된다.
	@RequestMapping(value="/mng/selectionUpdate.do", method=RequestMethod.GET)
	public String updateSelection(SelectVO selectVO, Model model) {
		System.out.println(selectVO.toString());
		SelectVO info = ans.getSelectionInfoValue(selectVO);
		model.addAttribute("svalue", info);
		return "selectionModify";
	}
	
	// 업데이트 시 DB에 등록한다.
	@RequestMapping(value="/mng/selectionUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateSelectionPost(SelectVO selectVO, Model model) {
		System.out.println(selectVO.toString());
		int result = ans.updateSelect(selectVO);
		return String.valueOf(result);
	}
	
	// 문항을 추가한다.
	@RequestMapping(value="/mng/selectionAppend.do", method=RequestMethod.GET)
	public String selectionInsert(@RequestParam("q_selection") int q_selection, Model model) {
		SelectVO select = ans.getSelectionInfoCount(q_selection);
		int count = select.getCnt();
		String q_type = select.getQ_type();
		model.addAttribute("count", count);
		model.addAttribute("q_type", q_type);
		return "selectionAppend";
	}
	
	// 새창에 작성한 정보를 DB에 연동, 추가한다.
	@RequestMapping(value="/mng/selectionAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String selectionAppendPost(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.selectionAppend(selectVO);
		return String.valueOf(result);
	}
	
	// 문항을 삭제한다.
	@RequestMapping(value="/mng/deleteSelection.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteSelectionPost(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.deleteSelection(selectVO);
		return String.valueOf(result);
	}
	
	// 설문조사 등록 정보를 추가한다.
	@RequestMapping(value="/mng/infoAppend.do", method=RequestMethod.GET)
	public String infoAppend(Model model) {
		InfoVO info = ans.getAnalysisCount();
		int count = 0;
		if(info == null) {
			count = 0;
		} else {
			count = info.getCnt();
		}
		
		model.addAttribute("count", count);
		return "infoAppend";
	}
	
	// 내용을 채우면 DB에 업데이트한다.
	@RequestMapping(value="/mng/infoAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoAppendPost(InfoVO infoVO) {
		System.out.println(infoVO.toString());
		int result = ans.inputAnalysisInfo(infoVO);
		return String.valueOf(result);
	}
	
	// 설문조사 등록 정보를 업데이트한다.
	@RequestMapping(value="/mng/infoUpdate.do", method=RequestMethod.GET)
	public String infoModify(@RequestParam("a_no") int a_no, Model model) {
		InfoVO info = ans.getAnalysisInfo(a_no);
		model.addAttribute("info", info);
		return "infoModify";
	}
	
	// 설문조사 등록 정보을 채워넣었으면 이를 DB에 업데이트한다.
	@RequestMapping(value="/mng/infoUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoUpdatePost(InfoVO infoVO) {
		//System.out.println(infoVO.toString());
		int result = ans.infoUpdate(infoVO);
		return String.valueOf(result);
	}
	
	// 설문조사 진행 정보를 삭제한다.
	@RequestMapping(value="/mng/infoDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoDeletePost(InfoVO infoVO) {
		int result = ans.infoDelete(infoVO);
		int result2 = ans.infoDeleteTrigger(infoVO);
		return String.valueOf(result);
	}

	
	
	
	// 게시판을 등록함
	@RequestMapping(value="/mng/newBoardAppend.do", method=RequestMethod.GET)
	public String newBoardAppend(Model model) {
		List<MenuVO> menuList = as.getMenuList();
		model.addAttribute("menuList", menuList);
		return "multi/newBoardAppend";
	}
	
	// 게시판 등록 포스트
	@RequestMapping(value="/mng/newBoardAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String newBoardAppendPost(MultiBoardVO multiboardVO) {
		int result = as.newBoardAppend(multiboardVO);
		return String.valueOf(result);
	}
	
	// 게시판을 수정함
	@RequestMapping(value="/mng/boardInfoUpdate.do", method=RequestMethod.GET)
	public String boardInfoUpdate(@RequestParam("board_no") int board_no, Model model) {
		MultiBoardVO temp = new MultiBoardVO();
		temp.setBoard_no(board_no);
		MultiBoardVO board = as.getMultiBoardOne(temp);
		model.addAttribute("board", board);
		List<MenuVO> menuList = as.getMenuList();
		model.addAttribute("menuList", menuList);
		return "multi/boardInfoUpdate";
	}
	
	// 게시판 정보 수정 포스트
	@RequestMapping(value="/mng/boardInfoUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardInfoUpdatePost(MultiBoardVO multiBoardVO, @RequestParam("board_no") int board_no) {
		multiBoardVO.setBoard_no(board_no);
		System.out.println(multiBoardVO.toString());
		int result = as.boardInfoUpdate(multiBoardVO);
		return String.valueOf(result);
	}
	
	// 게시판을 삭제함
	@RequestMapping(value="/mng/boardInfoDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardInfoDeletePost(MultiBoardVO multiBoardVO) {
		int result = as.boardInfoDelete(multiBoardVO);
		return String.valueOf(result);
	}
	
	// 게시판 순서 반영
	@RequestMapping(value="/mng/boardOrderCommit.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardOrderCommitPost(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> params) {
		
		MultiBoardVO thisBoardinfo = new MultiBoardVO();
		thisBoardinfo.setBoard_no(Integer.parseInt((String)params.get("board_no")));
		thisBoardinfo = as.getMultiBoardOne(thisBoardinfo);
		
		//System.out.println("업데이트 이전 : " + thisBoardinfo.toString());
		thisBoardinfo.setBoard_order((int)params.get("board_order") + 1);
		int result = as.boardOrderUpdate(thisBoardinfo);
		//System.out.println("업데이트 이후 : " + thisBoardinfo.toString() );
		
		return String.valueOf(result);
	}
	
	// 특수 게시판을 등록함.
	@RequestMapping(value="/mng/specialChartAppend.do", method=RequestMethod.GET)
	public String specialChartAppend(Model model) {
		List<MenuVO> menuList = as.getMenuList();
		model.addAttribute("menuList", menuList);
		return "multi/specialChartAppend";
	}
	
	@RequestMapping(value="/mng/specialAnalAppend.do", method=RequestMethod.GET)
	public String specialAnalAppend(Model model) {
		List<MenuVO> menuList = as.getMenuList();
		model.addAttribute("menuList", menuList);
		return "multi/specialAnalAppend";
	}
	
	// 메뉴를 등록함.
	@RequestMapping(value="/mng/newMenuAppend.do", method=RequestMethod.GET)
	public String newMenuAppend() {
		return "multi/newMenuAppend";
	}
	
	// 메뉴를 등록함 POST
	@RequestMapping(value="/mng/newMenuAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public int newMenuAppendPost(MenuVO menuVO) {
		System.out.println("menu : " + menuVO.toString());
		int result = as.newMenuAppend(menuVO);
		return result;
	}
	
	// 메뉴 수정
	@RequestMapping(value="/mng/menuInfoUpdate.do", method=RequestMethod.GET)
	public String menuInfoUpdate(@RequestParam("menu_no") int menu_no, Model model) {
		MenuVO thisMenu = as.getMenuInfo(menu_no);
		model.addAttribute("menuInfo", thisMenu);
		return "multi/menuInfoUpdate";
	}
	
	// 메뉴 수정 POST
	@RequestMapping(value="/mng/menuInfoUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public int menuInfoUpdatePost(MenuVO menuVO) {
		System.out.println(menuVO.toString());
		int result = as.menuInfoUpdate(menuVO);
		return result;
	}
	
	// 메뉴 삭제
	@RequestMapping(value="/mng/menuInfoDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public int menuInfoDelete(MenuVO menuVO) {
		int menu_no = menuVO.getMenu_no();
		int result = as.menuInfoDelete(menu_no);
		return result;
	}
	
	// 메뉴 순서 반영
	@RequestMapping(value="/mng/menuOrderCommit.do", method=RequestMethod.POST)
	@ResponseBody
	public String menuOrderCommitPost(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> params) {
	
		MenuVO menuVO = new MenuVO();
		menuVO.setMenu_no(Integer.parseInt((String)params.get("menu_no")));
		menuVO = as.getMenuInfo(Integer.parseInt((String)params.get("menu_no")));
		
		menuVO.setMenu_order((int)params.get("menu_order") + 1);
		int result = as.menuOrderUpdate(menuVO);
		return String.valueOf(result);
	}
	
}
