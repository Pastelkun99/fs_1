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
<!DOCTYPE html>
<html>
<head>
<title>회원 가입</title>
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
			<form class="form-signin" action="${pageContext.request.contextPath }/user/userSignUp.do" method="post">
				<h1 class="h3 mb-3 font-weight-normal">Sign up</h1>
					<input type="text" name="regID" id="regID" class="form-control" placeholder="ID" required autofocus> </br>
					<p class="result">
						<span class="msg">아이디를 확인해 주십시오.</span>
					</p>
					<button type="button" class="btn btn-warning" onclick="userIdCheck()">아이디 확인</button> </br>
					</br>
					<input type="password" name="regPassword" class="form-control" placeholder="Password" required> </br>
					<input type="password" name="regPasswordConfirm" class="form-control" placeholder="Password Confirm" required> </br>
					<input type="text" name="regName" class="form-control" placeholder="Name" required> </br>
					<button class="btn btn-lg btn-primary btn-block" id="registerButton" type="submit" disabled="disabled">Register</button>
					</br>
					</br>
				</form>
			<button class="btn btn-lg btn-outline-danger" onclick="location.href='${pageContext.request.contextPath}/'">Back to Main</button>
			<p class="mt-5 mb-3 text-muted">&copy; Fusionsoft</p>
			</div>
			<div class="col"></div>
		</div>
		<script>
			function userIdCheck() {
				var regId = $('#regID').val();
				var regExp = /^[A-Za-z0-9+]{4,12}$/;
				var result = regExp.test(regId);
				
				if(result) {
					$.ajax({
						type : "POST",
						url : "/user/userIdCheck.do",
						data : {"regId" : regId},
						dataType : "json",
						success : function(result) {
							if(result == 1) {
								$(".result .msg").text('사용 가능한 아이디 입니다.');
								$(".result .msg").attr('style', 'color:#00f');
								$("#registerButton").removeAttr('disabled');
							} else {
								$(".result .msg").text('사용 불가능한 아이디 입니다.');
								$(".result .msg").attr('style', 'color:#f00');
								$("#registerButton").attr('disabled', true);
							}
						},
						error : function(error) {
							alert('아이디 검사 실패');
						}
					});
				} else {
					$(".result .msg").text('영문, 숫자를 포함한 4자리 이상으로 지정해주세요.');
					$(".result .msg").attr('style', 'color:#f00');
					$("#registerButton").attr('disabled');
					$('#regID').val('');
				}				
			}
		</script>
	</body>
</html>
