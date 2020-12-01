<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>noticeOne</title>
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
		<!-- 공지사항 내용 -->
		<h3>공지사항 상세보기</h3>
		<a href="${pageContext.request.contextPath}/admin/noticeList/1">[목록]</a>
		<a href="${pageContext.request.contextPath}/admin/modifyNotice/${notice.noticeId}">[수정]</a>
		<a href="${pageContext.request.contextPath}/admin/removeNotice/${notice.noticeId}">[삭제]</a>
		<div>
			<table border="1" width="100%" class="table table-bordered">
				<tr>
					<td width="10%">글번호</td>
					<td width="90%">${notice.noticeId}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${notice.noticeTitle}</td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td>${notice.noticeDate}</td>
				</tr>
				<tr>
					<td>수정일자</td>
					<td>${notice.noticeUpdateDate}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>${notice.noticeContent}</td>
				</tr>
			</table>
			
			<h3>첨부된 파일</h3>
			<table border="1">
				<c:forEach var="nf" items="${notice.noticeFileList}">
					<tr>				
						<td>
							<a href="${pageContext.request.contextPath}/upload/${nf.noticeFileName}">
								${nf.noticeFileName}
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			
			<h3>댓글</h3>
			<table border="1">
				<c:forEach var="comment" items="${notice.noticeCommentList}">
					<tr>
						<td>${comment.noticeCommentContent}</td>
						<td>${comment.noticeCommentDate}</td>
						<td>
							<a href="${pageContext.request.contextPath}/admin/removeNoticeComment/${noticeId}/${comment.noticeCommentId}">
								삭제
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<form action="${pageContext.request.contextPath}/admin/addNoticeComment/${noticeId}" method="post">
			<textarea id="noticeCommentContent" name="noticeCommentContent" rows="3" cols="50"></textarea>
			<button type="submit">댓글 입력</button>
		</form>
	</div>
</body>
</html>