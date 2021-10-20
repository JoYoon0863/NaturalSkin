<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>로그인</title>
  <link rel="stylesheet" href="/css/member/login/search.css">
  <script src="js/member/login/search.js"></script>
  <script>
function openwin() {
  window.open('about:blank','searchIdAlert','width=600, height=200');
  document.searchId.submit();
}
</script>
</head>
<body>
<c:import url="../../header.jsp"/>
  <img id="login" src="images/login-top.png" width="100%">
    <h1>아이디 찾기</h1>
    <hr>
    <form action="searchIdAlert" name="searchId" target="searchIdAlert" method="post">
    <div class="searchIdDiv">
    	<p class="p">가입하신 방법에 따라 아이디 찾기가 가능합니다.<br>
    	이메일 또는 휴대폰 번호를 입력해주세요.</p>
    	<div id="radioDiv">
    		<span>찾을수단</span>
    		<input type="radio" name="findBy" value="1" checked="checked" onclick="idFind(this.value);">
    		<label>이메일</label>
    		<input type="radio" name="findBy" value="2" onclick="idFind(this.value);">
    		<label>휴대폰번호</label>
    	</div>
    	<div id="name">
    		<label>이름</label>
    		<input class="input" id="member_name" name="member_name" type="text">
    	</div>
    	<div id="email">
    		<label>이메일</label>
    		<input class="input" id="member_email" name="member_email" type="email">
    	</div>
    	<div id="phone" style="display:none">
    		<label>휴대폰번호</label>
    		<input class="input" id="member_phone" name="member_phone" type="text">
    	</div>
    </div>
    <button type="button" onclick="openwin()">찾기</button>
    </form>
    <c:import url="../../footer.jsp"/>
</body>
</html>