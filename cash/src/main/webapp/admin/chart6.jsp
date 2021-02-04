<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>연간 카테고리 별 수입</title>
		
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
			<h2 class="mb-3">연간 카테고리 별 수입</h2>
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
								<button type="button" id="inCategoryPolarAreaChartByYear" class="btn btn-outline-success">
									차트 보기
								</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<div>
				<span class="hiden d-flex justify-content-end"></span>
				<canvas id="polarAreaChart"></canvas>
			</div>
		</div>
	</body>
	
	<script>
		// 해당년도 총 카테고리 별 수입 차트
		$('#inCategoryPolarAreaChartByYear').click(function() {
			$('.hiden').text('단위 : 원');
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/inCategoryChartByYear/'+$('#year').val(),
				type: 'get',
				success: function(data) {
					console.log(data);
					let polarAreaCtx = $('#polarAreaChart');
					let polarAreaChart = new Chart(polarAreaCtx, {
						type: 'polarArea',
						data: {
							labels: ['금융이자', '급여'],
							datasets:[{
								backgroundColor: ['rgba(128, 192, 255, 0.5)', 'rgba(128, 128, 255, 0.5)'],
								borderColor: ['#80c0ff', '#8080ff'],
								data: [data.금융이자, data.급여, data.용돈]
							}]
						}
					});
				}
			});
		});
	</script>
</html>						