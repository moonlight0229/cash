<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인 페이지</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
			.font {
				font-family: 'Noto Sans KR', sans-serif;
			}
			.in {
				color: #0080FF;
			}
			.out {
				color: #FF5570;
			}
		</style>
	</head>
	
	<body class="font">
		<header>
			<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		</header>
		
		<div class="container">
			<!-- 수입 · 지출 -->
			<h3 class="mb-3">최근 3달간 수입 · 지출 내역</h3>
			
			<div>
				<table class="table table-borderless">
					<thead>
						<tr>
							<th>날짜</th>
							<th>수입</th>
							<th>지출</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="io" items="${inOutList}">
							<tr>
								<td>${io["날짜"]}</td> <!-- io.get("날짜")와 같은 표현 -->
								<td class="in">+${io["수입"]}원</td>
								<td class="out">-${io["지출"]}원</td>
								<td>${io["합계"]}원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 공지사항 -->
			<h3 class="mb-3">공지사항</h3>
			
			<div class="d-flex justify-content-end">
				<a class="btn btn-outline-primary mb-3" href="${pageContext.request.contextPath}/admin/noticeList/1">
					더보기
				</a>
			</div>
			
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>작성일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="n" items="${noticeList}">
							<tr>
								<td>${n.noticeId}</td>
								<td>${n.noticeTitle}</td>
								<td>${n.noticeDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>