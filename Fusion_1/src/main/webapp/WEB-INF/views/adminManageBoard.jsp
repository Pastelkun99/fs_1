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
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>관리자 페이지</title>
<style>
.dragRow {
	background-color : #eee;
}
</style>
</head>
<body>
<script type="text/javascript">
	$(function() {
		var ordered_items;
		$('#boardTable').tableDnD({
			onDragClass : "dragRow",
	    });
	})
	
	function rowEffect() {
		
		$('.rowAttr').each(function(index) {
			var totalArr = {};
			$(this).find('td').each(function() {
				/* alert($(this).find('.form-control').attr('data-code'));
				alert($(this).find('.form-control').val()); */
				totalArr[$(this).find('.form-control').attr('data-code')] = $(this).find('.form-control').val();
			});
			totalArr['board_order'] = index;
			
			$.ajax({
				type : "post",
				url : "boardOrderCommit.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(totalArr),
				dataType : "json",
				success : function(result) {
					window.location.reload();
				},
				error : function(error) {
					alert('문제 발생' + error);
				}
			})
		})
		
	}
</script>
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
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=board">게시판 관리</a></li>
				<li class="nav-item"><button type="button" class="btn btn-danger" onClick="logoutLogic();">로그아웃</button></li>
			</ul>
		</div>
	</nav>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<h1 style="text-align: center; margin-bottom: 30px;">게시판 관리</h1>
			<table id="boardTable" class="table" style="width:100%;">
				<tr id="rowTemp">
					<th scope="col">No</th>
					<th scope="col">게시판 이름</th>
					<th scope="col">게시판 타입</th>
					<th scope="col">답글 사용 여부</th>
					<th scope="col">댓글 사용 여부</th>
					<th scope="col">비밀글 사용 여부</th>
					<th scope="col">MODE</th>
				</tr>
				<c:forEach items="${multiList }" var="multiList" varStatus="status">
					<tr id="rowTemp" class="rowAttr">
						<th scope="row">${status.index + 1 }</th>
						<td><input type="text" class="form-control" value="${multiList.board_name}" readonly="readonly" data-code="board_name"></td>
						<td>
							<select id="board_type${multiList.board_no}" name="board_type" class="form-control" data-code="board_type" disabled="disabled">
								<option value="0"<c:if test="${multiList.board_type eq 0 }"> selected </c:if>>일반형</option>
								<option value="1"<c:if test="${multiList.board_type eq 1 }"> selected </c:if>>알림형</option> 
							</select>
						</td>
						<td>
							<select id="board_reBoardAval${multiList.board_no}" name="board_reBoardAval" class="form-control" data-code="board_reBoardAval" disabled="disabled">
								<option value="Y"<c:if test="${multiList.board_reboardyn eq 'Y' }"> selected </c:if>>활성화</option>
								<option value="N"<c:if test="${multiList.board_reboardyn eq 'N' }"> selected </c:if>>비활성화</option> 
							</select>
						</td>
						<td>
							<select id="board_replyAval${multiList.board_no}" name="board_replyAval" class="form-control" data-code="board_replyAval" disabled="disabled">
								<option value="Y"<c:if test="${multiList.board_replyyn eq 'Y' }"> selected </c:if>>활성화</option>
								<option value="N"<c:if test="${multiList.board_replyyn eq 'N' }"> selected </c:if>>비활성화</option> 
							</select>
						</td>
						<td>
							<select id="board_secretAval${multiList.board_no}" name="board_secretAval" class="form-control" data-code="board_secretAval" disabled="disabled">
								<option value="Y"<c:if test="${multiList.board_secretyn eq 'Y' }"> selected </c:if>>활성화</option>
								<option value="N"<c:if test="${multiList.board_secretyn eq 'N' }"> selected </c:if>>비활성화</option> 
							</select>
						</td>
						<td>
							<input type="hidden" id="board_no" name="board_no" class="form-control" data-code="board_no" value="${multiList.board_no }"/>
							<button type="button" id="boardInfoUpdate(${multiList.board_no})" onclick="boardInfoUpdate(${multiList.board_no});" class="btn btn-warning">수정</button>
							<button type="button" id="boardInfoDelete(${multiList.board_no})" onclick="boardInfoDelete(${multiList.board_no});" class="btn btn-danger">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			<button type="button" id="newBoardAppend" onclick="newBoardAppend();" class="btn btn-success">등록</button>
			<button type="button" id="orderCommit" onclick="rowEffect();" class="btn btn-primary">순서 반영</button>
			<button type="button" id="goToBoardList" onclick="location.href='${pageContext.request.contextPath}/multi/boardList.do?board_no=-1&page_no=1&pageSize=10'" class="btn btn-Info">게시판으로</button>
		</div>
		<div class="col-md-3"></div>
	</div>
<script>
var url = '${pageContext.request.contextPath}';

function newBoardAppend() {
	window.open('/mng/newBoardAppend.do', '_blank', 'width=500px, height=700px');
}

function boardInfoUpdate(board_no) {
	window.open('/mng/boardInfoUpdate.do?board_no=' + board_no, '_blank', 'width=500px, height=700px');
}

function boardInfoDelete(board_no) {
	
	$.ajax({
		type : "post",
		url : "/mng/boardInfoDelete.do",
		data : {"board_no" : board_no},
		dataType : "json",
		success : function(result) {
			alert('삭제되었습니다.');
			window.location.reload();
		},
		error : function(error) {
			alert('문제가 발생했습니다.');
		}
	});
}

function logoutLogic() {
  var root = '${pageContext.request.contextPath}';
  location.href = root + '/user/userSignOut.do';
}
</script>
</body>
</html>