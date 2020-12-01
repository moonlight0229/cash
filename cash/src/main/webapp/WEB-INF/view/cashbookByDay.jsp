<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cashbookByDay</title>
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
	</style>
</head>
<body class="font">
<header>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
</header>
	<div class="container">
		<h3>일별 내역보기</h3>
		<div>
			<a href="${pageContext.request.contextPath}/admin/cashbookByDay/pre/${currentYear}/${currentMonth}/${currentDay}">
				<i class="fas fa-calendar-minus"></i>
			</a>
			${currentYear}년 ${currentMonth}월 ${currentDay}일
			<a href="${pageContext.request.contextPath}/admin/cashbookByDay/next/${currentYear}/${currentMonth}/${currentDay}">
				<i class="fas fa-calendar-plus"></i>
			</a>
		</div>
		
		<c:forEach var="c" items="${cashList}">
				<c:if test="${c.cashbookKind == '수입'}">
					<div class="in">+ ${c.cashbookPrice}원</div>
				</c:if>
				<c:if test="${c.cashbookKind == '지출'}">
					<div class="out">- ${c.cashbookPrice}원</div>
				</c:if>
		</c:forEach>
		
		<a href="${pageContext.request.contextPath}/admin/addCashbook/${currentYear}/${currentMonth}/${currentDay}">
				[수입 · 지출 추가]
		</a>
	
		<table border="1" class="table">
			<thead>
				<tr>
					<th>수입 · 지출</th>
					<th>수입 · 지출 카테고리</th>
					<th>수입 · 지출 금액</th>
					<th>수입 · 지출 내용</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="c" items="${cashbookList}">
					<tr>
						<td>${c.cashbookKind}</td>
						<td>${c.categoryName}</td>
						<td>${c.cashbookPrice}원</td>
						<td>${c.cashbookContent}</td>
						<td>
							<a href="${pageContext.request.contextPath}/admin/modifyCashbook/${c.cashbookId}">수정</a>
						</td>
						<td>
							<a href="${pageContext.request.contextPath}/admin/removeCashbook/${c.cashbookId}">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>