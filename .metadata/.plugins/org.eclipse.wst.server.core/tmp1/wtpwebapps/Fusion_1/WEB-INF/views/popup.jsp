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
<title>${pop_title }</title>
</head>
<body>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<div class="row" style="margin-bottom: 40px">
				<div class="col-md-1"></div>
				<div class="col-md-10" style="text-align: center;"><h2>${pop_title }</h2></div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10" style="text-align: center;">
					<a href="http://${pop_url }" target="_blank">${pop_content }</a>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
					<div class="col-md-10" style="text-align: center;">
						<a href="http://${pop_url }" target="_blank"><img alt="이미지" src="${pop_imageurl }" style="width:${pop_width - 100};"></a>
					</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row" style="margin-top: 100px;">
				<div class="col-md-1"></div>
				<div class="col-md-10" style="text-align: center;">
					<button type="button" class="btn btn-danger" onClick="self.close();">닫기</button>
					<button type="button" class="btn btn-danger" onClick="closePopup();">오늘 하루 보지 않기</button>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
		<div class="col-md-1"></div>
	</div>
<script type="text/javascript">
function closePopup() {
	  var currentUserId = '${sessionScope.userid}';
	  setCookie(currentUserId + 'window', currentUserId, 1);
	  self.close();
}

function setCookie(cname, value, expire) {
	   var todayValue = new Date();
	   todayValue.setDate(todayValue.getDate() + expire);
	   document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
	}
</script>
</body>
</html>
</body>
</html>
