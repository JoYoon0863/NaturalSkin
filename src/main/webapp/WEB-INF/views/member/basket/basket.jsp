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
<link rel="stylesheet" href="css/member/basket/basket.css">
</head>
<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/basket.png"/>
	<h1>장바구니</h1>
	<hr style="border: solid 2px;"><br>
	<table>
		<tr>
			<th>상품이름</th>	
			<th>판매가</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
		<input type="hidden" id="count" value="${count }" />
		<c:forEach var="dto" items="${list }" varStatus="state">
		<tr>
			<input type="hidden" id="basket_id${state.index }" value="${dto.basket_id }" >
			<td><img class="basketImg" src="${product_list[state.index].product_main_img_path }">${product_list[state.index].product_name }</td>	
			<td><fmt:formatNumber pattern="###,###,###" value="${product_list[state.index].product_price }" />원</td>
			<td><input id="productCount${state.index }" type='number' value="${dto.basket_amount }" min='1' max='999' step='1' /></td>
			<td><span id="sum${state.index }">${product_list[state.index].product_price * dto.basket_amount }</span>원</td>
			<td>
				<input type="hidden" id="basket_id" value="${dto.basket_id }">
				<input type="hidden" id="price${state.index }" value="${product_list[state.index].product_price }">
				<button type="button" id="delete${dto.basket_id }" class="delete" >삭제</button>
			</td>
		</tr>
		<input type="hidden" id="total${state.index }" value="${product_list[state.index].product_price * dto.basket_amount }">
		</c:forEach>
	</table>
	<button type="button" class="allDelete" style="float: right; margin-right: 7%;">장바구니비우기</button>
	<p style="clear: both; font-size: 1px">&nbsp;</p>
	<hr style="border: solid 2px;"><br>
	<table class="pay">
		<tr>
			<th>총상품금액</th>	
			<th>배송비</th>
			<th>결제예정금액</th>
		</tr>
		<tr>
			<td id="priceSum"></td>	
			<td>2,500원</td>
			<td id="priceTotal"></td>
		</tr>
	</table>	
	<hr style="border: solid 2px;"><br>
	<button type="button" onclick="window.open('order2','','width=1200, height=800');">주문하기</button><br><br>
	<c:import url="../../footer.jsp"/>
</body>

<script>
var count = document.getElementById("count").value;
var total2=0;
for( var i=0; i<count; i++ ) {
	total2 = total2 + document.getElementById("total"+i).value *1;
}
	console.log("총합 : " + total2);
	
	document.getElementById("priceSum").innerHTML = total2 + "원";
	document.getElementById("priceTotal").innerHTML = total2 + 2500 + "원";

$("body").on("click", "[id^=productCount]", function(event) {
	var count = document.getElementById("count").value;
    console.log(this.id);
    var vId = this.id;
    var amount = document.getElementById(vId).value;
    var basket_id;
    var price;
    var i;
    var tatal;
    var tatal2;
    for( i=0; i<100; i++ ) {
	    if(vId == "productCount"+i) {
	    	basket_num = document.getElementById("basket_id"+i).value;
	    	price = document.getElementById("price"+i).value;
	    	console.log("번호" +basket_id);
	    	console.log("금액"+price);
	    	break;
	    }

    }
    console.log(vId);
    console.log(amount);
    

    $.ajax({ // 컨트롤러와 통신
		type: 'POST',
		url: "/basket1",
		data: {"basket_num": basket_num, "amount":amount},
		success: function(data) {
			var data_num = Number( data );
			if (data_num >= 1) {
				document.getElementById("sum"+i).innerHTML= price * amount;
		
				/* 
				var a0 = document.getElementById("sum"+0).innerHTML;
				var a1 = document.getElementById("sum"+1).innerHTML;
				var a2 = document.getElementById("sum"+2).innerHTML;
				console.log("카운트 : "+count);
				console.log("a0 : "+a0);
				console.log("a1 : "+a1);
				console.log("a2 : "+a2);
		 */
				var arrNumber = new Array();
		 		total2 = 0;
		 		for(var a=0; a<count; a++) {
		 			arrNumber[a] = document.getElementById("sum"+a).innerHTML;
		 			console.log("리스트 : " + arrNumber[a]);
		 			total2 = total2 + arrNumber[a] * 1;
		 			console.log("total2 : " + total2);
		 		}
				console.log("총합 : " + count);
				
				
				document.getElementById("priceSum").innerHTML = total2 + "원";
				document.getElementById("priceTotal").innerHTML = total2 + 2500 + "원";

			} 
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});



});

$("body").on("click", "[id^=delete]", function(event) {
    
    console.log(this.id);
    var vId = this.id;
    var basket_id = document.getElementById("basket_id").value;
    console.log(basket_id);
    
    $.ajax({ // 컨트롤러와 통신
		type: 'POST',
		url: "/basket",
		data: {"basket_id": basket_id},
		success: function(data) {
			location.href = "/basket";
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});
});

$(".allDelete").click(function(){
    
    var id = '<%=(String)session.getAttribute("member_id")%>';
    console.log(id);
    
    $.ajax({ // 컨트롤러와 통신
		type: 'POST',
		url: "/basket",
		data: {"id": id},
		success: function(data) {
			location.href = "/basket";
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});
});

</script>
</html>