<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/review/reviewProductChoice.css">
<script type="text/javascript"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<header><h2>상품3건</h2></header>
	<hr style="border: solid 2px;">
	  <form action="">
				<table>
					<tr>
						<th>선택</th>
						<th colspan="2">상품명</th>
					</tr>	
					<c:forEach var="dto" items="${list }" varStatus="state">
					<tr>
					    <td>
                          <input type="radio" name="product-choice" id="num${state.count }" value="${dto.product_id }"></td>
                      <td id="product-td">
                      	<img class="product-image" src="${dto.product_main_img_path }" alt="" />
                      </td>
                      <td>
                      	<label id="product-name">${dto.product_name }</label>
                      </td>
                    </tr>
                    </c:forEach>
                     </table>       
		<button id="first-btn" type="button" onclick="window.close()">취소</button>
		<button type="button" onclick="window.close()">확인</button>	
         </form>
</body>

 <script type="text/javascript">
 $("body").on("click", "[id^=num]", function(event) {
	 console.log(this.id);
	 var id = this.id;
	 var value = document.getElementById(id).value;
	 console.log(value);
	 if (value == 1) {
		 opener.document.getElementById("product-name").value = "Natural Ample 75ml";
		 opener.document.getElementById("product_id").value = value;
	 } else if (value == 2) {
		 opener.document.getElementById("product-name").value = "Natural BodyOil 200ml";
		 opener.document.getElementById("product_id").value = value;
	 } else if (value == 3) {
		 opener.document.getElementById("product-name").value = "Natural Cream 20ml";
		 opener.document.getElementById("product_id").value = value;
	 } else if (value == 4) {
		 opener.document.getElementById("product-name").value = "Natural Soap 100g";
		 opener.document.getElementById("product_id").value = value;
	 }
	 
 });
</script>
</html>