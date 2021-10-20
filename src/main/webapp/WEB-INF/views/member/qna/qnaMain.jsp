<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.naturalskin.dto.QnaDto" %>
<%@ page import="java.util.List"%>

<%
		List<QnaDto> list = (List<QnaDto>)request.getAttribute("qna_list");
		System.out.println( "list count:" + list.size() );
		String list_page = (String)request.getAttribute("page");
		System.out.println( "list_page:" + list_page );
		
		String id = (String)session.getAttribute("member_id"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/qna/qnaMain.css">
<script type="text/javascript"></script>
<script>
    function login_check(){ 
         var id = '<%=(String)session.getAttribute("member_id")%>';

          if(id=="null"){ 
             alert("로그인 후 이용가능합니다.", "error"); 
          }
          else{
        	  location.href='qnaW';
          }
    }   
</script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<div><img class="banner-image" src="images/banner.png"></div>
	<h1>Q&A</h1>
	<hr style="border: solid 2px;">
	<table>
	<tr id="first-tr">
		<th>번호</th>
		<th>구분</th>
		<th>제목</th>
		<th>아이디</th>
		<th>작성일</th>
	</tr>
	<c:forEach var="dto" items="${qna_list }" varStatus="status">
		<c:if test="${dto.member_id != 'admin' }">
			<tr onclick="location.href='qnaV1?qna_board_id=${dto.qna_board_id }'">
	    </c:if>
	    <c:if test="${dto.member_id eq 'admin' }">
			<tr onclick="location.href='qnaV2?qna_board_id=${dto.qna_board_id }'">
	    </c:if>

		<td>${dto.qna_board_id }</td>
		<td>${dto.qna_board_type }</td>
		<c:if test="${dto.member_id != 'admin' }">
			<td>${dto.qna_board_title }
				<c:if test="${dto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if>
			</td>
		</c:if>
		
		<c:if test="${dto.member_id eq 'admin' }">
			<td><img id="re" src="images/re.png">${dto.qna_board_title }<c:if test="${dto.qna_board_lock eq '1' }"><img id="lock" src="images/lock.png" alt="잠금" /></c:if></td>
		</c:if>
		<td>${dto.member_id }</td>
		<%-- <td>${dto.qna_board_date }</td> --%>
		<fmt:formatDate value="${ dto.qna_board_date }" pattern="yyyy-MM-dd" var="qna_date" />
		<td>${ qna_date }</td>
	</tr>
	</c:forEach>
	</table>
	<div id="btn">
		<div id="search-bar">
			<select id="select-box" onchange="roleClick()">
				<option>아이디</option>
				<option>구분</option>
				<option>제목</option>
			</select>
			<input id="input" type="text">
			<img id="search-logo" src="images/search.png" style="border: solid 0.5px;">
		</div>
		<button id="button1" type="button" onclick="login_check();">글쓰기</button>
	</div>
	<nav aria-label="...">
	  	<ul class="pagination">
	  		<li class="page-item disabled">
		      	<span class="page-link">&lt;</span>
		    </li>
	  		<c:forEach begin="0" end="${count }" step="10" varStatus="status">
			<li>
				<a class="page-link" href="qaMain?page=${status.count }">${status.count }</a>
			</li>
		    </c:forEach>
	    	<li class="page-item">
		      	<a class="page-link">&gt;</a>
		    </li>
	  	</ul>
	</nav>
	<br><br><br>
	<c:import url="../../footer.jsp"/>
	<script></script>
</body>
</html>