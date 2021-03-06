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
<title>문항 수정</title>
</head>
<body>
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-md-10">
		<h1 style="text-align: center; margin-bottom: 30px;">문항 관리</h1>
		<table class="table">
			<tr>
				<th class="table-success">문항 내용</th>
				<td><input type="text" style="width:200px;" name="q_svalue" id="q_svalue" class="form-control"/ value="${svalue.q_svalue }"></td>
			</tr>
		</table>
	</div>
	<div class="col-md-1"></div>
</div>
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6" style="text-align: center;">
		<button type="button" class="btn btn-danger" style="width:150px;" onClick="self.close();">취소</button>
		<button type="button" class="btn btn-primary" style="width:150px;" onClick="selectionUpdate(${svalue.select_no});">수정</button>
	</div>
	<div class="col-md-3"></div>
</div>
</body>
<script type="text/javascript">
	function selectionUpdate(select_no) {
		
		var q_selection = '${param.q_selection}';
		var url = '${pageContext.request.contextPath}';
		var q_svalue = $('#q_svalue').val();
		
		if(q_svalue.length == 0) {
			alert('내용은 반드시 입력해야 합니다.');
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"/mng/selectionUpdate.do",
			data : {
				"select_no" : select_no,
				"q_selection" : q_selection,
				"q_svalue" : q_svalue
			},
			dataType:"json",
			success : function(result) {
				alert('수정이 완료되었습니다.');
				self.close();
				opener.location.reload();
			},
			error : function(error) {
				alert('에러');
			}
		})
	}
</script>
</html>