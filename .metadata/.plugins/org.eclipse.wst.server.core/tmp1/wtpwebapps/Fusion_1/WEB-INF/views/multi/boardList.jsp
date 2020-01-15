<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="true"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"	crossorigin="anonymous"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"	crossorigin="anonymous"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"	crossorigin="anonymous"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<html>
<head>
<link rel="shortcut icon" href="#">
<title>WebBoard - 게시판입니다.</title>
<style type="text/css">
#pop {
	width: 400px;
	height: 600px;
	background: #3d3d3d;
	color: #fff;
	position: absolute;
	top: 120px;
	left: 120px;
	text-align: center;
	border: 2px solid #000;
}

.close div {
	float: left;
	text-align: right;
}

#check {
	font-size: 16px;
	font-family: '돋움';
	padding-left: 70px;
}

#close {
	font-size: 16px;
	padding: 5px;
	font-weight: bold;
}
</style>
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
					<c:if test="${param.board_no ne -1 }">
						<button type="button" class="btn btn-primary" onClick="javascript:void(window.open('articleWrite.do?board_no=${param.board_no}', '_blank', 'height=900px, width=1200px, scrollbars=1')); return false;">
						새 글 쓰기
						</button>
					</c:if>
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-dark" data-toggle="modal" id="myModal" data-target="#exampleModalLong">공지사항 보기</button>
					<c:if test="${sessionScope.isAdmin eq 1 }">
						<button type="button" class="btn btn-outline-secondary" onClick="location.href='${pageContext.request.contextPath}/mng/adminCheck.do'">관리자 페이지</button>
					</c:if>
					<button type="button" class="btn btn-dark" onClick="goToIndividualPage();">유저 개인 페이지</button>
					<br>
					<br>
					
					<form name="pagefrm" method="get">
						<input type="hidden" name="page_no" value="1" /> 
						<select name="pageSize" class="form-control" title="페이징 갯수" onchange="select_page();" style="width:10rem;">
							<option value="10" <c:if test="${page.pageSize eq '10'}">selected="selected"</c:if>>10개</option>
							<option value="20" <c:if test="${page.pageSize eq '20'}">selected="selected"</c:if>>20개</option>
							<option value="50" <c:if test="${page.pageSize eq '50'}">selected="selected"</c:if>>50개</option>
						</select>
					</form>
						
					<form name="pageSearchfrm" method="get">
						<input type="hidden" name="board_no" id="board_no" value="${param.board_no }">
						<input type="hidden" name="page_no" id="page_no" value="1" /> 
						<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" />
						<!-- <input type="hidden" id="keyword" name="keyword" value=""/> -->
							<div class="input-group mb-1">
							<div class="col-md-2" style="padding-left: 0; padding-right:0">
							<select name="searchCon" id="searchCon" class="form-control" title="검색조건 선택">
								<option value="1" <c:if test="${page.searchCon == '1'}">selected="selected"</c:if>>제목</option>
								<option value="2" <c:if test="${page.searchCon == '2'}">selected="selected"</c:if>>내용</option>
								<option value="3" <c:if test="${page.searchCon == '3'}">selected="selected"</c:if>>작성자</option>
								<option value="4" <c:if test="${page.searchCon == '4'}">selected="selected"</c:if>>전체</option>
							</select>
							</div>
							<div class="col-md-10 input-group" style="padding-left: 0; padding-right:0">
							<input type="text" 
								   class="form-control"
								   placeholder="키워드를 입력하시면 찾아드립니다." 
								   id="keyword" 
								   name="keyword"
								   aria-label="boardSearch" aria-describedby="button-addon2"
								   value="${page.keyword }">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2" onclick="search_board()">Search</button>
							</div>
							</div>
						</div>
					</form>
						<c:if test="${boardConfig.board_type eq 1 }">
							<div class="alert alert-info" role="alert">
 								 <strong>알림형 게시판</strong>에 접속하셨습니다.<br> 읽지 않은 게시글은 총 <strong>${nonReadCount }</strong>개, 이 게시판에서 읽지 않은 글은 <strong>${nonReadCountThisBoard }</strong>개 입니다.
							</div>
						</c:if>
				<table class="table">
					<thead class="thead-light">
						<tr>
							<th>순번</th>
							<th>글제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="noticeBoard" items="${noticeList }">
							<tr>
								<td><strong>공지</strong></td>
								<td>
								<c:if test="${noticeBoard.reply_cnt ne 0 }">
								&nbsp;[${noticeBoard.reply_cnt }]
								</c:if>
								<strong><a href="#"	onclick="javascript:void(window.open('board.do?board_no=${param.board_no}&article_no=${noticeBoard.article_no}', '_blank', 'width=1000px, height=600px')); return false;">${noticeBoard.article_title}</a></strong>
								</td>
								<td>${noticeBoard.article_writer}</td>
								<td>${noticeBoard.article_hit}</td>
								<td>${noticeBoard.article_date}</td>
							<tr>
						</c:forEach>
							<c:forEach var="article" items="${articleList}" varStatus="status">
								<c:if test="${article.article_deleteyn eq 'Y' }">
								<tr>
									<td>${page.totalCount - (param.page_no-1)*param.pageSize - status.index}</td>								
									<td colspan="2">삭제된 게시물입니다.</td>
									<td></td>
									<td></td>
								<tr>
								</c:if>
								<c:if test="${article.article_deleteyn eq 'N' }">
									<tr>
										<td><strong>${page.totalCount - (param.page_no-1)*param.pageSize - status.index}</strong></td>								
										<td>
											<strong>
											<c:forEach var="i" begin="0" end="${article.article_groupdepth }" >
												&nbsp;
											</c:forEach>
											<a href="#"	onclick="javascript:void(window.open('board.do?board_no=${param.board_no}&article_no=${article.article_no}', '_blank', 'width=1000px, height=600px')); return false;">${article.article_title}</a></strong>
											<c:if test="${article.reply_cnt ne 0 }" >
												&nbsp;[${article.reply_cnt }]
											</c:if>
											<c:if test="${fn:indexOf(article.article_content, 'img') ne -1}">
												&nbsp;<i class="far fa-image"></i>
											</c:if>
											<c:if test="${article.article_secretyn eq 'Y' }">
												&nbsp;<i class="fas fa-lock"></i>
											</c:if>
										</td>
										<td>${article.article_writer}</td>
										<td>${article.article_hit}</td>
										<td>${article.article_date}</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
					
					<nav aria-label="Page navigation example" style="align: center;">
						<ul class="pagination">
							<li class="page-item">
								<!-- 왼쪽 -->
								<c:if test="${param.page_no ne 1 }">
  									<a class="page-link" href="${pageContext.request.contextPath }/multi/boardList.do?board_no=${param.board_no }&page_no=${param.page_no-1}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }" aria-label="Previous">
   									<span aria-hidden="true">&laquo;</span>
    								</a>
								</c:if>
 							</li>
 							<!-- 네비게이션 -->
 							<c:forEach begin="1" end="${page.endPage }" var="value">
  								<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/multi/boardList.do?board_no=${param.board_no }&page_no=${value}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }">${value }</a></li>						 
 							</c:forEach>
 							<li class="page-item">
 							<!-- 오른쪽 -->
 							<c:if test="${param.page_no ne page.endPage && page.endPage ne 0 }">
  								<a class="page-link" href="${pageContext.request.contextPath }/multi/boardList.do?board_no=${param.board_no}&page_no=${param.page_no+1}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }" aria-label="Next">
   								<span aria-hidden="true">&raquo;</span>
   								</a>
 							</c:if>
 							</li>
						</ul>
					</nav>
				</c:if>
				<div class="rows" style="text-align: center; margin-top: 5rem;"></div>
			</div>
		</div>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModalLong" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<c:if test="${notice.board_title eq null }">
						<h5 class="modal-title" id="exampleModalLongTitle">현재 등록된 공지가 없습니다.</h5>
					</c:if>
					<c:if test="${notice.board_title ne null }">
						<h5 class="modal-title" id="exampleModalLongTitle">${notice.board_title}</h5>
					</c:if>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<c:if test="${notice.board_content eq null }">
					<div class="modal-body"></div>										
				</c:if>
				<c:if test="${notice.board_content ne null }">
					<div class="modal-body">${notice.board_content }</div>
				</c:if>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" id="noticeClose"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-danger" onclick="closeNotice();">오늘 하루 동안 보지 않기</button>
				</div>
			</div>
		</div>
	</div>
<script>

	function goToIndividualPage() {
		var root = '${pageContext.request.contextPath}';
		window.open(root + '/multi/individualInfo.do', '_blank', 'width=700px, height=850px');
	}
	
	function logoutLogic() {
		var root = '${pageContext.request.contextPath}';
		location.href = '/user/userSignOut.do';
	}

	function select_page() {
		var root = '${pageContext.request.contextPath}';
		var board_no = "${param.board_no}";
		var pageSize = document.pagefrm.pageSize.value;
		var searchCon = document.getElementById('searchCon').value;
		var keyword = document.getElementById('keyword').value;
		location.href = root + '/multi/boardList.do?board_no=' + board_no + '&page_no=1&pageSize=' + pageSize + '&searchCon=' + searchCon + '&keyword=' + keyword;
	}

	function search_board() {
		var page_no = document.getElementById('page_no').value;
		var pageSize = document.getElementById('pageSize').value;
		var searchCon = document.getElementById('searchCon').value;
		var keyword = document.getElementById('keyword').value;
		document.pageSearchfrm.action = "<c:url value='/multi/boardList.do'/>";
		document.pageSearchfrm.submit();
	}

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
					/* alert('데이터 전송 성공'); */
				},
				error : function(error) {
					/* alert(error); */
				}
			});
	}
</script>
</body>
</html>