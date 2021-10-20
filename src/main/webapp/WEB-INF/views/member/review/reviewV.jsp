<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="css/member/review/reviewV.css">
	<script type="text/javascript"></script>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>

<body>
<c:import url="../../header.jsp"/>
<div><img class="banner-image" src="images/banner2.png"></div>
<div><br>
<h2>리뷰상세보기</h2><br>
<hr class="second-hr" style="border: solid 1px;">
<form action="">
<input id="product_id" name="product_id" type="hidden" readonly value="${product_list.product_id }">
<input id="review_board_id" name="review_board_id" type="hidden" value="${list.review_board_id}">
<table>
	<tr class="tr">
		<th>상품</th>
		<td colspan="6">${product_list.product_name }</td>
	</tr>
	<tr class="tr">
		<th><label id="title-label">제목</label></th>
		<td colspan="6">${list.review_board_title }</td>
	</tr>
	<tr class="tr">
	    <th><label>아이디</label>&nbsp;&nbsp;<span>${list.member_id }</span></th>
	    <fmt:formatDate value="${ list.review_board_date }" pattern="yyyy-MM-dd" var="date" />
	    <th><label>작성일</label>&nbsp;&nbsp;<span>${date}</span></th>
	    <th>
	    	<label>별점</label>&nbsp;&nbsp;
		    <span>
		    	<c:if test="${list.review_board_score == 1 }"><img class="star-image" id="starImage" src="images/star1.png" alt="" /></c:if>
		    	<c:if test="${list.review_board_score == 2 }"><img class="star-image" id="starImage" src="images/star2.png" alt="" /></c:if>
		    	<c:if test="${list.review_board_score == 3 }"><img class="star-image" id="starImage" src="images/star3.png" alt="" /></c:if>
		    	<c:if test="${list.review_board_score == 4 }"><img class="star-image" id="starImage" src="images/star4.png" alt="" /></c:if>
		    	<c:if test="${list.review_board_score == 5 }"><img class="star-image" id="starImage" src="images/star5.png" alt="" /></c:if>
		    </span>
	    </th>
	    <th><label>조회수</label>&nbsp;&nbsp;<span>${list.review_board_hit }</span></th>
	<tr>
		<td colspan="6">
			<label id="review-image"><img id="review-img" src="${list.review_board_img_path }" alt="" /></label>
			<div id="review-content">${list.review_board_content }</div>
			<br>
		</td>
	</tr>
</table>
</form>
</div>
<div id="comment">
<h2>댓글</h2>
<p id="reply">악의적인 비방글은 무통보 삭제된다는 점 유의해주세요^^</p>
<form action="replyW">
<input id="product_id" name="product_id" type="hidden" readonly value="${product_list.product_id }">
<input id="review_board_id" name="review_board_id" type="hidden" value="${list.review_board_id}">
<% String id = (String)session.getAttribute("member_id"); 
	if( id == null) {
%>
	<textarea placeholder="로그인 해주세요"></textarea><br>
<%	} else {
	%>
	<textarea name="review_reply_content"></textarea><br>
	<button type="submit" id="comment-button">댓글달기</button><br>
<%
	}
%>

</form>
<table>
<tr></tr>
<c:forEach var="dto" items="${reviewList }" varStatus="state">
<tr>
	<td><br>
	<form>
	<div id="comment-content">
		<input id="review_board_id" name="review_board_id" type="hidden" value="${list.review_board_id}">
		<input type="hidden" name="review_reply_id" value="${dto.review_reply_id }" />
		<c:if test="${dto.review_reply_depth == 1}"> &nbsp; &nbsp;<img src="images/re.png" style="width: 30px; height: 16px;"></c:if>
		<c:if test="${dto.review_reply_depth == 1}">&nbsp;</c:if><label id="comment-id">${dto.member_id }</label><br>
		<fmt:formatDate value="${dto.review_reply_date }" pattern="yyyy-MM-dd" var="date" />
	    <c:if test="${dto.review_reply_depth == 1}"> &nbsp; &nbsp;</c:if><label class="date">${ date }</label><br>
	    <c:if test="${dto.review_reply_depth == 1}"> &nbsp; &nbsp;</c:if>&nbsp;
	    
	    <c:set var="id" value="<%=id %>" scope="request" />
	    <c:if test="${dto.member_id != id}"><label class="comment">${dto.review_reply_content }</label></c:if>
		<c:if test="${dto.member_id == id}">
		<textarea style="background-color: white; height: 40px;" name="content2" >${dto.review_reply_content }</textarea><br>
	    <span id="comment-btns">
		    <button type="submit" formaction="replyM">수정</button>
			<button type="submit" formaction="replyD">삭제 </button>
		</span>
		</c:if>
    </div>
    </form>
    <c:if test="${dto.review_reply_depth == 0}">
    <details>
	    <summary> 댓글</summary>
	    <hr class="second-hr">
	    <div id="comment-write">
		    <form action="rereplyW">
		    <input id="product_id" name="product_id" type="hidden" readonly value="${product_list.product_id }">
			<input id="review_board_id" name="review_board_id" type="hidden" value="${list.review_board_id}">
			<input id="review_reply_id" name="review_reply_id" type="hidden" value="${dto.review_reply_id}">
<%
	if( id == null) {
%>
		<textarea placeholder="로그인 해주세요"></textarea><br>
<%	} else {
	%>
		<textarea name="reply_content"></textarea><br>
		<button type="submit" id="comment-button">댓글달기</button><br>
<%
	}
%>
			<br>
			</form>
		</div>
    </details>
    </c:if>
    <br>
	</td>

</tr>
</c:forEach>
</table>
</div>
<br>
<hr class="second-hr" style="border: solid 1px;">
<br>
<br>
<div id="button">
	<button id="toList" onclick="location.href='reviewMain'">목록으로</button>
	<div id="buttons">
		<button type="button" onClick="location.href='reviewM?review_board_id=${list.review_board_id}'">리뷰수정</button>
		<button type="button"
			onclick="window.open('reviewAlert?review_board_id=${list.review_board_id}','','width=600, height=200')">리뷰삭제 </button>
	</div>
</div>
<br>
<br>
<br>
<c:import url="../../footer.jsp"/>
<script src="js/user/qna/qnaM.js"></script>
</body>

</html>