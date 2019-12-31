<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true"%>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
	
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>설문조사</title>
</head>
<body>
<div class="row">
	<div class="col-3"></div>
	<div class="col-6">
		<!-- 프로그레스 바 진행 -->
		<div class="progress" style="margin-bottom: 70px; margin-top:70px">
  			<div class="progress-bar" role="progressbar" style="width:${param.page * 20}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">${param.page * 20}%</div>
		</div>
		<!-- 질문 출력 -->
		<c:forEach items="${questionList }" var="question" varStatus="status">
				<c:if test="${question.q_page eq param.page }">
					<div class="card" style="width: 100%; margin-bottom:40px;">
	  					<div class="card-header">
	  					  <!-- 문제 번호, depth 처리를 함 -->
	  					  <c:if test="${question.q_depth eq 0 }">${status.index + 1 }.</c:if>
	  					  <c:if test="${question.q_depth ne 0 }">${question.q_parentno }.</c:if>
	  					  <c:if test="${question.q_depth ne 0 }">${question.q_depth }</c:if> 
	  					  <strong>${question.q_subject }</strong> ${question.q_value }
	  					</div>
	  					<ul class="list-group list-group-flush">
	  					  <li class="list-group-item">
	  					  	
	  					  	<c:set var="etc" value="N" />
	  					  	
	  					  	<!-- 문항 처리를 함. 해당 문항의 type에 따라 다른 문항이 출력되도록 함. -->
	  			 		 	<c:forEach items="${selectList }" var="select" varStatus="order">
	  			  				<c:if test="${question.q_no eq select.q_no }">
	  			  				
	  			  					<!-- 객관식(001) 문항 출력  -->
	  								<c:if test="${select.q_type eq '001'}">
	  								
	  									<!-- 객관식 중에서 복수 선택이 가능한 것 -->
			  					  		<c:if test="${select.q_selection gt 3000 && select.q_selection lt 5001 }">
			  					  		
			  					  			<c:if test="${select.q_svalue eq '기타' }">
			  					  				 <c:set var="etc" value="Y" />
			  					  			</c:if>
				  					  		
				  					  		<!-- 이 부분은 복수 체크 문항 -->
				  					  		<input type="checkbox" 
				  					  			   class="commitCheckMulti a${question.q_no } check${question.q_page}" 
				  					  			   data-code="${question.q_no}" 
				  					  			   data-code2="${select.q_svalue }" 
				  					  			   a_no="${question.a_no }"
				  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
				  					  			   name="selectGroup${question.q_no }"
				  					  			   <c:forEach items="${answerList }" var="answer">
				  					  			   		<c:if test="${question.q_no eq answer.q_no }">
				  					  			   			<c:if test="${select.q_order eq answer.q_value }">
				  					  			   				checked='checked'
				  					  			   			</c:if>
				  					  			   		</c:if>
				  					  			   </c:forEach>
				  					  			   value="${select.q_order }"
				  					  			   >${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
				  					  		<input type="hidden" id="q_selection${question.q_no }" value="${question.q_selection }">
				  					  		
			  					  		</c:if>
			  					  		<!-- 복수선택 문항 끝 -->
			  					  		
	  									<c:if test="${select.q_selection gt 1110 && select.q_selection lt 3001 }">
	  									
		  									<c:if test="${select.q_svalue eq '기타' }">
		  					  					 <c:set var="etc" value="Y" />
		  					  				</c:if>
	  					  				
		  									<!-- 이 부분은 단수 체크 문항 -->
				  					  		<input type="checkbox" 
				  					  			   class="commitCheck a${question.q_no } check${question.q_page}" 
				  					  			   data-code="${question.q_no}"
				  					  			   data-code2="${select.q_svalue }"
				  					  			   a_no="${question.a_no }"
				  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
				  					  			   name="selectGroup${question.q_no }"
				  					  			   onclick="commitCheck(${question.q_no});"
				  					  			  <c:forEach items="${answerList }" var="answer">
				  					  			   		<c:if test="${question.q_no eq answer.q_no }">
				  					  			   			<c:if test="${select.q_order eq answer.q_value }">
				  					  			   				checked='checked'
				  					  			   			</c:if>
				  					  			   		</c:if>
				  					  			   </c:forEach>
				  					  			   value="${select.q_order }"
				  					  			   >${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
				  					  		<input type="hidden" id="q_selection${question.q_no }" value="${question.q_selection }">
			  					  		</c:if>
			  					  		<!-- 단수 선택 문항 끝 -->
			  					  		
			  			  			</c:if>
			  			  			<!-- 객관식 끝 -->
			  			  			
			  			  			<!-- 주관식 문항 출력 시작 -->
				  			  		<c:if test="${select.q_selection eq 5000}">
			  				  			<textarea rows="5" cols="100" id="selectGroup${question.q_no }"><c:forEach items="${answerList }" var="answer"><c:if test="${question.q_no eq answer.q_no }"><c:if test="${answer.a_isetc eq 1 }">${answer.a_value }</c:if></c:if></c:forEach></textarea>
			  				  			<button type="button" class="btn btn-success" onclick="subjectInput(${question.q_no});">저장</button>
			  				  			<input type="hidden" id="q_selection${question.q_no }" value="${question.q_selection }">
			  				  		</c:if>
		  				  		
		  			  			</c:if>
	  			  			</c:forEach>
	  			  			<!-- 문제 출력 끝 -->
	  			  			
	  			  			<!-- 기타 문항의 경우 따로 textarea 출력 -->
	  			  			<c:if test="${etc eq 'Y' }">
	  			  				<div class="input-group mb-3">
								  <input type="text" class="form-control" 
								  		 id="EtcArea${question.q_no }" 
								  		 placeholder="기타 입력 후 꼭 저장버튼을 눌러주세요"
								  		 aria-label="Etc" 
								  		 aria-describedby="button-addon2" 
								  		 style="width:50%;" 
								  		 disabled="disabled" 
								  		  <c:forEach items="${answerList }" var="answer">
				  					  		  <c:if test="${question.q_no eq answer.q_no }">
				  					  			  <c:if test="${answer.a_isetc eq 1 }">
				  					  			  		value="${answer.a_value }"
				  					  			  </c:if>
				  					  		  </c:if>
				  					  	  </c:forEach>
				  					>
				  				  <!-- 기타 창 입력시 저장 버튼을 눌러야 함. -->
								  <div class="input-group-append">
								    <button class="btn btn-outline-secondary" id="EtcAreaButton${question.q_no }" type="button" id="button-addon2" onclick="EtcInput(${question.q_no});" disabled="disabled">저장</button>
								  </div>
								</div>
	  			  			</c:if>
	  			  			<!-- 기타 항목 출력 끝 -->
	  			  		  </li>
	 			 		</ul>
					</div>
				</c:if>
		</c:forEach>
		<!-- 질문 및 문항, 기타창 모두 출력 완료 -->
	</div>
  	<div class="col-3"></div>
</div>

<div class="row">
<div class="col-3"></div>

<div class="col-6" style="text-align:right;">
	<!-- 페이지 값에 따라 이전, 다음 버튼을 화면에 출력 -->
	<c:if test="${param.page eq 1 }">
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="nextPageCheck(${param.page});" style="width:200px;">다음</button>
	</c:if>
	<c:if test="${param.page lt 5 && param.page gt 1 }">
		<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page - 1}'" style="width:200px;">이전</button>
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="nextPageCheck(${param.page});" style="width:200px;">다음</button>
	</c:if>
	<c:if test="${param.page eq 5 }">
		<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page - 1}'" style="width:200px;">이전</button>
		<button class="btn btn-lg btn-success" id="commitCheck" onClick="nextPageCheck(${param.page});" style="width:200px;">완료</button>
	</c:if>
</div>

<div class="col-3"></div>
</div>

<script>
/* 처음 페이지 로딩 시, DB에서 체크 된 값을 가져와 미리 처리하는 로직 */
$(document).ready(function() {
	
	// 복수 선택 문항
	$('.commitCheckMulti').each(function() {
		// 없음에 이미 체크된 경우, 다른 문항을 선택할 수 없도록 함.
		if($(this).attr('data-code2') == '없음' && $(this).is(':checked')) {
			$('.a'+$(this).attr('data-code')).attr('disabled', true);
			$('.a'+$(this).attr('data-code')).prop("checked", false);
			$(this).prop("checked", true);
			$(this).attr('disabled', false);
		}
		
		// 기타에 이미 체크된 경우, 해당 문항에 존재하는 textarea를 사용가능하도록 조치함.
		if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
			$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
			$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
		}
	});
	
	// 단수 선택 문항
	$('.commitCheck').each(function() {
		// 없음에 체크한 경우 다른 값은 선택이 불가능하도록 처리.
		if($(this).attr('data-code2') == '없음' && $(this).is(':checked')) {
			$('.a'+$(this).attr('data-code')).attr('disabled', true);
			$('.a'+$(this).attr('data-code')).prop("checked", false);
			$(this).prop("checked", true);
			$(this).attr('disabled', false);
		}
		
		// 기타에 체크된 경우 해당 문제가 사용가능한 textarea 사용가능 및 버튼 활성화.
		if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
			$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
			$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
		}
	});
	
});
 

// 설문 참여 중, 단수 체크 문항에 체크했을때 발생하는 이벤트
$(".commitCheck").on('click', function() {
	
	// 단수 문항은 2개 이상 체크가 불가능하므로, 이미 체크된 상태에서는 다른 문항을 체크 할 수 없도록 함.
	$('.a'+$(this).attr('data-code')).prop("checked", false);
	$(this).prop("checked", true);
	
	// 기타가 체크되지 않은 경우 해당 영역의 textarea를 사용할 수 없도록 처리.
	if(!($(this).attr('data-code2') == '기타')) {
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	// 기타가 체크된 경우 해당 영역의 textarea를 사용할 수 있도록 처리.
	if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
	}
});

/* 제한 숫자, 만약 필요한 경우 추가로 선언하거나 값을 바꿀 수 있음. */
var limit = 2;

/* 복수 문항 체크 시 사용되는 로직 */
$(".commitCheckMulti").on('click', function() {
	
	// 없음을 체크한 경우 단수 문항과 마찬가지로 모든 체크박스를 비활성화 한다. + 기타 입력 textarea 역시 비활성화 처리.
	if($(this).attr('data-code2') == '없음' && $(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', true);
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	// 복수 문항은 없음 항목에 체크를 해제하면 다른 체크박스를 사용 가능하도록 해야 한다. 
	if($(this).attr('data-code2') == '없음' && !$(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', false);
	}
	
	// 기타를 선택한 경우 textarea와 저장 버튼을 사용할 수 있도록 한다.
	if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
	}
	
	// 기타 버튼이 해제된 경우 textarea에 입력된 값을 없애고, textarea와 버튼을 비활성화 시킨다.
	if($(this).attr('data-code2') == '기타' && !$(this).is(':checked')){
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	// 미리 지정해둔 limit 값 이상으로 여러개 체크가 불가능 하도록 한다. 
	if($(this).siblings(':checked').length >= limit) {
		this.checked = false;
		return;
	}
	
	// 조건을 제대로 만족했을 경우 ajax 통신을 통해 Database에 값을 입력한다.
	if($(this).is(':checked')) {
		
		var test = ''; 											// 중복된 값을 처리하기 위해 미리 만들어둔 변수
		var a_no = $(this).attr('a_no');
		var a_value = '';										// 중복된 값을 처리하기 위해 미리 만들어둔 변수
		var cnt = 0;											// 값이 들어오는 숫자를 카운트
		var currentUserid = '${userid}';						// 현재 로그인된 ID
		var q_no = $(this).attr('data-code');					// 문제 번호
		var currentSelection = $('#q_selection' + q_no).val();	// 현재 문제의 타입  1111, 1112 ...
		
		// 복수 선택 문항의 값을 '/' 을 기준으로 묶은 뒤, Controller에서 분리할 수 있도록 작업한다.
		$('input[name=selectGroup'+ $(this).attr('data-code') +']:checked').each(function() {
			if(cnt < 2) {
				test += $(this).val();
				a_value += $(this).attr('data-code2');
				cnt++;
				if(cnt == 1) { 
					test += '/';
					a_value += '/';
				};
			}
		});
		
		// 완성된 값을 ajax로 저장한 후 Controller에 보내 DB에 삽입, 또는 update 시킨다.
		$.ajax({
			type:"POST",
			url:"/analysisUpdateMulti.do",
			data: {"a_no" : a_no,
				   "q_no" : q_no,
				   "q_id" : currentUserid,
				   "q_selection" : currentSelection,
				   "q_value" : test,
				   "a_value" : a_value,
				   "a_isetc" : 0},
			dataType : "json",
			success : function(result) {
			},
			error : function(error) {
				alert('에러...');
			}
		});
	}
});
/* 복수 문항 체크 시 사용되는 로직 끝 */

/* 단수 문항 체크 시 사용되는 로직  */
function commitCheck(q_no) {
	
	// 단수 문항의 경우에는 체크가 들어올때 마다 ajax로 통신해도 무관하다.
	$('.a' + q_no).on('click', function() {
		
		 var value = $(this).attr('value');								// 문항의 value 값
		 var currentUser = '${sessionScope.userid}';					// 현재 로그인 된 ID
		 var currentSelection = $('#q_selection' + q_no).val();			// 문항의 타입. 1110, 1111 ...
		 var a_value = $(this).attr('data-code2');						// 문항의 값. 매우만족, 약간 만족 ...
		 var a_no = $(this).attr('a_no');
		 
		 // ajax를 통해 Controller로 VO 값을 보낸다.
		 $.ajax({
			 type:"POST",
			 url:"/analysisUpdate.do",
			 data: {"a_no" : a_no,
				 	"q_no" : q_no,
			 	 	"q_id" : currentUser,
					"q_selection" : currentSelection,
					"q_value" : value,
					"a_order" : 1,
					"a_value" : a_value,
					"a_isetc" : 0},
			 dataType : "json",
			 success : function(result) {
			 },
			 error : function(error) {
			 	alert('에러 발생');
			 }
		 });
	});
}
/* 단수 문항 체크 시 사용되는 로직 끝 */


/* 기타 textarea에 값을 입력시 사용되는 로직 */
function EtcInput(q_no) {
	
	var currentId = '${userid}';													// 현재 접속된 ID	
	var a_value = $('#EtcArea' + q_no).val();										// 문제 번호에 따른 textarea에 입력한 값
	var q_selection = $('#q_selection' + q_no).val();								// 문제 타입 1111, 1112 ...
	var q_value = $('input[name=selectGroup'+ q_no +']:checked').attr('value');		// 기타 value 값 지정
	
	// ajax 통신을 통해 Controller로 보냄
	$.ajax({
		type:"POST",
		url:"/etcInput.do",
		data : {"q_id" : currentId,
				"q_no" : q_no,
				"q_value" : q_value,
				"q_selection" : q_selection,
				"a_value" : a_value,
				"a_isetc" : 1
				},
		dataType : "json",
		success : function(result) {
			alert('저장되었습니다.');
		},
		error : function(error) {
			alert('실패');
		}
	});
}
/* 기타 textarea에 값을 입력시 사용되는 로직 끝 */


/* 주관식 문항을 입력하였을때 사용되는 로직 */
function subjectInput(q_no) {
	
	var currentId = '${userid}';								// 현재 접속된 ID
	var q_selection = $('#q_selection' + q_no).val();			// 현재 문제의 타입. 주관식끼리는 타입이 같으므로 아마 1117 하나만 들어갈 것이다.
	var a_value = $('#selectGroup' + q_no).val();				// 주관식 문제에 입력한 값
	var valueLength = $('#selectGroup' + q_no).val().length;	// 입력된 값의 길이. 이게 0이면 입력하지 않은 꼴이 된다.
	
	$.ajax({
		type : "POST",
		url : "/subjectInput.do",
		data : {
			"q_id" : currentId,
			"q_no" : q_no,
			"q_value" : 0,
			"q_selection" : q_selection,
			"a_value" : a_value,
			"a_isetc" : 1
		},
		dataType : "json",
		success : function(result) {
			alert('저장되었습니다.');
		},
		error : function(error) {
			alert('실패');
		}
	});	
}
/* 주관식 문항을 입력하였을때 사용되는 로직 끝 */

/* 페이지당 제대로 입력된 문항을 체크하기 위한 로직 
 * 하드 코딩 되었다. 이 부분을 가장 우선적으로 손봐야 함. */
function nextPageCheck(page) {
	
	var temp = page;
	var url = '${pageContext.request.contextPath}';
	var limit = 2;
	
	/* $('input:checkbox[name*="selectGroup"]').each(function() {
		var check = $(this).is(':checked').length;
		alert(check);
	}) */
	
	if(page == 1) {
		var a = $('input:checkbox[name="selectGroup1"]:checked').length;
		var b = $('input:checkbox[name="selectGroup2"]:checked').length;
		var c = $('input:checkbox[name="selectGroup3"]:checked').length;
		var d = $('input:checkbox[name="selectGroup4"]:checked').length;
		var e = $('input:checkbox[name="selectGroup5"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			if(a == 0) {
				alert('1번 문항이 체크되지 않았습니다.')
			} else if(b == 0) {
				alert('2번 문항이 체크되지 않았습니다.')
			} else if(c == 0) {
				alert('3번 문항이 체크되지 않았습니다.')
			} else if(d == 0) {
				alert('4번 문항이 체크되지 않았습니다.')
			} else if(e == 0) {
				alert('5번 문항이 체크되지 않았습니다.')
			}
		} else  {
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
		
	} else if (page == 2) {
		var a = $('input:checkbox[name="selectGroup6"]:checked').length;
		var b = $('input:checkbox[name="selectGroup7"]:checked').length;
		var c = $('input:checkbox[name="selectGroup8"]:checked').length;
		var d = $('input:checkbox[name="selectGroup9"]:checked').length;
		var e = $('input:checkbox[name="selectGroup10"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			if(a == 0) {
				alert('6번 문항이 체크되지 않았습니다.')
			} else if(b == 0) {
				alert('7번 문항이 체크되지 않았습니다.')
			} else if(c == 0) {
				alert('8번 문항이 체크되지 않았습니다.')
			} else if(d == 0) {
				alert('9번 문항이 체크되지 않았습니다.')
			} else if(e == 0) {
				alert('10번 문항이 체크되지 않았습니다.')
			}
		} else  {
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
		
	} else if (page == 3) {
		var a = $('input:checkbox[name="selectGroup11"]:checked').length;
		var b = $('input:checkbox[name="selectGroup12"]:checked').length;
		var c = $('input:checkbox[name="selectGroup13"]:checked').length;
		var d = $('input:checkbox[name="selectGroup14"]:checked').length;
		var e = $('input:checkbox[name="selectGroup15"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			if(a == 0) {
				alert('11 번 문항이 체크되지 않았습니다.')
			} else if(b == 0) {
				alert('12 번 문항이 체크되지 않았습니다.')
			} else if(c == 0) {
				alert('13 번 문항이 체크되지 않았습니다.')
			} else if(d == 0) {
				alert('14번 문항이 체크되지 않았습니다.')
			} else if(e == 0) {
				alert('15번 문항이 체크되지 않았습니다.')
			}
		} else  {
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
		
	} else if (page == 4) {
		var a = $('input:checkbox[name="selectGroup17"]:checked').length;
		var a_value = $('input:checkbox[name="selectGroup17"]:checked').attr('data-code2');
		if(a_value == '없음') {
			a = 2;
		}
		
		var b = $('input:checkbox[name="selectGroup18"]:checked').length;
		var b_value = $('input:checkbox[name="selectGroup18"]:checked').attr('data-code2');
		if(b_value == '없음') {
			b = 2;
		}
		
		var c = $('input:checkbox[name="selectGroup19"]:checked').length;
		var c_value = $('input:checkbox[name="selectGroup19"]:checked').attr('data-code2');
		if(c_value == '없음') {
			c = 2;
		}
		
		var d = $('#selectGroup20').val().length;
		var e = $('input:checkbox[name="selectGroup21"]:checked').length;
		
		if (a < limit  || b < limit || c < limit || d == 0 || e == 0) {
			if(a < limit ) {
				alert('16-1 번 문항이 체크되지 않았습니다.')
			} else if(b < limit ) {
				alert('16-2 번 문항이 체크되지 않았습니다.')
			} else if(c < limit) {
				alert('16-3 번 문항이 체크되지 않았습니다.')
			} else if(d == 0) {
				alert('17번 문항이 체크되지 않았습니다.')
			} else if(e == 0) {
				alert('18번 문항이 체크되지 않았습니다.')
			}
		} else  {
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
		
	} else if(page == 5) {
		var id = '${userid}';
		var a = $('#selectGroup22').val().length;
		if(a <= 0) {
			var result = confirm('18번 문항이 체크되지 않았습니다. 이대로 제출하시겠습니까?');
			if(result) {
				alert(id + '님 수고하셨습니다.');
				location.href = url + '/analysisComplete.do';
			} else {
				alert('취소하셨습니다. 항목을 작성한 다음 반드시 저장해 주십시오.');
			}
		} else  {
			alert(id + '님 수고하셨습니다.');
			location.href = url + '/analysisComplete.do';
		} 
		
	}
}
</script>
</body>
</html>