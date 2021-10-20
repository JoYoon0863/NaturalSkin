<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/mypage/myPageOrder.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/myPage.png"/>
	<h1>주문상세페이지</h1>
	
	<input type="hidden" id="state" value="${dto.member_order_state}">
	<input type="hidden" id="id" value="${dto.member_order_id}">
	<input type="hidden" id="price" value="${dto.member_order_price }">

	<span class="orderNum">주문번호 : ${dto.member_order_id}</span><br>
	<p style="clear: both; font-size: 1px">&nbsp;</p>
	<hr style="border: solid 2px;"><br>
	<div>
		<div class="div1">주문완료(${dto.member_order_state})</div>
		<div class="div2">	
		<c:choose>
			<c:when test="${dto.member_order_state eq '주문취소요청'}"></c:when>
			<c:otherwise>
			<input type="button" value="배송조회" onclick="window.open('trackAlert','','width=600, height=200');"></input>
			</c:otherwise>
		</c:choose>	
		</div>
	</div>
	<br>
	<table class="order">
	<c:forEach var="detail" items="${orderDetail }" varStatus="state">
		<tr>
			<td><img class="orderImg" src="${pDto[state.index].product_main_img_path }"></td>	
			<td>${pDto[state.index].product_name}</td>
			<td>${detail.order_detail_price }원</td>
			<td>${detail.order_detail_amount }개</td>
			<td>
			<c:choose>
				<c:when test="${dto.member_order_state eq '주문취소요청'}"></c:when>
				<c:otherwise>
				<c:if test="${detail.order_detail_review == 0 }">
				<button type="button" onclick="location.href='reviewW'">리뷰쓰기</button></c:if>
				</c:otherwise>
			</c:choose>	
			</td>
		</tr>
		</c:forEach>
		<!-- <tr>
			<td><img class="orderImg" src="images/myPageOrder.png"></td>	
			<td>BodyOil</td>
			<td>25,000원</td>
			<td>2개</td>
			<td><input type="hidden"></td>
		</tr> -->
	</table>
	
	<hr style="border: solid 2px;"><br>
	<div class="div1">배송정보</div><br>
	<table class="deliver">
		<tr>
			<th>받는사람</th>
			<td>${dto.member_order_receive_name }</td>
			
			<td rowspan="3">
				<c:choose>
				<c:when test="${dto.member_order_state eq '주문취소요청'}"></c:when>
				<c:otherwise>
					<button type="button" onclick="window.open('myPageOrderM?member_order_id=${dto.member_order_id}','','width=600, height=400');">배송정보변경</button>
				</c:otherwise>
			</c:choose>	
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${dto.member_order_receive_address }</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${dto.member_order_receive_phone }</td>
		</tr>
	</table>
	<hr style="border: solid 2px;"><br>
	<div class="div1">결제정보</div><br>
	<table class="pay">
		<tr>
			<th>결제수단</th>
			<th>결제금액</th>
			<th rowspan="2">
			<c:choose>
				<c:when test="${dto.member_order_state eq '주문취소요청'}"></c:when>
				<c:otherwise>
				<button type="button" onclick="window.open('cancelAlert','','width=600, height=200');">결제/주문취소</button>		
				</c:otherwise>
			</c:choose>	
			</th>
		</tr>
		<tr>
			<td>${dto.member_order_payment_method }</td>
			<td>${dto.member_order_price }원</td>
		</tr>
	</table>
	
	<hr style="border: solid 2px;">
	
	<div id="btns">
		<button type="button" onclick="location.href='myPageMain'">목록</button>
	</div>
	<br>
	<c:import url="../../footer.jsp"/>
</body>
</html>