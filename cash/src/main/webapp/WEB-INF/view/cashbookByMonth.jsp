<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cashbookByMonth</title>
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
		th {
			width: ${100/7}%;
		}
		td {
			height: 80px;
			vertical-align: top;
		}
		.font {
			font-family: 'Noto Sans KR', sans-serif;
		}
	</style>
	<script type="text/javascript">
		jQuery(document).ready(function($) {
		    $(".clickable-row").click(function() {
		        window.location = $(this).data("href");
		    });
		});
	</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	</header>
	<div class="container font">
		<h4>
			${currentMonth}월 수입 :&nbsp;
			<span class="in">
				+ ${sumIn}원
			</span>
		</h4>
		<h4>
			${currentMonth}월 지출 :&nbsp;
			<span class="out">
				- ${sumOut}원
			</span>
		</h4>
		<h3>
			<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth-1}">
				<i class="fas fa-calendar-minus"></i>
			</a>
			${currentYear}년 ${currentMonth} 월
			<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth+1}">
				<i class="fas fa-calendar-plus"></i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/-1/-1">
				<i class="fas fa-calendar-day"></i>
			</a>
		</h3>
		
		<!-- 달력 -->
		<div>
			<table border="1" width="100%" class="table table-bordered">
				<thead>
					<tr>
						<th>
							<span class="sunday">일</span>
						</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>
							<span class="saturday">토</span>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="i" begin="1" end="${lastDay+(firstDayOfWeek-1)}" step="1">
							<c:if test="${i-(firstDayOfWeek-1) < 1}">
								<td>&nbsp;</td>
							</c:if>
							<c:if test="${i-(firstDayOfWeek-1) > 0}">
								<td class="clickable-row" data-href="${pageContext.request.contextPath}/admin/cashbookByDay/now/${currentYear}/${currentMonth}/${i-(firstDayOfWeek-1)}">
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
												<div class="out"></div>
											</c:if>
											<c:if test="${c.cashbookKind == '지출'}">
												<div class="in"></div>
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