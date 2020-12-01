<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyCashbook</title>
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
	<!-- 수입/지출 내역 수정 -->
	<h3>수입 · 지출 내역 수정</h3>
	<div>
		<form method="post" action="${pageContext.request.contextPath}/admin/modifyCashbook/{cashbook.cashbookId}" id="cashbookForm">
			<div>
				<input style="display:none" type="text" name="cashbookId" value="${cashbook.cashbookId}" readonly="readonly">
			</div>
			<table border="1" class="table table-bordered">
				<tr>
					<td>수입 · 지출 일자</td>
					<td>
						<input type="text" name="cashbookDate" class="form-control" value="${cashbook.cashbookDate}" readonly="readonly">
						<span id="dateCk"></span>
					</td>
				</tr>
				<tr>
					<td>수입 · 지출</td>
					<td>
						<c:if test="${cashbook.cashbookKind == '수입'}">
							<input type="radio" name="cashbookKind" value="수입" checked="checked">수입 &nbsp;
							<input type="radio" name="cashbookKind" value="지출">지출
						</c:if>
						<c:if test="${cashbook.cashbookKind == '지출'}">
							<input type="radio" name="cashbookKind" value="수입">수입 &nbsp;
							<input type="radio" name="cashbookKind" value="지출" checked="checked">지출
						</c:if>
						<span id="inOutCk"></span>
					</td>
				</tr>
				<tr>
					<td>수입 · 지출 카테고리</td>
					<td>
						<select name="categoryName" class="form-control">
							<c:forEach var="c" items="${categoryList}">
								<c:if test="${c.categoryName == cashbook.categoryName}">
									<option value="${c.categoryName}" selected="selected">${c.categoryName}</option>
								</c:if>
								<c:if test="${c.categoryName != cashbook.categoryName}">
									<option value="${c.categoryName}">${c.categoryName}</option>
								</c:if>
							</c:forEach>
						</select>
						<span id="categoryCk"></span>
					</td>
				</tr>
				<tr>
					<td>수입 · 지출 금액</td>
					<td>
						<input type="text" name="cashbookPrice" class="form-control" value="${cashbook.cashbookPrice}">
						<span id="priceCk"></span>
					</td>
				</tr>
				<tr>
					<td>수입 · 지출 내용</td>
					<td>
						<input type="text" name="cashbookContent" class="form-control" value="${cashbook.cashbookContent}">
						<span id="contentCk"></span>
					</td>
				</tr>
			</table>
		<button type="submit" class="btn btn-success">수정</button>
		</form>
	</div>
</div>
</body>
</html>