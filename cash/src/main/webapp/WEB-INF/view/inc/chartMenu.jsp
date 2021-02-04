<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style type="text/css">
	.font {
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>

<div class="container font">
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart1.jsp">
		연간 월별 수입
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart2.jsp">
		연간 월별 지출
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart3.jsp">
		연간 월별 수입·지출
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart4.jsp">
		연간 총 수입·지출
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart5.jsp">
		연간 월별 자산
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart6.jsp">
		연간 카테고리 별 수입
	</a>
	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/chart7.jsp">
		연간 카테고리 별 지출
	</a>
</div>