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

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
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
			<form action="${pageContext.request.contextPath }/multi/articleEdit.do" id="articleUpdate" method="post">
			<div class="table table-responsive">
				<table class="table">
						<tr>
							<th class="table-success">글번호</th>
							<td>${article.article_no }</td>
							<th class="table-success">조회수</th>
							<td>${article.article_hit }</td>
						</tr>
						<tr>
							<th class="table-success">작성자</th>
							<td>${article.article_writer }</td>
							<th class="table-success">작성일</th>
							<td>${article.article_date }</td>
						</tr>
						<tr>
							<th class="table-success">제목</th>
							<td colspan="3"><input type="text" name="article_title" id="article_title" class="form-control" value="${article.article_title }"/></td>
						</tr>
						<tr>
							<th class="table-success">글 내용</th>
							<td colspan="3"><textarea class="summernote" name="article_content" id="article_content" rows="10" height="500px">${article.article_content }</textarea></td>
						</tr>
					</table>
				</div>
				<input type="hidden" name="article_no" id="article_no" value=${article.article_no }>
				<button type="button" class="btn btn-primary" onclick="articleUpdate();">수정 완료</button>
				<button type="button" class="btn btn-danger" onclick="history.back();">돌아가기</button>
				<input type="hidden" name="article_userid" id="article_userid" value="${article.article_userid }"/>
			</form>
			</div>
		</div>
		<script type="text/javascript">
			function articleUpdate() {
				var article_no = document.getElementById('article_no').value;
				var article_title = document.getElementById('article_title').value;
				var article_content = document.getElementById('article_content').value;
				var article_userid = document.getElementById('article_userid').value;
				
				$.ajax({
					    type : "POST",
				        url : "/multi/articleEdit.do",
				        data : {"article_no" : article_no,
								"article_title" : article_title,
								"article_content" : article_content,
								"article_userid" : article_userid
				        		},
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
			
			$(document).ready(function() {
				$('#article_content').summernote({
					height:400
				});
			});
		</script>
</body>
</html>
