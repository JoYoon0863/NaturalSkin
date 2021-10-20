<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.OrderDto" %>
<%@ page import="java.util.List"%>

<%
		List<OrderDto> list = (List<OrderDto>)request.getAttribute("order_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/admin/order/aOrderMain.css">
<script type="text/javascript"></script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<h1>관리자페이지</h1>
	<hr style="border: solid 2px;">
	<h2>주문목록</h2>
	<form action="orderSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box">
				<option>아이디</option>
				<option>이름</option>
				<option>주문번호</option>
			</select>
			<input id="input" name="input" type="text">
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>주문번호</th>
		<th>주문일</th>
	</tr>
	<c:forEach var="orderDto" items="${ order_list }" varStatus="status">	
		<tr onclick="window.open('aOrderV?member_order_id=${orderDto.member_order_id }','child_window','width=780, height=520')">
			<td>${num.get(status.index) }</td>
			<td>${orderDto.member_id }</td>
			<td>${member_list[status.index].member_name }</td>
			<td>${orderDto.member_order_id }</td>
			<%-- <td>${orderDto.member_order_date }</td> --%>
			<fmt:formatDate value="${ orderDto.member_order_date }" pattern="yyyy-MM-dd" var="order_date" />
			<td>${ order_date }</td>
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
				<a class="page-link" href="aOrderMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
		    	<li class="page-item">
			      	<a class="page-link">&gt;</a>
			    </li>
	  	</ul>
	</nav>
	<script src="js/admin/member/"></script>
</body>
</html>