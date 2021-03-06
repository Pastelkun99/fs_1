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
<title>메뉴 수정</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>메뉴 정보 수정</strong></div>
		<input type="hidden" id="a_no" value="">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				메뉴 이름 : <input type="text" class="form-control" name="menu_name" id="menu_name" value="${menuInfo.menu_name }" maxlength="20">
			</li>
			<li class="list-group-item">
				메뉴 사용 여부 : 
				<select id="menu_useyn" name="menu_useyn" class="form-control">
					<option value="Y" <c:if test="${menuInfo.menu_useyn eq 'Y' }"> selected </c:if>>활성화</option>
					<option value="N" <c:if test="${menuInfo.menu_useyn eq 'N' }"> selected </c:if>>비활성화 
				</select>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-success" style="width:150px;" onClick="menuUpdate();">수정</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
function closeWindow() {
	self.close();
}

function menuUpdate() {
	
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
	
	var menu_no = '${param.menu_no}';
	var menu_name = $('#menu_name').val();
	var menu_useyn = $('#menu_useyn').val();
	
	$.ajax({
		type : "post",
		url : "/mng/menuInfoUpdate.do",
		data : {"menu_no" : menu_no,
				"menu_name" : menu_name,
				"menu_useyn" : menu_useyn
		},
		dataType : "json",
		success : function(result) {
			alert('메뉴 정보 수정에 성공했습니다.');
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
