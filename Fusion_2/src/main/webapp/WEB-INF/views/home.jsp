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
<script
	src="https://www.gstatic.com/charts/loader.js"></script>

<html>
<head>
<title>구글 차트를 이용</title>
<style type="text/css">
	h2.headerText {
		text-align : center;
	}
</style>
</head>
<body>
<div class="container">
  <div class="row">
    <div class="col">
    </div>
    <div class="col-8">
    	<h2 class="headerText">Dialogue System Chart</h2>
	    <div id="columnchart_material" onkeypress="onlyNumber();" style="width: 800px; height: 500px;"></div>
	    Dialogue Name:<br>
	    <input id="sendDialogue" type="text" class="form-control"><br>
	    Send:<br>
	    <input id="sendInput" onkeypress="onlyNumber();" type="number" class="form-control"><br>
	    Response:<br>
	    <input id="responseInput" type="number" class="form-control"><br><br>
	    <button type="button" class="btn btn-primary" onclick="addData();">Add</button> 
	    <button type="button" class="btn btn-danger" onclick="removeData();">Remove</button>
    </div>
    <div class="col">
    </div>
  </div>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);
	  
	  var count = 1;
	  var data;
	  var chart;
      var options;
	  
      function drawChart() {
	  data = new google.visualization.DataTable();
	  data.addColumn('string', 'Dialogue');
	  data.addColumn('number', 'Send');
	  data.addColumn('number', 'Response');
	  data.addRow(['Dialogue 1', 100, 100]);
	  
        options = {
          chart: {
            title: '',
            subtitle: '',
          }
        };

        chart = new google.charts.Bar(document.getElementById('columnchart_material'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
      
      function addData(){
	    count++;
		data.addRow([String(document.getElementById('sendDialogue').value), Number(document.getElementById('sendInput').value), Number(document.getElementById('responseInput').value)]);
		chart.draw(data, options)
		document.getElementById('sendDialogue').value = '';
		document.getElementById('sendInput').value = '';
		document.getElementById('responseInput').value = '';
      }
      
      function removeData(){
		data.removeRow(data.getNumberOfRows() - 1);
		chart.draw(data, options)
      }
      
      function onlyNumber() {
    	  if(event.keyCode < 48 || event.keyCode > 57)
    		  event.returnValue = false;
      }
    </script>
  </body>
</html>