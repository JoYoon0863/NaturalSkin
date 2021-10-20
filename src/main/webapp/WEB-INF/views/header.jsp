<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/header.css">
</head>
<body>
	<div id="header">
		<div id="headerLeft">
			<a class="header"id="img" href="/">
				<img src="images/logo.png">
			</a>
			<a class="header" href="brand">Brand</a>
			<div class="dropdown">
				<a class="header" href="productMain">Product</a>
				<div class="dropdown-content">
					<a class="header" href="productMain">모든제품</a>
					<a class="header">클렌저</a>
					<a class="header">로션&크림</a>
					<a class="header">앰플&세럼</a>
					<a class="header">오일</a>
				</div>
			</div>
			<a class="header" href="reviewMain">Review</a>
			<div class="dropdown">
				<a class="header" href="noticeMain">Support</a>
				<div class="dropdown-content">
					<a class="header" href="noticeMain">공지사항</a>
					<a class="header" href="qnaMain">Q&A</a>
				</div>
			</div>
		</div>
		<div>
			<%
				String member_id = (String)session.getAttribute("member_id");
				if( member_id == null ) {
					// 로그아웃 상태
			%>
			<a class="header" href="login">Login</a>
			<a class="header" href="join">Join</a>
			<%
			}
				else {
					if( member_id.length() == 0 ) {
						// 로그아웃 상태
			%>
			<a class="header" href="login">Login</a>
			<a class="header" href="join">Join</a>
			<%
					} else {
						// 로그인 상태
			%>
			<span id="whoru"><%=member_id %>님 환영합니다.</span>
			<a class="header" href="logoutAction">Logout</a>
			<a class="header" href="myPageMain">MyPage</a>
			<a class="header" href="basket">Cart</a>
			<%
					}
				}
			%>	
			<c:forEach var="memberInfo" items="${memberInfo}">
				<c:if test="${memberInfo.member_role == 1}">
					<div id="third-dropdown" class="dropdown">
						<a class="header" href="aMain">AdminPage</a>
						<div class="dropdown-content">
								<a class="header" href="aMemberMain">회원관리</a>
								<a class="header" href="aNoticeMain">공지사항관리</a>
								<a class="header" href="aQnaMain">Q&A관리</a>
								<a class="header" href="aOrderMain">주문관리</a>
								<a class="header" href="aProductMain">상품관리</a>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
</body>
</html>