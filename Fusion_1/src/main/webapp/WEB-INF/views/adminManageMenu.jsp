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
<script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/1.0.3/jquery.tablednd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/1.0.3/jquery.tablednd.min.js"></script>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>

<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>관리자 페이지</title>
<style>
.dragRow {
	background-color : #eee;
}
</style>
</head>
<body>
<script type="text/javascript">
	$(function() {
		$('#boardTable').tableDnD({
			onDragClass : "dragRow",
	    });
	})
	
	function rowEffect() {
		
		$('.rowAttr').each(function(index) {
			var totalArr = {};
			$(this).find('td').each(function() {
				/* alert($(this).find('.form-control').attr('data-code'));
				alert($(this).find('.form-control').val()); */
				totalArr[$(this).find('.form-control').attr('data-code')] = $(this).find('.form-control').val();
			});
			totalArr['menu_order'] = index;
			
			$.ajax({
				type : "post",
				url : "menuOrderCommit.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(totalArr),
				dataType : "json",
				success : function(result) {
					window.location.reload();
				},
				error : function(error) {
					alert('문제 발생' + error);
				}
			})
		})
		
	}
</script>
	<jsp:include page="adminNavbar.jsp"></jsp:include>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<h1 style="text-align: center; margin-bottom: 30px;">메뉴 관리</h1>
			<table id="boardTable" class="table" style="width:100%;">
				<tr id="rowTemp">
					<th scope="col">순서</th>
					<th scope="col">메뉴 이름</th>
					<th scope="col">메뉴 사용 여부</th>
					<th scope="col">MODE</th>
				</tr>
				<c:forEach items="${menuList }" var="menuList" varStatus="status">
					<tr id="rowTemp" class="rowAttr">
						<td>${status.index + 1}</td>
						<td>${menuList.menu_name}</td>
						<td>
							<c:if test="${menuList.menu_useyn eq 'Y' }">
								활성화
							</c:if>
							<c:if test="${menuList.menu_useyn eq 'N' }">
								비활성화
							</c:if>
						</td>
						<td>
							<input type="hidden" id="menu_no" name="menu_no" class="form-control" data-code="menu_no" value="${menuList.menu_no }"/>
							<button type="button" id="boardInfoUpdate(${menuList.menu_no })" onclick="menuInfoUpdate(${menuList.menu_no });" class="btn btn-warning">수정</button>
							<button type="button" id="boardInfoDelete(${menuList.menu_no })" onclick="menuInfoDelete(${menuList.menu_no });" class="btn btn-danger">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			<button type="button" id="newMenuAppend" onclick="newMenuAppend();" class="btn btn-success">등록</button>
			<button type="button" id="orderCommit" onclick="rowEffect();" class="btn btn-primary">순서 반영</button>
			<button type="button" id="goToBoardList" onclick="location.href='${pageContext.request.contextPath}/multi/boardList.do?board_no=-1&page_no=1&pageSize=10'" class="btn btn-Info">게시판으로</button>
		</div>
		<div class="col-md-3"></div>
	</div>
<script>
var url = '${pageContext.request.contextPath}';

function newMenuAppend() {
	window.open('/mng/newMenuAppend.do', '_blank', 'width=500px, height=300px');
}

function menuInfoUpdate(menu_no) {
	window.open('/mng/menuInfoUpdate.do?menu_no=' + menu_no, '_blank', 'width=500px, height=700px');
}

function menuInfoDelete(menu_no) {
	
	$.ajax({
		type : "post",
		url : "/mng/menuInfoDelete.do",
		data : {"menu_no" : menu_no},
		dataType : "json",
		success : function(result) {
			alert('삭제되었습니다.');
			window.location.reload();
		},
		error : function(error) {
			alert('문제가 발생했습니다.');
		}
	});
}

function logoutLogic() {
  var root = '${pageContext.request.contextPath}';
  location.href = root + '/user/userSignOut.do';
}
</script>
</body>
</html>