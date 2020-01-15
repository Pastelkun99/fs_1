<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="true"%>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<html>
<head>
<link rel="shortcut icon" href="#">
<title>WebBoard - 게시판입니다.</title>
</head>
<body>
<div class="row" style="margin-bottom: 3rem;"></div>
		<div class="row" style="margin-left: 3rem; margin-right: 25rem;">
			<div class="col-3" style="text-align: left; margin-top:10rem;">
				<jsp:include page="menubar.jsp"></jsp:include>
			</div>
			<div class="col-9">
				<input type="hidden" id="popup" name="popup" onclick="windowPopup();">
				<c:if test="${sessionScope.username eq null }">
					<h2>로그인 후 가능한 서비스 입니다.</h2>
				</c:if>
				<c:if test="${sessionScope.username ne null }">
					<h2>${sessionScope.username }님 환영합니다.</h2>
					<button type="button" class="btn btn-danger" onClick="logoutLogic();">로그아웃</button>
					<button type="button" class="btn btn-dark" onClick="goToIndividualPage();">유저 개인 페이지</button>
					<c:if test="${sessionScope.isAdmin eq 1 }">
						<button type="button" class="btn btn-outline-secondary" onClick="location.href='${pageContext.request.contextPath}/mng/adminCheck.do'">관리자 페이지</button>
					</c:if>
				</c:if>
				<button type="button" id="layerPopup" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable"></button>
				
				<div class="rows" style="text-align: center; margin-top: 5rem;">
					<img alt="배너 이미지" src="https://www.popco.net/zboard/data/dica_forum_sony/2016/07/14/304773363578773ce7120f.jpg" width="100%" height="200" style="margin-bottom: 2rem;">
					<c:if test="${param.board_no eq -1 || param.board_no eq null }">
						<h3>당신이 놓친 글들</h3>
						<table class="table table-hover">
						<caption>당신이 놓친 글이 ${nonReadCount }개 있습니다.</caption>
						  <thead>
						    <tr>
						      <th scope="col">게시판 이름</th>
						      <th scope="col">글 제목</th>
						      <th scope="col">날짜</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${nonReadList }" var="nonReadList">
						    <tr>
						      <td>${nonReadList.board_name }</td>
						      <td>
						      	<c:if test="${nonReadList.article_secretyn eq 'Y' }">
						      		&nbsp;<i class="fas fa-lock"></i>
						      	</c:if>
						      	<a href="#" onclick="javascript:void(window.open('board.do?board_no=${nonReadList.board_no}&article_no=${nonReadList.article_no}', '${nonReadList.article_title }', '_blank')); return false;">${nonReadList.article_title }</a>
						      	<c:if test="${nonReadList.reply_cnt ne 0 }">
						      	&nbsp;[${nonReadList.reply_cnt }]
						      	</c:if>
						      	<c:if test="${fn:indexOf(nonReadList.article_content, 'img') ne -1}">
								&nbsp;<i class="far fa-image"></i>
								</c:if>
						      </td>
						      <td>${nonReadList.article_date }</td>
						    </tr>
						  </c:forEach>
						  </tbody>
						</table>					
					</c:if>
				</div>
			</div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalScrollableTitle">Welcome!</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body" style="text-align:center;">
		        	게시판에 온 것을 환영합니다.
		        	<a href="https://www.fusionsoft.co.kr" target="_blank"><img src="http://img.danawa.com/prod_img/500000/114/707/img/4707114_1.jpg?shrink=500:500&_v=20181122111334" width="400px" height="400px"></a>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeNotice();">오늘 하루동안 보지 않기</button>
		      </div>
		    </div>
		  </div>
		</div>
	
<script>
	$(document).ready(function() {
		
		$('#layerPopup').hide();
		
		var currentUserId = '${sessionScope.userid}';
		var result = getCookie(currentUserId + "popup");
		var resultWindow = getCookie(currentUserId + "window");
		
		if (resultWindow == currentUserId) {
			return false;
		}

		if (result == currentUserId) {
			return false;
		} else {
			$('#layerPopup').click();
		}
	});
	
	window.onload = function() {
		var log_userid = '${sessionScope.userid}';
		var log_userreferrer = document.referrer;
		$.ajax({
				type : "POST",
				url : "/log.do",
				data : {
					"log_userid" : log_userid,
					"log_userreferrer" : log_userreferrer
				},
				dataType : "json",
				success : function(result) {
				},
				error : function(error) {
				}
			});
	}
	
	function goToIndividualPage() {
		var root = '${pageContext.request.contextPath}';
		window.open(root + '/multi/individualInfo.do', '_blank', 'width=700px, height=850px');
	}

	function setCookie(cname, value, expire) {
		var todayValue = new Date();
		todayValue.setDate(todayValue.getDate()	+ expire);
		document.cookie = cname + "=" + encodeURI(value) + "; expires="	+ todayValue.toGMTString() + "; path=/;";
	}

	function getCookie(name) {
		var cookieName = name + "=";
		var x = 0;
		while (x <= document.cookie.length) {
			var y = (x + cookieName.length);
			if (document.cookie.substring(x, y) == cookieName) {
				if ((lastChrCookie = document.cookie.indexOf(";", y)) == -1)
					lastChrCookie = document.cookie.length;
				return decodeURI(document.cookie.substring(y, lastChrCookie));
			}
			x = document.cookie.indexOf(" ", x) + 1;
			if (x == 0)
				break;
		}
		return "";
	}

	function closeNotice() {
		var currentUserId = '${sessionScope.userid}';
		setCookie(currentUserId + 'popup', currentUserId, 1);
		document.getElementById('noticeClose').click();
	}

	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(	hostIndex, location.href.indexOf('/', hostIndex + 1));
	}

	function logoutLogic() {
		var root = getContextPath();
		location.href = '/user/userSignOut.do';
	}
</script>
</body>
</html>