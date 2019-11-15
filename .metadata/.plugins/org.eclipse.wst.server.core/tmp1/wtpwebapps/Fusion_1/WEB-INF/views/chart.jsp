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
<!-- <script src="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<title>WebBoard - 통계 페이지</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#logTable').DataTable();
	} );
</script>
	<div class="row">
		<nav class="navbar navbar-light bg-light">
  			<span class="navbar-brand mb-0 h1">관리자 통계 페이지</span>
		</nav>
	</div>
	<div class="row">
		</br>
		</br>
	</div>
	<div class="row">
		<div class="col-8" style="margin-left:10px">
			<table id="logTable" class="display" style="width:100%; margin-left:20px;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">No</th>
						<th scope="col">ID</th>
						<th scope="col">Date</th>
						<th scope="col">IP</th>
						<th scope="col">Browser</th>
						<th scope="col">Browser Ver.</th>
						<th scope="col">OS</th>
						<th scope="col">Refer</th>
						<th scope="col">Tool</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="log" items="${logList }" varStatus="status">
						<tr>
							<th scope="row">${status.index + 1 }</th>
							<td><strong>${log.log_userid }</strong></td>
							<td>${log.log_date }</td>
							<td>${log.log_userip }</td>
							<td><strong>${log.log_userbrowser }</strong></td>
							<td>${log.log_bversion }</td>
							<td><strong>${log.log_osversion }</strong></td>
							<td>${log.log_userreferrer }</td>
							<td>
								<button type="button" id="logDelete${log.log_no}" class="btn btn-danger btn-sm" onClick="logDelete(${log.log_no});">제거하기</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col">
			<div class="row" id="LogPieChart" style="width: 600px; height: 400px;"></div>
			<div class="row">
			
			</div>
			<div class="row">
			
			</div>
		</div>
	</div>
	<script>
		function logDelete(log_no) {
			$.ajax({
				type : "POST",
				url : "/logDelete.do",
				data : {"log_no" : log_no},
				dataType : "json",
				success : function(result) {
					alert('삭제가 완료되었습니다.');
					location.reload();
				},
				error : function(error) {
					alert('에러 발생');
				}
			});
		}
	</script>
</body>
</html>