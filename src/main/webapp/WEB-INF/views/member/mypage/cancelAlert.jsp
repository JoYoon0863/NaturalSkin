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
	<header><h3>결제취소</h3></header>
	<form action="cancelAlertA">
	<input type="hidden" id="id" name="id">
	<main>
		<p>결제금액 : <span id="price"></span>원</p>
		<p>환불예상금액 : <span id="total"></span>원 (배송비 2,500원 제외)</p>
		<button id="btns" type="button" onclick="window.close()">돌아가기</button>
		<button type="submit">취소요청</button>		
	</main>
	</form>
</body>
<script type="text/javascript">
	var id = opener.document.getElementById("id");
	console.log(id.value);
	document.getElementById("id").value = id.value;
	var price = opener.document.getElementById("price");
	console.log(price.value);
	document.getElementById("price").innerHTML = price.value;
	document.getElementById("total").innerHTML = price.value - 2500;
</script>
</html>