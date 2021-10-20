<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/admin/product/productW.css">
<script type="text/javascript"></script>
<script> 
	function mainImg(event) { 
		var reader = new FileReader(); 
		reader.onload = function(event) { 
			var img = document.createElement("img"); 
			img.setAttribute("src", event.target.result); 
			document.querySelector("div#mainImageContainer").appendChild(img); 
			}; 
		reader.readAsDataURL(event.target.files[0]); 
	} 
	
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

</head>
<body>
	<h2>상품등록</h2>
	<hr style="border: solid 1px;">
	<form action="aProductWA" method="post" enctype="multipart/form-data">
		<label>카테고리</label>
		<select name="product_category">
			<option>클렌저</option>
			<option>로션&크림</option>
			<option>앰플&세럼</option>
			<option>오일</option>
		</select><br>
		<label>상품명</label><br>
		<input id="product_name" name="product_name" type="text"><br>
		<label>재고</label><br>
		<input id="product_stock" name="product_stock" type="text"><br>
		<label>가격</label><br>
		<input id="product_price" name="product_price" type="text"><br>
		<label>대표이미지</label>
		<input type="file" id="search-address" name="file" onchange="mainImg(event);" /><br>
		<div id="mainImageContainer"></div>
<!-- 	<button id="search-address" type="button">파일찾기</button><br>
		<input placeholder="두개이상 파일은 , 으로구분해주세요" value="" type="text"><br> -->
		<label>제품상세이미지</label>
		<input type="file" id="search-address" name="file2" onchange="contentImg(event);" multiple="multiple" /><br>
		<div id="contentImageContainer"></div>
		<!-- <button id="search-address" type="button">파일찾기</button><br>
		<input placeholder="두개이상 파일은 , 으로구분해주세요" value="" type="text"><br> -->
		<label>제품상세정보</label><br>
		<textarea id="product_content" name="product_content"></textarea>
		<hr class="second-hr" style="border: solid 1px;">
		<div id="btns">
			<button type="button" onclick="window.close()">취소</button>
			<button type="submit">저장</button>
		</div>
	</form>
</body>
</html>