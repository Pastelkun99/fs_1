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
<title>특수 게시판 등록</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>통계 페이지 등록</strong></div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				등록할 이름 :
				<input type="text" name="board_name" id="board_name" class="form-control" maxlength="50">
			</li>
			<li class="list-group-item">
				어디에 등록하시겠어요?
				<select id="menu_no" name="menu_no" class="form-control">
					<c:forEach items="${menuList }" var="menuList">
						<option value="${menuList.menu_no }">${menuList.menu_name }</option>
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="chartBoardAppend();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function () {
	if($('#menu_no option').length == 0) {
		alert('생성된 메뉴가 없습니다.');
		self.close();
	}
});

function closeWindow() {
	self.close();
}

function chartBoardAppend() {
	var menu_no = $('#menu_no').val();
	var board_name = $('#board_name').val();
	var board_type = 0;
	var board_reboardyn = 'N';
	var board_replyyn = 'N';
	var board_secretyn = 'N';
	var board_order = 0;
	var board_maintanence = 1;
	var board_url = '/Chart.do?fromDate=&toDate=';
	
	$.ajax({
		type : "post",
		url : "/mng/newBoardAppend.do",
		data : {
			"menu_no" : menu_no,			
			"board_name" : board_name,
			"board_type" : board_type,
			"board_reboardyn" : board_reboardyn,
			"board_replyyn" : board_replyyn,
			"board_secretyn" : board_secretyn,
			"board_order" : board_order,
			"board_maintanence" : board_maintanence,
			"board_url" : board_url
		},
		dataType : "json",
		success : function(result) {
			alert('등록되었습니다.');
			self.close();
			opener.location.reload();
		},
		error : function(error) {
			alert('문제가 발생했습니다.');
		}
	})
}
</script>
</html>
