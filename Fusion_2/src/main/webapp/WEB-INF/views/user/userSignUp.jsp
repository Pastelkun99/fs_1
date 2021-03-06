<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<html>
<head>
<title>회원 가입</title>
</head>
<body class="text-center">
<div class="row" style="margin-bottom: 15rem;"></div>
<div class="row">
	<div class="col"></div>
	<div class="col">
		<form class="form-signin" action="${pageContext.request.contextPath }/user/userSignUp.do" method="post">
			<h1 class="h3 mb-3 font-weight-normal">Sign up</h1>
				<input type="text" name="regID" id="regID" class="form-control" placeholder="ID" maxlength="16" autofocus required> 
					<br>
				<input type="password" name="regPassword" class="form-control" placeholder="Password" maxlength="16" required> 
					<br>
				<input type="text" name="regName" class="form-control" placeholder="Name" maxlength="50" required> 
					<br>
				<button class="btn btn-lg btn-primary btn-block" id="registerButton" type="submit" disabled="disabled">Register</button>
					<br>
				<input type="radio" name="userGender" class="custom-control-input" value="F">여성
				<input type="radio" name="userGender" class="custom-control-input" value="M">남성
		</form>
		<button class="btn btn-lg btn-outline-danger" onclick="location.href='${pageContext.request.contextPath}/'">Back to Main</button>
		<p class="mt-5 mb-3 text-muted">&copy; Fusionsoft Board</p>
	</div>
	<div class="col"></div>
</div>
<script>
	
</script>
</body>
</html>