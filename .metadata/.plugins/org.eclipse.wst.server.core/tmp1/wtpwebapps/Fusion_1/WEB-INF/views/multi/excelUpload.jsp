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
<title>엑셀을 통한 대량 업로드</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>엑셀 업로드</strong></div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				이 곳에 파일을 업로드하세요.</br>
				<strong>경고</strong> : 엑셀 파일에 올바른 값이 입력되지 않은 경우 진행되지 않을 수 있습니다.</br>
				아이디와 비밀번호는 반드시 영문, 숫자를 혼합한 4자 이상, 16자 이하로 설정해 주십시오.</br></br>
				<form action="${pageContext.request.contextPath }/mng/excelUpload.do" method="post" id="fileUploadForm" enctype="multipart/form-data" accept=".xlsx">
					<input type="file" name="excelFile" id="excelFile">
				</form>
			</li>
			<li class="list-group-item">
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="fileUpload();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function () {

});

function closeWindow() {
	self.close();
}


function fileUpload() {
	
	var fileCheck = $('#excelFile').val();
	alert(fileCheck);
	var fileName = $('#excelFile').prop("files")[0]['name'];
	alert(fileName);
	
	if(!fileCheck) {
		alert('파일이 첨부되지 않았습니다.');
		return false;
	}
	
	/* if(fileName.indexOf('xlsx') == -1) {
		alert('업로드한 파일은 엑셀 파일이 아닙니다.');
		return false;
	} */
	
	var form = $('#fileUploadForm')[0];
	var data = new FormData(form);
	
	$.ajax({
		type : "POST",
		enctype : "multipart/form-data",
		url : "/mng/excelUpload.do",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data : data,
		processData: false,
		contentType: false,
		cache : false,
		timeout : 600000,
		success : function(data) {
			alert(data);
			opener.location.reload();
			self.close();
		},
		error : function(error) {
			console.log("ERROR : " + error);
			alert('파일 형식에 문제가 있거나, 통신에 실패했습니다.');
			opener.location.reload();
			self.close();
		}
	})
}
</script>
</html>
