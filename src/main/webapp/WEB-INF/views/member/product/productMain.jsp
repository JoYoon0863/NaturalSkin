<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/product/productMain.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<div>
		<div><img id="indexImg" src="images/product.png" ></div>
		<h1>모든상품</h1>
		<hr>
		<div id="productDiv">
			<c:forEach var="dto" items="${ product_list }" end="3">	
			<div class="productDiv" onclick="location.href='productV?product_id=${dto.product_id}'">
				<div class="imgDiv"><img src="${dto.product_main_img_path }" ></div>
				<p>${dto.product_name }<br>${dto.product_price }원</p>
			</div>
			</c:forEach>
		</div>
	</div>
	<c:import url="../../footer.jsp"/>
</body>
</html>