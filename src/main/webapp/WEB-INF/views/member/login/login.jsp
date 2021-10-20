<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>로그인</title>
  <link rel="stylesheet" href="/css/member/login/login.css">

<script>
	function checkValue() {
		if( !document.loginMember.id.value ) { 
			alert("아이디를 입력해주세요");			
			document.getElementById('id').focus();
			return false; 
		}
		if( !document.loginMember.pw.value ) {
			alert("비밀번호를 입력해주세요");			
			document.getElementById('pw').focus();
			return false; 
		}
	}
</script>  
  
</head>
<body>
<c:import url="../../header.jsp"/>
  <img id="login" src="images/login-top.png">
    <h1>로그인</h1>
    <hr>
    <form action="loginAction" method="post" name="loginMember" onsubmit="return checkValue()">
	    <div class="login">
		    <input type="text" id="id" name="id" placeholder="Id">
		    <input type="password" id="pw" name="pw" placeholder="Password">
		    <div id="flexBox2">
		    	<div><input id="checkBox" type="checkbox">아이디 저장</div>
		    	<div><a href="idSearch">아이디</a> / <a href="pwSearch">비밀번호 찾기</a></div>
		    </div>
		    <button type="submit">로그인</button>
		    <div id="joinBox">
		    	<p>회원이 아니신가요?<br>고객님만을 위한 다양한 혜택이 준비되어 있습니다.</p>
		    	<button type="button" id="joinBtn" onclick="location.href='join'">회원가입</button>
		    </div>
	    </div>
    </form>
    <c:import url="../../footer.jsp"/>
  <script>
  </script>
 
</body>
</html>