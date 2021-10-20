<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/css/member/join/join.css">
<script type="text/javascript"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>

function idCheck() {
	var member_id = document.getElementById("member_id").value;
	console.log(member_id);

	$.ajax({
		url : '/idcheck',
		data: {"id": member_id},
		success : function(data) {
			console.log("1 = 중복됨, 0 = 중복안됨 : "+ data);							
			
			var data_num = Number( data );
			
			if (data_num >= 1) {
				// 1 : 아이디가 중복되는 문구
				document.getElementById("member_id_check").innerHTML="중복된 아이디입니다.";
			} else {
				// 0 : 아이디가 안됨.
				document.getElementById("member_id_check").innerHTML="사용가능한 아이디입니다.";
			}
		}, 
		error : function() {
				console.log("실패");
		}
	});
}

	function join2Action() {
		  var id = document.getElementById("member_id");
		  var pw = document.getElementById("member_pw");
		  var pwCheck = document.getElementById("pwCheck");
		  var name = document.getElementById("member_name");
		  var birthdayY = document.getElementById("birthdayY");
		  var birthdayM = document.getElementById("birthdayM");
		  var birthdayD = document.getElementById("birthdayD");

		  if (id.value == "") {
			  document.getElementById("member_id_check").innerHTML="아이디를 입력하세요."
			  id.focus();
			  return false; 
		  };
		  
		  var isIdCheck = /^[a-z]{1}[a-zA-Z0-9_-]{4,19}$/;
		  
		  if (!isIdCheck.test(id.value)) {
			  document.getElementById("member_id_check").innerHTML="소문자 + 숫자 + 특수문자(- _)만 사용가능(5~20자 이내)";
			  id.focus();
			  return false;
		  }
		  
		  //비밀번호 영문자+숫자+특수조합(8~16자리 입력) 정규식
		  var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;

		  if (!pwdCheck.test(pw.value)) {
			  document.getElementById("pwCheckText1").innerHTML="비밀번호는 영문자+숫자+특수문자 조합으로 8~16자리 사용해야 합니다.";
			  pw.focus();
			  return false;
		  }
		  else if( pw.value != pwCheck.value ) {
			  document.getElementById("pwCheckText2").innerHTML="비밀번호가 일치하지 않습니다.";
			  pwCheck.focus();
			  return false;
		  };
		  
		  if (name.value == "") { 
			  document.getElementById("nameCheckText").innerHTML="이름을 입력하세요.";
			  name.focus(); 
			  return false; 
		  };

		  if (birthdayY.value == "") {
			  document.getElementById("birthdayYCheckText").innerHTML="태어난 년도 4자리를 정확하게 입력하세요.";
		      birthdayY.focus();
		      return false;
		  } else {
			  document.getElementById("birthdayYCheckText").innerHTML="";
		  };
		  
		  if (birthdayM.value == "") {
			  document.getElementById("birthdayMCheckText").innerHTML="태어난 월(날짜) 2자리를 정확하게 입력하세요.";
			  birthdayM.focus();
			  return false;
		  } else {
			  document.getElementById("birthdayMCheckText").innerHTML="";
		  };
		  
		  if (birthdayD.value == "") {
			  document.getElementById("birthdayDCheckText").innerHTML="태어난 일(날짜) 2자리를 정확하게 입력하세요.";
			  birthdayD.focus();
			  return false;
		  } else {
			  document.getElementById("birthdayDCheckText").innerHTML="";
		  };
		  
		  document.getElementById("check").submit();
	}
	
	function pwcheckFunc() {
		var pw = document.getElementById("member_pw").value;
		var pwCheck = document.getElementById("pwCheck").value;
		
		if( pwCheck == "" ) {
			document.getElementById("pwCheckText2").innerHTML="";
		}
		else if( pw != pwCheck ) {
			document.getElementById("pwCheckText2").innerHTML="비밀번호가 일치하지 않습니다.";
		}
		else {
			document.getElementById("pwCheckText2").innerHTML="";
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
</head>
<body>
	<c:import url="../../header.jsp"/>
	<img class="mainImg" src="images/join.png"/>
	<h1>회원가입</h1>
	<hr style="border: solid 2px;">
	<form class="userInfo" id="check" action="join2Action">
		<label>아이디</label><br>
		<input type="text" class="id" id="member_id" name="member_id" oninput="idCheck();" placeholder="아이디를 입력하세요(5~20자)" /><br>
		<label id="member_id_check"></label><br>
		<label>비밀번호</label><br>
		<input type="password" id="member_pw" name="member_pw" placeholder="비밀번호는 영문자+숫자+특수문자 조합으로 8~16자리 사용해야 합니다."><br>
		<label id="pwCheckText1"></label><br>
		<label>비밀번호 확인</label><br>
		<input type="password" id="pwCheck" name="pwCheck" onkeyup="pwcheckFunc()"><br>
		<label id="pwCheckText2"></label><br>
		<label>이름</label><br>
		<input type="text" id="member_name"  name="member_name"><br>
		<label>생년월일</label><br>
		<div id="birth">
			<input type="text" id="birthdayY" name="birthdayY" placeholder="년(4자)" maxlength="4">
			<input type="text" id="birthdayM" name="birthdayM" placeholder="월(2자)" maxlength="2">
			<input type="text" id="birthdayD" name="birthdayD" placeholder="일(2자)" maxlength="2">
		</div>
		<label id="birthdayYCheckText"></label><label id="birthdayMCheckText"></label><label id="birthdayDCheckText"></label><br>
		<label>성별</label><br>
		<select name="member_gender">
			<option>남자</option>
			<option>여자</option>
			<option>선택안함</option>
		</select><br>
		<label>주소</label><button type="button" id="search-address" onclick="sample5_execDaumPostcode()">주소찾기</button><br>
		<input type="text" id="address" name="address"><br>
		<label>상세주소</label><br>
		<input type="text" id="detailAddress" name="detailAddress"><br>
		<label>전화번호</label><br>
		<input type="text" name="member_phone" placeholder="xxx-xxxx-xxxx"><br>
		<label>이메일</label><br>
		<input type="email" name="member_email" placeholder="xxxxxx@gmail.com"><br>
		
		<!-- <button type="submit" id="save" class="btn">가입하기</button> -->
		<button type="button" id="save" class="btn" onclick="join2Action();">가입하기</button>

	</form>
	<br><br>
	<c:import url="../../footer.jsp"/>
</body>
</html>