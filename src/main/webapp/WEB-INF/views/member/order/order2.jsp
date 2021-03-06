<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/member/order/order.css">
</head>
<body>
	<header><h3>주문하기</h3></header>
	<form action="orderAction">
	<table class="order">
		<tr>
			<th>주문상품[1건]</th>	
			<th>상품명</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
		<c:forEach var="dto" items="${basket }" varStatus="state">
		<tr>
			<td><img id="img" class="orderImg" src="${product_list[state.index].product_main_img_path }"></td>
			<td>${product_list[state.index].product_name }</td>
			<td>
				${dto.basket_amount }
				<input type="hidden" name="amount" value="${dto.basket_amount }"/>
				<input type="hidden" name="product_id" value="${dto.product_id }"/>
			</td>
			<td>
				<span>${product_list[state.index].product_price * dto.basket_amount}원</span>
				<input type="hidden" id="price${state.index }" name="price" value="${product_list[state.index].product_price * dto.basket_amount}"/>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td></td>
			<td>총상품금액</td>
			<td><input type="text" id="total" name=total style="background-color: white;text-align: center;"></td>
		</tr>
	</table>
	<h3 style="margin-left: 7.5%;">배송정보</h3>
	<div class="main">
		<div class="recipient">
			<div><input id="checkBox" type="checkbox" onchange="onChangeHandler()">주문자 정보와 동일</div>
			<!-- <p style="clear: both; font-size: 1px">&nbsp;</p> -->
			<label>받는사람</label><br>
			<input type="text" id="name" name="name"><br>
			<label>주소</label>
			<button type="button" id="search-address" onclick="sample5_execDaumPostcode()">주소찾기</button><br>
			<input type="text" id="address" name="address"><br>
			<input type="text" id="detailAddress" name="detailAddress"><br>
			<label>전화번호</label><br>
			<input type="text" id="phone" name="phone"><br>
		</div>
		<div class="orderer">
			<h4>주문자정보</h4>
			<label>고객명</label><br>
			<input type="text" id="orderName" value="${dto.member_name }"><br>
			<label>전화번호</label><br>
			<input type="text" id="orderPhone" value="${dto.member_phone }"><br>
			<label>이메일</label><br>
			<input type="email" id="orderEmail" value="${dto.member_email }"><br>
			<input type="hidden" id="address1" value="${address[0] }"><br>
			<input type="hidden" id="address2" value="${address[1] }"><br>
		</div>
	</div>
	<h3 style="margin-left: 7%;">결제정보 및 금액</h3>
	<hr style="border: solid 2px; margin-left: 7%; margin-right: 7%;">
	<table class="payment">
		<tr>
			<th>결제방법 선택</th>
			<td>
				<input class="radio" type="radio" name="radio" value="무통장입금" />무통장입금&nbsp;&nbsp;
				<input class="radio" type="radio" name="radio" value="신용카드" />신용카드&nbsp;&nbsp;
				<input class="radio" type="radio" name="radio" value="핸드폰결제" />핸드폰결제
			</td>
		</tr>
		<tr>
			<th>배송비</th>
			<td>2,500원</td>
		</tr>
		<tr>
			<th>총 결제 금액</th>
			<td>
				<input type="hidden" id="count" name="count" value="${count }" />
				<input type="text" id="sum" name=sum style="background-color: white;">
			</td>
		</tr>
	</table>
	<div id="btns">
		<button type="button" onclick="window.close()">취소</button>
		<button type="submit">결제하기</button>
	</div>
	</form>

</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var count = document.getElementById("count").value;
var total2=0;
for( var i=0; i<count; i++ ) {
	total2 = total2 + document.getElementById("price"+i).value *1;
}
	console.log("총합 : " + total2);
	document.getElementById('total').value = total2;
	document.getElementById('sum').value = total2 + 2500;
	
function onChangeHandler() {
	var check = document.getElementById('checkBox').checked;

	console.log(check);

	if( check == true ) {
		console.log('o');
		document.getElementById('name').value = document.getElementById('orderName').value;
		document.getElementById('address').value = document.getElementById('address1').value;
		document.getElementById('detailAddress').value = document.getElementById('address2').value;
		document.getElementById('phone').value = document.getElementById('orderPhone').value;
		
	} else {
		console.log('x');
		document.getElementById('name').value = "";
		document.getElementById('address').value = "";
		document.getElementById('detailAddress').value = "";
		document.getElementById('phone').value = "";
	}
}

function sample5_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("address").value = extraAddr;
            
            } else {
                document.getElementById("address").value = '';
            }

            // 주소 정보를 해당 필드에 넣는다.
            document.getElementById("address").value = addr + extraAddr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>	
</html>