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
            document.getElementById("qna_board_id").value = opener.document.getElementById("qna_board_id").value;
            document.getElementById("parents_id").value = opener.document.getElementById("parents_id").value;
        }
</script>
</head>
<body>
	<header><h3>문의글삭제</h3></header>
	<form action="aQnaAlert2A">
		<input type="hidden" id="parents_id" name="parents_id" value="${qnaDto.qna_board_id }">
		<input type="hidden" id="qna_board_id" name="qna_board_id" />
		<main>
			<p>해당 게시물을 삭제하시겠습니까?</p>
			<button id="first-btn" type="button" onclick="window.close()">취소</button>
			<button type="submit" onclick="getParentText();">확인</button>
		</main>
	</form>
</body>
</html>