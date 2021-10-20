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
</head>
<body>
<c:import url="../../header.jsp"/>
<div><img class="banner-image" src="images/banner.png"></div>
<br>
	<h2>문의글수정</h2>
	<br>
	<hr class="second-hr" style="border: solid 1px;">
	<form action="qnaMA">
		<input type="hidden" id="product_id" name="product_id" value="${qnaDto.product_id }" />
		<input type="hidden" id="qna_board_id" name="qna_board_id" value="${qnaDto.qna_board_id }" />
		<input type="hidden" id="member_id" name="member_id" value='<%=(String)session.getAttribute("member_id") %>' />
		<table>
			<tr>
				<th>구분</th>
				<td>
					<select id="qna-box" name="qna_board_type" onchange="select()">
					<c:if test="${qnaDto.qna_board_type eq '배송' }">
                    	<option selected="selected">배송</option>
                    	<option>상품</option>
                    </c:if>
                    <c:if test="${qnaDto.qna_board_type eq '상품' }">
                    	<option selected="selected">상품</option>
                    	<option>배송</option>
                    </c:if>	
                    </select>
                    <select id="product" name="product_id" style="display:none">
                    <c:if test="${qnaDto.product_id == 1 }">
                    	<option value="1" selected="selected">Natural Ample 75ml</option>
                        <option value="2">Natural BodyOil 200ml</option>
                        <option value="3">Natural Cream 20ml</option>
                        <option value="4">Natural Soap 100g</option>
                    </c:if>	
                    <c:if test="${qnaDto.product_id == 3 }">
                    	<option value="1">Natural Ample 75ml</option>
                        <option value="2" selected="selected">Natural BodyOil 200ml</option>
                        <option value="3">Natural Cream 20ml</option>
                        <option value="4">Natural Soap 100g</option>
                    </c:if>	
                    <c:if test="${qnaDto.product_id == 3 }">
	                    <option value="1">Natural Ample 75ml</option>
                        <option value="2">Natural BodyOil 200ml</option>
                        <option value="3" selected="selected">Natural Cream 20ml</option>
                        <option value="4">Natural Soap 100g</option>
                    </c:if>	
                    <c:if test="${qnaDto.product_id == 4 }">
	                    <option value="1">Natural Ample 75ml</option>
                        <option value="2">Natural BodyOil 200ml</option>
                        <option value="3">Natural Cream 20ml</option>
                        <option value="4" selected="selected">Natural Soap 100g</option>
                    </c:if>	
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
				<td colspan="6"><input id="qna-title" name="qna_board_title" value="${qnaDto.qna_board_title }" type="text"></td>
			</tr>
			<tr>
				<td colspan="6"><textarea id="content" name="qna_board_content" onkeydown="resize(this)" onkeyup="resize(this)">${qnaDto.qna_board_content }</textarea></td>
			</tr>
		</table>
		<div id="buttons">
			<button type="button"onclick="history.back()">취소</button>
			<button type="submit">수정</button>
		</div>
	</form>
	<br>
	<br>
	<c:import url="../../footer.jsp"/>
	<script>
	function select(){
		var qnaSelect = document.getElementById("qna-box");
		var selected = qnaSelect.options[qnaSelect.selectedIndex].text;
		if(selected == '상품'){
			product.style.display = "inline-block";
			}
		else{
			product.style.display = "none";
		}
	    
  }
  function resize(obj){
obj.style.height = '1px';
obj.style.height = (12 + obj.scrollHeight) + 'px';
}
	

</script>
<script src="js/user/qna/qnaM.js"></script>
</body>
</html>