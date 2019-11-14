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
<script src="https://cdn.ckeditor.com/4.13.0/standard/ckeditor.js"></script>
<html>
<head>
<title>WebBoard - 게시글 쓰기</title>
</head>
<body>
	</br>
	</br>
	<div class="row">
		<div class="col-xs-2 col-md-2"></div>
		<div class="col-xs-8 col-md-8">
			<h2 class="text-center">게시글 쓰기</h2>
			<p>&nbsp;</p>
		<form action="${pageContext.request.contextPath }/boardWrite.do" id="boardWrite" method="post">
			<div class="table table-responsive">
				<table class="table">
						<tr>
							<th class="table-success">작성자</th>
							<td>${sessionScope.username }</td>
							<th class="table-success">작성일</th>
							<td>${date }
							<c:if test="${sessionScope.userid eq 'admin'}">
								<select name="board_isnotice" id="board_isnotice">
									<option value="0">일반</option>
									<option value="1">공지</option>
								</select>
							</c:if>
							<c:if test="${sessionScope ne 'admin' }">
								<input type="hidden" id="board_isnotice" name="board_isnotice" value="0">
							</c:if>
							</td>
						</tr>
						<tr>
							<th class="table-success">제목</th>
							<td colspan="3"><input type="text" name="board_title" id="board_title" class="form-control"/></td>
						</tr>
						<tr>
							<th class="table-success">글 내용</th>
							<td colspan="3"><textarea class="ckeditor" name="board_content" id="board_content" rows="10" height="500px"></textarea></td>
						</tr>
					</table>
				</div>
				<input type="hidden" name="board_no"/>
				<input type="hidden" name="board_writer" id="board_writer" value="${sessionScope.username }"/>
				<input type="hidden" id="board_content" value="">
				<button type="button" class="btn btn-primary" onclick="boardWrite();">작성 완료</button>
				<button type="button" class="btn btn-danger" onclick="self.close();">돌아가기</button>
				<input type="hidden" name="board_userid" id="board_userid" value="${sessionScope.userid }"/>
			</div>
		</div>
		</form>
		<script>
			CKEDITOR.replace('board_content', {
				toolbar : 'Full',
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P
			});
		</script>
		<script type="text/javascript">
		function boardWrite() {
			var board_writer = document.getElementById('board_writer').value;
			var board_userid = document.getElementById('board_userid').value;
			var board_title = document.getElementById('board_title').value;
			var board_content = CKEDITOR.instances['board_content'].getData();
			var board_isnotice = document.getElementById('board_isnotice').value;
			$.ajax({
				    type : "POST",
			        url : "/boardWrite.do",
			        data : {"board_writer" : board_writer,
			        		"board_userid" : board_userid,
			        		"board_title" : board_title,
			        		"board_content" : board_content,
			        		"board_isnotice" : board_isnotice},
			        dataType : "json",
			        success: function(result){
			        	alert('등록이 완료되었습니다.');
			        	opener.location.reload();
			        	self.close();
			        },
			        error: function(error) {
			        	alert('등록에 실패했습니다.');
			        	console.log(error);
			            self.close();
			        }  
			});
		}
		</script>
</body>
</html>