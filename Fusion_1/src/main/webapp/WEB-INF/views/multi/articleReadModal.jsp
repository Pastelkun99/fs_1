<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true" pageEncoding="UTF-8"%>

	<div class="row">
		<div class="col-xs-2 col-md-2"></div>
		<div class="col-xs-8 col-md-8">
			<h2 class="text-center">게시글 보기</h2>
			<p>&nbsp;</p>
			<div class="table table-responsive">
				<table class="table">
					<tr>
						<th class="table-success">글번호</th>
						<td>${article.article_no }</td>
						<th class="table-success">조회수</th>
						<td>${article.article_hit }</td>
					</tr>
					<tr>
						<th class="table-success">작성자</th>
						<td>${article.article_writer }</td>
						<th class="table-success">작성일</th>
						<td>${article.article_date }</td>
					</tr>
					<tr>
						<th class="table-success">제목</th>
						<td colspan="3">${article.article_title }</td>
					</tr>
					<tr>
						<th class="table-success">글 내용</th>
						<td colspan="3">${article.article_content }</td>
					</tr>
					<tr>
					</tr>
				</table>
			<!-- 현재 보고 있는 글의 article_no -->
			<input type="hidden" id="article_no" value="${article.article_no }"/>
			<!-- 현재 보고 있는 글을 쓴 사람의 id -->
			<input type="hidden" id="article_userid" value="${article.article_userid }"/>
			<!-- 현재 로그인 된 사람의 이름 -->
			<input type="hidden" id="current_user" value="${sessionScope.username }"/>
			<!-- 현재 로그인 된 사람의 아이디 -->
			<input type="hidden" id="current_userid" value="${sessionScope.userid }"/>
			</div>
			<div>
			<hr>
  			</div> 
			</div>
		</div>