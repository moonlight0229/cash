<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart3</title>
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
		<h2>연간 수입 · 지출 막대 차트</h2>
		<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
		<div class="input-group mb-3">
			<input type="text" id="year" class="form-control" placeholder="년도를 입력하세요">
			<div class="input-group-append">
				<button id="inOutBarChartByYear" type="button" class="btn btn-success">
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
	// 해당년도 총 수입/지출 바 차트
	$('#inOutBarChartByYear').click(function() {
		$('.hiden').text('단위 : 원');
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/inOutBarChartByYear/'+$('#year').val(),
			type : 'get',
			success : function(data) {
				console.log(data);
				var barCtx = $('#barChart');
				var barChart = new Chart(barCtx, {
					type : 'bar',
					data : {
						labels:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
						datasets : [{
							label : $('#year').val()+'년 월별 수입',
							data:[
								data.inJanuary, data.inFebruary, data.inMarch, data.inApril, data.inMay, data.inJune,
								data.inJuly, data.inAugust, data.inSeptember, data.inOctober, data.inNovember, data.inDecember
							],
							backgroundColor: [
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF',
								'#0080FF'
							],
							borderColor: [
								'#0080FF'
							]}, {
							label : $('#year').val()+'년 월별 지출',
							data:[
								data.outJanuary, data.outFebruary, data.outMarch, data.outApril, data.outMay, data.outJune,
								data.outJuly, data.outAugust, data.outSeptember, data.outOctober, data.outNovember, data.outDecember
							],
							backgroundColor: [
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570',
								'#FF5570'
							],
							borderColor: [
								'#FF5570'
							]}
					]}
				});
			}
		});
	});
</script>
</html>