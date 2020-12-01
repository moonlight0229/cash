<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addMember</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	$('id').focus();
	$('id').blur(function() {
		if($('#id').val != '') {
			$('#id').focus();
			return;
		}
		// 비동기요청으로 id값을 서버로 보내고 중복된 값인지 확인
		$ajax({
			url: "/admin/idCheck",
			data: {id:${'#id'}.val()},
			succeess:function(date) {
				if(data == 'yes') {
					alert($('#id').val() + '는 사용가능한 아이디입니다.');
				$('#pw').focus();
				} else {
					alert($('#id').val() + '는 사용중인 아이디입니다.');
					$('#id').select();
					$('#id').focus();
				}
			}
		});
	});
})
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
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
</header>
<div class="container">
	<form method="post" action="${pageContext.request.contextPath}/admin/addmin">
		<div>
			ID : <input type="text" id="id" name="id">
		</div>
		<div>
			PW : <input type="password" id="pw" name="pw">
		</div>
		<div><button type="button" id=addMember> addMember</button></div>
	</form>
</div>
</body>
</html>