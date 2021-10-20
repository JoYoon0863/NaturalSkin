<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.MemberDto" %>
<%@ page import="java.util.List"%>

<%
		List<MemberDto> list = (List<MemberDto>)request.getAttribute("member_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/admin/member/aMemberMain.css">
<script type="text/javascript"></script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<h1>관리자페이지</h1>
	<hr style="border: solid 2px;">
	<h2>회원리스트</h2>
	<form action="memberSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box" onchange="roleClick()">
				<option value="1">아이디</option>
				<option value="2">이름</option>
				<option value="3">분류</option>
			</select>
			<input id="input" name="input" type="text">
			<select id="role" name="role">
				<option value="0">일반회원</option>
				<option value="1">관리자</option>
			</select>
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>분류</th>
		<th>아이디</th>
		<th>이름</th>
		<th>가입일</th>
	</tr>
	<c:forEach var="memberDto" items="${ member_list }">	
		<tr onclick="window.open('aMemberV?member_id=${ memberDto.member_id }','child_window','width=650, height=700')">
			<td>${ memberDto.member_idx }</td>
			<c:if test="${memberDto.member_role == 0}">
				<td>일반회원</td>
			</c:if>
			<c:if test="${memberDto.member_role == 1}">
				<td>관리자</td>
			</c:if>
			<%-- <td>${ memberDto.member_role }</td> --%>
			<td>${ memberDto.member_id }</td>
			<td>${ memberDto.member_name }</td>
			<%-- <td>${ memberDto.member_date }</td> --%>
			<fmt:formatDate value="${ memberDto.member_date }" pattern="yyyy-MM-dd" var="member_date" />
			<td>${ member_date }</td>
		</tr>
	</c:forEach>
	</table>
	<div>
		<button type="button" onClick="location.href='aMain'">메인으로</button>
	</div>
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
		      	<a class="page-link" href="aMemberMain">&lt;</a>
			</li>
	  		<c:forEach begin="0" end="${count }" step="5" varStatus="status">
			<li>
				<a class="page-link" href="aMemberMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
		    <c:if test="${count % 5 > 0 }">
	    	<li class="page-item">
		      	<a class="page-link" href="aMemberMain?page=${intcount / 5 + 1 }">&gt;</a>
		    </li>
		    </c:if>
	  	</ul>
	</nav>
	<script src="js/admin/member/aMemberMain.js"></script>
</body>
</html>