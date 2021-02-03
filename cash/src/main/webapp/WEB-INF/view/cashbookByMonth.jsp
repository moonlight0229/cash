<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>월별 내역</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<script src="https://use.fontawesome.com/releases/v5.10.2/js/all.js"></script>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
		
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
			.sunday {
				color: #FF0000;
			}
			.saturday {
				color: #0000FF;
			}
			.in {
				color: #0080FF;
			}
			.out {
				color: #FF5570;
			}
			.calth {
				width: ${100/7}%;
			}
			.caltd {
				height: 100px;
				vertical-align: top;
			}
			.font {
				font-family: 'Noto Sans KR', sans-serif;
			}
		</style>
		
		<script>
			jQuery(document).ready(function($) {
			    $(".clickable-row").click(function() {
			        window.location = $(this).data("href");
			    });
			});
		</script>
	</head>
	
	<body class="font">
		<header>
			<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		</header>
		
		<div class="container">
			<div class="d-flex justify-content-center">
				<table style="width:100%;">
					<tr>
						<td rowspan="2" style="width:30%"/>
						<td rowspan="2" style="width:5%; vertical-align:middle;" align="right">
							<h2>
								<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth-1}">
									<i class="fas fa-calendar-minus"></i>
								</a>
							</h2>
						</td>
						<td rowspan="2" style="width:30%; vertical-align:middle;" align="center">
							<h1>
								<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/-1/-1">
									${currentYear}년 ${currentMonth} 월
								</a>
							</h1>
						</td>
						<td rowspan="2" style="width:5%; vertical-align:middle;" align="left">
							<h2>
								<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth+1}">
									<i class="fas fa-calendar-plus"></i>
								</a>
							</h2>
						</td>
						<td style="width:10%; vertical-align:bottom;" align="right">
							<h4>총 수입&nbsp;:</h4>
						</td>
						<td style="width:20%; vertical-align:bottom;" align="right">
							<h4>
								<span class="in">
									+ ${sumIn}원
								</span>
							</h4>
						</td>
					</tr>
					<tr>
						<td style="width:10%; vertical-align:top;" align="right">
							<h4>총 지출&nbsp;:</h4>
						</td>
						<td style="width:20%; vertical-align:top;" align="right">
							<h4>
								<span class="out">
									- ${sumOut}원
								</span>
							</h4>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 달력 -->
			<div>
				<table class="table table-bordered mt-3">
					<thead>
						<tr>
							<th class="calth">
								<span class="sunday">일</span>
							</th>
							<th class="calth">월</th>
							<th class="calth">화</th>
							<th class="calth">수</th>
							<th class="calth">목</th>
							<th class="calth">금</th>
							<th class="calth">
								<span class="saturday">토</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:forEach var="i" begin="1" end="${lastDay+(firstDayOfWeek-1)}" step="1">
								<c:if test="${i-(firstDayOfWeek-1) < 1}">
									<td class="caltd">&nbsp;</td>
								</c:if>
								<c:if test="${i-(firstDayOfWeek-1) > 0}">
									<td class="clickable-row caltd" data-href="${pageContext.request.contextPath}/admin/cashbookByDay/now/${currentYear}/${currentMonth}/${i-(firstDayOfWeek-1)}">
										<div>
											${i-(firstDayOfWeek-1)}
										</div>
										<!-- 수입/지출 목록이 있는 날짜를 cashList에서 검색 -->
										<c:forEach var="c" items="${cashList}">
											<c:if test="${i-(firstDayOfWeek-1) == c.day}">
												<c:if test="${c.cashbookKind == '수입'}">
													<div class="in">
														+${c.cashbookPrice}
													</div>
												</c:if>
												<c:if test="${c.cashbookKind == '지출'}">
													<div class="out">
														-${c.cashbookPrice}
													</div>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</c:if>
								<c:if test="${i%7 == 0}">
									</tr><tr>
								</c:if>
							</c:forEach>
							
							<!-- 공백 출력 -->
							<c:if test="${(lastDay+(firstDayOfWeek - 1)) % 7 != 0}">
								<c:forEach begin="1" end="${7- ((lastDay+(firstDayOfWeek-1)) % 7)}" step="1">
									<td>&nbsp;</td>
								</c:forEach>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>