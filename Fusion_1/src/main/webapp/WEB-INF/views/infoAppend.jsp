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
		<div class="card-header"><strong>설문 등록</strong></div>
		<input type="hidden" id="a_no" value="${count + 1}">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				설문 이름 : <input type="text" class="form-control" name="a_name" id="a_name">
			</li>
			<li class="list-group-item">
				주최자 : <input type="text" class="form-control" name="a_collector" id="a_collector">
			</li>
			<li class="list-group-item">
				대상자 : <input type="text" class="form-control" name="a_submitter" id="a_submitter">
			</li>
			<li class="list-group-item">
				시작 날짜 : <input class="form-control" id="a_fromdate" name="a_fromdate" placeholder="날짜를 선택하세요!" readonly="readonly">
			</li>
			<li class="list-group-item">
				마감 날짜 : <input class="form-control" id="a_todate" name="a_todate" placeholder="날짜를 선택하세요!" readonly="readonly">
			</li>
			<li class="list-group-item">
				당첨일 발표 : <input class="form-control" id="a_deploydate" name="a_deploydate" placeholder="날짜를 선택하세요!" readonly="readonly">
			</li>
			<li class="list-group-item" style="text-align: right;">
				활성화 여부 : 
				<select name="a_aval" id="a_aval">
					<option value="1">활성화</option>
					<option value="0">비활성화</option> 
				</select>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="infoAppend();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
$('#a_fromdate').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});

$('#a_todate').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});

$('#a_deploydate').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});

	function closeWindow() {
		self.close();
	}
	
	function infoAppend() {
		
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
		
		var a_no = $('#a_no').val();
		var a_name = $('#a_name').val();
		var a_collector = $('#a_collector').val();
		var a_submitter = $('#a_submitter').val();
		var a_fromdate = $('#a_fromdate').val();
		var a_todate = $('#a_todate').val();
		var a_deploydate = $('#a_deploydate').val();
		var a_aval = $('#a_aval').val();
		
		$.ajax({
			type : "post",
			url : "/mng/infoAppend.do",
			data : {"a_no" : a_no,
					"a_name" : a_name,
					"a_collector" : a_collector,
					"a_submitter" : a_submitter,
					"a_fromdate" : a_fromdate,
					"a_todate" : a_todate,
					"a_deploydate" : a_deploydate,
					"a_aval" : a_aval},
			dataType : "json",
			success : function(result) {
				alert('등록 성공');
				opener.location.reload();
				self.close();
			},
			error : function(error) {
				alert('등록 실패');
			}
		});
	}
</script>
</html>
