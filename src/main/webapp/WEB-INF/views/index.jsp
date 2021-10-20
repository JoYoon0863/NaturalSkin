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
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
	<c:import url="header.jsp"/>
	<div id="index">
		<div><img id="indexImg" src="images/index.png" ></div>
		<div id="IndfirstDiv" class="div">
			<h1>Our Company.</h1>
			<p>우리는 과장된 광고로 고객의 똑똑한 선택을 가로막지 않습니다.<br>
				모든제품은 반드시, 효과적이고 유익해야 합니다. 예외는 없습니다.</p>
			<br><button id="contactUsBtn" onclick="location.href='brand'">Learn More</button>
		</div>
		<div id="IndSecondDiv">
			<h1>Product.</h1><br><br>
			<div>
			<c:forEach var="dto" items="${list }" end="3">
				<div class="productDiv" onclick="location.href='productV?product_id=${dto.product_id}'">
					<div class="imgDiv"><img src="${dto.product_main_img_path }" onmouseover="this.src='images/naturalAmple2.png'" onmouseout="this.src='${dto.product_main_img_path }'"></div>
					<p>${dto.product_name }<br>${dto.product_price }원</p>
				</div>
			</c:forEach>
			</div>
		</div>
		<div id="IndThirdDiv">
			<h1>CS Center.</h1><br>
			<div>
				<table>
					<tr id="firstTr">
						<th>공지사항</th>
						<td id="more" onclick="location.href='noticeMain'">더보기</td>
					</tr>
					<c:forEach var="list2" items="${list2 }" end="4">
					<tr style="border-bottom: 1px solid rgb(213, 213, 213); " onclick="location.href='noticeV?notice_id=${list2.notice_board_id}'">
						<td>${list2.notice_board_title }</td>
						<fmt:formatDate value="${list2.notice_board_date }" pattern="yyyy-MM-dd" var="date" />
						<td>${date }</td>
					</tr>
					</c:forEach>
					
				</table>
				<div id="csBtns">
					<div><a href="qnaMain"><img src="images/qna.png" width="200px"></a></div>
					<div><a href="brand"><img src="images/contactUs.png" width="200px"></a></div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"/>
</body>
</html>