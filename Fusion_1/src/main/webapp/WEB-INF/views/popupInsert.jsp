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
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>관리자 페이지</title>
</head>
<body>
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-md-10">
		<h1 style="text-align: center; margin-bottom: 30px;">팝업 관리</h1>
		<table class="table">
			<tr>
				<th class="table-success">팝업 제목</th>
				<td><input type="text" style="width:200px;" name="pop_title" id="pop_title" class="form-control"/></td>
				<th></th>
				<td></td>
			</tr>
			<tr>
				<th class="table-success">팝업 노출 기간</th>
				<td colspan="2">
					<input class="form-control" style="width:140px;" id="fromDatePicker" placeholder="날짜를 선택하세요!">
				</td>
				<td colspan="2">
					<input class="form-control" style="width:140px;" id="toDatePicker" placeholder="날짜를 선택하세요!">
				</td>
			</tr>
			<tr>
				<th class="table-success">팝업 높이</th>
				<td><input type="number" min="0" max="1080" style="width:100px;" name="pop_height" id="pop_height" class="form-control"/></td>
				<th class="table-success">팝업 넓이</th>
				<td><input type="number" min="0" max="1920" style="width:100px;" name="pop_width" id="pop_width" class="form-control"/></td>
			</tr>
			<tr>
				<th class="table-success">팝업 내용</th>
				<td colspan="3">
					<textarea class="form-control" name="pop_content" id="pop_content" rows="10" style="width:300px;"></textarea>
				</td>
			</tr>
			<tr>
				<th class="table-success">이미지 링크</th>
				<td colspan="3"><input type="text" style="width:400px;" name="pop_imageurl" id="pop_imageurl" class="form-control"/></td>
			</tr>
			<tr>
				<th class="table-success">연결 링크</th>
				<td colspan="3"><input type="text" style="width:400px;" name="pop_url" id="pop_url" class="form-control"/></td>
			</tr>
			<tr>
				<th class="table-success">표시 여부</th>
				<td colspan="3">
					<select id="pop_aval" name="pop_aval" class="form-control">
						<option value="1">보임</option>
						<option value="0">보이지않음</option> 
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div class="col-md-1"></div>
</div>
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
		<button type="button" class="btn btn-primary" style="width:150px;" onClick="popupInfoInsert();">등록</button>
	</div>
	<div class="col-md-3"></div>
</div>
</body>
<script>
$('#fromDatePicker').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});

$('#toDatePicker').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});

function closeWindow() {
	opener.location.reload();
	self.close();
}

function popupInfoInsert() {
	/* var pop_id = $('#pop_id').attr('no'); */
	var pop_title = $('#pop_title').val();
	var pop_fromdate = $('#fromDatePicker').val();
	var pop_todate = $('#toDatePicker').val();
	var pop_height = $('#pop_height').val();
	var pop_width = $('#pop_width').val();
	var pop_content = $('#pop_content').val();
	var pop_imageurl = $('#pop_imageurl').val();
	var pop_url = $('#pop_url').val();
	var pop_aval = $('#pop_aval').val();
	
	$.ajax({
		type : "post",
		url : "/mng/popupInsert.do",
		data : {
				"pop_title" : pop_title,
				"pop_fromdate" : pop_fromdate,
				"pop_todate" : pop_todate,
				"pop_height" : pop_height,
				"pop_width" : pop_width,
				"pop_content" : pop_content,
				"pop_imageurl" : pop_imageurl,
				"pop_url" : pop_url,
				"pop_aval" : pop_aval
				},
		dataType : "json",
		success : function(result) {
			alert('등록이 완료되었습니다.');
			opener.location.reload();
			self.close();
		},
		error : function(error) {
			alert('에러 발생');
		}
	});
}
</script>
</html>