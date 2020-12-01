<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>noticeList</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
	<!-- 공지 -->
	<h3>공지사항</h3>
	<span>
		<i class="fas fa-edit"></i>
	</span>
	<a href="${pageContext.request.contextPath}/admin/addNotice">
		[글쓰기]
	</a>
		<div>
		<table border="1" width="100%" class="table table-bordered">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="n" items="${noticeList}">
					<tr>
						<td>${n.noticeId}</td>
						<td><a href="${pageContext.request.contextPath}/admin/noticeOne/${n.noticeId}">${n.noticeTitle}</a></td>
						<td>${n.noticeDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br>
	<div>
		<!-- 페이지 네비게이션 -->
		<ul class="pagination justify-content-center">
			<!-- 처음으로 버튼 -->
			<c:choose>
				<c:when test="${currentPage > 1}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList/1">[처음]</a>
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
						<a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList/${currentPage - 1}">[이전]</a>
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
								<a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList/${i}">[${i}]</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
				<!-- 다음 버튼 -->
			<c:choose>
				<c:when test="${currentPage < lastPage}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList/${currentPage + 1}">[다음]</a>
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
						<a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList/${lastPage}">[마지막]</a>
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
					${currentPage} / ${lastPage} 페이지
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>