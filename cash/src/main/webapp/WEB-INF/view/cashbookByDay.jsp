<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일별 내역</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<script src="https://use.fontawesome.com/releases/v5.10.2/js/all.js"></script>
		
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
			.in {
				color: #0080FF;
			}
			.out {
				color: #FF5570;
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
		
		<div class="container">
			<div class="d-flex justify-content-center">
				<table style="width:100%;">
					<tr>
						<td rowspan="2" style="width:30%"/>
						<td rowspan="2" style="width:5%; vertical-align:middle;" align="right">
							<h2>
								<a href="${pageContext.request.contextPath}/admin/cashbookByDay/pre/${currentYear}/${currentMonth}/${currentDay}">
									<i class="fas fa-calendar-minus"></i>
								</a>
							</h2>
						</td>
						<td rowspan="2" style="width:30%; vertical-align:middle;" align="center">
							<h1>
								${currentYear}년 ${currentMonth}월 ${currentDay}일
							</h1>
						</td>
						<td rowspan="2" style="width:5%; vertical-align:middle;" align="left">
							<h2>
								<a href="${pageContext.request.contextPath}/admin/cashbookByDay/next/${currentYear}/${currentMonth}/${currentDay}">
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
			
			<div class="d-flex justify-content-end mt-3 mb-3">
				<a class="btn btn-outline-success" href="${pageContext.request.contextPath}/admin/addCashbook/${currentYear}/${currentMonth}/${currentDay}">
					추가
				</a>
			</div>
			
			<table class="table">
				<thead>
					<tr align="center">
						<th style="width:10%; vertical-align:middle;">
							수입 · 지출
						</th>
						<th style="width:20%; vertical-align:middle;">
							카테고리
						</th>
						<th style="width:10%; vertical-align:middle;">
							금액
						</th>
						<th style="width:40%; vertical-align:middle;">
							내용
						</th>
						<th style="width:10%; vertical-align:middle;">
							수정
						</th>
						<th style="width:10%; vertical-align:middle;">
							삭제
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${cashbookList}">
						<c:if test="${cashbookList != null}">
							<tr align="center">
								<td style="vertical-align:middle;">
									${c.cashbookKind}
								</td>
								<td style="vertical-align:middle;">
									${c.categoryName}
								</td>
								<td style="vertical-align:middle;">
									${c.cashbookPrice}원
								</td>
								<td style="vertical-align:middle;" align="left">
									${c.cashbookContent}
								</td>
								<td style="vertical-align:middle;">
									<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/modifyCashbook/${c.cashbookId}">
										수정
									</a>
								</td>
								<td style="vertical-align:middle;">
									<a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/admin/removeCashbook/${c.cashbookId}">
										삭제
									</a>
								</td>
							</tr>
						</c:if>
					</c:forEach>
						<c:if test="${sumIn == 0 && sumOut == 0}">
							<tr>
								<td colspan="6">
									<div class="d-flex justify-content-center">
										수입 / 지출이 없습니다
									</div>
								</td>
							</tr>
						</c:if>
				</tbody>
			</table>
		</div>
	</body>
</html>