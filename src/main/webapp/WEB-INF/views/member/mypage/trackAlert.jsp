<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/member/mypage/myPageAlert.css">
<title></title>
</head>
<body>
	<header><h3>배송조회</h3></header>
	<input type="hidden" name="member_order_id">
	<main>
		<p>현재 고객님의 소중한 상품은 ‘<span id="order_state"></span>’ 입니다.</p>
		<button id="btn" type="button" onclick="window.close()">확인</button>
	</main>
</body>
<script type="text/javascript">
	var a = opener.document.getElementById("state");
	console.log(a.value);
	document.getElementById("order_state").innerHTML = a.value;
</script>
</html>