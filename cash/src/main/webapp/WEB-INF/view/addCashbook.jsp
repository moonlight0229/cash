<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수입 / 지출 추가</title>
		
		<!-- 제이쿼리 -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<!-- 부트스트랩 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
		</style>
		
		<!-- 유효성 검사 -->
		<script>
			$(document).ready(function() {
				let numCk = /^\D*$/;
				
				$('#subButton').click(function() {
					//  수입 지출 선택 유효성 검사
					if($(':radio[name="cashbookKind"]:checked').length == 0) {
						$('#kindMsg').text('수입 · 지출을 선택하세요');
						return
					} else if($(':radio[name="cashbookKind"]:checked').length == 1) {
						$('#kindMsg').text('');
					}
		
					// 카테고리 선택 유효성 검사
					if($('#categoryName').val() == 0) {
						$('#categoryMsg').text('카테고리를 선택하세요');
						return
					} else if($('#categoryName').val() == 1) {
						$('#categoryMsg').text('');
					}
		
					// 금액 유효성 검사
					if($('#cashbookPrice').val == ""){
						$('#priceMsg').text('금액을 입력하세요');
						return
					} else if(numCk.test($('#cashbookPrice').val())) {
						$('#priceMsg').text('숫자만 입력하세요');
						return
					} else {
						$('#priceMsg').text('');
					}
		
					// 내용 유효성 검사
					if($('#cashbookContent').val == ""){
						$('#contentMsg').text('내용을 입력하세요');
						return
					} else {
						$('#contentMsg').text('');
					}
					$("#addCashbookForm").submit();
				});
			});
		</script>
	</head>
	
	<body>
		<header>
			<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		</header>
		
		<div class="container font">
			<h3 class="mb-3">
				수입 · 지출 내역 추가
			</h3>
			
			<form method="post" action="${pageContext.request.contextPath}/admin/addCashbook/${currentYear}/${currentMonth}/${currentDay}" id="addCashbookForm">
				<table class="table">
					<tr>
						<td style="width:15%; vertical-align:middle;">
							일자
						</td>
						<td style="vertical-align:middle;">
							<input type="text" id="cashbookDate" name="cashbookDate" class="form-control" value="${currentYear}-${currentMonth}-${currentDay}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td style="vertical-align:middle;">
							수입 · 지출
						</td>
						<td style="vertical-align:middle;">
							<input type="radio" name="cashbookKind" value="수입">수입 &nbsp;
							<input type="radio" name="cashbookKind" value="지출">지출
							<span id="kindMsg"></span>
						</td>
					</tr>
					<tr style="vertical-align:middle;">
						<td style="vertical-align:middle;">
							카테고리
						</td>
						<td style="vertical-align:middle;">
							<select id="categoryName" name="categoryName" class="form-control">
								<c:forEach var="c" items="${categoryList}">
									<option value="${c.categoryName}">${c.categoryName}</option>
								</c:forEach>
							</select>
							<span id="categoryMsg"></span>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:middle;">
							금액
						</td>
						<td>
							<input type="text" id="cashbookPrice" name="cashbookPrice" class="form-control">
							<span id="priceMsg"></span>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:middle;">
							내용
						</td>
						<td style="vertical-align:middle;">
							<input type="text" id="cashbookContent" name="cashbookContent" class="form-control">
							<span id="contentMsg"></span>
						</td>
					</tr>
				</table>
				
				<div class="d-flex justify-content-end mt-3 mb-3">
					<button type="button" id="subButton" class="btn btn-outline-success">
						추가
					</button>
				</div>
			</form>
		</div>
	</body>
</html>