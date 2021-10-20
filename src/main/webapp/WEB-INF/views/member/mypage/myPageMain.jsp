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
<link rel="stylesheet" href="/css/member/mypage/myPageMain.css">

</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/myPage.png"/>
	<h1>마이페이지</h1>
	<hr style="border: solid 2px;">
	<h2>주문목록</h2>
	<hr style="border: solid 1px;">
	
	<table>
		<tr id="first-tr">
			<th>주문일</th>
			<th>주문상태</th>
			<th>상품명</th>
			<th>금액</th>
		</tr>
		<c:forEach var="orderDto" items="${ order_list }" varStatus="status">	
		<tr onclick="location.href='myPageOrder?member_order_id=${orderDto.member_order_id}'">
			<input type="hidden" name="member_order_id" value="${orderDto.member_order_id }" />
			<fmt:formatDate value="${ orderDto.member_order_date }" pattern="yyyy-MM-dd" var="order_date" />
			<td>${ order_date }</td>
			<td>${orderDto.member_order_state }</td>
			<td>${list[status.index].product_name}</td>
			<td>${orderDto.member_order_price }</td>
		</tr>
		</c:forEach>
	</table>
	
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
			      	<span class="page-link">&lt;</span>
			    </li>
	  		<c:forEach begin="0" end="${count }" step="10" varStatus="status">
			<li>
				<a class="page-link" href="myPageMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
		    	<li class="page-item">
			      	<a class="page-link">&gt;</a>
			    </li>
	  	</ul>
	</nav>
	
	<div id="btns">
		<div id="infoDiv" onclick="location.href='myPageM'">
			<div class="front">
				<div><img src="images/a-member-logo.png"/></div>
				<div>회원정보</div>
			</div>
		</div>
		<div>
			<div class="front hover">
				<div><img src="images/task.png"/></div>
				<div>게시글관리</div>
			</div>
			<p class="p">
				<a class="myPageMain" href="myPageReview">리뷰게시글</a><br><br>
				<a class="myPageMain" href="myPageQna">Q&A게시글</a>
			</p>
		</div>
	</div>
	
	<c:import url="../../footer.jsp"/>
</body>
</html>