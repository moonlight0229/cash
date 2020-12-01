<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>chart2</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style type="text/css">
		html {
		    overflow-y: scroll;
		}
		body {
			padding-top: 80px;
		}
		header {
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			
			height: 80px;
			justify-content: space-between;
			align-items: center;
		}
		.font {
			font-family: 'Noto Sans KR', sans-serif;
		}
	</style>
</head>
<body class="font">
<header>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
</header>
	<div class=container>
		<h2>연간 지출 막대 차트</h2>
		<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
		<div class="input-group mb-3">
			<input type="text" id="year" class="form-control" placeholder="년도를 입력하세요">
			<div class="input-group-append">
				<button type="button" id="outBarChartByYear" class="btn btn-success">
					차트 보기
				</button>
			</div>
			<button type="button" id="resetButton" class="btn btn-success" onClick="window.location.reload()">리셋</button>
		</div>
		<div>
			<span class=hiden></span>
			<canvas id="barChart"></canvas>
		</div>
	</div>
</body>
<script>
	// 해당년도 지출 바 차트
	$('#outBarChartByYear').click(function() {
		$('.hiden').text('단위 : 원');
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/outBarChartByYear/'+$('#year').val(),
			type : 'get',
			success : function(data) {
				console.log(data);
				var barCtx = $('#barChart');
				var barChart = new Chart(barCtx, {
					type : 'bar',
					data : {
						labels : [$('#year').val()+'년'],
						datasets : [{
							label : '1월',
							data : [data.January],
							backgroundColor : '#ff8080',
							borderColor : '#ff8080',
						}, {
							label: '2월',
							data: [data.February],
							backgroundColor: '#ffc080',
							borderColor: '#ffc080',
						}, {
							label: '3월',
							data: [data.March],
							backgroundColor: '#ffff80',
							borderColor: '#ffff80',
						}, {
							label: '4월',
							data: [data.April],
							backgroundColor: '#c0ff80',
							borderColor: '#c0ff80',
						}, {
							label: '5월',
							data: [data.May],
							backgroundColor: '#80ff80',
							borderColor: '#80ff80',
						}, {
							label: '6월',
							data: [data.June],
							backgroundColor: '#80ffc0',
							borderColor: '#80ffc0',
						}, {
							label: '7월',
							data: [data.July],
							backgroundColor: '#80ffff',
							borderColor: '#80ffff',
						}, {
							label: '8월',
							data: [data.August],
							backgroundColor: '#80c0ff',
							borderColor: '#80c0ff',
						}, {
							label: '9월',
							data: [data.September],
							backgroundColor: '#8080ff',
							borderColor: '#8080ff',
						}, {
							label: '10월',
							data: [data.October],
							backgroundColor: '#c080ff',
							borderColor: '#c080ff',
						}, {
							label: '11월',
							data: [data.November],
							backgroundColor: '#ff80ff',
							borderColor: '#ff80ff',
						}, {
							label: '12월',
							data: [data.December],
							backgroundColor: '#ff80c0',
							borderColor: '#ff80c0',
						}]
					}
				});
			}
		});
	});
</script>
</html>						