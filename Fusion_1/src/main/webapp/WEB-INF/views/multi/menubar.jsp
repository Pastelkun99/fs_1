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

<h4 style="margin-bottom: 3rem;"><a href="${pageContext.request.contextPath }/multi/boardMain.do">Board List</a></h4>
<c:forEach items="${menuList }" var="menuList">
	<c:if test="${menuList.menu_useyn eq 'N' }"> 
	
	</c:if>
	<c:if test="${menuList.menu_useyn eq 'Y' }">
	<h4 style="margin-top: 3rem;">${menuList.menu_name }</h4>
	<ul class="list-group">
	<c:forEach items="${boardList }" var="boardList">
		<c:if test="${menuList.menu_no eq boardList.menu_no }">
				<li class="list-group-item">
					<c:if test="${boardList.board_url ne null }">
						<a href="${pageContext.request.contextPath }${boardList.board_url}">${boardList.board_name}</a>
					</c:if>
					<c:if test="${boardList.board_url eq null }">
						<a href="${pageContext.request.contextPath }/multi/boardList.do?board_no=${boardList.board_no }&page_no=1&pageSize=10">${boardList.board_name}</a>
					</c:if>
				</li>
		</c:if>
	</c:forEach>
	</ul>
	</c:if>
</c:forEach>
