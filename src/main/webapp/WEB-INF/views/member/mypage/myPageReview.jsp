<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.ReviewBoardDto" %>
<%@ page import="java.util.List"%>

<%
		List<ReviewBoardDto> list = (List<ReviewBoardDto>)request.getAttribute("review_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/myPage/myPageBoard.css">
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/myPage.png"/>
	<h1>나의게시물</h1>
	<hr style="border: solid 2px;">
	<h2>리뷰게시물</h2>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
		<tr id="first-tr">
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>별점</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="dto" items="${ review_list }">	
		<tr onclick="location.href='reviewV?review_board_id=${dto.review_board_id }'">
			<td>${dto.review_board_id }</td>
			<td><img class="reviewImg" src="${dto.review_board_img_path }" onError="this.style.visibility='hidden'">${dto.review_board_title }.</td>
			<fmt:formatDate value="${ dto.review_board_date }" pattern="yyyy-MM-dd" var="review_board_date" />
			<td>${ review_board_date }</td>
			<td>
				<c:if test="${dto.review_board_score == 1 }"><img src="images/star1.png" class="star"></c:if>
				<c:if test="${dto.review_board_score == 2 }"><img src="images/star2.png" class="star"></c:if>
				<c:if test="${dto.review_board_score == 3 }"><img src="images/star3.png" class="star"></c:if>
				<c:if test="${dto.review_board_score == 4 }"><img src="images/star4.png" class="star"></c:if>
				<c:if test="${dto.review_board_score == 5 }"><img src="images/star5.png" class="star"></c:if>
			</td>
			<td>${dto.review_board_hit }</td>
		</tr>
		</c:forEach>
	</table>
	<br>
	<div id="search-bar">
		<select>
			<option>제목</option>
		</select>
		<input type="text">
		<input type="image" id="search-logo" src="images/search.png" style="border: solid 0.5px;"/>
	</div>
	<div id="btns">
		<button type="button" onclick="location.href='myPageQna'">Q&A게시물</button>
		<button type="button" onclick="location.href='myPageMain'">마이페이지</button>
	</div>
	
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
	<c:import url="../../footer.jsp"/>
</body>
</html>