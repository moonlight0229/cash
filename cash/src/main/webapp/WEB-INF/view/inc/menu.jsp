<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style type="text/css">
	.font {
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>

<nav class="navbar navbar-expand-sm bg-light navbar-light font">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/index">
			가계부 프로젝트		
		</a>

		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/index">홈으로</a>
			</li>
			<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/admin/cashbookByMonth/-1/-1">달력 보기</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/cashbookList/1">내역 보기</a>
			</li>
			<li class="nav-item">	
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/chart1.jsp">차트 보기</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/noticeList/1">공지사항</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/addMember">사용자 추가</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/logout"><font color="red">로그아웃</font></a>
			</li>
		</ul>
	</div>
</nav>
<br>