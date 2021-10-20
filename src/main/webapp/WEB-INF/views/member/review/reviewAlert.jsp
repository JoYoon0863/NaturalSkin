<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/review/reviewAlert.css">
<script type="text/javascript"></script>
<script type="text/javascript">
    function getParentText(){
        document.getElementById("review_board_id").value = opener.document.getElementById("review_board_id").value;
    }
</script>
</head>
<body>
	<header><h3>문의글삭제</h3></header>
	<form action="reviewAlertA">
	<input type="hidden" id="review_board_id" name="review_board_id">
	<main>
		<p>해당 게시물을 삭제하시겠습니까?<br>
		(해당 게시물의 모든 리뷰도 삭제되오니 유의하세요.)
		</p>
		<button id="first-btn" type="button" onclick="window.close()">취소</button>
		<button type="submit" onclick="getParentText();">확인</button>
	</main>
	</form>
</body>
</html>