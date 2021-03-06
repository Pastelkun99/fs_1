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
<title>설문조사</title>
</head>
<body>
<div class="row">
	<div class="col-3"></div>
	<div class="col-6">
		<div class="card" style="width:100%;">
	  		<div class="card-body">
	  		  <h5 class="card-title"></h5>
	   		  <h6 class="card-subtitle mb-2 text-muted">설문조사 ${infoList.a_no }</h6>
	    	  <p class="card-text">${infoList.a_submitter }분들을 대상으로 ${infoList.a_name }(을)를 진행합니다.</br>
	    	  응답하신 내용은 통계법 33조(비밀의 보호)에 의거 비밀이 보장되며, 서비스 개선을 위한 자료 외에 어떠한 목적으로도 사용되지 않음을 약속드립니다. 많은 참여 부탁드리며,
	    	  앞으로도 교육정책 및 교육과정 정보를 보다 빠르게 활용하실 수 있도록 더욱 노력하겠습니다.</p>
	    	  <ul class="list-group list-group-flush">
	    	  	<li class="list-group-item">ㅇ 조사주관 : ${infoList.a_collector }</li>
	    	  	<li class="list-group-item">ㅇ 참여대상 : ${infoList.a_submitter }</li>
	    	  	<li class="list-group-item">ㅇ 참여기간 : ${infoList.a_fromdate } ~ ${infoList.a_todate }</li>
	    	  	<li class="list-group-item">ㅇ 참여방법 : 하단의 설문 시작 버튼을 클릭하여 총 19개의 문항에 답변을 마치면 응답 완료!</li>
	    	  	<li class="list-group-item">ㅇ 당첨자발표 : ${infoList.a_deploydate } 퓨전소프트 공지사항 게시판</li>
	    	  	<li class="list-group-item">※ 유의사항</br>
	    	  								- 당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.</br>
	    	  								- 1인 1회에 한하여 참여 가능합니다.</li>
	    	  	<li class="list-group-item">
			   	  	<button class="btn btn-lg btn-primary" onClick="location.href='${pageContext.request.contextPath}/analysisList.do?page=1&a_no=${infoList.a_no}'" style="width:200px;">설문 참여하기</button>
			   	  	<button class="btn btn-lg btn-danger" onClick="location.href='${pageContext.request.contextPath}/anal.do'" style="width:200px">이전으로 돌아가기</button>
	    	  	</li>
	    	  </ul>
		  	</div>
  		</div>
	</div>
  	<input type="hidden" id="no" value="${infoList.a_no }">
  	<div class="col-3"></div>
</div>
</body>
<script type="text/javascript">
var size = '${answerListSize}';
if(size >= 21) {
	var result = confirm('응답하신 설문이 있습니다. 설문조사를 수정하시겠습니까?');
	if(result) {
		alert('설문조사를 수정합니다. 주관식 값을 수정했을때는 반드시 저장을 눌러주십시오.');
	} else {
		alert('설문조사를 수정하지 않습니다. 이전 화면으로 돌아갑니다.');
		history.back();
	}
} else if(size < 21 && size > 0) {
	alert('진행중인 설문이 있습니다. 입장하셔서 계속 진행해 주십시오.');
} else if (size == 0) {
	alert('설문조사에 오신것을 환영합니다.');
}

</script>
</html>
