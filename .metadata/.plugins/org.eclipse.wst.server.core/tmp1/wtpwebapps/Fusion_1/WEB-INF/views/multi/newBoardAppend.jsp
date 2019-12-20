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
<title>게시판 등록</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>게시판 등록</strong></div>
		<input type="hidden" id="a_no" value="">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				게시판 이름 : <input type="text" class="form-control" name="board_name" id="board_name" maxlength="20">
			</li>
			<li class="list-group-item">
				게시판 타입 : 
				<select id="board_type" name="board_type" class="form-control">
					<option value="0">일반형</option>
					<option value="1">알림형</option> 
				</select>
			</li>
			<li class="list-group-item">
				답글 등록 여부 : 
				<select id="board_reboardyn" name="board_reboardyn" class="form-control">
					<option value="Y">가능</option>
					<option value="N">불가능</option> 
				</select>
			</li>
			<li class="list-group-item">
				댓글 등록 여부 :
				<select id="board_replyyn" name="board_replyyn" class="form-control">
					<option value="Y">가능</option>
					<option value="N">불가능</option> 
				</select> 
			</li>
			<li class="list-group-item">
				비밀글 등록 여부 : 
				<select id="board_secretyn" name="board_secretyn" class="form-control">
					<option value="Y">가능</option>
					<option value="N">불가능</option> 
				</select>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="boardAppend();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
function closeWindow() {
	self.close();
}

function boardAppend() {
	
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
	
	var board_name = $('#board_name').val();
	var board_type = $('#board_type').val();
	var board_reboardyn = $('#board_reboardyn').val();
	var board_replyyn = $('#board_replyyn').val();
	var board_secretyn= $('#board_secretyn').val();
	
	$.ajax({
		type : "post",
		url : "/mng/newBoardAppend.do",
		data : {"board_name" : board_name,
				"board_type" : board_type,
				"board_reboardyn" : board_reboardyn,
				"board_replyyn" : board_replyyn,
				"board_secretyn" : board_secretyn},
		dataType : "json",
		success : function(result) {
			alert('게시판 등록에 성공했습니다.');
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