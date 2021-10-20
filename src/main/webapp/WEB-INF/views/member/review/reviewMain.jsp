<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.ReviewBoardDto" %>
<%@ page import="java.util.List"%>

<%
		List<ReviewBoardDto> list = (List<ReviewBoardDto>)request.getAttribute("reviewBoard_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" href="/css/member/review/reviewMain.css">
<script type="text/javascript"></script>
<style>
	
</style>
</head>
<body>
<c:import url="../../header.jsp"/>
<div><img class="banner-image" src="images/banner2.png"></div>
	<h1>리뷰게시판</h1>
	<hr style="border: solid 2px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>제목</th> 
		<th>아이디</th>
		<th>작성일</th>
		<th>별점</th>
		<th>조회수</th>
	</tr>
	<c:forEach var="dto" items="${reviewBoard_list }">
	<tr onClick="location.href='reviewV?review_board_id=${dto.review_board_id}'">
		<td>${dto.review_board_id }</td>
		<td id="title"><img class="product-image" src="${dto.review_board_img_path }" onError="this.style.visibility='hidden'" width="70px" height="70px"/><span>${dto.review_board_title }</span></td>
		<td>${dto.member_id }</td>
		<fmt:formatDate value="${ dto.review_board_date }" pattern="yyyy-MM-dd" var="date" />
		<td>${ date }</td>
		<td>
			<c:if test="${dto.review_board_score == 1 }"><img class="star-image" src="images/star1.png" alt="" /></c:if>
			<c:if test="${dto.review_board_score == 2 }"><img class="star-image" src="images/star2.png" alt="" /></c:if>
			<c:if test="${dto.review_board_score == 3 }"><img class="star-image" src="images/star3.png" alt="" /></c:if>
			<c:if test="${dto.review_board_score == 4 }"><img class="star-image" src="images/star4.png" alt="" /></c:if>
			<c:if test="${dto.review_board_score == 5 }"><img class="star-image" src="images/star5.png" alt="" /></c:if>
		</td>
		<td>${dto.review_board_hit }</td>
	</tr>
	</c:forEach>
	</table>
	    <div id="search-bar">
		<select id="select-box">
			<option>제목</option>
			<option>아이디</option>
		</select>
		<input id="input" type="text">
		<img id="search-logo" src="images/search.png" style="border: solid 0.5px;">
		
		<button id="review-write" onClick="location.href='reviewW'">리뷰작성</button>
		
		</div>
		<br><br>
	
	<c:import url="../../footer.jsp" />
</body>
</html>