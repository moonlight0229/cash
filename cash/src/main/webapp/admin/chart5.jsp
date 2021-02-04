<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>연간 월별 자산</title>
		
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
			<h2 class="mb-3">연간 월별 자산</h2>
		</div>
			
		<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
		
		<div class=container>	
			<table class="mt-3 mb-3" style="width:100%;">
				<tr>
					<td style="width:70%;">
						<div class="d-flex justify-content-start input-group">
							<button type="button" id="resetButton" class="btn btn-outline-success" onClick="window.location.reload()">
								리셋
							</button>
						</div>
					</td>
					<td style="width:30%;">
						<div class="d-flex justify-content-end input-group mb-3">
							<input type="text" id="year" class="form-control" placeholder="년도를 입력하세요" value="2019">				
							<div class="input-group-append">
								<button type="button" id="totalLineChartByYear" class="btn btn-outline-success">
									차트 보기
								</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<div>
				<span class="hiden d-flex justify-content-end"></span>
				<canvas id="lineChart"></canvas>
			</div>
		</div>
	</body>
	<script>
		// 해당연도 월별 자산현황 선 차트
		$('#totalLineChartByYear').click(function() {
			$('.hiden').text('단위 : 원');
			$.ajax({
				url : '${pageContext.request.contextPath}/admin/totalLineChartByYear/'+$('#year').val(),
				type : 'get',
				success : function(data) {
					console.log(data);
					var lineCtx = $('#lineChart');
					var lineChart = new Chart(lineCtx, {
						type : 'line',
						data : {
							labels:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
							datasets : [{
								label : $('#year').val()+'년 월별 수입',
								data:[
									data.inJanuary, data.inFebruary, data.inMarch, data.inApril, data.inMay, data.inJune,
									data.inJuly, data.inAugust, data.inSeptember, data.inOctober, data.inNovember, data.inDecember
								],
								borderColor: ['rgb(0, 128, 255)'],
								backgroundColor: ['rgba(0, 128, 255, 0.2)']
							}, {
								label : $('#year').val()+'년 월별 지출',
								data:[
									data.outJanuary, data.outFebruary, data.outMarch, data.outApril, data.outMay, data.outJune,
									data.outJuly, data.outAugust, data.outSeptember, data.outOctober, data.outNovember, data.outDecember
								],
								borderColor: ['rgb(255, 85, 112)'],
								backgroundColor: ['rgba(255, 85, 112, 0.2)']
							}, {
								label : $('#year').val()+'년 월별 자산',
								data:[
									data.totalJanuary, data.totalFebruary, data.totalMarch, data.totalApril, data.totalMay, data.totalJune,
									data.totalJuly, data.totalAugust, data.totalSeptember, data.totalOctober, data.totalNovember, data.totalDecember
								],
								borderColor: ['rgb(128, 255, 85)'],
								backgroundColor: ['rgba(128, 255, 85, 0.2)']
							}
						]}
					});
				}
			});
		});
	</script>
</html>