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
<link rel="stylesheet" href="css/admin/notice/aNoticeMain.css">
<script type="text/javascript"></script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<h1>관리자페이지</h1>
	<hr style="border: solid 2px;">
	<h2>공지사항관리</h2>
	<form action="noticeBoardSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box" onchange="roleClick()">
				<option value="1">아이디</option>
				<option value="2">제목</option>
			</select>
			<input id="input" name="input" type="text">
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>제목</th>
		<th>아이디</th>
		<th>작성일</th>
	</tr>
	<c:forEach var="dto" items="${ noticeBoard_list }">	
		<tr onclick="window.open('aNoticeV?notice_board_id=${dto.notice_board_id }','child_window','width=650, height=500')">
			<td>${dto.notice_board_id }</td>
			<td>${dto.notice_board_title }</td>
			<td>${dto.member_id }</td>
			<%-- <td>${dto.notice_board_date }</td> --%>
			<fmt:formatDate value="${ dto.notice_board_date }" pattern="yyyy-MM-dd" var="noticeBoard_date" />
			<td>${ noticeBoard_date }</td>
		</tr>
	</c:forEach>
	</table>
	<button id="button1" type="button" onClick="location.href='aMain'">메인으로</button>
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
	<button id="button2" type="button" onClick="window.open('aNoticeW','','width=650, height=500')">글쓰기</button>
	<script src="js/admin/notice/aNoticeMain.js"></script>
</body>
</html>