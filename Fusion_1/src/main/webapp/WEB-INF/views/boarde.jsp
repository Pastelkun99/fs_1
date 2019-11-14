<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true" pageEncoding="UTF-8"%>
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
<title>WebBoard - 게시글 수정하기</title>
</head>
<body>
	</br>
	</br>
	<div class="row">
		<div class="col-xs-2 col-md-2"></div>
		<div class="col-xs-8 col-md-8">
			<h2 class="text-center">게시글 수정</h2>
			<p>&nbsp;</p>
			<div class="table table-responsive">
			<form action="${pageContext.request.contextPath }/boardedit.do" id="boardUpdate" method="post">
				<table class="table">
						<tr>
							<th class="table-success">글번호</th>
							<td>${board.board_no }</td>
							<th class="table-success">조회수</th>
							<td>${board.board_hit }</td>
						</tr>
						<tr>
							<th class="table-success">작성자</th>
							<td>${board.board_writer }</td>
							<th class="table-success">작성일</th>
							<td>${board.board_date }</td>
						</tr>
						<tr>
							<th class="table-success">제목</th>
							<td colspan="3"><input type="text" name="board_title" class="form-control" value="${board.board_title }"/></td>
						</tr>
						<tr>
							<th class="table-success">글 내용</th>
							<td colspan="3"><textarea class="form-control" name="board_content" rows="10" height="500px">${board.board_content }</textarea></td>
						</tr>
					</table>
				</div>
				<input type="hidden" name="board_no" value=${board.board_no }>
				<button type="button" class="btn btn-primary" onclick="boardUpdate();">수정 완료</button>
				<button type="button" class="btn btn-danger" onclick="history.back();">돌아가기</button>
				<input type="hidden" name="board_userid" value="${board.board_userid }"/>
			</div>
		</div>
		</form>
		<script type="text/javascript">
			function boardUpdate() {
				var test = $('#boardUpdate').serialize();
				$.ajax({
					    type : "POST",
				        url : "/boardedit.do",
				        data : test,
				        dataType : "json",
				        success: function(result){
				        	alert('수정이 완료되었습니다.');
				        	opener.location.reload();
				        	self.close();
				        },
				        error: function(error) {
				        	alert('수정에 실패했습니다.');
				            alert(error);
				            self.close();
				        }  
				});
			}
		</script>
</body>
</html>
