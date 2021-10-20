<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.QnaDto" %>
<%@ page import="java.util.List"%>

<%
		List<QnaDto> list = (List<QnaDto>)request.getAttribute("qna_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/mypage/myPageBoard.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/myPage.png"/>
	<h1>나의게시물</h1>
	<hr style="border: solid 2px;">
	<h2>Q&A게시물</h2>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
		<tr id="first-tr">
			<th>번호</th>
			<th>구분</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="dto" items="${ qna_list }" varStatus="status">	
		<tr onclick="location.href='#'">
			<td>${dto.qna_board_id }</td>
			<td>${dto.qna_board_type }</td>
			<td>${dto.qna_board_title }</td>
			<fmt:formatDate value="${ dto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_date" />
			<td>${ qna_date }</td>
		</tr>
		</c:forEach>
	</table>
	<br>
	<div id="search-bar">
		<select>
			<option>제목</option>
			<option>구분</option>
		</select>
		<input type="text">
		<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
	</div>
	<div id="btns">
		<button type="button" onclick="location.href='myPageReview'">리뷰게시물</button>
		<button type="button" onclick="location.href='myPageMain'">마이페이지</button>
	</div>
	<br><br>
	
	<c:import url="../../footer.jsp"/>
</body>
</html>