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
		<div class="card-header"><strong>문항 등록</strong></div>
		<input type="hidden" id="q_order" value="${count + 1 }">
		<input type="hidden" id="q_type" value="${q_type}">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				문항 이름 : <input type="text" class="form-control" name="q_svalue" id="q_svalue">
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="selectionAppend();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
function closeWindow() {
	self.close();
	opener.location.reload();
}

function selectionAppend() {
	var q_selection = '${param.q_selection}';
	var q_type = $('#q_type').val();
	var q_svalue = $('#q_svalue').val();
	var q_order = $('#q_order').val();
	
	$.ajax({
		type : "post",
		url : "/mng/selectionAppend.do",
		data : {
			"q_type" : q_type,
			"q_selection" : q_selection,
			"q_svalue" : q_svalue,
			"q_order" : q_order
		},
		dataType : "json",
		success : function(result) {
			alert('등록 성공');
			opener.location.reload();
			self.close();
		},
		error : function(error) {
			alert('실패');
		}
	})
}
</script>
</html>
