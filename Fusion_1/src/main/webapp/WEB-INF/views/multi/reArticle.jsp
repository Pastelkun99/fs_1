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
<style>
	.layer {
		display: none;
	}
</style>
<title>게시글 답글쓰기 - ${article.article_title }</title>
</head>
<body>
	<div class="row">
		<div class="col-xs-2 col-md-2"></div>
		<div class="col-xs-8 col-md-8">
			<h2 class="text-center">답글 작성</h2>
			<p>&nbsp;</p>
			<div class="table table-responsive">
				<table class="table">
						<tr>
							<th class="table-success">작성자</th>
							<td>${sessionScope.username }</td>
							<th class="table-success">작성일</th>
							<td>${date }
								<c:if test="${boardConfig.board_secretyn eq 'Y' }">
									<select name="article_secretyn" id="article_secretyn" class="form-control" style="float:right; width:100px;">
										<option value="N">일반글</option>
										<option value="Y">비밀글</option>
									</select>
									<!-- 이 레이어는 보이지 않음 -->
									<div class="layer">
										<input type="password" id="article_password" class="form-control" name="article_password" placeholder="여기에 비밀번호를 입력해 주세요.">
									</div>
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="table-success">제목</th>
							<td colspan="3"><input type="text" name="article_title" id="article_title" class="form-control" value="Re : ${article.article_title}"/></td>
						</tr>
						<tr>
							<th class="table-success">글 내용</th>
							<td colspan="3"><textarea class="summernote" name="article_content" id="article_content" rows="20" height="500px"></textarea></td>
						</tr>
					</table>
				<input type="hidden" name="article_no" id="article_no" value=${article.article_no }>
				<input type="hidden" name="board_no" id="board_no" value=${param.board_no }>
				<input type="hidden" name="article_parentsno" id="article_parentsno" value=${article.article_parentsno }>
				<input type="hidden" name="article_writer" id="article_writer" value="${sessionScope.username }"/>
				<input type="hidden" name="article_userid" id="article_userid" value="${sessionScope.userid }"/>
				<input type="hidden" name="article_grouporder" id="article_grouporder" value="${article.article_grouporder }"/>
				<input type="hidden" name="article_groupdepth" id="article_groupdepth" value="${article.article_groupdepth }"/>
				<button type="button" class="btn btn-primary" onclick="reArticleWrite();">작성 완료</button>
				<button type="button" class="btn btn-danger" onclick="history.back();">돌아가기</button>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#article_content').summernote({
		height:400
	})
});

$('#article_secretyn').change(function() {
	var state = $('#article_secretyn option:selected').val();
	if(state == 'Y') {
		$('.layer').show();
	} else {
		$('#article_password').val('');
		$('.layer').hide();
	}
})
</script>
<script type="text/javascript">
	function reArticleWrite() {
		
		if($('#article_password').val().length == 0 && $('.layer').is(":visible")) {
			alert('비밀번호가 입력되지 않았습니다.');
			return false;
		}
		
		if(($('#article_password').val().length > 15 || $('#article_password').val().length < 5) && $('.layer').is(":visible")) {
			alert('비밀번호는 4자 이상, 15자 미만으로 부탁드립니다.');
			return false;
		}
		
		var board_no = $('#board_no').val();
		var article_writer = $('#article_writer').val();
		var article_userid = $('#article_userid').val();
		var article_title = $('#article_title').val();
		var article_content = $('#article_content').val();
		var article_secretyn = $('#article_secretyn').val();
		var article_password = $('#article_password').val();
		var article_parentsno = $('#article_parentsno').val();
		var article_grouporder = $('#article_grouporder').val();
		var article_groupdepth = $('#article_groupdepth').val();
		
		$.ajax({
			type : "post",
			url : "/multi/reArticleWrite.do",
			data : {"board_no" : board_no,
					"article_writer" : article_writer,
					"article_userid" : article_userid,
					"article_title" : article_title,
					"article_content" : article_content,
					"article_secretyn" : article_secretyn,
					"article_password" : article_password,
					"article_parentsno" : article_parentsno,
					"article_grouporder" : article_grouporder,
					"article_groupdepth" : article_groupdepth
					},
			dataType : "json",
			success : function(result) {
				alert('답글이 작성되었습니다.');
				self.close();
				opener.location.reload();
			},
			error : function(error) {
				alert('문제가 발생하였습니다.');
			}
		})
	}
</script>
</body>
</html>
