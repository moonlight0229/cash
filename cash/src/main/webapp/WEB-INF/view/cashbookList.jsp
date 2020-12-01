<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashbookList</title>
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
<div class="container">
	<h2>내역 보기</h2>
	<a href="${pageContext.request.contextPath}/admin/cashbookListExcel">[전체 내역을 엑셀 파일로 다운로드]</a>
	<table class="table">
		<thead>
			<tr>
				<th>일자</th>
				<th>수입/지출</th>
				<th>카테고리</th>
				<th>금액</th>
				<th>내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="c" items="${cashbookList}">
				<tr>
					<td>${c.cashbookDate}</td>
					<td>${c.cashbookKind}</td>
					<td>${c.categoryName}</td>
					<td>${c.cashbookPrice}</td>
					<td>${c.cashbookContent}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<!-- 페이지 네비게이션 -->
		<ul class="pagination justify-content-center">
			<!-- 처음으로 버튼 -->
			<c:choose>
				<c:when test="${currentPage > 1}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/1">[처음]</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#">[처음]</a>
					</li>
				</c:otherwise>
			</c:choose>
				<!-- 이전 버튼 -->
			<c:choose>
				<c:when test="${currentPage > 1}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${currentPage - 1}">[이전]</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#">[이전]</a>
					</li>
				</c:otherwise>
			</c:choose>
				<!-- 현재 페이지 표시 -->
			<c:forEach var="i" begin="${navFirstPage}" end="${navLastPage}">
				<c:if test="${i <= lastPage}">
					<c:choose>
						<%-- 현재 페이지 --%>
						<c:when test="${i == currentPage}">
							<li class="page-item disabled">
								<a class="page-link" href="#">[${i}]</a>
							</li>
						</c:when>
						<%-- 현재 페이지가 아닌 선택 가능한 페이지 --%>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${i}">[${i}]</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
				<!-- 다음 버튼 -->
			<c:choose>
				<c:when test="${currentPage < lastPage}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${currentPage + 1}">[다음]</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#">[다음]</a>
					</li>
				</c:otherwise>
			</c:choose>
				<!-- 마지막으로 버튼 -->
			<c:choose>
				<c:when test="${currentPage < lastPage}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${lastPage}">[마지막]</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#">[마지막]</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
		<br>
		<div>
		<!-- 총 페이지 수 출력 -->
		<table style="margin: auto;">
			<tr>
				<td>
					<button type="button" class="btn btn-outline-dark btn-sm">
						${currentPage} / ${lastPage} 페이지
					</button>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>