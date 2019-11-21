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
		<div id="qGroup1">
			<c:forEach items="${questionList }" var="question" varStatus="status">
					<c:if test="${question.q_page eq 1 }">
						<div class="card" style="width: 100%; margin-bottom:40px;">
		  					<div class="card-header">
		  					  ${question.q_no }. <strong>${question.q_subject }</strong> ${question.q_value }
		  					</div>
		  					<ul class="list-group list-group-flush">
		  					  <li class="list-group-item">
		  			 		 	<c:forEach items="${selectList }" var="select">
		  			  				<c:if test="${question.q_no eq select.q_no }">
		  								<c:if test="${select.q_type eq '001'}">
				  					  		<input type="checkbox" id="selectGroup${question.q_no }" name="selectGroup${question.q_no }" value="${select.q_order }">${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
				  			  			</c:if>
				  			  		<c:if test="${select.q_selection eq '1117'}">
			  				  			<textarea rows="5" cols="100"></textarea>
			  				  		</c:if>
			  				  			<c:if test="${select.q_selection eq '1110' }">
			  			  				</c:if>
			  			  			</c:if>
		  			  			</c:forEach>
		  			  		  </li>
		 			 		</ul>
						</div>
					</c:if>
			</c:forEach>
		</div>
		
		<div id="qGroup2">
			<c:forEach items="${questionList }" var="question" varStatus="status">
					<c:if test="${question.q_page eq 2 }">
						<div class="card" style="width: 100%; margin-bottom:40px;">
		  					<div class="card-header">
		  					  ${question.q_no }. <strong>${question.q_subject }</strong> ${question.q_value }
		  					</div>
		  					<ul class="list-group list-group-flush">
		  					  <li class="list-group-item">
		  			 		 	<c:forEach items="${selectList }" var="select">
		  			  				<c:if test="${question.q_no eq select.q_no }">
		  								<c:if test="${select.q_type eq '001'}">
				  					  		<input type="checkbox" id="selectGroup${question.q_no }" name="selectGroup${question.q_no }" value="${select.q_order }">${select.q_svalue }&nbsp;&nbsp;&nbsp;&nbsp;
				  			  			</c:if>
				  			  		<c:if test="${select.q_selection eq '1117'}">
			  				  			<textarea rows="5" cols="100"></textarea>
			  				  		</c:if>
			  				  			<c:if test="${select.q_selection eq '1110' }">
			  			  				</c:if>
			  			  			</c:if>
		  			  			</c:forEach>
		  			  		  </li>
		 			 		</ul>
						</div>
					</c:if>
			</c:forEach>
		</div>
	</div>
  	<div class="col-3"></div>
</div>
<div class="row">
<div class="col-3"></div>
<div class="col-6" style="text-align:right;">
	<c:if test="${param.page eq 1 }">
		<button class="btn btn-lg btn-primary" id="commitCheck" onClick="commitCheck();" style="width:200px;">다음</button>
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
	$("input:checkbox").on('click', function() {
	  var $box = $(this);
	  if ($box.is(":checked")) {
	    var group = "input:checkbox[id='" + $box.attr("id") + "']";
	    $(group).prop("checked", false);
	    $box.prop("checked", true);
	  } else {
	    $box.prop("checked", false);
	  }
	});
	
	function commitCheck() {
		 var a = $('input:checkbox[name="selectGroup1"]:checked').val();
		 alert(a);
	}
	
</script>
</body>
</html>
