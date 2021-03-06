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
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>권한 확인</title>
</head>
<body class="text-center">
<script type="text/javascript">
$(function () {
	  $('#passwordPopOver').popover({
	    container: 'body'
	  })
	})
</script>
<div class="row" style="margin-bottom: 18rem;"></div>
<div class="row">
	<div class="col"></div>
	<div class="col">
			<form class="form-signin" action="${pageContext.request.contextPath }/multi/ownerCheck.do" method="post">
				<h1 class="h3 mb-3 font-weight-normal">해당 글은 비밀글입니다.<br>비밀번호를 입력하세요.</h1>
					<input type="hidden" name="article_no" id="article_no" value="${article.article_no }">
					<input type="hidden" name="OrderedUrl" id="OrderedUrl" value="${OrderedUrl }">
					<input type="password" name="inputPassword" class="form-control" placeholder="Password" required>
				<br>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Check</button>
				<br>
				<br>
			</form>
		<c:if test="${userInfo.user_admin eq 1 }">
			<button type="button" id="passwordPopOver" class="btn btn-secondary" data-container="body" data-toggle="popover" data-placement="bottom" data-content="${article.article_password }">
  				관리자용 비밀번호 보기
			</button>
		</c:if>
		<p class="mt-5 mb-3 text-muted">&copy; Fusionsoft</p>
	</div>
	<div class="col"></div>
</div>
</body>
</html>
