<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
		
		<style>
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
			.centered {
				display: table;
				margin-left: auto;
				margin-right: auto;
			}
			.layer {
				position:absolute;
				top:0;right:0;bottom:0;left:0;
				display:flex;
				align-items:center;
				justify-content:center;
				  
				display:-webkit-flex;
				-webkit-align-items:center;
				-webkit-justify-content:center;
			}
			.font {
				font-family: 'Noto Sans KR', sans-serif;
			}
		</style>		
	</head>
	
	<body class="font">
		<!-- 최상단 네비바 -->
		<header>
			<nav class="navbar navbar-expand-sm bg-light navbar-light">
				<div class="container">
					<a class="navbar-brand font" href="${pageContext.request.contextPath}/admin/index">
						가계부 프로젝트		
					</a>
				</div>
			</nav>
		</header>
	
		<!-- 로그인 -->
		<div class="container">
			<!-- 로그인 -->
			<div class="centered">
				<h3>로그인</h3>
				
				<form action="${pageContext.request.contextPath}/login" method="post">
					<table class="table table-borderless">
						<tr>
							<td>
								<input type="text" class="form-control" name="id" placeholder="아이디" value="goodee">
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" class="form-control" name="pw" placeholder="비밀번호" value="1234">
							</td>
						</tr>
						<tr>
							<td>
								<button type="submit" class="btn btn-success btn-block centered">로그인</button>
							</td>
						<tr>
					</table>				
				</form>
			</div>
			<br>
			
			<!-- 공지사항 -->
			<div>
				<h3 class="mb-3">공지사항</h3>
				
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
		</div>
	</body>
</html>