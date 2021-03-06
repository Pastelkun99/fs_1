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
<title>WebBoard</title>
</head>
<body>
<div>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</div>
<div class="row">
	<div class="col"></div>
	<div class="col">
		<form action="${pageContext.request.contextPath }/analysis.do" method="post">
			<select id="a_no" name="a_no" class="form-control" style="margin-bottom: 50px;">
				<c:forEach items="${analList }" var="anal">
					<c:if test="${anal.a_aval eq 1 }">
						<option value="${anal.a_no }">${anal.a_name }</option>
					</c:if>
				</c:forEach>
			</select>
			<button class="btn btn-lg btn-primary btn-block" type="submit" style="width:200px;">GO</button>
		</form>
		<p class="mt-5 mb-3 text-muted" style="text-align: center;">&copy; Fusionsoft</p>
	</div>
	<div class="col"></div>
</div>
<script type="text/javascript">
	var count = $('#a_no').children('option').length;
	if(count == 0) {
		alert('현재 진행 가능한 설문이 없습니다.');
		var url = '${pageContext.request.contextPath}';
		location.href = url + '/boardList.do?page_no=1&pageSize=10';
	}
</script>
</body>
</html>
