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
            document.getElementById("member_order_id").value = opener.document.getElementById("member_order_id").value;
        }
</script>
</head>
<body>
	<header><h3>주문삭제</h3></header>
	<form action="aOrderDelete">
		<main>
			<input type="hidden" id="member_order_id" name="member_order_id">
			<p>해당 주문건을 삭제하시겠습니까?</p>
			<button id="first-btn" type="button" onclick="window.close()">취소</button>
			<button type="submit" onclick="getParentText();">확인</button>
		</main>
	</form>
</body>
</html>