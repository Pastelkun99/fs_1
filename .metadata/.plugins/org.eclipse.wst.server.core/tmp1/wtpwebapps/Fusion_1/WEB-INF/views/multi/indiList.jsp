<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>


<ul class="list-group list-group-flush">
  <li class="list-group-item">
  	글 쓴 횟수 : <strong>${traceInfo.writeCount }</strong><br>
  	글 수정 횟수 : <strong>${traceInfo.editCount }</strong><br>
  	글 삭제 횟수 : <strong>${traceInfo.deleteCount}</strong><br>
  	댓글 작성 횟수 : <strong>${traceInfo.replyCount}</strong><br>
  	로그인 횟수 : <strong>${traceInfo.signoutCount }</strong>
	</li>
<c:if test="${fn:length(indiList) lt 1}">
	<li class="list-group-item">
		작성한 글이 없습니다.
	</li>			  	
</c:if>
<c:if test="${fn:length(indiList) gt 0 }">
 	<c:forEach items="${indiList }" var="indiList">
		<li class="list-group-item">
  			<strong><a href="#" onclick="goToArticle(${indiList.board_no}, ${indiList.article_no })" data-toggle="modal" data-target="#exampleModal">${indiList.menu_name } - ${indiList.article_title }</a></strong>
		  		<br>
		  		<br>
  			<p>${indiList.article_content }...</p> 
 		</li>
 	</c:forEach>
</c:if>
</ul>
