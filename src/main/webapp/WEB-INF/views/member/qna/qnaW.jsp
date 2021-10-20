<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/qna/qnaW.css">
<script type="text/javascript"></script>
<script src="js/member/qna/qnaW.js"></script>
<script>
if(document.getElementById("secret-check").checked) {
    document.getElementById("secret-check_hidden").disabled = true;
}
	
</script>
</head>
<body>
	<c:import url="../../header.jsp"/>
	<div><img class="banner-image" src="images/banner.png"></div>
	<div>
	    <br>
		<h2>문의하기</h2>
		<br>
		<hr class="second-hr" style="border: solid 1px;">
		<form action="qnaWA">
		<input type="hidden" id="member_id" name="member_id" value='<%=(String)session.getAttribute("member_id") %>' />
			<table>
				<tr>
					<th>구분</th>
					<td>
						<select id="qna-box" name="qna_board_type" onchange="select()">
	                    	<option>배송</option>
	                        <option>상품</option>
	                    </select>
	                    <select id="product" name="product_id" style="display:none">
	                    	<option value="0">상품을 선택하세요</option>
	                        <option value="1">Natural Ample 75ml</option>
	                        <option value="2">Natural BodyOil 200ml</option>
	                        <option value="3">Natural Cream 20ml</option>
	                        <option value="4">Natural Soap 100g</option>
	                     </select>
	                </td>                                                  
					<td>
						<div>비밀글
							<input type="checkbox" id="secret-check" name="qna_board_lock" value="1" />
							<input type="hidden" id="secret-check_hidden" name="qna_board_lock" value='0' />
						</div>
					</td>
				</tr>
				<tr>
					<th><label id="title-label">제목</label></th>
					<td colspan="6"><input id="qna-title" name="qna_board_title" type="text"></td>
				</tr>
				<tr>
					<td colspan="6"><textarea id="content" name="qna_board_content" onkeydown="resize(this)" onkeyup="resize(this)"> 배송문의입니다.</textarea></td>
				</tr>
			</table>
			<div id="buttons">
				<button type="submit">글쓰기</button>
				<button type="button" onclick="history.back()">취소</button>
			</div>
		</form>
	</div>
	<br>
	<br>
<c:import url="../../footer.jsp"/>
</body>

</html>