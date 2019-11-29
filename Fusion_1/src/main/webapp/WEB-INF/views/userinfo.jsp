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
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>사용자 정보</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>상세 정보</strong></div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item"><strong>회원 일련 번호 : </strong>${userInfo.userno }</li>
			<li class="list-group-item"><strong>아이디 : </strong>${userInfo.userid }</li>
			<li class="list-group-item"><strong>비밀번호 : </strong>${userInfo.userpw }</li>
			<li class="list-group-item"><strong>이름 : </strong>${userInfo.username }</li>
			<li class="list-group-item"><strong>관리자 여부 : </strong>${userInfo.user_admin }</li>
			<li class="list-group-item"><strong>활성화 여부 : </strong>${userInfo.user_aval }</li>
		</ul>
	</div>
</body>
</html>
