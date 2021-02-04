<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 보기</title>
		
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
			<h2 class="mb-3">공지사항 상세보기</h2>
			
			<table class="mb-3" style="width:100%;">
				<tr>
					<td style="width:30%; vertical-align:middle;" align="left">
						<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/noticeList/1">
							목록으로
						</a>
					</td>
					<td style="width:30%; vertical-align:middle;" align="right">
						<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/modifyNotice/${notice.noticeId}">
							수정
						</a>
						<a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/admin/removeNotice/${notice.noticeId}">
							삭제
						</a>
					</td>
				</tr>
			</table>
			
			<div>
				<table class="table">
					<tr>
						<td>No.</td>
						<td>${notice.noticeId}</td>
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
				
				<h4>첨부된 파일</h4>
				
				<table class="table">
					<c:forEach var="nf" items="${notice.noticeFileList}">
						<c:if test="${nf.noticeFileName != null}">
							<tr>				
								<td>
									<a href="${pageContext.request.contextPath}/upload/${nf.noticeFileName}">
										${nf.noticeFileName}
									</a>
								</td>
							</tr>
						</c:if>
						<c:if test="${nf.noticeFileName == null}">
							<tr>				
								<td>
									첨부된 파일이 없습니다
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
				
				<h4>댓글</h4>
				
				<table class="table">
					<c:forEach var="comment" items="${notice.noticeCommentList}">
						<tr>
							<td style="vertical-align:middle;">
								${comment.noticeCommentContent}
							</td>
							<td style="vertical-align:middle;">
								${comment.noticeCommentDate}
							</td>
							<td style="vertical-align:middle;" align="center">
								<a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/admin/removeNoticeComment/${noticeId}/${comment.noticeCommentId}">
									삭제
								</a>
							</td>
						</tr>
					</c:forEach>
				</table>
				<form action="${pageContext.request.contextPath}/admin/addNoticeComment/${noticeId}" method="post">
					<textarea id="noticeCommentContent" name="noticeCommentContent" class="form-control" rows="3" cols="50"></textarea>
					
					<div class="d-flex justify-content-end">
						<button type="submit" class="btn btn-outline-success mt-3">
							댓글입력
						</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>