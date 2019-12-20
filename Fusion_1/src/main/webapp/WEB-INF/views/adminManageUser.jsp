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
	    $('#userTable').DataTable();
	} );
</script>
	<nav class="navbar navbar-expand-lg navbar-light bg-light" style="margin-bottom: 100px;">
		<a class="navbar-brand">관리자 페이지</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=user">유저 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=analysis&a_no=1&q_selection=1111">설문 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=popup&pop_id=1">팝업 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=board">게시판 관리</a></li>
				<li class="nav-item"><button type="button" class="btn btn-danger" onClick="logoutLogic();">로그아웃</button></li>
			</ul>
		</div>
	</nav>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<h1 style="text-align: center; margin-bottom: 30px;">유저 관리</h1>
			<table id="userTable" class="display" style="width:100%;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">No</th>
						<th scope="col">ID</th>
						<th scope="col">NAME</th>
						<th scope="col">관리자 여부</th>
						<th scope="col">활성화 여부</th>
						<th scope="col">MODE</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${userList }" var="userList" varStatus="status">
					<tr>
						<th scope="row">${status.index + 1 }</th>
						<td><a href="#" onclick="userInfoOpen('${userList.userid }')">${userList.userid }</a></td>
						<td>${userList.username }</td>
						<td>
							<select id="userAdmin${userList.userno }" name="user_admin" class="form-control">
								<option value="1"<c:if test="${userList.user_admin eq 1 }"> selected </c:if>>관리자</option>
								<option value="0"<c:if test="${userList.user_admin eq 0 }"> selected </c:if>>일반회원</option> 
							</select>
						</td>
						<td>
							<select id="userAval${userList.userno }" name="user_aval" class="form-control">
								<option value="1"<c:if test="${userList.user_aval eq 1 }"> selected </c:if>>활성화</option>
								<option value="0"<c:if test="${userList.user_aval eq 0 }"> selected </c:if>>비활성화</option> 
							</select>
						</td>
						<td>
							<button type="button" id="userInfoUpdate${userList.userno }" onclick="userInfoUpdate(${userList.userno});" class="btn btn-outline-success">수정</button>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-3"></div>
	</div>
<script>
var url = '${pageContext.request.contextPath}';

function userInfoOpen(user_id) {
	var windowInfo = window.open(url + "/mng/userInfo.do?userid=" + user_id, "유저 정보", "width=400, height=460");
	windowInfo.resizeTo(400, 400);
	windowInfo.resizeBy(0, 0);
}
	
function userInfoUpdate(no) {
	var userno = no;
	var userChangedAdmin = $('#userAdmin' + no).val();
	var userChangedAval = $('#userAval' + no).val();
	
	$.ajax({
		type : "POST",
		url : "/mng/userInfoUpdate.do",
		data : {"userno" : userno,
				"user_admin" : userChangedAdmin,
				"user_aval" : userChangedAval
		},
		dataType : "json",
		success : function(result) {
			alert('수정되었습니다.');
		},
		error : function(error) {
			alert('에러 발생');
		}
	});
}
	
function logoutLogic() {
  var root = '${pageContext.request.contextPath}';
  location.href = root + '/user/userSignOut.do';
}
</script>
</body>
</html>