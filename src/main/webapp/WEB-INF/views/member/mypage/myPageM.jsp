<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/mypage/myPageM.css">

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
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/myPage.png"/>
	<h1>회원정보</h1>
	<hr style="border: solid 2px;">
	<form action="myPageMAction">
		<div id="first-div">
			<label>아이디</label><br>
			<input id="member_id" name="member_id" value="${memberDto.member_id }" readonly style="border:none">
		</div><br>
		<label>비밀번호</label><br>
		<input id="member_pw" name="member_pw" value="${memberDto.member_pw }" type="password"><br>
		<label>비밀번호 확인</label><br>
		<input type="password"><br>
		<label>이름</label><br>
		<input id="member_name" name="member_name" value="${memberDto.member_name }" type="text"><br>
		<label>생년월일</label><br>
		<div id="birth">
			<input id="birthdayY" name="birthdayY" value="${birthday[0] }" type="text">
			<input id="birthdayM" name="birthdayM" value="${birthday[1] }" type="text">
			<input id="birthdayD" name="birthdayD" value="${birthday[2] }" type="text">
		</div>
		<label>성별</label><br>
		<select id="member_gender" name="member_gender">
			<option>${memberDto.member_gender }</option>
			<c:if test="${memberDto.member_gender eq '남자'}">
				<option>여자</option>
			</c:if>
			<c:if test="${memberDto.member_gender eq '여자'}">
				<option>남자</option>
			</c:if>
		</select><br>
		<label>주소</label><button id="search-address" type="button" onclick="sample5_execDaumPostcode()">주소찾기</button><br>
		<input id="address" name="address" value="${address[0] }" type="text"><br>
		<label>상세주소</label><br>
		<input id="detailAddress" name="detailAddress" value="${address[1] }" type="text"><br>
		<label>전화번호</label><br>
		<input id="member_phone" name="member_phone" value="${memberDto.member_phone }" type="text"><br>
		<label>이메일</label><br>
		<input id="member_email" name="member_email" value="${memberDto.member_email }" type="email"><br><br>

		<div id="btns">
			<button type="button" onclick="location.href='myPageMain'">마이페이지</button>
			<button type="submit">회원정보 수정</button>
			<button type="button" onclick="window.open('quitAlert','','width=600, height=200');">회원탈퇴</button>
		</div>
	</form><br><br>

	<c:import url="../../footer.jsp"/>
</body>
</html>