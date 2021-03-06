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
<title>WebBoard - 게시판입니다.</title>
</head>
<body>
</br>
</br>
</br>
</br>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col-11">
				<c:if test="${sessionScope.username eq null }">
					<h2>로그인 후 가능한 서비스 입니다.</h2>
					</br>
				</c:if>
				<c:if test="${sessionScope.username ne null }">
					<h2>${sessionScope.username }님 환영합니다.</h2>
					</br>
					<button type="button" class="btn btn-danger" onClick="location.href='${pageContext.request.contextPath}/user/userSignOut.do'">로그아웃</button>
					<button type="button" class="btn btn-primary" onClick="location.href='${pageContext.request.contextPath}/boardWrite.do'">새 글 쓰기</button>
					</br>
					</br>
					<div class="input-group mb-3">
  						<input type="text" class="form-control" placeholder="키워드를 입력하시면 찾아드립니다." id="boardSearchKeyWord" name="boardSearchKeyWord" aria-label="boardSearch" aria-describedby="button-addon2">
  						<div class="input-group-append">
    					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="boardSearch()">Search</button>
  						</div>
					</div>
				</c:if>
				<table>
					<table class="table">
						<thead class="thead-light">
							<tr>
								<th>NO</th>
								<th>글제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="board" items="${boardlist}">
								<tr>
									<td>${board.board_no}</td>
									<td><a href="/board.do?boardno=${board.board_no}"/>${board.board_title}</td>
									<td>${board.board_writer}</td>
									<td>${board.board_hit}</td>
									<td>${board.board_date}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
						<nav aria-label="Page navigation example">
  							<ul class="pagination">
   								 <li class="page-item">
   								 	<c:if test="${param.page ne 1 }">
	    								 <a class="page-link" href="${pageContext.request.contextPath }/main.do?page=${param.page-1}" aria-label="Previous">
	     							 	<span aria-hidden="true">&laquo;</span>
	      								 </a>
   								 	</c:if>
    							 </li>
    							 <c:forEach begin="1" end="${totalPage }" var="value">
	    							 <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/main.do?page=${value}">${value }</a></li>						 
    							 </c:forEach>
    							 <li class="page-item">
    							 <c:if test="${param.page ne totalPage }">
     							 	<a class="page-link" href="${pageContext.request.contextPath }/main.do?page=${param.page+1}" aria-label="Next">
      							 	<span aria-hidden="true">&raquo;</span>
      							 	</a>
    							 </c:if>
    							</li>
  							</ul>
						 </nav>
					</div>
					<div class="col"></div>
				</div>
		<script>
			function boardSearch() {
				var searchKeyWord = $('#boardSearchKeyWord').val();
				var page = 1;
				location.href='/boardSearch.do?keyword=' + searchKeyWord + '&page=' + page;
			}
		</script>
</body>
</html>
</body>
</html>
