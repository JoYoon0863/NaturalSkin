<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/member/review/reviewW.css">
<script type="text/javascript"></script>
</head>

<body>
<c:import url="../../header.jsp"/>
<div><img class="banner-image" src="images/banner2.png"></div>
<div>
	<br>
	<h2>리뷰작성</h2>
	<br>
	<hr class="second-hr" style="border: solid 1px;">
		<form action="reviewWA" method="post" enctype="multipart/form-data">
		<table>
			<tr class="tr">
				<th>상품선택</th>
				<td colspan="6">
					<input id="product_id" name="product_id" type="hidden" readonly value=""> 
					<input id="product-name" name="product_name" type="text" readonly value=""> 
					<button id="product-choice" type="button" onclick="window.open('reviewProductChoice','','width=700, height=450')" >상품선택</button>                                                                                        
	           </td>
			</tr>
			<tr class="tr">
				<th><label id="title-label">제목</label></th>
				<td colspan="6"><input id="review-title" name="title" type="text"></td>
			</tr>
			<tr class="tr">
			    <th><label id="rating">별점</label></th>
			    <td>
                   <input type="radio" name="rating" value="1" id="rate1"><label for="rate1"><img class="star-image" src="images/star1.png" alt="" /> &nbsp;</label>
                   <input type="radio" name="rating" value="2" id="rate2"><label for="rate2"><img class="star-image" src="images/star2.png" alt="" /> &nbsp;</label>
                   <input type="radio" name="rating" value="3" id="rate3"><label for="rate3"><img class="star-image" src="images/star3.png" alt="" /> &nbsp;</label>
                   <input type="radio" name="rating" value="4" id="rate4"><label for="rate4"><img class="star-image" src="images/star4.png" alt="" /> &nbsp;</label>
                   <input type="radio" name="rating" value="5" id="rate5"><label for="rate5"><img class="star-image" src="images/star5.png" alt="" /></label>
               </td>
               <tr class="tr">
                   <th><label>첨부파일</label></th>
                   <td><input type="file" id="search-address" name="file" onchange="contentImg(event);" multiple="multiple" />
         
               </tr>
				<tr>
					<td colspan="6">
						<div id="contentImageContainer"></div><br><br>
						<textarea id="content" name="content" onkeydown="resize(this)" onkeyup="resize(this)"> 내용</textarea><br>
					</td>
				</tr>
				<tr>
		</table><br>
		<div id="buttons">
			<button type="submit">글쓰기</button>
			<button type="button" onclick="location.href='reviewMain'">취소</button>
		</div>
		<br><br><br>
	</form>
</div>
<c:import url="../../footer.jsp"/>
<script src="js/user/qna/qnaM.js"></script>
<script>
function contentImg(event) {
	for (var image of event.target.files) {
		var reader = new FileReader(); 
		reader.onload = function(event) { 
			var img = document.createElement("img"); 
			img.setAttribute("src", event.target.result); 
			document.querySelector("div#contentImageContainer").appendChild(img); 
		}; 
		console.log(image); reader.readAsDataURL(image); 
	} 
}
</script>
</body>

</html>