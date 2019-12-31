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
<script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/1.0.3/jquery.tablednd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/1.0.3/jquery.tablednd.min.js"></script>
<!-- <script type="text/javascript" src="resources/jquery.tablednd.js"></script> -->
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>개인 페이지</title>
</head>
<body>
	<div class="row" style="margin-top: 5rem;">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="card" style="width:100%;">
			  <div class="card-header">
			  	${sessionScope.username }의 갤로그
			  </div>
			  <ul class="list-group list-group-flush">
			  	<c:if test="${fn:length(indiList) lt 1}">
					<li class="list-group-item">
						작성한 글이 없습니다.
					</li>			  	
			  	</c:if>
			  	<c:if test="${fn:length(indiList) gt 0 }">
			    	<c:forEach items="${indiList }" var="indiList">
				    <li class="list-group-item">
				    		<strong><a href="#" onclick="goToArticle(${indiList.board_no}, ${indiList.article_no })">${indiList.menu_name } - ${indiList.article_title }</a></strong><br>
				    		${indiList.article_content } ...
				    </li>
			    	</c:forEach>
			  	</c:if>
			  </ul>
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>
	<script type="text/javascript">
		function goToArticle(board_no, article_no) {
			window.open("/multi/articleRead.do?board_no=" + board_no + "&article_no=" + article_no, "_blank", "width: 800px, height: 800px");
		}
	</script>
</body>
</html>