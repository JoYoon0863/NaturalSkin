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
<script type="text/javascript"></script>
</head>
<body>
	<header><h3>비밀번호찾기 결과</h3></header>
	<main>
		<p>-고객님의 소중한 정보입니다.<br>
		-로그인 후 비밀번호를 변경해주세요.<br><br>
		- 임시 비밀번호 <input type="text" value="${dto.member_pw }" readonly>
		</p>
		<button onclick="window.close(); opener.location.href='login'">확인</button>
	</main>
	<script src="js/user/qna/qnaAlert.js"></script>
</body>
</html>