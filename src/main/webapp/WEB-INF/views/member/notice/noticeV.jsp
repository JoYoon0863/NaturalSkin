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
<link rel="stylesheet" href="css/member/notice/noticeV.css">
<script type="text/javascript"></script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img id="noticemain" src="images/notice.png">
	<br>
	<br>
	<h2>공지사항 상세보기</h2>
	<br>
	<hr style="border: solid 2px;">
	<input type="hidden" id="notice_board_id" name="notice_board_id" value="${noticeBoardDto.notice_board_id }">
	<table>
	<tr class="tr">
		<th id="firstTh">제목</th>
		<td colspan="5">${ noticeBoardDto.notice_board_title }</td>
	</tr>
	<tr class="tr">
		<th>아이디</th>
		<td>${noticeBoardDto.member_id }</td>
		<th>작성일</th> 
		<td>
			<fmt:formatDate value="${ noticeBoardDto.notice_board_date }" pattern="yyyy-MM-dd" var="noticeBoard_date" />
			${noticeBoard_date }
		</td>
		<th>조회수</th>
		<td>${noticeBoardDto.notice_board_hit }</td>
	</tr>
	<tr>
		<td colspan="6">${noticeBoardDto.notice_board_content }</td>
	</tr>
	</table>
		<div id="btns">
			<button type="button" onclick="location.href='noticeMain'">&nbsp;목록&nbsp;</button>
		</div>
	<br>
	<br>
	<c:import url="../../footer.jsp"/>
</body>
</html>