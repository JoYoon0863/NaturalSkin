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
<link rel="stylesheet" href="css/admin/qna/aQnaMain.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<h1>관리자페이지</h1>
	<hr style="border: solid 2px;">
	<h2>Q&A관리</h2>
	<form action="qnaBoardSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box" onchange="select()">
				<option>아이디</option>
				<option>구분</option>
				<option>상태</option>
			</select>
			<input id="input" name="input" type="text">
			<select id="delimiter" name="type">
				<option>상품</option>
				<option>배송</option>
			</select>
			<select id="state" name="state">
				<option value="0">미답변</option>
				<option value="1">답변완료</option>
			</select>
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<hr class="second-hr" style="border: solid 1px;">
	<table>                    
		<tr id="first-tr">
			<th>번호</th>
			<th>구분</th>
			<th>제목</th>
			<th>아이디</th>
			<th>작성일</th>
			<th></th>
		</tr>
		<c:forEach var="dto" items="${qna_list }" varStatus="status">
		<tr>
			<td>${dto.qna_board_id }</td>
			<td>${dto.qna_board_type }</td>
			<c:if test="${dto.member_id eq 'jdy0863' }">
				<td onclick="window.open('aQnaV1?qna_board_id=${dto.qna_board_id}','','width=650, height=700')">${dto.qna_board_title }<c:if test="${dto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if></td>
			</c:if>
			<c:if test="${dto.member_id eq 'admin' }">
				<td onclick="window.open('aQnaV2?qna_board_id=${dto.qna_board_id}','','width=650, height=700')"><img id="re" src="images/re.png">${dto.qna_board_title }<c:if test="${dto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if></td>
			</c:if>
			<td>${dto.member_id }</td>
			<%-- <td>${dto.qna_board_date }</td> --%>
			<fmt:formatDate value="${ dto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_date" />
			<td>${ qna_date }</td>
			<td><c:if test="${dto.qna_board_reply_state == 0 }"><input type="button" value="답변하기" onclick="window.open('aQnaReply?qna_board_id=${dto.qna_board_id}','','width=650, height=700')"></c:if></td>
		</tr>
		</c:forEach>
	
	</table>
	<button type="button" onClick="location.href='aMain'">메인으로</button>
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
			      	<span class="page-link">&lt;</span>
			    </li>
	  		<c:forEach begin="0" end="${count }" step="10" varStatus="status">
			<li>
				<a class="page-link" href="aQnaMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
		    	<li class="page-item">
			      	<a class="page-link">&gt;</a>
			    </li>
	  	</ul>
	</nav>
	<script src="js/admin/qna/aQnaMain.js"></script>
</body>
</html>