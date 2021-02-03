<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내역 보기</title>
		
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
			<h2 class="mb-3">내역 보기</h2>
			
			<table class="table">
				<thead>
					<tr align="center">
						<th style="width:15%; vertical-align:middle;">
							일자
						</th>
						<th style="width:10%; vertical-align:middle;">
							수입/지출
						</th>
						<th style="width:20%; vertical-align:middle;">
							카테고리
						</th>
						<th style="width:15%; vertical-align:middle;">
							금액
						</th>
						<th style="width:40%; vertical-align:middle;">
							내용
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${cashbookList}">
						<tr align="center">
							<td>${c.cashbookDate}</td>
							<td>${c.cashbookKind}</td>
							<td>${c.categoryName}</td>
							<td>${c.cashbookPrice}</td>
							<td align="left">
								${c.cashbookContent}
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이지 네비게이션 바 -->
			<div class="d-flex justify-content-center">
				<ul class="pagination small">
					<%-- 처음 버튼 --%>
					<c:if test="${currentPage != 1}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/1">
								&lt;&lt;
							</a>
						</li>
					</c:if>
					<c:if test="${currentPage == 1}">
						<li class="page-item disabled">
							<a class="page-link">
								&lt;&lt;
							</a>
						</li>
					</c:if>
					
					<%-- 이전 버튼 --%>
					<c:if test="${pageNaviBegin != 1}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${pageNaviBegin-1}">
								&lt;
							</a>
						</li>
					</c:if>
					<c:if test="${pageNaviBegin == 1}">
						<li class="page-item disabled">
							<a class="page-link">
								&lt;
							</a>
						</li>
					</c:if>
					
					<%-- 각 페이지 이동 버튼 --%>
					<c:forEach var="p" begin="${pageNaviBegin}" end="${pageNaviEnd}" step="1">
						<c:if test="${p != currentPage}">
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${p}">
									${p}
								</a>
							</li>
						</c:if>
						<c:if test="${p == currentPage}">
							<li class="page-item active">
								<a class="page-link">
									${p}
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<%-- 다음 버튼 --%>
					<c:if test="${pageNaviEnd != lastPage}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${pageNaviEnd+1}">
								&gt;
							</a>
						</li>
					</c:if>
					<c:if test="${pageNaviEnd == lastPage}">
						<li class="page-item disabled">
							<a class="page-link">
								&gt;
							</a>
						</li>
					</c:if>
					
					<%-- 마지막 버튼 --%>
					<c:if test="${currentPage != lastPage}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/admin/cashbookList/${lastPage}">
								&gt;&gt;
							</a>
						</li>
					</c:if>
					<c:if test="${currentPage == lastPage}">
						<li class="page-item disabled">
							<a class="page-link">
								&gt;&gt;
							</a>
						</li>
					</c:if>
				</ul>
			</div>
			
			<div>
				<!-- 총 페이지 수 출력 -->
				<table style="margin: auto;">
					<tr>
						<td>
							<button type="button" class="btn btn-outline-primary btn-sm">
								${currentPage} / ${lastPage} 페이지
							</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>