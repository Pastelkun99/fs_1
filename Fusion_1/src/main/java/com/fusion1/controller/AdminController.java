package com.fusion1.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fusion1.dao.AnalysisDAO;
import com.fusion1.dao.InfoVO;
import com.fusion1.dao.PopupVO;
import com.fusion1.dao.QuestionVO;
import com.fusion1.dao.SelectVO;
import com.fusion1.dao.UserVO;
import com.fusion1.service.AdminServiceImpl;
import com.fusion1.service.AnalysisServiceImpl;
import com.fusion1.service.UserServiceImpl;

@Controller
public class AdminController {
	
	@Autowired
	UserServiceImpl us;
	
	@Autowired
	AdminServiceImpl as;
	
	@Autowired
	AnalysisServiceImpl ans;

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
			int requestPopup = Integer.parseInt(request.getParameter("pop_id"));
			//System.out.println("requestpopup : " + requestPopup);
			
			// 팝업 정보를 불러온다.
			List<PopupVO> popList = as.getPopupInfoList();
			PopupVO temp = new PopupVO();
			temp.setPop_id(requestPopup);
			PopupVO popup = as.getPopupInfo(temp);
			if(popup == null) {
				//System.out.println("조건에 만족하는 팝업이 없음.");
			} else {
				//System.out.println("뷰에서 부려주는 정보 : " + popup.toString());
				// 가져올 수 있는 팝업이 있다면 이를 불러온다.
				model.addAttribute("popupInfo", popup);
			}
			model.addAttribute("popList", popList);
			return "adminManagePopup";
			
		} else  {
			model.addAttribute("msg", "허용되지 않은 페이지 이동입니다.");
			model.addAttribute("href", request.getContextPath() + "/mng/adminManagement.do?mode=user");
			return "alert";
		}
		
	}
	
	@RequestMapping(value="/mng/userInfo.do", method=RequestMethod.GET)
	public String userInfo(@RequestParam("userid") String userid, Model model) {
		UserVO userInfo = us.getUserInfo(userid);
		model.addAttribute("userInfo", userInfo);
		return "userinfo";
	}
	
	@RequestMapping(value="/mng/userInfoUpdate.do")
	@ResponseBody
	public String updateUserInfo(UserVO userVO) {
		System.out.println(userVO.toString());
		int result = us.userInfoUpdate(userVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/popupModify.do")
	public String popupModify(Model model, @RequestParam("pop_id") int pop_id) {
		PopupVO temp = new PopupVO();
		temp.setPop_id(pop_id);
		PopupVO popup = as.getPopupInfo(temp);
		model.addAttribute("popupInfo", popup);
		return "popupModify";
	}
	
	@RequestMapping(value="/mng/popupInsert.do", method=RequestMethod.GET)
	public String popupInsert(Model model, PopupVO popupVO) {
		return "popupInsert";
	}
	
	@RequestMapping(value="/mng/popupInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupInsertPost(Model model, PopupVO popupVO) {
		System.out.println("포스트로 들어온 것 : " + popupVO.toString());
		int result = as.insertPopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/popupInfoUpdate.do")
	@ResponseBody
	public String popupInfoUpdate(PopupVO popupVO) {
		System.out.println(popupVO.toString());
		int result = as.updatePopupInfo(popupVO);
		return String.valueOf(result);
	}
	
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
	
	@RequestMapping(value="/mng/popupInfoInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupInfoInsert(PopupVO popupVO) {
		System.out.println(popupVO.toString());
		int result = as.insertPopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/popupDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String popupDeletePost(PopupVO popupVO) {
		int result = as.deletePopupInfo(popupVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/questionInfo.do")
	public String questionInfo(Model model, @RequestParam("a_no") int a_no, @RequestParam("q_no") int q_no) {
		
		QuestionVO temp = new QuestionVO();
		temp.setA_no(a_no);
		temp.setQ_no(q_no);
		
		QuestionVO question = ans.getQuestionInfo(temp);
		List<SelectVO> selectionList = ans.getSelectionList();
		
		model.addAttribute("question", question);
		model.addAttribute("selectionList", selectionList);
		return "questionInfo";
	}
	
	@RequestMapping(value="/mng/questionUpdate.do")
	@ResponseBody
	public String questionUpdate(QuestionVO questionVO) {
		System.out.println(questionVO.toString());
		int result = ans.updateQuestion(questionVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/questionAppend.do")
	public String questionAppend(@RequestParam("a_no") int a_no, Model model) {
		List<SelectVO> selectionList = ans.getSelectionList();
		QuestionVO count = ans.getQuestionCount(a_no);
		int cnt = count.getCnt() + 1;
		model.addAttribute("selectionList", selectionList);
		model.addAttribute("count", cnt);
		return "questionAppend";
	}
	
	@RequestMapping(value="/mng/questionAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String questionAppendForm(QuestionVO questionVO) {
		System.out.println(questionVO.toString());
		int result = ans.appendQuestion(questionVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/questionDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String questionDelete(QuestionVO questionVO) {
		System.out.println(questionVO.toString());
		int result = ans.deleteQuestion(questionVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/newOddGroup.do", method=RequestMethod.POST)
	@ResponseBody
	public String newOddGroup(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.inputSelectionGroup(selectVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/newEvenGroup.do", method=RequestMethod.POST)
	@ResponseBody
	public String newEvenGroup(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.inputSelectionGroup(selectVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/selectionUpdate.do", method=RequestMethod.GET)
	public String updateSelection(SelectVO selectVO, Model model) {
		System.out.println(selectVO.toString());
		SelectVO info = ans.getSelectionInfoValue(selectVO);
		model.addAttribute("svalue", info);
		return "selectionModify";
	}
	
	@RequestMapping(value="/mng/selectionUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateSelectionPost(SelectVO selectVO, Model model) {
		System.out.println(selectVO.toString());
		int result = ans.updateSelect(selectVO);
		return String.valueOf(result);
	}
	
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
	
	@RequestMapping(value="/mng/infoAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoAppendPost(InfoVO infoVO) {
		System.out.println(infoVO.toString());
		int result = ans.inputAnalysisInfo(infoVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/infoUpdate.do", method=RequestMethod.GET)
	public String infoModify(@RequestParam("a_no") int a_no, Model model) {
		InfoVO info = ans.getAnalysisInfo(a_no);
		model.addAttribute("info", info);
		return "infoModify";
	}
	
	@RequestMapping(value="/mng/infoUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoUpdatePost(InfoVO infoVO) {
		System.out.println(infoVO.toString());
		int result = ans.infoUpdate(infoVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/infoDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String infoDeletePost(InfoVO infoVO) {
		System.out.println(infoVO.toString());
		int result = ans.infoDelete(infoVO);
		int result2 = ans.infoDeleteTrigger(infoVO);
		return String.valueOf(result);
	}

	@RequestMapping(value="/mng/selectionAppend.do", method=RequestMethod.GET)
	public String selectionInsert(@RequestParam("q_selection") int q_selection, Model model) {
		SelectVO select = ans.getSelectionInfoCount(q_selection);
		int count = select.getCnt();
		String q_type = select.getQ_type();
		model.addAttribute("count", count);
		model.addAttribute("q_type", q_type);
		return "selectionAppend";
	}
	
	@RequestMapping(value="/mng/selectionAppend.do", method=RequestMethod.POST)
	@ResponseBody
	public String selectionAppendPost(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.selectionAppend(selectVO);
		return String.valueOf(result);
	}
	
	@RequestMapping(value="/mng/deleteSelection.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteSelectionPost(SelectVO selectVO) {
		System.out.println(selectVO.toString());
		int result = ans.deleteSelection(selectVO);
		return String.valueOf(result);
	}
}
