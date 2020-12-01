<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart6</title>
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
		<h2>연간 카테고리 별 지출 차트</h2>
		<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
		<div class="input-group mb-3">
			<input type="text" id="year" class="form-control" placeholder="년도를 입력하세요">
			<div class="input-group-append">
				<button type="button" id="inCategoryPolarAreaChartByYear" class="btn btn-success">
					차트 보기
				</button>
			</div>
			<button type="button" id="resetButton" class="btn btn-success" onClick="window.location.reload()">리셋</button>
		</div>
		<div>
			<span class=hiden></span>
			<canvas id="polarAreaChart"></canvas>
		</div>
	</div>
</body>
<script>
	// 해당년도 총 카테고리 별 지출 차트
	$('#inCategoryPolarAreaChartByYear').click(function() {
		$('.hiden').text('단위 : 원');
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/outCategoryChartByYear/'+$('#year').val(),
			type: 'get',
			success: function(data) {
				console.log(data);
				let polarAreaCtx = $('#polarAreaChart');
				let polarAreaChart = new Chart(polarAreaCtx, {
					type: 'polarArea',
					data: {
						labels: ['관광', '교육', '교통', '문화', '생활', '식비', '의료', '주거', '카페/간식', '통신', '편의점/마트/잡화'],
						datasets:[{
							backgroundColor: [
								'rgba(255, 128, 128, 0.5)',
								'rgba(255, 192, 128, 0.5)',
								'rgba(255, 255, 128, 0.5)',
								'rgba(192, 255, 128, 0.5)',
								'rgba(128, 255, 128, 0.5)',
								'rgba(128, 255, 192, 0.5)',
								'rgba(128, 255, 255, 0.5)',
								'rgba(128, 192, 255, 0.5)',
								'rgba(128, 128, 255, 0.5)',
								'rgba(192, 128, 255, 0.5)',
								'rgba(255, 128, 255, 0.5)',
							],
							borderColor: [
								'rgb(255, 128, 128)',
								'rgb(255, 192, 128)',
								'rgb(255, 255, 128)',
								'rgb(192, 255, 128)',
								'rgb(128, 255, 128)',
								'rgb(128, 255, 192)',
								'rgb(128, 255, 255)',
								'rgb(128, 192, 255)',
								'rgb(128, 128, 255)',
								'rgb(192, 128, 255)',
								'rgb(255, 128, 255)'
							],
							data: [
								data.관광,
								data.교육,
								data.교통,
								data.문화,
								data.생활,
								data.식비,
								data.의료,
								data.주거,
								data.카페,
								data.통신,
								data.편의점
							]
						}]
					}
				});
			}
		});
	});
</script>
</html>						