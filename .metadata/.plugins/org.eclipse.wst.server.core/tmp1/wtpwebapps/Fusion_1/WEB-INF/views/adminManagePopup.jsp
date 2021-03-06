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

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>관리자 페이지</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#popupTable').DataTable();
	} );
</script>
	<jsp:include page="adminNavbar.jsp"></jsp:include>
	<div class="row">
		<div class="col-md-3">
		</div>
		<div class="col-md-6">
				<table id="popupTable" class="display" style="width:100%; margin-left:20px;">
						<thead class="thead-dark">
							<tr>
								<th scope="col">No</th>
								<th scope="col">제목</th>
								<th scope="col">유효기간</th>
								<th scope="col">보임 여부</th>
								<th scope="col">Mode</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="pop" items="${popList }" varStatus="status">
								<tr>
									<th scope="row">${status.index + 1 }</th>
									<td><a href="${pageContext.request.contextPath }/mng/adminManagement.do?mode=popup&pop_id=${pop.pop_id}"><strong>${pop.pop_title }</strong></a></td>
									<td>${pop.pop_fromdate } ~ ${pop.pop_todate }</td>
									<td>${pop.pop_aval }</td>
									<td>
										<button type="button" class="btn btn-danger" style="width:100px;" onClick="popupDelete(${pop.pop_id});">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
				</table>
			<h1 style="text-align: center; margin-bottom: 30px;">팝업 관리</h1>
			<input type="hidden" id="pop_id" value="${popupInfo.pop_id}">
			<input type="hidden" id="pop_title" value="${popupInfo.pop_title}">
			<input type="hidden" id="pop_fromdate" value="${popupInfo.pop_fromdate }">
			<input type="hidden" id="pop_todate" value="${popupInfo.pop_todate }">
			<input type="hidden" id="pop_height" value="${popupInfo.pop_height }">
			<input type="hidden" id="pop_width" value="${popupInfo.pop_width }">
			<input type="hidden" id="pop_content" value="${popupInfo.pop_content }">
			<input type="hidden" id="pop_imageurl" value="${popupInfo.pop_imageurl }">
			<input type="hidden" id="pop_url" value="${popupInfo.pop_url }">
			<table class="table">
				<tr>
					<th class="table-success">팝업 번호</th>
					<td id="pop_id">${popupInfo.pop_id }</td>
					<th class="table-success">팝업 제목</th>
					<td id="pop_title">${popupInfo.pop_title }</td>
				</tr>
				<tr>
					<th class="table-success">팝업 노출 기간</th>
					<td colspan="3">${popupInfo.pop_fromdate } ~ ${popupInfo.pop_todate }</td>
				</tr>
				<tr>
					<th class="table-success">팝업 높이</th>
					<td id="pop_height">${popupInfo.pop_height }</td>
					<th class="table-success">팝업 넓이</th>
					<td id="pop_width">${popupInfo.pop_width }</td>
				</tr>
				<tr>
					<th class="table-success">팝업 내용</th>
					<td colspan="3" id="pop_content">
					${popupInfo.pop_content }
					</td>
				</tr>
				<tr>
					<th class="table-success">이미지 링크</th>
					<td colspan="3" id="pop_imageurl">${popupInfo.pop_imageurl }</td>
				</tr>
				<tr>
					<th class="table-success">미리보기</th>
					<td colspan="3" id="pop_image">
					<c:if test="${popupInfo.pop_imageurl eq '' }">
						미리보기가 없습니다.
					</c:if>
					<c:if test="${popupInfo.pop_imageurl ne '' }">
						<img alt="이미지" src="${popupInfo.pop_imageurl }">
					</c:if>
					</td>
				</tr>
				<tr>
					<th class="table-success">연결 링크</th>
					<td colspan="3" id="pop_url">${popupInfo.pop_url }</td>
				</tr>
			</table>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6" style="text-align:center; margin-top: 30px;">
			<button type="button" class="btn btn-warning" style="width:300px;" onClick="popupModify();">수정하기</button>
			<button type="button" class="btn btn-primary" style="width:300px;" onClick="popupInsert();">새로 등록하기</button>
		</div>
		<div class="col-md-3"></div>
	</div>
<script>
function popupModify() {
	var url = '${pageContext.request.contextPath}';
	var pop_id = $('#pop_id').val();
	window.open(url + "/mng/popupModify.do?pop_id=" + pop_id, "_blank", "width=800, height=800");
}

function popupInsert() {
	var url = '${pageContext.request.contextPath}';
	window.open(url + "/mng/popupInsert.do", "_blank", "width=800, height=800");
}

function popupDelete(pop_id) {
	var url = '${pageContext.request.contextPath}';
	$.ajax({
		type:"post",
		url:"/mng/popupDelete.do",
		data:{"pop_id" : pop_id},
		dataType : "json",
		success : function(result) {
			alert('삭제가 완료 되었습니다.');
			location.reload();
		},
		error : function(error) {
			alert("에러 발생");
		}
	})
}

function logoutLogic() {
	  var root = '${pageContext.request.contextPath}';
	  location.href = root + '/user/userSignOut.do';
	}
</script>
</body>
</html>