<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 수정</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
		<script>
			$(document).ready(function(){
				$('#addBtn').click(function(){
					let html = '<div><input type="file" name="noticeFile" class="noticeFile"></div>';
					$('#fileInput').append(html);
				});
		
				$('#delBtn').click(function(){
					$('#fileInput').children().last().remove();
				})
		
				$('#subBtn').click(function(){
					let ck = true;
					$('.noticeFile').each(function(index, item){
						console.log($(item).val());
						if($(item).val() == '') {
							ck = false;
						}
					})
					if(ck == false) { // if(ck)
						alert('선택하지 않은 파일이 있습니다');
					} else {
						$('#noticeForm').submit();
					}
					
				});
			});
		</script>
		
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
			<!-- 공지사항 수정 -->
			<h2 class="mb-3">공지사항 수정</h2>
			
			<div class="d-flex justify-content-start mb-3">
				<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/noticeOne/${notice.noticeId}">
					상세보기
				</a>
			</div>
			
			<div>
				<form id="noticeForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/modifyNotice/${notice.noticeId}">
					<table border="1" width="100%" class="table table-bordered">
						<tr>
							<td>글번호</td>
							<td>
								<input type="text" name="noticeId" id="noticeId" class="form-control" value="${notice.noticeId}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td>
								<input type="text" name="noticeDate" id="noticeDate" class="form-control" value="${notice.noticeDate}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>수정일자</td>
							<td>
								<input type="text" name="noticeUpdateDate" id="noticeUpdateDate" class="form-control" value="${notice.noticeUpdateDate}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td>
								<input type="text" name="noticeTitle" id="noticeTitle" class="form-control" value="${notice.noticeTitle}">
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea name="noticeContent" id="noticeContent" class="form-control">${notice.noticeContent}</textarea>
							</td>
						</tr>
						<c:forEach var="bf" items="${board.boardfileList}">
							<tr>
								<td>첨부된 파일</td>
								<td>
									<a href="${pageContext.request.contextPath}/upload/${bf.boardfileName}">
										${bf.boardfileName}
									</a>
									<a href="${pageContext.request.contextPath}/removeBoardfileOne/${board.boardId}/${bf.boardfileId}">
										삭제
									</a>
									<br>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td>새로운 첨부파일 등록</td>
							<td>
								<div>
									<button type="button" id="addBtn" class="btn btn-outline-success">
										파일추가
									</button>
									<button type="button" id="delBtn" class="btn btn-outline-danger">
										파일삭제
									</button>
								</div>
								<div id="fileInput">
								</div>
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<button type="button" id="subBtn" class="btn btn-outline-success">
							수정
						</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>