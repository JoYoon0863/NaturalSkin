<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/admin/member/aMemberAlert.css">
<script type="text/javascript">
        function getParentText(){
            document.getElementById("product_id").value = opener.document.getElementById("product_id").value;
        }
</script>
</head>
<body>
	<header><h3>상품삭제</h3></header>
	<form action="aProductAlertAction">
		<main>
			<input type="hidden" id="product_id" name="product_id">
			<p>해당 상품을 삭제하시겠습니까?</p>
			<button id="first-btn" type="button" onclick="window.close()">취소</button>
			<button type="submit" onclick="getParentText();">확인</button>
		</main>
	</form>
</body>
</html>