<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="css/admin/qna/aQnaV.css">
</head>

<body>
	<h2>Q&A상세보기</h2>
	<input type="hidden" id="parents_id" name="parents_id" value="${dto.qna_board_id }">
	<br>
	<hr class="second-hr" style="border: solid 1px;">
	<table>
		<tr>
			<th>구분</th>
			<td>${dto.qna_board_type }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${dto.qna_board_title }<c:if test="${dto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${dto.member_id }</td>
			<th>작성일</th>
			<!-- <td>2021-09-07</td> -->
			<fmt:formatDate value="${dto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_board_date" />
			<td>${qna_board_date }</td>
		</tr>
		<tr>
			<td id="content" colspan="6">${dto.qna_board_content }</td>
		</tr>
	</table>

	<h2>답변</h2>
	<form action="aQnaV1ViewUpdate">
		<input type="hidden" id="qna_board_id" name="qna_board_id" value="${qnaDto.qna_board_id }">
		<br>
		<hr class="second-hr" style="border: solid 1px;">
		<table>
			<tr>
				<th>아이디</th>
				<td>${qnaDto.member_id }</td>
				<th>작성일</th>
				<!-- <td>2021-09-07</td> -->
				<fmt:formatDate value="${qnaDto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_board_date" />
				<td>${qna_board_date }</td>
				<th>조회수</th>
				<td>${qnaDto.qna_board_hit }</td>
			</tr>
			<tr>
				<td colspan="6"><textarea name="qna_board_content">${qnaDto.qna_board_content }</textarea></td>
			</tr>
		</table>
		<div id="adminPageButtons">
			<button type="button" onClick="window.close()">취소</button>
			<button type="submit">수정</button>
			<button type="button"
				onclick="window.open('aQnaAlert2V','','width=600, height=200')">삭제</button>
		</div>
	</form>
</body>
</html>