<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<script src="resources/analysis/analysis.js"></script>
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
	  			 		 	<c:forEach items="${selectList }" var="select" varStatus="order">
	  			  				<c:if test="${question.q_no eq select.q_no }">
	  								<c:if test="${select.q_type eq '001'}">
			  					  		<c:if test="${select.q_selection ne '1111' }">
			  					  		<input type="checkbox" 
			  					  			   class="commitCheckMulti a${question.q_no }" 
			  					  			   data-code="${question.q_no}" 
			  					  			   data-code2="${select.q_svalue }" 
			  					  			   onclick="commitCheckMulti(${question.q_no});" 
			  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
			  					  			   name="selectGroup${question.q_no }"
			  					  			   ${answerList[status.index].q_value eq select.q_order ? "checked='checked'" : ''}
			  					  			   value="${select.q_order }"
			  					  			   >${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
			  					  		<input type="hidden" id="q_selection" value="${question.q_selection }">
			  					  		</c:if>
	  									<c:if test="${select.q_selection eq '1111' }">
			  					  		<input type="checkbox" 
			  					  			   class="commitCheck a${question.q_no }" 
			  					  			   data-code="${question.q_no}"
			  					  			   onclick="commitCheck(${question.q_no});" 
			  					  			   id="selectGroup${question.q_no }_${select.q_order }" 
			  					  			   name="selectGroup${question.q_no }"
			  					  			   ${answerList[status.index].q_value eq select.q_order ? "checked='checked'" : ''}
			  					  			   value="${select.q_order }"
			  					  			   >${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
			  					  		<input type="hidden" id="q_selection" value="${question.q_selection }">
			  					  		</c:if>
			  			  			</c:if>
			  			  		<c:if test="${select.q_selection eq '1117'}">
		  				  			<textarea rows="5" cols="100" id="selectGroup${question.q_no }">${answerList[status.index].q_value }</textarea>
		  				  		</c:if>
		  			  		</c:if>
	  			  			</c:forEach>
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
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page + 1}'" style="width:200px;">다음</button>
	</c:if>
	<c:if test="${param.page eq 5 }">
		<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=${param.page - 1}'" style="width:200px;">이전</button>
	</c:if>
</div>
<div class="col-3"></div>
</div>
<script>
/* 각 문제에 대한 제한 설정 */
$(".commitCheck").on('click', function() {
	$('.a'+$(this).attr('data-code')).prop("checked", false);
	$(this).prop("checked", true);
	
	/* if ($box.is(":checked")) {
		//var group = "input:checkbox[id='" + $box.attr("id") + "']";
		
		//alert($(this).attr('data-code'));
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$box.prop("checked", true);
	} else {
		$box.prop("checked", false);
	} */
});



/* 제한 숫자, 만약 필요한 경우 추가로 선언하거나 값을 바꿀 수 있음 */
var limit = 2;


$('.commitCheckMulti').on('change', function(evt) {
	if ($(this).siblings(':checked').length >= limit) {
		this.checked = false;
	}
})

$(".commitCheckMulti").on('click', function() {
	if($(this).attr('data-code2') == '없음' && $(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', true);
		$('.a'+$(this).attr('data-code')).prop("checked", false);
		$(this).prop("checked", true);
		$(this).attr('disabled', false);
	}
	
	if($(this).attr('data-code2') == '없음' && !$(this).is(':checked')){
		$('.a'+$(this).attr('data-code')).attr('disabled', false);
	}
	
	if($(this).is(':checked')) {
		var test = '';
		var cnt = 0;
		var currentUserid = '${userid}';
		var currentSelection = $('#q_selection').val();
		var q_no = $(this).attr('data-code');
		
		$('input[name=selectGroup'+ $(this).attr('data-code') +']:checked').each(function() {
			if(cnt < 2) {
				test += $(this).val();
				cnt++;
				if(cnt == 1) { 
					test += ',';
				};
			}
		});
		
		 $.ajax({
			 type:"POST",
			 url:"/analysisUpdateMulti.do",
			 data: {"q_no" : q_no,
					"q_id" : currentUserid,
					"q_selection" : currentSelection,
					"q_value" : test},
			dataType : "json",
			success : function(result) {
				alert('tjdrhd');
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







/* 20번은 주관식 문항 */


/* 22번은 주관식 문항 */
  
 
 
 
/* 문제별 항목 제한 설정 끝 */
 
 
 
/* 문항별 체크 로직 */
function commitCheck(q_no) {
	$('.a' + q_no).on('click', function() {
		 var value = $(this).attr('value');
		 var currentUser = '${sessionScope.userid}';
		 var currentSelection = $('#q_selection').val();
		 
		 $.ajax({
			 type:"POST",
			 url:"/analysisUpdate.do",
			 data: {"q_no" : q_no,
					"q_id" : currentUser,
					"q_selection" : currentSelection,
					"q_value" : value},
			dataType : "json",
			success : function(result) {
				
			},
			error : function(error) {
				alert('에러...');
			}
		 });
		 
	});
	//console.log($(this).attr('value'));
	/*  var value = $('input:checkbox[name="selectGroup' + q_no + '"]:checked').val(); */
}

function commitCheckMulti(q_no) {
	
	var limit = 2;
	var valueArray = [];
	var currentUser = '${sessionScope.userid}';
	var currentSelection = $('#q_selection').val();

	/* $('input:checkbox[name="selectGroup' + q_no + '"]:checked').on('click', function() {
		var value = $(this).attr('value');
	 	alert(value);		
	}); */
	
	$('input:checkbox[name="selectGroup' + q_no + '"]:checked').each(function() {
		valueArray.push($(this).val());
	})
}

function nextPageCheck(page) {
	var url = '${pageContext.request.contextPath}';
	if(page == 1) {
		var a = $('input:checkbox[name="selectGroup1"]:checked').length;
		var b = $('input:checkbox[name="selectGroup2"]:checked').length;
		var c = $('input:checkbox[name="selectGroup3"]:checked').length;
		var d = $('input:checkbox[name="selectGroup4"]:checked').length;
		var e = $('input:checkbox[name="selectGroup5"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			alert('체크되지 않은 항목 존재.');
			if(a == 0) {
				alert('체크되지 않은 문항')
			} else if(b == 0) {
				
			} else if(c == 0) {
				
			} else if(d == 0) {
				
			} else if(e == 0) {
				
			}
		} else  {
			alert('기준 만족');
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
	} else if (page == 2) {
		var a = $('input:checkbox[name="selectGroup6"]:checked').length;
		var b = $('input:checkbox[name="selectGroup7"]:checked').length;
		var c = $('input:checkbox[name="selectGroup8"]:checked').length;
		var d = $('input:checkbox[name="selectGroup9"]:checked').length;
		var e = $('input:checkbox[name="selectGroup10"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			alert('체크되지 않은 항목 존재.');
		} else  {
			alert('기준 만족');
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
	} else if (page == 3) {
		var a = $('input:checkbox[name="selectGroup11"]:checked').length;
		var b = $('input:checkbox[name="selectGroup12"]:checked').length;
		var c = $('input:checkbox[name="selectGroup13"]:checked').length;
		var d = $('input:checkbox[name="selectGroup14"]:checked').length;
		var e = $('input:checkbox[name="selectGroup15"]:checked').length;
		if (a == 0 || b == 0 || c == 0 || d == 0 || e == 0) {
			alert('체크되지 않은 항목 존재.');
		} else  {
			alert('기준 만족');
			location.href= url + '/analysisList.do?page=' + (page+1);
		}
	} else if (page == 4) {
		
	}
}
</script>
</body>
</html>
