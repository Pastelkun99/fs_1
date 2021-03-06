<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>테스트 중입니다.</title>
</head>
<body>
<div class="row">
<div class="col-md-3"></div>
<div class="col-md-6">
<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">날짜</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach items="${boardList}" var="boardList">
    <tr>
      <th scope="row">${boardList.board_no }</th>
      <td>
      	<form name="readArticle" id="readArticle${boardList.board_no }" action="/multi/testFormArticle.do" method="post" target="popup_window">
      		<input type="hidden" id="board_no" name="board_no" value="${boardList.board_no }">
	      	<a href="#" id="submitLink" onclick="goToArticle(${boardList.board_no});" class="goToArticle ${boardList.board_no }">${boardList.board_title }</a>
      	</form>
      </td>
      <td>${boardList.board_date }</td>
    </tr>
  	</c:forEach>
  </tbody>
</table>
</div>
<div class="col-md-3"></div>
</div>
<script type="text/javascript">
	/* function goToArticle() {
		var articleForm = document.readArticle;
		var url = "/multi/testFormArticle.do";
		window.open('', 'readArticle', 'width=500px, height=500px');
		
		articleForm.action = url;
		articleForm.method = "post";
		articleForm.target = "readArticle";
		articleForm.submit();
	} */
	
	/* $('#submitLink').on("click", function() {
		window.open("", 'popup_window', 'width=500px, height=500px');
		$('#readArticle').submit();		
	}); */
	
	function goToArticle(board_no) {
		window.open("", "popup_window", "width=500px, height=500px");
		$('#readArticle' + board_no).submit();
	}	
</script>
</body>
</html>