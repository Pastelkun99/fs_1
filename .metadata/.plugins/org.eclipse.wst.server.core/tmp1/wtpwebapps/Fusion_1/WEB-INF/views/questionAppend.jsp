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
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>문제 정보 ${count }</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>문제 등록</strong></div>
		<input type="hidden" id="a_no" value="${param.a_no }">
		<input type="hidden" id="q_no" value="${count + 1 }">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				문제 구분 : <input type="text" class="form-control" name="q_subject" id="q_subject">
			</li>
			<li class="list-group-item">
				문제 내용 : <input type="text" class="form-control" name="q_value" id="q_value">
			</li>
			<li class="list-group-item">
				문제 형식 : 
				<select id="q_type" class="form-control">
					<option value="001">객관식</option>
					<option value="002">주관식</option>
				</select>
			</li>
			<li class="list-group-item">
				매칭할 문항 : 
				<select id="q_selection" class="form-control">
					<c:forEach items="${selectionList }" var="select">
						<option value="${select.q_selection }">${select.q_selection }</option>					
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				보여줄 페이지 : <input type="number" min="1" max="10" class="form-control" name="q_page" id="q_page">
			</li>
			<li class="list-group-item">
				부모 문항 번호 : (부모 문항이 없다면 ${count }을(를) 입력하세요)
				 <input type="number" min="1" max="10" class="form-control" name="q_parentno" id="q_parentno" >
			</li>
			<li class="list-group-item" style="text-align: right;">
				<button class="btn btn-danger" onclick="self.close();">취소</button>
				<button class="btn btn-primary" onclick="appendQuestion();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">
	function appendQuestion() {

		var a_no = $('#a_no').val();
		var q_subject = $('#q_subject').val();
		var q_value = $('#q_value').val();
		var q_type = $('#q_type').val();
		var q_selection = $('#q_selection').val();
		var q_page = $('#q_page').val();
		var q_parentno = $('#q_parentno').val();
		
		if(q_value.length == 0) {
			alert('문제 내용은 반드시 입력해야 합니다.');
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"/mng/questionAppend.do",
			data:{
			      "a_no" : a_no,
			      "q_subject" : q_subject,
			      "q_value" : q_value,
			      "q_type" : q_type,
			      "q_selection" : q_selection,
			      "q_page" : q_page,
			      "q_parentno" : q_parentno
			      },
			dataType:"json",
			success : function(result) {
				alert('등록했습니다.');
				opener.location.reload();
				self.close();
			},
			error : function(error) {
				alert('실패');
			}
		});
	}

	$(function () {
		$('#q_type').change(function() {
			var url = '${pageContext.request.contextPath}';
			var value = this.value;
			if(value == '002') {
				$('#q_selection').prop('disabled', true);
				$('#q_selection').val('5000');
			} else {
				$('#q_selection').prop('disabled', false);
			}
		})
	})
</script>
</html>
