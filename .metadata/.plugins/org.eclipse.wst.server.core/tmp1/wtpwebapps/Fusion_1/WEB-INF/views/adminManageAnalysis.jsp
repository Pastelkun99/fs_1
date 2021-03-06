<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>관리자 페이지</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#questionTable').DataTable();
	    $('#selectTable').DataTable();
	} );
</script>
	<jsp:include page="adminNavbar.jsp"></jsp:include>
	<div class="row">
		<div class="col-md-1" style="text-align:center;">
		</div>
		<div class="col-md-3" style="margin-bottom: 3rem;">
			<h2>설문 이름</h2>
			<select name="a_no" id="a_no" class="form-control" style="text-align: center; margin-bottom: 2rem;">
				<c:forEach items="${infoList }" var="info">
					<option value="${info.a_no }" <c:if test="${info.a_no eq param.a_no }">selected</c:if>>${info.a_name }&nbsp;&nbsp;${info.a_fromdate }&nbsp;~&nbsp;${info.a_todate }</option>
				</c:forEach>
			</select>
			<button class="btn btn-info" onclick="infoAppend(${infoCount + 1});">설문조사 등록</button>
			<button class="btn btn-warning" onclick="infoUpdate(${param.a_no});">설문조사 수정</button>
			<button class="btn btn-danger" onclick="infoDelete(${param.a_no});">설문조사 삭제</button>
		</div>
		<div class="col-md-3">
		</div>
	</div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<table id="selectTable" class="display" style="width:100%;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">문제번호</th>
						<th scope="col">구분</th>
						<th scope="col">문제</th>
						<th scope="col">형식</th>
						<th scope="col">매칭 문항</th>
						<th scope="col">보여줄 페이지</th>
						<th scope="col">Mode</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="question" items="${questionList}" varStatus="status">
						<tr>
							<th scope="row">${status.index + 1 }</th>
							<td style="width: 140px;"><strong>${question.q_subject}</strong></td>
							<td>${question.q_value }</td>
							<td>${question.q_type }</td>
							<td style="width:90px;">${question.q_selection }</td>
							<td style="width:30px;">${question.q_page }</td>
							<td>
								<button class="btn btn-sm btn-info" id="updateQuestion(${question.q_no });" onclick="updateQuestion(${question.q_no });">수정</button>
								<button class="btn btn-sm btn-danger" id="deleteQuestion(${question.q_no });"onclick="deleteQuestion(${question.q_no });">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-1"></div>
	</div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" style="text-align:right; margin-top: 3rem;">
			<button class="btn btn-lg btn-primary" onclick="createQuestion();">등록</button>
		</div>
		<div class="col-md-1"></div>
	</div>
	<div class="row">
		<div class="col-md-1" style="text-align:center;">
		</div>
		<div class="col-md-3" style="margin-bottom: 3rem;">
			<h2>문항 정보</h2>
			<select name="q_selection" id="q_selection" class="form-control" style="text-align: center; width:50%; margin-bottom: 3rem;">
				<c:forEach items="${selectionList }" var="selection">
					<option value="${selection.q_selection }"<c:if test="${selection.q_selection eq param.q_selection }">selected</c:if>>${selection.q_selection }</option>
				</c:forEach>
			</select>
			<button class="btn btn-info" onclick="newGroup(1);">새로운 객관식 단수 그룹</button>
			<button class="btn btn-warning" onclick="newGroup(2);" style="margin-left: 3rem;">새로운 객관식 복수 그룹</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<table id="questionTable" class="display" style="width:100%;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">No</th>
						<th scope="col">구분</th>
						<th scope="col">문항</th>
						<th scope="col">Mode</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="selection" items="${selectionInfoList}" varStatus="status">
						<tr>
							<th scope="row">${status.index + 1 }</th>
							<c:if test="${selection.q_selection gt 1110 && selection.q_selection lt 3001 }">
								<td>객관식 단수 문항</td>
							</c:if>
							<c:if test="${selection.q_selection gt 3001 && selection.q_selection lt 5001 }">
								<td>객관식 복수 문항</td>
							</c:if>
							<c:if test="${selection.q_selection eq 5000 }">
								<td>주관식 문항</td>
							</c:if>
							<td><strong>${selection.q_svalue }</strong></td>
							<td>
								<button class="btn btn-sm btn-info" id="updateSelection(${selection.select_no });" onclick="updateSelection(${selection.select_no });">수정</button>
								<button class="btn btn-sm btn-danger" id="deleteSelection(${selection.select_no });"onclick="deleteSelection(${selection.select_no });">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-1"></div>
	</div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" style="text-align:right; margin-top: 3rem;">
			<button class="btn btn-lg btn-primary" onclick="selectionAppend()">등록</button>
		</div>
		<div class="col-md-1"></div>
	</div>
<script>
function infoAppend(a_no) {
	var url = '${pageContext.request.contextPath}';
	window.open(url + "/mng/infoAppend.do", "문제 정보", "width=700, height=820");
}

function infoUpdate(a_no) {
	var url = '${pageContext.request.contextPath}';
	window.open(url + "/mng/infoUpdate.do?a_no=" + a_no, "문제 수정", "width=700, height=820");
}

function infoDelete(a_no) {
	var result = confirm('현재 설문 조사를 삭제합니다. 설문조사가 가진 문제도 삭제됩니다만 괜찮겠습니까?');
	if(result) {
		$.ajax({
			type : "post",
			url : "/mng/infoDelete.do",
			data : {"a_no" : a_no},
			dataType : "json",
			success : function(result) {
				alert('현재 설문조사가 삭제되었습니다.');
				window.location.href = '/mng/adminManagement.do?mode=analysis&a_no=1&q_selection=1111';
			},
			error : function(error) {
				alert('실패');
			}
		})
	} else {
		
	}
}

$(function () {
	$('#a_no').change(function() {
		var url = '${pageContext.request.contextPath}';
		var value = this.value;
		var selection = $('#q_selection').val();
		location.href = url + '/mng/adminManagement.do?mode=analysis&a_no=' + value + '&q_selection=' + selection;
	})
})

$(function () {
	$('#q_selection').change(function() {
		var url = '${pageContext.request.contextPath}';
		var value = this.value;
		var a_no = $('#a_no').val();
		location.href = url + '/mng/adminManagement.do?mode=analysis&a_no=' + a_no + '&q_selection=' + value;
	})
})



function updateQuestion(q_no) {
	var a_no = '${param.a_no}';
	var url = '${pageContext.request.contextPath}';
	window.open(url + "/mng/questionInfo.do?a_no=" + a_no + "&q_no=" + q_no, "문제 정보", "width=700, height=820");
}

function deleteQuestion(q_no) {
	var a_no = '${param.a_no}';
	var url = '${pageContext.request.contextPath}';
	
	$.ajax({
		type:"post",
		url:"/mng/questionDelete.do",
		data:{"q_no" : q_no,
		      "a_no" : a_no,
		      },
		dataType:"json",
		success : function(result) {
			alert('성공');
			location.reload();
		},
		error : function(error) {
			alert('실패');
		}
	});
}

function createQuestion() {
	var a_no = '${param.a_no}';
	var url = '${pageContext.request.contextPath}';
	window.open(url + "/mng/questionAppend.do?a_no=" + a_no, "문제 등록", "width=700, height=820");
}

function newGroup(condition) {
	if(condition == 1) {
		var uid = '${oddCount}';
		uid *= 1;
		var uuid = uid + 1;
		
		$.ajax({
			type:"post",
			url:"/mng/newOddGroup.do",
			data: {
					"q_type" : '001',
					"q_selection" : uuid,
					"q_svalue" : '임시 문항',
					"q_order" : 1
				 },
			dataType : "json",
			success : function(result) {
				alert(uuid + '번 그룹이 생성되었습니다.');
				location.reload();
			},
			error : function(error) {
				alert('실패');
			}
		});
	} else {
		var uid = '${evenCount}';
		uid *= 1;
		var uuid = uid + 1;
		
		$.ajax({
			type:"post",
			url:"/mng/newEvenGroup.do",
			data: {
					"q_type" : '001',
					"q_selection" : uuid,
					"q_svalue" : '임시 문항',
					"q_order" : 1
				 },
			dataType : "json",
			success : function(result) {
				alert(uuid + '번 그룹이 생성되었습니다.');
				location.reload();
			},
			error : function(error) {
				alert('실패');
			}
		});
	}
}

function updateSelection(select_no) {
	var url = '${pageContext.request.contextPath}';
	var q_selection = '${param.q_selection}'; 
	window.open(url + "/mng/selectionUpdate.do?q_selection=" + q_selection + "&select_no=" + select_no, "문제 수정", "width=500, height=250");
}

function selectionAppend() {
	var url = '${pageContext.request.contextPath}';
	var q_selection = '${param.q_selection}';
	window.open(url + '/mng/selectionAppend.do?q_selection=' + q_selection, "문항 등록", "width=500, height=250");
}

function deleteSelection(select_no) {
	$.ajax({
		type : "POST",
		url : "/mng/deleteSelection.do",
		data : {
			"select_no" : select_no
		},
		dataType : "json",
		success : function(result) {
			alert('삭제했습니다.');
			location.reload();
		},
		error : function(error) {
			alert('문제 발생');
		}
	})
}
function logoutLogic() {
	  var root = '${pageContext.request.contextPath}';
	  location.href = root + '/user/userSignOut.do';
	}

</script>
</body>
</html>