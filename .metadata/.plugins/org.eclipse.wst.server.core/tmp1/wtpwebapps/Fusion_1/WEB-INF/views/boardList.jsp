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
	
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<title>WebBoard - 게시판입니다.</title>
<style type="text/css">
 #pop{
  width:400px; height:600px; background:#3d3d3d; color:#fff;
  position:absolute; top:120px; left:120px; text-align:center;
  border:2px solid #000;
   }
.close div{float:left; text-align:right;}
 #check{font-size:16px; font-family:'돋움'; padding-left:70px;}
 #close{font-size:16px; padding:5px; font-weight:bold;}
</style>
</head>
<script>
function windowPopup() {
	var url = '${pageContext.request.contextPath}';
	
	var pop_title = '${pop_title}';
	var pop_fromdateString = '${pop_fromdate}';
	var pop_fromdate = Date.parse(pop_fromdateString);
	
	var pop_todateString = '${pop_todate}';
	var pop_todate = Date.parse(pop_todateString);
	
	var pop_nowDate = new Date().getTime();
	
	if(pop_nowDate >= pop_fromdate && pop_nowDate <= pop_todate) {
		var pop_aval = '${pop_aval}';
		if(pop_aval == 1) {
			var pop_height = '${pop_height}';
			var pop_width= '${pop_width}';
			var pop_content = '${pop_content}';
			var pop_imageurl = '${pop_imageurl}';
			var pop_url = '${pop_url}';
			var opt = 'width=' + pop_width + ", height=" + pop_height;
			window.open(url + '/mng/showPopup.do', "_blank", opt);
		} 
	}
}

</script>
<body>
</br>
</br>
</br>
</br>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col-11">
				<input type="hidden" id="popup" name="popup" onclick="windowPopup();">
				<c:if test="${sessionScope.username eq null }">
					<h2>로그인 후 가능한 서비스 입니다.</h2>
					</br>
				</c:if>
				<c:if test="${sessionScope.username ne null }">
					<h2>${sessionScope.username }님 환영합니다.</h2>
					</br>
					<button type="button" class="btn btn-danger" onClick="logoutLogic();">로그아웃</button>
					<button type="button" class="btn btn-danger" onClick="location.href = '${pageContext.request.contextPath}/multi/boardList.do?board_no=-1&page_no=1&pageSize=10'">신페이지로 이동</button>
					<button type="button" class="btn btn-primary" onClick="javascript:void(window.open('boardWrite.do', '_blank', 'location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no')); return false;">새 글 쓰기</button>
					<button type="button" class="btn btn-info" onClick="location.href='${pageContext.request.contextPath }/boardList.do?page_no=1&pageSize=${page.pageList}&searchCon=0&keyword='">게시판 보기</button>
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-dark" data-toggle="modal" id="myModal"
						data-target="#exampleModalLong">공지사항 보기</button>
					<c:if test="${sessionScope.isAdmin eq 1 }">
						<button type="button" class="btn btn-light" onClick="location.href='${pageContext.request.contextPath}/Chart.do?fromDate=&toDate='">관리자 통계 페이지</button>
						<button type="button" class="btn btn-dark" onClick="location.href='${pageContext.request.contextPath}/mng/adminCheck.do'">관리자 페이지</button>
					</c:if>
					<button type="button" class="btn btn-warning" onClick="location.href='${pageContext.request.contextPath}/anal.do'">설문조사 참여</button>
					</br>
					</br>
					<script>
						
					</script>
					<form name="pagefrm" method="get">
						  <input type="hidden" name="page_no" value="1"/>
                          <select name="pageSize" class="select" title="페이징 갯수" onchange="select_page();">
                          	<option value="10" <c:if test="${page.pageSize eq '10'}">selected="selected"</c:if>>10개</option>
                          	<option value="20" <c:if test="${page.pageSize eq '20'}">selected="selected"</c:if>>20개</option>
                          	<option value="50" <c:if test="${page.pageSize eq '50'}">selected="selected"</c:if>>50개</option>
                          </select>
                    </form>
                    <form name="pageSearchfrm" method="get">
                    	<input type="hidden" name="page_no" id="page_no" value="1"/>
                    	<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }"/>
                    	<!-- <input type="hidden" id="keyword" name="keyword" value=""/> -->
	                    <select name="searchCon" id="searchCon" class="select" title="검색조건 선택">
					       <option value="1" <c:if test="${page.searchCon == '1'}">selected="selected"</c:if> >제목</option>
				           <option value="2" <c:if test="${page.searchCon == '2'}">selected="selected"</c:if> >내용</option>             
				           <option value="3" <c:if test="${page.searchCon == '3'}">selected="selected"</c:if> >작성자</option>            
				           <option value="4" <c:if test="${page.searchCon == '4'}">selected="selected"</c:if> >전체</option>
	                    </select>
					<div class="input-group mb-3">
  						<input type="text" class="form-control" placeholder="키워드를 입력하시면 찾아드립니다." id="keyword" name="keyword" aria-label="boardSearch" aria-describedby="button-addon2" value="${page.keyword }">
  						<div class="input-group-append">
    					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="search_board()">Search</button>
  						</div>
					</div>
                    </form>
				</c:if>
					<table class="table">
						<thead class="thead-light">
							<tr>
								<th>순번</th>
								<th>글제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="noticeBoard" items="${noticeList }">
								<tr>
									<td><strong>공지</strong></td>
									<td><a href="#" onclick="javascript:void(window.open('board.do?board_no=${noticeBoard.board_no}', '${noticeBoard.board_title }', '_blank'));"/>${noticeBoard.board_title }</a></td>
									<td>${noticeBoard.board_writer}</td>
									<td>${noticeBoard.board_hit}</td>
									<td>${noticeBoard.board_date}</td>
								<tr>
							</c:forEach>
							<c:forEach var="board" items="${boardlist}" varStatus="status">
								<c:if test="${board.board_deletecon eq 1 }">
								<tr>
									<td>${page.totalCount - (param.page_no-1)*param.pageSize - status.index}</td>								
									<td colspan="2">삭제된 게시물입니다.</td>
									<td></td>
									<td></td>
								<tr>
								</c:if>
								<c:if test="${board.board_deletecon ne 1 }">
									<tr>
										<td>${page.totalCount - (param.page_no-1)*param.pageSize - status.index}</td>								
										<td><a href="#" onclick="javascript:void(window.open('board.do?board_no=${board.board_no}', '${board.board_title }', '_blank')); return false;"/>${board.board_title}</a></td>
										<td>${board.board_writer}</td>
										<td>${board.board_hit}</td>
										<td>${board.board_date}</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
						<nav aria-label="Page navigation example">
  							<ul class="pagination">
   								 <li class="page-item">
   								 	<c:if test="${param.page_no ne 1 }">
	    								 <a class="page-link" href="${pageContext.request.contextPath }/boardList.do?page_no=${param.page_no-1}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }" aria-label="Previous">
	     							 	<span aria-hidden="true">&laquo;</span>
	      								 </a>
   								 	</c:if>
    							 </li>
    							 <c:forEach begin="1" end="${page.endPage }" var="value">
	    							 <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/boardList.do?page_no=${value}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }">${value }</a></li>						 
    							 </c:forEach>
    							 <li class="page-item">
    							 <c:if test="${param.page_no ne page.endPage }">
     							 	<a class="page-link" href="${pageContext.request.contextPath }/boardList.do?page_no=${param.page_no-1}&pageSize=${page.pageList}&searchCon=${page.searchCon}&keyword=${page.keyword }" aria-label="Next">
      							 	<span aria-hidden="true">&raquo;</span>
      							 	</a>
    							 </c:if>
    							</li>
  							</ul>
						 </nav>
					</div>
					<div class="col"></div>
				</div>
				</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModalLong" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<c:if test="${notice.board_title eq null }">
						<h5 class="modal-title" id="exampleModalLongTitle">현재 등록된 공지가 없습니다.</h5>
					</c:if>
					<c:if test="${notice.board_title ne null }">
						<h5 class="modal-title" id="exampleModalLongTitle">${notice.board_title}</h5>
					</c:if>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<c:if test="${notice.board_content eq null }">
					<div class="modal-body"></div>										
				</c:if>
				<c:if test="${notice.board_content ne null }">
					<div class="modal-body">${notice.board_content }</div>
				</c:if>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" id="noticeClose"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-danger" onclick="closeNotice();">오늘 하루 동안 보지 않기</button>
				</div>
			</div>
		</div>
	</div>
	<script language="JavaScript">
  <!--
  function setCookie( name, value, expiredays ) {
   var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
   }

  function closePop() {
   if ( document.pop_form.chkbox.checked ){
    setCookie( "maindiv", "done" , 1 );
   }
   document.all['pop'].style.visibility = "hidden";
  }
  //-->
  $(document).ready(function() {
	 var currentUserId = '${sessionScope.userid}';
	 var result = getCookie(currentUserId + "popup");
	 var resultWindow = getCookie(currentUserId + "window");
	 
	 if(resultWindow == currentUserId) {
		 return false;
	 } else {
		 windowPopup();
	 }
	 
	 if(result == currentUserId) {
		 return false;
	 } else {
		 document.getElementById('myModal').click();
	 }
  });
  
  function setCookie(cname, value, expire) {
	   var todayValue = new Date();
	   todayValue.setDate(todayValue.getDate() + expire);
	   document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
	}
  
  function getCookie(name) {
	   var cookieName = name + "=";
	   var x = 0;
	   while ( x <= document.cookie.length ) {
	      var y = (x+cookieName.length);
	      if ( document.cookie.substring( x, y ) == cookieName) {
	         if ((lastChrCookie=document.cookie.indexOf(";", y)) == -1)
	            lastChrCookie = document.cookie.length;
	         return decodeURI(document.cookie.substring(y, lastChrCookie));
	      }
	      x = document.cookie.indexOf(" ", x ) + 1;
	      if ( x == 0 )
	         break;
	      }
	   return "";
	}
  
  function closeNotice() {
	  var currentUserId = '${sessionScope.userid}';
	  setCookie(currentUserId + 'popup', currentUserId, 1);
	  document.getElementById('noticeClose').click();
  }
  
  function getContextPath() {
	  var hostIndex = location.href.indexOf(location.host) + location.host.length;
	  return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
  }
  
  function logoutLogic() {
	  var root = getContextPath();
	  location.href = root + '/user/userSignOut.do';
  }
  
  function select_page() {
		var pageSize = document.pagefrm.pageSize.value;
		var searchCon = document.getElementById('searchCon').value;
		var keyword = document.getElementById('keyword').value;
		location.href= getContextPath() + '/boardList.do?page_no=1&pageSize=' + pageSize + '&searchCon=' + searchCon + '&keyword=' + keyword;
	} 
	
  function search_board() {
		var page_no = document.getElementById('page_no').value;
		var pageSize = document.getElementById('pageSize').value;
		var searchCon = document.getElementById('searchCon').value;
		var keyword = document.getElementById('keyword').value;
		document.pageSearchfrm.action = "<c:url value='/boardList.do'/>";
		document.pageSearchfrm.submit();
  }
  
  window.onload = function() {
	  
	  var log_userid = '${sessionScope.userid}'; 
	  var log_userreferrer = document.referrer;
	  
	  $.ajax({
		  type : "POST",
	  	  url : "/log.do",
	  	  data : {"log_userid" : log_userid,
	  		  	  "log_userreferrer" : log_userreferrer},
		  dataType : "json",
		  success : function(result) {
			  /* alert('데이터 전송 성공'); */
		  },
		  error : function(error) {
			  /* alert(error); */
		  }
	  });
  }
</script>
</body>
</html>
</body>
</html>
