<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addNotice</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- jQuery를 이용하여 유효성 검사 -->
	<script>
		$(document).ready(function() {
			$('#noticeTitle').focus();
			
			$('#addBtn').click(function(){
				let html = '<div><input type="file" name="noticeFile" class="noticeFile"></div>';
				$('#fileInput').append(html);
			});

			$('#delBtn').click(function(){
				$('#fileInput').children().last().remove();
			})
			
			$("#subBtn").click(function() {
				if ($("#noticeTitle").val() == "") {
					$("#noticeTitleMsg").text('');
					$('#noticeTitleMsg').text('제목을 입력하세요');
					$('#noticeTitle').focus();
					return;
				} else {
					$("#noticeTitleMsg").text('');
				}
				if ($("#noticeContent").val() == "") {
					$("#noticeContentMsg").text('');
					$('#noticeContentMsg').text('내용을 입력하세요');
					$('#noticeContent').focus();
					return;
				} else {
					$("#noticeContentMsg").text('');
				}
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
		table {
			text-align: center;
		}
		.msgDiv {
			color: #FF0000;
		}
	</style>
</head>
<body class="font">
	<header>
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	</header>
	<div class="container">
		<!-- 공지사항 작성 -->
		<h3>공지사항 작성</h3>
		<a href="${pageContext.request.contextPath}/admin/noticeList/1">
			[목록으로]
		</a>
		<form id="noticeForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/addNotice">
			<table border="1" width="100%" class="table table-bordered">
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="noticeTitle" id="noticeTitle" class="form-control">
						<div class="msgDiv" id="noticeTitleMsg"></div>
					</td>
				</tr>
				<tr>
					<td>첨부파일 등록</td>
					<td>
						<div>
							<button type="button" id="addBtn" class="btn btn-success">파일추가</button>
							<button type="button" id="delBtn" class="btn btn-danger">파일삭제</button>
						</div>
						<div id="fileInput">
						</div>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="noticeContent" id="noticeContent" class="form-control"></textarea>
						<div class="msgDiv" id="noticeContentMsg"></div>
					</td>
				</tr>
			</table>
			<button type="button" id="subBtn" class="btn btn-success">입력</button>
		</form>
	</div>
</body>
</html> 