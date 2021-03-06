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
<title>대댓글 작성</title>
</head>
<body>
	<div class="card" style="width: 100%;">
		<div class="card-header"><strong>대댓글 작성</strong></div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				작성할 내용 : 
				<textarea type="text" name="reply_content" id="reply_content" class="form-control" maxlength="200" rows="2"></textarea>
			</li>
			<li class="list-group-item">
				
			</li>
			<li class="list-group-item">
				<input type="hidden" id="reply_parentsno" name="reply_parentsno" value="${thisReply.reply_no }"/>
				<button type="button" class="btn btn-danger" style="width:150px;" onClick="closeWindow();">취소</button>
				<button type="button" class="btn btn-primary" style="width:150px;" onClick="reReplyAppend();">등록</button>
			</li>
		</ul>
	</div>
</body>
<script type="text/javascript">

	function closeWindow() {
		self.close();
	}
	
	function reReplyAppend() {
		
		if($('#reply_content').val().length == 0) {
			alert('댓글 내용이 입력되지 않았습니다.');
			return false;
		}
		
		var article_no = '${param.article_no}';
		var reply_no = '${param.reply_no}';
		var reply_writer = '${sessionScope.username}';
		var reply_userid = '${sessionScope.userid}';
		var reply_content = $('#reply_content').val();
		var reply_parentsno = $('#reply_parentsno').val();
		var reply_grouporder = $('#reply_grouporder').val();
		var reply_groupdepth = $('#reply_groupdepth').val();
		
		$.ajax({
			type : "post",
			url : "/multi/reReplyWriteAction",
			data : {
				"article_no" : article_no,
				"reply_no" : reply_no,
				"reply_writer" : reply_writer,
				"reply_userid" : reply_userid,
				"reply_content" : reply_content,
				"reply_parentsno" : reply_parentsno,
				"reply_grouporder" : reply_grouporder,
				"reply_groupdepth" : reply_groupdepth
			},
			dataType : "json",
			success : function(result) {
				alert('등록되었습니다.');
				opener.location.reload();
				self.close();
			},
			error : function(error) {
				alert('하;;');
			}
		})
	}
</script>
</html>
