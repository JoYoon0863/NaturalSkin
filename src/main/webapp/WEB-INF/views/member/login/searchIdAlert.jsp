<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/login/searchAlert.css">
</head>
<body>
	<header><h3>아이디찾기 결과</h3></header>
	<main>
		<p>고객님의 소중한 정보입니다.<br><br>
		- 아이디 <input type="text" value="${dto.member_id }" readonly>
		</p>
		<button onclick="window.close(); opener.location.href='login'">확인</button>
	</main>
	<script src="js/user/qna/qnaAlert.js"></script>
</body>
</html>