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
<title>게시글 상세보기 - ${board.board_title }</title>
</head>
<body>
	</br>
	</br>
	<div class="row">
		<div class="col-xs-2 col-md-2"></div>
		<div class="col-xs-8 col-md-8">
			<h2 class="text-center">게시글 보기</h2>
			<p>&nbsp;</p>
			<div class="table table-responsive">
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
						<td colspan="3">${board.board_title }</td>
					</tr>
					<tr>
						<th class="table-success">글 내용</th>
						<td colspan="3" rows="20">${board.board_content }</td>
					</tr>
					<tr>
					</tr>
				</table>
			<!-- 현재 보고 있는 글의 board_no -->
			<input type="hidden" id="board_no" value="${board.board_no }"/>
			<!-- 현재 보고 있는 글을 쓴 사람의 id -->
			<input type="hidden" id="board_id" value="${board.board_userid }"/>
			<!-- 현재 로그인 된 사람의 이름 -->
			<input type="hidden" id="current_user" value="${sessionScope.username }"/>
			<!-- 현재 로그인 된 사람의 아이디 -->
			<input type="hidden" id="current_userid" value="${sessionScope.userid }"/>
			
			<button type="button" class="btn btn-primary" onClick="location.href='${pageContext.request.contextPath }/boardedit.do?board_no=${board.board_no}'">수정하기</button>
			<button type="button" class="btn btn-danger" onClick="boardDelete();">삭제하기</button>
			<c:if test="${board.board_isnotice ne 1 }">
				<button type="button" class="btn btn-success" onClick="location.href='${pageContext.request.contextPath}/reBoardWrite.do?board_no=${board.board_no }'">답글달기</button>
			</c:if>
			<button type="button" class="btn btn-warning" onClick="windowClose();">닫기</button>
			<hr>
			</div>
			<div class="row">
				<div class="col-2">
					작성자</br>
					<c:if test="${sessionScope.userid ne null }">
						<strong>${sessionScope.username }</strong>
					</c:if>
					<c:if test="${sessionScope.userid eq null }">
						<strong>로그인 필요</strong>
					</c:if>
				</div>
				<div class="col-8">
					<textarea id="replyContent" placeholder="댓글 내용을 입력하십시오." rows="3" style="width:100%"></textarea>
				</div>
				<div class="col-2">
					<input type="button" class="btn-lg btn btn-primary" id="button1" onclick="replyWriteAction();" value="작성"/>
				</div>
  			</div>
  			<div>
			<hr>
  			<div id="replyListView">
	  			<c:forEach items="${reply_list}" var="reply_list">
	  				<div class="row">
	  					<div class="col-10">
	  						<div class="row-1">
	  							<input type="hidden" id="reply_no${reply_list.reply_no }" value="${reply_list.reply_no }"/>
	  							<strong>${reply_list.reply_writer }</strong>
	  						</div>
	  						<div class="row-3" id="reply_component${reply_list.reply_no }">${reply_list.reply_content }</div>
	  						<div class="row-1">
			  					${reply_list.reply_date }	  					  						
	  						</div>
	  					</div>
	  					<div class="col-2">		
	  					<c:choose>
	  						<c:when test="${sessionScope.userid eq reply_list.reply_userid}">
	  							<input type="button" id="reply_config${reply_list.reply_no }" class="btn-sm btn btn-info" onclick="updateReply(${reply_list.reply_no})" value="수정"/>
	  							<input type="button" id="reply_delete${reply_list.reply_no }" class="btn-sm btn btn-danger" onclick="deleteReply(${reply_list.reply_no})" value="삭제"/>
  							</c:when>
  							<c:when test="${sessionScope.userid eq 'admin'}">
  								<input type="button" id="reply_config${reply_list.reply_no }" class="btn-sm btn btn-info" onclick="updateReply(${reply_list.reply_no})" value="수정"/>
  								<input type="button" id="reply_delete${reply_list.reply_no }" class="btn-sm btn btn-danger" onclick="deleteReply(${reply_list.reply_no})" value="삭제"/>
  							</c:when>
  						</c:choose>
	  					</div>
	  				</div>
				<hr>
  				</c:forEach>
  			</div>
  			</div> 
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function() { getReplyList(); });
	
	function boardDelete() {
		var board_no = document.getElementById('board_no').value;
		var board_userid = document.getElementById('board_id').value;
		$.ajax({
			    type : "GET",
		        url : "/boardDelete.do",
		        data : {"board_no" : board_no,
						"board_userid" : board_userid},
		        dataType : "json",
		        success: function(result){
		        	alert('삭제가 완료되었습니다.');
		        	opener.location.reload();
		        	self.close();
		        },
		        error: function(error) {
		        	alert('권한이 없습니다.');
		        }  
		});
	}
	
	function windowClose() {
		self.close();
		opener.location.reload();
	}
	
	function replyWriteAction() {
		if($("#current_user").val() == "" || $('#current_user').val() == null) {
			alert('로그인이 필요한 서비스입니다.')
			return false;
		}
		
		var reply_board = $('#board_no').val();
		var reply_writer = $('#current_user').val();
		var reply_userid = $('#current_userid').val();
		var reply_content= $('#replyContent').val();
		
		$.ajax({
			type : "POST",
			url : "reply/writeReplyAction",
			data : {"reply_board" : reply_board,
					"reply_writer" : reply_writer,
					"reply_userid" : reply_userid,
					"reply_content" : reply_content},
			dataType : "json",
			success : function(result) {
				getReplyList();
				$('#replyContent').val('');
			},
			error : function(error) {
				alert('오류 발생');
			}
		});
	}
	
	function getReplyList() {
		
		var current_userid = $('#current_userid').val();
		var reply_board = $('#board_no').val();
		
		$.ajax({
			type : "GET",
			url : "reply/getReplyList",
			data : {"reply_board" : reply_board},
			dataType : "json",
			success : function(result) {
				var innerHTML = '';
				for(var i = 0; i<result.length; i++) {
					innerHTML += '<div class="row"> <div class="col-10"> <div class="row-1">';
					innerHTML += '<input type="hidden" value="'
					innerHTML += result[i].reply_no;
					innerHTML += '"/>';
					innerHTML += '<strong>';
					innerHTML += result[i].reply_writer;
					innerHTML += '</strong>';
					innerHTML += '</div> <div class="row-3" id="reply_component';
					innerHTML += result[i].reply_no;
					innerHTML += '">';
					innerHTML += result[i].reply_content;
					innerHTML += '</div> <div class="row-1">';
					innerHTML += result[i].reply_date;
					innerHTML += '</div> </div> <div class="col-2">';
					if(current_userid == result[i].reply_userid || current_userid == 'admin') {
						innerHTML += '<input type="button" class="btn-sm btn btn-info" onclick="updateReply(';
						innerHTML += result[i].reply_no;
						innerHTML += ')" value="수정"/>';
						innerHTML += '<input type="button" class="btn-sm btn btn-danger" onclick="deleteReply(';
						innerHTML += result[i].reply_no;
						innerHTML += ')" value="삭제"/>';
					}
					innerHTML += '</div> </div> <hr>';
				}
				$('#replyListView').html(innerHTML);
			},
			error : function(error) {
				alert('실패');
			}
		});
	}
	
	function deleteReply(reply_no) {
		// alert('삭제될 번호는' + reply_no);
		$.ajax({
			type : "GET",
			url : "reply/deleteReply",
			data : {"reply_no" : reply_no},
			dataType : "json",
			success : function(result) {
				getReplyList();
				//location.reload();
			},
			error : function(error) {
				alert('오류 발생');
			}
		});
	}
	
	function updateReply(reply_no) {
		var before_reply_content = $('#reply_component' + reply_no).text();
		var innerHTML = '';
		
		innerHTML += '<textarea id="replyContent';
		innerHTML += reply_no;
		innerHTML += '" placeholder="댓글 내용을 입력하십시오." rows="1" style="width:100%">';
		innerHTML += before_reply_content;
		innerHTML += '</textarea> </br>';
		innerHTML += '<input type="button" class="btn-sm btn btn-success" id="updateConfirm';
		innerHTML += reply_no;
		innerHTML += '" onclick="updateReplyConfirm(';
		innerHTML += reply_no;
		innerHTML += ')" value="완료">';
		
		$('#reply_component'+ reply_no).html(innerHTML);
	}
	
	function updateReplyConfirm(reply_no) {
		var new_reply_content = $('#replyContent' + reply_no).val();
		
		$.ajax({
			type : "POST",
			url : "reply/updateReplyConfirm",
			data : {"reply_content" : new_reply_content,
					"reply_no" : reply_no},
			dataType : "json",
			success : function(result) {
				getReplyList();
			},
			error : function(error) {
				alert('댓글 갱신 오류 발생');
			}
		});
	}
	</script>
</body>
</html>
