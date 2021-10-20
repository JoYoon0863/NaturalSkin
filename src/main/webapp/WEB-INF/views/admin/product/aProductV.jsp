<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/admin/product/productV.css">
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
	<h2>상품상세</h2>
	<hr style="border: solid 1px;">
	<form action="aProductA" method="post" enctype="multipart/form-data">
		<input id="product_id" name="product_id" value="${productDto.product_id }" type="hidden">
		<label>카테고리</label><br>
		<select name="product_category">
			<option>${productDto.product_category }</option>
			<option>클렌저</option>
			<option>로션&크림</option>
			<option>앰플&세럼</option>
			<option>오일</option>
		</select><br>
		<label>상품명</label><br>
		<input id="product_name" name="product_name" value="${productDto.product_name }" type="text"><br>
		<label>재고</label><br>
		<input id="product_stock" name="product_stock" value="${productDto.product_stock }" type="text"><br>
		<label>가격</label><br>
		<input id="product_price" name="product_price" value="${productDto.product_price }" type="text"><br>
		<label>대표이미지</label>
		<input type="file" id="search-address" name="file" onchange="mainImg(event);"><br>
		<div id="mainImageContainer"></div>
		<input type="hidden" id="search-address" name="file3" value="${productDto.product_main_img_path }">
		<label>제품상세이미지</label>
		<input type="file" id="search-address" name="file2" multiple="multiple" onchange="contentImg(event);"/><br>
		<div id="contentImageContainer"></div>
		<input type="hidden" id="search-address" name="file4" multiple="multiple" value="${productDto.product_content_img_path }" />
		<label>제품상세정보</label><br>
		<textarea name="product_content">${productDto.product_content }</textarea>
		<hr class="second-hr" style="border: solid 1px;">
		<div id="btns">
			<button type="button" onclick="window.close()">취소</button>
			<button type="submit">수정</button>
			<button type="button" onclick="window.open('aProductAlert','','width=600, height=200')">삭제</button>
		</div>
	</form>
</body>
</html>