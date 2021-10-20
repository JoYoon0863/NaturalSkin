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
<link rel="stylesheet" href="css/admin/order/aOrderV.css">
<script type="text/javascript"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
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
	                    document.getElementById("receive_address").value = extraAddr;
	                
	                } else {
	                    document.getElementById("receive_address").value = '';
	                }
	
	                // 주소 정보를 해당 필드에 넣는다.
	                document.getElementById("receive_address").value = addr + extraAddr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("receive_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
</head>
<body>
	<h2>주문상세페이지</h2>
	<hr style="border: solid 1px;">
	<form action="aOrderViewUpdate">
		<input type="hidden" id="member_order_id" name="member_order_id" value="${orderDto.member_order_id }">
	
		<label>주문자아이디</label>
		<span>${orderDto.member_id }</span>
		<label>주문일</label>
		<fmt:formatDate value="${ orderDto.member_order_date }" pattern="yyyy-MM-dd" var="order_date" />
		<span>${order_date }</span>
		<label>결제금액</label>
		<span>${orderDto.member_order_price }원</span>
		<label>주문번호</label>
		<span>${orderDto.member_order_id }</span><br>
		<hr id="second-hr">
		<label>받는분이름</label><br>
		<input id="receive_name" name="receive_name" value="${orderDto.member_order_receive_name }" type="text"><br>
		<label>받는분주소</label><button id="search-address" type="button" onclick="sample5_execDaumPostcode()">주소찾기</button><br>
		<input id="receive_address" name="receive_address" value="${address[0] }" type="text"><br>
		<label>상세주소</label><br>
		<input id="receive_detailAddress" name="receive_detailAddress" value="${address[1] }" type="text"><br>
		<label>받는분전화번호</label><br>
		<input id="receive_phone" name="receive_phone" value="${orderDto.member_order_receive_phone }" type="text"><br>
		<label>주문상태</label><br>
		<select id="order_state" name="order_state">
			<option>${orderDto.member_order_state }</option>
			<option>배송준비중</option>
			<option>배송중</option>
			<option>배송완료</option>
			<option>주문취소요청</option>
			<option>주문취소완료</option>
		</select>
		<hr class="second-hr" style="border: solid 1px;">
		<div id="btns">
			<button type="button" onclick="window.close()">취소</button>
			<button type="submit">수정</button>
			<button type="button" onclick="window.open('aOrderAlert?member_order_id=${orderDto.member_order_id }','','width=600, height=200')">삭제</button>
		</div>
	</form>
</body>
</html>