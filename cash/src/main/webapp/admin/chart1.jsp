<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>연간 월별 수입</title>
		
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
			<h2 class="mb-3">연간 월별 수입</h2>
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
								<button type="button" id="inBarChartByYear" class="btn btn-outline-success">
									차트 보기
								</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<!-- 차트 표시 -->
			<div>
				<span class="hiden d-flex justify-content-end"></span>
				<canvas id="barChart"></canvas>
			</div>
		</div>
	</body>
	
	<script>
		// 해당년도 수입 바 차트
		$('#inBarChartByYear').click(function() {	
			$('.hiden').text('단위 : 원');
			$.ajax({
				url : '${pageContext.request.contextPath}/admin/inBarChartByYear/'+$('#year').val(),
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
								backgroundColor : '#FF8080',
								borderColor : '#FF8080',
							}, {
								label: '2월',
								data: [data.February],
								backgroundColor: '#FFc080',
								borderColor: '#FFc080',
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