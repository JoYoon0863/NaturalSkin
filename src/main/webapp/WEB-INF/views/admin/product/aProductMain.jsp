<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.ProductDto" %>
<%@ page import="java.util.List"%>

<%
		List<ProductDto> list = (List<ProductDto>)request.getAttribute("product_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" href="/css/admin/product/productMain.css">
<script type="text/javascript"></script>
</head>
<body>
<c:import url="../../header.jsp"/>
	<h1>관리자페이지</h1>
	<hr style="border: solid 2px;">
	<h2> 상품관리 </h2>
	<form action="productSearch">
		<div id="search-bar">
			<select id="select-box" name="select-box">
				<option>상품명</option>
			</select>
			<input id="input" name="input" type="text">
			<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
		</div>
	</form>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>이미지</th>
		<th>상품명</th>
		<th>등록일</th>
	</tr>
	<c:forEach var="dto" items="${product_list }">
		<tr onclick="window.open('aProductV?product_id=${dto.product_id}','child_window','width=780, height=700')">
			<td>${dto.product_id }</td>
			<td><img class="mainImg" src="${dto.product_main_img_path }" alt="업로드된 이미지" /></td>
			<td >${dto.product_name }</td>
			<!-- <td>2020-09-23</td> -->
			<fmt:formatDate value="${ dto.product_date }" pattern="yyyy-MM-dd" var="product_date" />
			<td>${ product_date }</td>
		</tr>	
	</c:forEach>
	</table>
	<button id="button1" type="button" onClick="location.href='aMain'">메인으로</button>
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
			      	<span class="page-link">&lt;</span>
			    </li>
	  		<c:forEach begin="0" end="${count }" step="6" varStatus="status">
			<li>
				<a class="page-link" href="aProductMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
		    	<li class="page-item">
			      	<a class="page-link">&gt;</a>
			    </li>
	  	</ul>
	</nav>
	<button id="button2" type="button" onClick="window.open('aProductWV','','width=650, height=650')">상품등록</button>
</body>
</html>