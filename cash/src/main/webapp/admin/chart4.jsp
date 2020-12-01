<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart4</title>
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
		<h2>연간 총 수입 · 지출 도넛 차트</h2>
		<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
		<div class="input-group mb-3">
			<input type="text" id="year" class="form-control" placeholder="년도를 입력하세요">
			<div class="input-group-append">
				<button type="button" id="inOutDoughnutChartByYear" class="btn btn-success">
					차트 보기
				</button>
			</div>
			<button type="button" id="resetButton" class="btn btn-success" onClick="window.location.reload()">리셋</button>
		</div>
		<div>
			<span class=hiden></span>
			<canvas id="doughnutChart"></canvas>
		</div>
	</div>
</body>
<script>
	// 해당년도 총 수입/지출 도넛 차트
	$('#inOutDoughnutChartByYear').click(function() {
		$('.hiden').text('단위 : 원');
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/inOutDoughnutChartByYear/'+$('#year').val(),
			type: 'get',
			success: function(data) {
				console.log(data);
				let doughnutCtx = $('#doughnutChart');
				let doughnutChart = new Chart(doughnutCtx, {
					type: 'doughnut',
					data: {
						labels: ['수입', '지출'],
						datasets:[{
							backgroundColor: ['#0080FF', '#FF5570'],
							borderColor: ['#0080FF', '#FF5570'],
							data: [data.수입, data.지출]
						}]
					}
				});
			}
		});
	});
</script>
</html>						