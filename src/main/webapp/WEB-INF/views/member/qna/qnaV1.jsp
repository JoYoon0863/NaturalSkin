<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/qna/qnaV1.css">
</head>

<body>
	<c:import url="../../header.jsp" />
	<div><img class="banner-image" src="images/banner.png"></div>
	<br>
	<h2>문의내용 상세보기</h2>
	<br>
	<hr class="second-hr" style="border: solid 1px;">
	<input type="hidden" id="qna_board_id" name="qna_board_id" value="${qnaDto.qna_board_id }">
	<table>
		<tr>
			<th>구분</th>
			<td>${qnaDto.qna_board_type }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="6">				
				${qnaDto.qna_board_title }<c:if test="${qnaDto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${qnaDto.member_id }</td>
			<th>작성일</th>
			<fmt:formatDate value="${qnaDto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_board_date" />
			<td>${qna_board_date }</td>
			<th>조회수</th>
			<td>${qnaDto.qna_board_hit }</td>
		</tr>
		<tr>
			<td id="content" colspan="6">${qnaDto.qna_board_content }</td>
		</tr>
	</table>
	<div id=btn>
		<button onclick="location.href='qnaMain'" >목록으로</button>
		<div id="buttons">
			<button type="button" onclick="location.href='qnaM?qna_board_id=${qnaDto.qna_board_id }'">수정</button>
			<button type="button"
				onclick="window.open('qnaAlert?qna_board_id=${qnaDto.qna_board_id }','','width=600, height=200')">삭제</button>
		</div>
	</div>
	<br>
	<br>
	<c:import url="../../footer.jsp" />
</body>

</html>