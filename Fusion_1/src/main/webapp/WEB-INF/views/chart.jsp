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

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/printThis/1.15.0/printThis.js"></script>
<!-- <script src="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script> -->
<script src="resources/chart/Chart.bundle.js"></script>
<script src="resources/chart/Chart.bundle.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!DOCTYPE html>
<html>
<head>
<title>WebBoard - 통계 페이지</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#logTable').DataTable();
	} );
</script>
	<div class="row">
		<div class="col-3"></div>
		<div class="jumbotron" style="text-align:center;">
			  <h2 class="display-4"><strong>통계 페이지입니다.</strong></h2>
 				 <p class="lead">접속자별 통계, 접속자별 브라우저 통계, 접속자별 운영체제 통계, 접속 시간별 그래프를 조회할 수 있습니다.</p>
  				 <a class="btn btn-danger btn-lg" href="${pageContext.request.contextPath }/boardList.do?page_no=1&pageSize=10" role="button">돌아가기</a>
  				 <a class="btn btn-dark btn-lg" href="${pageContext.request.contextPath }/logExcelDownload.do?fromDate=${param.fromDate}&toDate=${param.toDate}" role="button">엑셀 다운로드</a>
  				 <button type="button" class="btn btn-warning btn-lg" id="printing">데이터 테이블 인쇄</button>
		</div>
		<div class="col-3"></div>
	</div>
	<div class="row">
		<div class="col-3"></div>
		<div class="col">
			<form action="${pageContext.request.contextPath }/Chart.do" method="get">
				<input type="text" name="fromDate" id="fromDate" placeholder="날짜를 선택해주세요" readonly="readonly" required>
				<input type="text" name="toDate" id="toDate" placeholder="날짜를 선택해주세요" readonly="readonly" required>
				<input type="submit" class="btn btn-primary" value="조회"/>
				<input type="reset" class="btn btn-info" value="초기화">
			</form>
		</div>
		<p>
			<button class="btn btn-warning" type="button" onclick="todayButton();">오늘</button>
			<button class="btn btn-warning" type="button" onclick="yesterdayButton();">어제</button>
			<button class="btn btn-warning" type="button" onclick="lastWeekButton();">최근 일주일</button>
			<button class="btn btn-warning" type="button" onclick="lastMonthButton();">최근 한달</button>
			<button class="btn btn-warning" type="button" onclick="lastYearButton();">최근 일년</button>
		</p>
		<div class="col-3"></div>
	</div>
	<div class="row">
		<div class="col-sm"></div>
		<p style="margin-left:1rem">
		<button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseTable" aria-expanded="true" aria-controls="collapseTable">
   			데이터 테이블
		</button>
		<button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseDate" aria-expanded="false" aria-controls="collapseDate">
    		날짜별 접속자 수
		</button>
		<button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseTotal" aria-expanded="false" aria-controls="collapseTotal">
    		날짜별 시간대 접속자 수
		</button>
		<button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseWeek" aria-expanded="false" aria-controls="collapseWeek">
    		요일별 접속자 수
		</button>
		<button class="btn btn-success" type="button" data-toggle="collapse" data-target="#collapseUser" aria-expanded="false" aria-controls="collapseUser">
    		유저별 그래프
		</button>
		<button class="btn btn-success" type="button" data-toggle="collapse" data-target="#collapseOS" aria-expanded="false" aria-controls="collapseOS">
    		운영체제별 그래프
		</button>
		<button class="btn btn-success" type="button" data-toggle="collapse" data-target="#collapseBrowser" aria-expanded="false" aria-controls="collapseBrowser">
    		브라우저별 그래프
		</button>
		<button class="btn btn-success" type="button" data-toggle="collapse" data-target="#collapseRefer" aria-expanded="false" aria-controls="collapseRefer">
    		접속경로별 그래프
		</button>
		</p>
		<div class="col-sm"> </div>
	</div>
	<div class="row">
	</div>
	<div class="row">
		<div class="col-8" style="margin-left:10px">
			<div class="collapse show" id="collapseTable">
			<h5 style="text-align:center;">조건에 따른 데이터 테이블</h5>
			<table id="logTable" class="display" style="width:100%; margin-left:20px;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">No</th>
						<th scope="col">ID</th>
						<th scope="col">Date</th>
						<th scope="col">IP</th>
						<th scope="col">Browser</th>
						<th scope="col">Browser Ver.</th>
						<th scope="col">OS</th>
						<th scope="col">Refer</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="log" items="${logList }" varStatus="status">
						<tr>
							<th scope="row">${status.index + 1 }</th>
							<td><strong>${log.log_userid }</strong></td>
							<td>${log.log_date }</td>
							<td>${log.log_userip }</td>
							<td><strong>${log.log_userbrowser }</strong></td>
							<td>${log.log_bversion }</td>
							<td><strong>${log.log_osversion }</strong></td>
							<td>${log.log_userreferrer }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
			<div class="collapse show" id="collapseDate">
				<h5 style="text-align: center;">날짜별 접속자 수</h5>
				<canvas id="logTimeTotalChart" style="width: 700px; height: 300px;"></canvas>
			</div>
			<div class="collapse show" id="collapseTotal">
			<script>
				$('#fromDate').datepicker({
					dateFormat: 'yy-mm-dd',
					changeYear: true,
					changeMonth: true,
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
				});
				
				$('#toDate').datepicker({
					dateFormat: 'yy-mm-dd',
					changeYear: true,
					changeMonth: true,
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
				});
			</script>
			<h5 style="text-align: center;"> 해당 날짜 시간별 접속자 수</h5>
			<canvas id="logTimeChart" style="width: 700px; height: 300px;"></canvas>
			</div>
			<div class="collapse show" id="collapseWeek">
				<h5 style="text-align:center;">요일별 접속자 수</h5>
				<canvas id="logWeekChart" style="width: 700px; height: 300px;"></canvas>
			</div>
		</div>
		<div class="col-3">
			<div class="collapse show" id="collapseUser">
  				<div class="card card-body">
					<h5 style="text-align: center;">유저별 그래프</h5>
					<canvas id="logNameChart" style="width: 600px; height: 400px;"></canvas>
  				</div>
			</div>
			<div class="collapse show" id="collapseOS">
  				<div class="card card-body">
					<h5 style="text-align: center;">운영체제별 그래프</h5>
					<canvas id="logOSChart" style="width: 600px; height: 400px;"></canvas>
  				</div>
			</div>
			<div class="collapse show" id="collapseBrowser">
  				<div class="card card-body">
					<h5 style="text-align: center;">브라우저별 그래프</h5>
					<canvas id="logBrowserChart" style="width: 600px; height: 400px;"></canvas>
  				</div>
			</div>
			<div class="collapse show" id="collapseRefer">
  				<div class="card card-body">
					<h5 style="text-align: center;">접속경로별 그래프</h5>
					<canvas id="logReferChart" style="width: 600px; height: 400px;"></canvas>
  				</div>
			</div>
			<div class="row">
			
			</div>
			<div class="row">
			
			</div>
		</div>
	</div>
	<script>
		function goPrint(title) {
			var sw = screen.width;
			var sh = screen.height;
			var weight = 1050;
			var height = 750;
			var xpos = (sw-weight)/2;
			var ypos = (sh-height)/2;
			
			var pHeader = "<html><head><link rel='stylesheet' type='text/css'><title>" + title + "</title></head><body>";
			var pgetContent = document.getElementById('logTable').innerHTML + '<br>';
			var pFooter = "</body></html>";
			
			var pContent = pHeader + pgetContent + pFooter;
			
			var pWin = window.open("", "print", "width=" + weight + ", height=" + height + ", top=" + ypos + ",left=" + xpos + ", status=yes, scrollbars=yes");
			pWin.document.open();
			pWin.document.write(pContent);
			pWin.document.close();
			pWin.print();
			pWin.close();
		}
	
		function logDelete(log_no) {
			$.ajax({
				type : "POST",
				url : "/logDelete.do",
				data : {"log_no" : log_no},
				dataType : "json",
				success : function(result) {
					alert('삭제가 완료되었습니다.');
					location.reload();
				},
				error : function(error) {
					alert('에러 발생');
				}
			});
		}
		
		function colorize() {
			var r = Math.floor(Math.random()*200);
			var g = Math.floor(Math.random()*200);
			var b = Math.floor(Math.random()*200);
			var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
			return color;
		}
		
		/* 이름별 리스트 정리 시작 */
		var jsonData = ${json}
		var jsonObject = JSON.stringify(jsonData);
		var jData = JSON.parse(jsonObject);
		
		var labelList = new Array();
		var valueList = new Array();
		var colorList = new Array();
		
		for(var i = 0; i<jData.length; i++) {
			var d = jData[i];
			labelList.push(d.ID);
			valueList.push(d.Count);
			colorList.push(colorize());
		}
		
		
		var data = {
						labels: labelList,
						datasets: [{
								backgroundColor: colorList,
								data : valueList
						}],
						options : {
								title : {
									display : true,
									text: '유저별 접속 횟수'
								}
						}
		};
		
		var ctx1 = document.getElementById('logNameChart').getContext('2d');
		new Chart(ctx1, {
			type: 'pie',
			data: data
		});
		/* 이름별 리스트 정리 끝 */
		
		
		/* OS별 리스트 정리 시작 */
		var jsonDataOS = ${jsonOS};
		var jsonObjectOS = JSON.stringify(jsonDataOS);
		var jDataOS = JSON.parse(jsonObjectOS);
		
		var labelListOS = new Array();
		var valueListOS = new Array();
		var colorListOS = new Array();
		
		for(var i = 0; i<jDataOS.length; i++) {
			var o = jDataOS[i];
			labelListOS.push(o.OS);
			valueListOS.push(o.Count);
			colorListOS.push(colorize());
		}
		
		var data2 = {
						labels : labelListOS,
						datasets: [{
							backgroundColor : colorListOS,
							data : valueListOS
						}],
						options : {
							title : {
								display : true,
								text : '운영체제별 접속 횟수'
							}
						}
		};
		
		var ctx2 = document.getElementById('logOSChart').getContext('2d');
		new Chart(ctx2, {
			type:'pie',
			data : data2
		})
		/* OS별 리스트 끝 */
		
		/* 브라우저별 리스트 시작 */
		var jsonDataBrowser = ${jsonBrowser};
		var jsonObjectBrowser = JSON.stringify(jsonDataBrowser);
		var jDataBrowser = JSON.parse(jsonObjectBrowser);
		
		var labelListBrowser = new Array();
		var valueListBrowser = new Array();
		var colorListBrowser = new Array();
		
		for(var i = 0; i<jDataBrowser.length; i++) {
			var b = jDataBrowser[i];
			labelListBrowser.push(b.Browser);
			valueListBrowser.push(b.Count);
			colorListBrowser.push(colorize());
		}
		
		var data3 = {
						labels : labelListBrowser,
						datasets: [{
							label : '접속 횟수',							
							backgroundColor : colorListBrowser,
							data : valueListBrowser
						}],
						options : {
							title : {
								display : true,
								text : '운영체제별 접속 횟수'
							}
						}
		};
		
		var ctx3 = document.getElementById('logBrowserChart').getContext('2d');
		new Chart(ctx3, {
			type:'pie',
			data : data3
		})
		/* 브라우저별 리스트 끝 */
		
		/* 시간별 리스트 시작 */
		var jsonDataTime = ${jsonTime};
		var jsonObjectTime = JSON.stringify(jsonDataTime);
		var jDataTime = JSON.parse(jsonObjectTime);
		
		var labelListTime = new Array();
		var valueListTime = new Array();
		var colorListTime = new Array();
		
		for(var i = 0; i<jDataTime.length; i++) {
			var t = jDataTime[i];
			labelListTime.push(t.DateTime);
			valueListTime.push(t.Count);
			colorListTime.push(colorize());
		}
		
		var data4 = {
						labels : labelListTime,
						datasets: [{
							label : '시간대별 접속자 수',
							data : valueListTime,
							backgroundColor: colorListTime
						}]
		};
		
		var ctx4 = document.getElementById('logTimeChart').getContext('2d');
		new Chart(ctx4, {
			type : 'bar',
			data : data4,
			options: {
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero : true
						}
					}]
				}
			}
		})
		/* 시간별 리스트 끝 */
		
		/* 토탈 타임 리스트 시작 */
		var jsonDataDate = ${jsonDate};
		var jsonObjectDate = JSON.stringify(jsonDataDate);
		var jDataDate = JSON.parse(jsonObjectDate);
		
		var labelListDate = new Array();
		var valueListDate = new Array();
		
		for(var i = 0; i<jDataDate.length; i++) {
			var date = jDataDate[i];
			labelListDate.push(date.Date);
			valueListDate.push(date.Count);
		}
		
		var data5 = {
						labels : labelListDate,
						datasets : [{
							label : '날짜별 접속자 수',
							data : valueListDate,
							borderColor: 'rgba(155, 14, 255, 1)',
							backgroundColor : 'rgba(155, 14, 255, 0.5)',
							fill : true,
							lineTension : 0
						}]
		};
		
		var dateOptions = {
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString : '날짜'
						}
					}],
					yAxes: [{
						display: true,
						ticks: {
							suggestedMin: 0,
						},
						scaleLabel:{
							display : true,
							labelString: '횟수'
						}
					}]
				}
		}
		
		var ctx5 = document.getElementById('logTimeTotalChart').getContext('2d');
		new Chart(ctx5, {
			type: 'line',
			data: data5,
			options: dateOptions
		})
		/* 토탈 타임 리스트 끝 */
		
		/* 접속 경로별 시작 */
		var jsonDataRefer = ${jsonRefer};
		var jsonObjectRefer = JSON.stringify(jsonDataRefer);
		var jDataRefer = JSON.parse(jsonObjectRefer);
		
		var labelListRefer = new Array();
		var valueListRefer = new Array();
		var colorListRefer = new Array();
		
		for(var i = 0; i<jDataRefer.length; i++) {
			var r = jDataRefer[i];
			labelListRefer.push(r.Refer);
			valueListRefer.push(r.Count);
			colorListRefer.push(colorize());
		}
		
		var data6 = {
						labels : labelListRefer,
						datasets: [{
							label : '접속 횟수',							
							backgroundColor : colorListRefer,
							data : valueListRefer
						}],
						options : {
							title : {
								display : true,
								text : '접속 경로별 접속 횟수'
							}
						}
		};
		
		var ctx6 = document.getElementById('logReferChart').getContext('2d');
		new Chart(ctx6, {
			type:'pie',
			data : data6
		})
		/* 접속 경로 로직 끝 */
		
		/* 요일별 접속 로그 시작 */
		var jsonDataWeek = ${jsonWeek};
		var jsonObjectWeek = JSON.stringify(jsonDataWeek);
		var jDataWeek = JSON.parse(jsonObjectWeek);
		
		var labelListWeek = new Array();
		var valueListWeek = new Array();
		var colorListWeek = new Array();
		
		for(var i = 0; i<jDataWeek.length; i++) {
			var w = jDataWeek[i];
			labelListWeek.push(w.WeekOfDays);
			valueListWeek.push(w.Count);
			colorListWeek.push(colorize());
		}
		
		var data7 = {
						labels : labelListWeek,
						datasets: [{
							label : '요일별 접속자 수',
							data : valueListWeek,
							backgroundColor: colorListWeek
						}]
		};
		
		var ctx7 = document.getElementById('logWeekChart').getContext('2d');
		new Chart(ctx7, {
			type : 'bar',
			data : data7,
			options: {
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero : true
						}
					}]
				}
			}
		})
		/* 요일별 접속 로그 끝 */
		
		// 동적 버튼 생성
		function getDateString(date) {
			return (date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate());
		}
		
		function today() {
			var d = new Date();
			return getDateString(d);
		}
		
		function todayButton() {
			$('#fromDate').val(today());
			$('#toDate').val(today());
		}
		
		function yesterday() {
			var d = new Date();
			var yesterday = d.getTime() - (1*24*60*60*1000);
			d.setTime(yesterday);
			return getDateString(d);
		}
		
		function lastweek() {
			var d = new Date();
			var dayOfMonth = d.getDate();
			d.setDate(dayOfMonth - 7);
			return getDateString(d);
		}
		
		function lastMonth() {
			var d = new Date();
			var monthOfYear = d.getMonth();
			d.setMonth(monthOfYear - 1);
			return getDateString(d);
		}
		
		function lastYear() {
			var y = new Date();
			var year = y.getFullYear();
			y.setFullYear(year - 1);
			return getDateString(y);
		}
		
		function yesterdayButton() {
			$('#fromDate').val(yesterday());
			$('#toDate').val(yesterday());
		}
		
		function lastWeekButton() {
			$('#fromDate').val(lastweek());
			$('#toDate').val(today());
		}
		
		function lastMonthButton() {
			$('#fromDate').val(lastMonth());
			$('#toDate').val(today());
		}
		
		function lastYearButton() {
			$('#fromDate').val(lastYear());
			$('#toDate').val(today());
		}
		
		$('#printing').click(function() {
			$('#logTable').printThis();
		})
		</script>
</body>
</html>