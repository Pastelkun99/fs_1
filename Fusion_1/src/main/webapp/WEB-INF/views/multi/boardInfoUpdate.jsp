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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>설문 등록</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>게시판 수정</strong></div>
		<input type="hidden" id="a_no" value="">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				게시판 이름 : <input type="text" class="form-control" name="board_name" id="board_name" value="${board.board_name }">
			</li>
			<li class="list-group-item">
				게시판 타입 : 
				<select id="board_type" name="board_type" class="form-control">
					<option value="0" <c:if test="${board.board_type eq 0 }"> selected </c:if>>일반형</option>
					<option value="1" <c:if test="${board.board_type eq 1 }"> selected </c:if>>알림형</option> 
				</select>
			</li>
			<li class="list-group-item">
				답글 등록 여부 : 
				<select id="board_reboardyn" name="board_reboardyn" class="form-control">
					<option value="Y" <c:if test="${board.board_reboardyn eq 'Y' }"> selected </c:if>>가능</option>
					<option value="N" <c:if test="${board.board_reboardyn eq 'N' }"> selected </c:if>>불가능</option> 
				</select>
			</li>
			<li class="list-group-item">
				댓글 등록 여부 :
				<select id="board_replyyn" name="board_replyyn" class="form-control">
					<option value="Y" <c:if test="${board.board_replyyn eq 'Y' }"> selected </c:if>>가능</option>
					<option value="N" <c:if test="${board.board_replyyn eq 'N' }"> selected </c:if>>불가능</option> 
				</select> 
			</li>
			<li class="list-group-item">
				비밀글 등록 여부 : 
				<select id="board_secretyn" name="board_secretyn" class="form-control">
					<option value="Y"<c:if test="${board.board_secretyn eq 'Y' }"> selected </c:if>>가능</option>
					<option value="N"<c:if test="${board.board_secretyn eq 'N' }"> selected </c:if>>불가능</option> 
				</select>
			</li>
			<li class="list-group-item">
				속한 메뉴 : 
				<select id="menu_no" name="menu_no" class="form-control">
					<c:forEach items="${menuList }" var="menuList">
						<option value="${menuList.menu_no }"<c:if test="${menuList.menu_no eq board.menu_no }"> selected </c:if>>${menuList.menu_name }</option>
					</c:forEach> 
				</select>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-success" style="width:150px;" onClick="boardUpdate();">수정</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
function closeWindow() {
	self.close();
}

function boardUpdate() {
	
	var falseCount = 0;
	
	$('.form-control').each(function() {
		if($(this).val().length == 0) {
			falseCount = 1;
		}
	})
	
	if(falseCount == 1) {
		alert('입력되지 않은 항목이 하나 이상 존재합니다.');
		return false;
	}
	
	var board_no = "${param.board_no}";
	var board_name = $('#board_name').val();
	var board_type = $('#board_type').val();
	var board_reboardyn = $('#board_reboardyn').val();
	var board_replyyn = $('#board_replyyn').val();
	var board_secretyn= $('#board_secretyn').val();
	var menu_no = $('#menu_no').val();
	
	$.ajax({
		type : "post",
		url : "/mng/boardInfoUpdate.do",
		data : {"board_no" : board_no,
				"board_name" : board_name,
				"board_type" : board_type,
				"board_reboardyn" : board_reboardyn,
				"board_replyyn" : board_replyyn,
				"board_secretyn" : board_secretyn,
				"menu_no" : menu_no},
		dataType : "json",
		success : function(result) {
			alert('게시판 정보 수정에 성공했습니다.');
			opener.location.reload();
			self.close();
		},
		error : function(error) {
			alert('문제가 발생했습니다.');
		}
	});
}
</script>
</html>
