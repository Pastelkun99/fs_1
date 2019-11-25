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
		<div class="progress" style="margin-bottom: 70px; margin-top:70px">
  			<div class="progress-bar" role="progressbar" style="width:${param.page * 20}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
		<c:forEach items="${questionList }" var="question" varStatus="status">
				<c:if test="${question.q_page eq param.page }">
					<div class="card" style="width: 100%; margin-bottom:40px;">
	  					<div class="card-header">
	  					  ${question.q_parentno }.<c:if test="${question.q_depth ne 0 }">${question.q_depth }</c:if> 
	  					  <strong>${question.q_subject }</strong> ${question.q_value }
	  					</div>
	  					<ul class="list-group list-group-flush">
	  					  <li class="list-group-item">
	  					  	
	  					  	<c:set var="etc" value="N" />
	  					  	
	  			 		 	<c:forEach items="${selectList }" var="select" varStatus="order">
	  			  				<c:if test="${question.q_no eq select.q_no }">
	  			  					<!-- 객관식 001  -->
	  								<c:if test="${select.q_type eq '001'}">
	  									<!-- 복수선택 1111-->
			  					  		<c:if test="${select.q_selection ne '1111' && select.q_selection ne '1115' }">
				  					  		
				  					  			<c:if test="${select.q_svalue eq '기타' }">
				  					  				 <c:set var="etc" value="Y" />
				  					  			</c:if>
				  					  		
				  					  		
				  					  		<!-- 이 부분은 복수 체크 문항 -->
				  					  		<input type="checkbox" 
				  					  			   class="commitCheckMulti a${question.q_no }" 
				  					  			   data-code="${question.q_no}" 
				  					  			   data-code2="${select.q_svalue }" 
				  					  			   <%-- onclick="commitCheckMulti(${question.q_no});" --%> 
				  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
				  					  			   name="selectGroup${question.q_no }"
				  					  			   <%-- ${answerList[question.q_no].q_value eq select.q_order ? "checked='checked'" : ''} --%>
				  					  			   <c:forEach items="${answerList }" var="answer">
				  					  			   		<c:if test="${question.q_no eq answer.q_no }">
				  					  			   			<c:if test="${select.q_order eq answer.q_value }">
				  					  			   				checked='checked'
				  					  			   			</c:if>
				  					  			   		</c:if>
				  					  			   </c:forEach>
				  					  			   value="${select.q_order }"
				  					  			   >${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
				  					  		<%-- <c:if test="${select.q_selection eq '1114' || select.q_selection eq '1115' }">
										  		<div class="hiddenArea${question.q_no }" order="${select.q_svalue }" style="display: none">
										  		</div>
									  		</c:if> --%>
				  					  		<input type="hidden" id="q_selection${question.q_no }" value="${question.q_selection }">
			  					  		</c:if>
			  					  		<!--  복수 끝 -->
			  					  		
	  									<c:if test="${select.q_selection eq '1111' || select.q_selection eq '1115' }">
	  									<c:if test="${select.q_svalue eq '기타' }">
	  					  					 <c:set var="etc" value="Y" />
	  					  				</c:if>
	  									<!-- 이 부분은 단수 체크 -->
			  					  		<input type="checkbox" 
			  					  			   class="commitCheck a${question.q_no }" 
			  					  			   data-code="${question.q_no}"
			  					  			   data-code2="${select.q_svalue }"
			  					  			   <%-- onclick="commitCheck(${question.q_no});"  --%>
			  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
			  					  			   name="selectGroup${question.q_no }"
			  					  			   onclick="commitCheck(${question.q_no});"
			  					  			  <%--  ${answerList[status.index].q_value eq select.q_order ? "checked='checked'" : ''} --%>
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
			  			  			</c:if>
			  			  			<!-- 객관식 끝 -->
			  			  		<c:if test="${select.q_selection eq '1117'}">
		  				  			<textarea rows="5" cols="100" id="selectGroup${question.q_no }"><c:forEach items="${answerList }" var="answer"><c:if test="${question.q_no eq answer.q_no }"><c:if test="${answer.a_isetc eq 1 }">${answer.a_value }</c:if></c:if></c:forEach></textarea>
		  				  			<button type="button" class="btn btn-success" onclick="subjectInput(${question.q_no});">저장</button>
		  				  			<input type="hidden" id="q_selection${question.q_no }" value="${question.q_selection }">
		  				  		</c:if>
		  			  		</c:if>
	  			  			</c:forEach>
	  			  			<c:if test="${etc eq 'Y' }">
	  			  				<%-- <input type="text" class="form-control" id="EtcArea${question.q_no }" style="width: 50%;" placeholder="기타 입력 후 저장 버튼을 꼭 눌러주세요!" disabled="disabled">
	  			  				<button type="button" class="btn btn-success" onclick="">저장</button> --%>
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
				  					  			   </c:forEach>>
								  <div class="input-group-append">
								    <button class="btn btn-outline-secondary" id="EtcAreaButton${question.q_no }" type="button" id="button-addon2" onclick="EtcInput(${question.q_no});" disabled="disabled">저장</button>
								  </div>
								</div>
	  			  			</c:if>
	  			  		  </li>
	 			 		</ul>
					</div>
				</c:if>
		</c:forEach>
	</div>
  	<div class="col-3"></div>
</div>
<div class="row">
<div class="col-3"></div>
<div class="col-6" style="text-align:right;">
	<c:if test="${param.page eq 1 }">
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="nextPageCheck(${param.page});" style="width:200px;">다음</button>
	</c:if>
	<c:if test="${param.page lt 5 && param.page gt 1 }">
		<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page - 1}'" style="width:200px;">이전</button>
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="nextPageCheck(${param.page});" style="width:200px;">다음</button>
	</c:if>
	<c:if test="${param.page eq 5 }">
		<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page - 1}'" style="width:200px;">이전</button>
		<button class="btn btn-lg btn-success" id="commitCheck" onClick="location.href='${pageContext.request.contextPath}/analysisComplete.do'" style="width:200px;">완료</button>
	</c:if>
</div>
<div class="col-3"></div>
</div>
<script>
/* 각 문제에 대한 제한 설정 */
 

$(document).ready(function() {
	
	
	$('.commitCheckMulti').each(function() {
		if($(this).attr('data-code2') == '없음' && $(this).is(':checked')) {
			$('.a'+$(this).attr('data-code')).attr('disabled', true);
			$('.a'+$(this).attr('data-code')).prop("checked", false);
			$(this).prop("checked", true);
			$(this).attr('disabled', false);
		}
		if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
			$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
			$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
		}
		
	});
	
	$('.commitCheck').each(function() {
		if($(this).attr('data-code2') == '없음' && $(this).is(':checked')) {
			$('.a'+$(this).attr('data-code')).attr('disabled', true);
			$('.a'+$(this).attr('data-code')).prop("checked", false);
			$(this).prop("checked", true);
			$(this).attr('disabled', false);
		}
		if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
			$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
			$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
		}
		
	});
	
});
 
 
$(".commitCheck").on('click', function() {
	
	$('.a'+$(this).attr('data-code')).prop("checked", false);
	$(this).prop("checked", true);
	
	if(!($(this).attr('data-code2') == '기타')) {
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
	}
	
});



/* 제한 숫자, 만약 필요한 경우 추가로 선언하거나 값을 바꿀 수 있음 */
var limit = 2;


/* $('.commitCheckMulti').on('change', function(evt) {
	if($(this).siblings(':checked').length >= limit) {
		this.checked = false;
	}
}) */

$(".commitCheckMulti").on('click', function() {
	
	// 체크 2개이상  X
	/* if($(this).siblings(':checked').length >= limit) {
		this.checked = false;
		return;
	} */
	
	if($(this).attr('data-code2') == '없음' && $(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', true);
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	if($(this).attr('data-code2') == '없음' && !$(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', false);
	}
	
	if($(this).attr('data-code2') == '기타' && $(this).is(':checked')) {
 		/* $('.a'+$(this).attr('data-code')).attr('disabled', true);
 		$('.a'+$(this).attr('data-code')).prop("checked", false); */
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', false);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', false);
	}
	
	if($(this).attr('data-code2') == '기타' && !$(this).is(':checked')){
		$('#EtcArea' + $(this).attr('data-code')).val('');
		$('#EtcArea' + $(this).attr('data-code')).attr('disabled', true);
		$('#EtcAreaButton' + $(this).attr('data-code')).attr('disabled', true);
	}
	
	// 체크 2개이상  X
	if($(this).siblings(':checked').length >= limit) {
		this.checked = false;
		return;
	}
	
	// DB
	if($(this).is(':checked')) {
		var test = '';
		var a_value = '';
		var cnt = 0;
		var currentUserid = '${userid}';
		var q_no = $(this).attr('data-code');
		var currentSelection = $('#q_selection' + q_no).val();
		
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
		
		 $.ajax({
			 type:"POST",
			 url:"/analysisUpdateMulti.do",
			 data: {"q_no" : q_no,
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
	
	/* var value = $(this).val();
	var $box = $(this);
	var group = "input:checkbox[id='" + $box.attr("id") + "']";
	var checked;
	if(value == 20 && checked) {
		$(group).attr('disabled', false);
		checked = false;
	}
	if(value == 20) {
		$(group).attr('disabled', true);
		$box.attr('disabled', false);
		checked = true;
	} */
});

/* 문제별 항목 제한 설정 끝 */
 
 
 
/* 문항별 체크 로직 */
function commitCheck(q_no) {
	$('.a' + q_no).on('click', function() {
		 var value = $(this).attr('value');
		 var currentUser = '${sessionScope.userid}';
		 var currentSelection = $('#q_selection' + q_no).val();
		 var a_value = $(this).attr('data-code2');
		 
		 $.ajax({
			 type:"POST",
			 url:"/analysisUpdate.do",
			 data: {"q_no" : q_no,
					"q_id" : currentUser,
					"q_selection" : currentSelection,
					"q_value" : value,
					"a_order" : 1,
					"a_value" : a_value,
					"a_isetc" : 0},
			dataType : "json",
			success : function(result) {
				alert('성공');
			},
			error : function(error) {
				alert('에러...');
			}
		 });
		 
	});
	//console.log($(this).attr('value'));
	/*  var value = $('input:checkbox[name="selectGroup' + q_no + '"]:checked').val(); */
}

/* function commitCheckMulti(q_no) {
	
	var limit = 2;
	var valueArray = [];
	var currentUser = '${sessionScope.userid}';
	var currentSelection = $('#q_selection').val();

	/* $('input:checkbox[name="selectGroup' + q_no + '"]:checked').on('click', function() {
		var value = $(this).attr('value');
	 	alert(value);		
	}); */
	
/* 	$('input:checkbox[name="selectGroup' + q_no + '"]:checked').each(function() {
		valueArray.push($(this).val());
	})
} */

function EtcInput(q_no) {
	var currentId = '${userid}';	
	var a_value = $('#EtcArea' + q_no).val();
	var q_selection = $('#q_selection' + q_no).val();
	var q_value = $('input[name=selectGroup'+ q_no +']:checked').attr('value');
	
	$.ajax({
		type:"POST",
		url:"/etcInput.do",
		data : {
			"q_id" : currentId,
			"q_no" : q_no,
			"q_value" : q_value,
			"q_selection" : q_selection,
			"a_value" : a_value,
			"a_isetc" : 1
		},
		dataType : "json",
		success : function(result) {
			alert('성공');
		},
		error : function(error) {
			alert('실패');
		}
	})
}

function subjectInput(q_no) {
	var currentId = '${userid}';	
	var q_selection = $('#q_selection' + q_no).val();
	var a_value = $('#selectGroup' + q_no).val();
	var valueLength = $('#selectGroup' + q_no).val().length;
	if(valueLength == 0) {
		alert('내용을 입력해 주십시오.');
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"/subjectInput.do",
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
			alert('성공');
		},
		error : function(error) {
			alert('실패');
		}
	})	
}

function nextPageCheck(page) {
	var url = '${pageContext.request.contextPath}';
	var limit = 2;
	
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
	}
}
</script>
</body>
</html>
