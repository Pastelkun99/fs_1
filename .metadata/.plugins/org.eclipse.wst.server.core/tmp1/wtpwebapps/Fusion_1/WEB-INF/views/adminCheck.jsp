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
<title>관리자 페이지 입장</title>
</head>
<div>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</div>
<div class="row">
	<div class="col"></div>
	<div class="col">
		<body class="text-center">
			<form class="form-signin" action="${pageContext.request.contextPath }/mng/adminCheck.do" method="post">
				<h1 class="h3 mb-3 font-weight-normal">관리자 비밀번호를 확인합니다.</h1>
				<input type="password" name="inputPassword" class="form-control" placeholder="Password" required>
				</br>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Check</button>
				</br>
				</br>
			</form>
		<p class="mt-5 mb-3 text-muted">&copy; Fusionsoft</p>
		</body>
	</div>
	<div class="col"></div>
</div>
</html>
