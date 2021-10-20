<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.NoticeBoardDto" %>
<%@ page import="java.util.List"%>

<%
		List<NoticeBoardDto> list = (List<NoticeBoardDto>)request.getAttribute("noticeBoard_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"></script>
<link rel="stylesheet" href="css/member/notice/noticeMain.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img id="noticemain" src="images/notice.png">
	<br>
	<h2>공지사항</h2>
	<br>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach var="dto" items="${ noticeBoard_list }">	
	<tr onclick="location.href='noticeV?notice_id=${dto.notice_board_id}'">	
		<td>${dto.notice_board_id }</td>
		<td>${dto.notice_board_title }</td>
		<fmt:formatDate value="${ dto.notice_board_date }" pattern="yyyy-MM-dd" var="noticeBoard_date" />
		<td>${ noticeBoard_date }</td>
		<td>${dto.notice_board_hit }</td>
	</tr>
	</c:forEach>
	</table>
	<form action="noticeSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box">
				<option value="1">제목</option>
			</select>
			<input id="input" name="input" type="text">
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<br>
	<br>
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
		      	<span class="page-link">&lt;</span>
		    </li>
	  		<c:forEach begin="0" end="${count }" step="10" varStatus="status">
			<li>
				<a class="page-link" href="aNoticeMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
	    	<li class="page-item">
		      	<a class="page-link">&gt;</a>
		    </li>
	  	</ul>
	</nav>
	<script src="js/member/notice/Noticemain.js"></script>
<c:import url="../../footer.jsp"/>
	
</body>
</html>