<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light" style="margin-bottom: 100px;">
		<a class="navbar-brand">관리자 페이지</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=user">유저 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=analysis&a_no=1&q_selection=1111">설문 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=popup&pop_id=1">팝업 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=board&menu_no=1">게시판 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=menu">메뉴 관리</a></li>
				<li class="nav-item"><button type="button" class="btn btn-danger" onClick="logoutLogic();">로그아웃</button></li>
			</ul>
		</div>
	</nav>