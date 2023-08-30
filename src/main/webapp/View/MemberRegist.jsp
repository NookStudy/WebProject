<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- core 라이브러리 적용 --%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery 3.7.0 적용 -->
<script  src="https://code.jquery.com/jquery-3.7.0.js"
  	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" 
  	crossorigin="anonymous"></script>
<!-- BootStrap 5.3.1  및 4.6.2 적용 -->
<script 
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" 
	crossorigin="anonymous"></script>
<script 
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" 
	crossorigin="anonymous"></script>
<link rel="stylesheet" 
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" 
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" 
	crossorigin="anonymous">
<link 
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" 
	crossorigin="anonymous">
<!-- 주소찾기 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title></title>
<script>
function isValidate(frm) {
  	if(frm.id.value==''){
         alert("아이디를 입력하세요");
         frm.id.focus();
         return false;
     	 }
  	if(frm.idcheck.value!="Y"){
   	  alert("ID 중복검사를 해주세요");
         frm.id.focus();
         return false;
   	 }
  	if(frm.nicknamecheck.value!="Y"){
      	  alert("닉네임 중복검사를 해주세요");
          frm.nickname.focus();
          return false;
  	 }
    /*
        패스워드 입력은 2번 받아야 하므로 하나라도 입력값이 없다면
        경고창을 띄운다. 단, 포커스 이동은 하지 않는다.
    */
    if(!frm.pass.value||!frm.pass2.value){
        alert('패스워드를 입력하세요');
        return false;
    }
    if(frm.name.value==''){
        alert("이름을 입력하세요");
        frm.id.focus();
        return false;
        }
    if(frm.nickname.value==''){
        alert("닉네임을 입력하세요");
        frm.id.focus();
        return false;
        }
	if(frm.pass.value !=frm.pass2.value){
        alert('입력한 패스워드가 일치하지 않습니다.');
        //기존의 입력값을 지우기 위해 빈값을 할당한다.
        frm.pass.value='';
        frm.pass2.value='';
        //비밀번호 첫번째 항목으로 포커스를 이동한다.
        frm.pass2.focus();
        return false;
    }
}
//id변경시 중복체크 해제
function uncheckid(){
	$('#idcheck').val("N");
	document.getElementById('idcheckbtn').removeAttribute("disabled");
	document.getElementById('idcheckbtn').style.opacity=1;
}
//nicknmae변경시 중복체크 해제
function unchecknickname(){
	$('#nickamecheck').val("N");
	document.getElementById('nicknamecheckbtn').removeAttribute("disabled");
	document.getElementById('nicknamecheckbtn').style.opacity=1;
}
//아이디 중복체크를 위한 function
function idCheck(fn){
	<c:set var="idcheck" value="false" scope="session"/>
	console.log("idcheck:"+${idcheck});
	<c:set var="idpossible" value="false" scope="session"/>
	console.log("idpossible:"+${idpossible});
    if(fn.id.value==''){
        alert('아이디를 입력후 중복확인 해주세요');
        fn.id.focus();
    }else{
        /*
            부모창에서 입력된 아이디를 쿼리스트링을 통해 팝업창으로 전달한다.
            이 때 파라미터명은 id이고 전달된 값은 사용자가 입력한 아이디 이다.
        */
        //url, 창이름, 창속성
        window.open("../member/checkid.do?id="+fn.id.value,"idover",
        "width=500,height=250");
    }
}
function nicknameCheck(fn){
	<c:set var="nicknamecheck" value="false" scope="session"/>
	console.log("nicknamecheck:"+${nicknamecheck});
	<c:set var="nicknamepossible" value="false" scope="session"/>
	console.log("nicknamepossible:"+${nicknamepossible});
    if(fn.nickname.value==''){
        alert('닉네임을 입력후 중복확인 해주세요');
        fn.nickname.focus();
    }else{
        /*
            부모창에서 입력된 아이디를 쿼리스트링을 통해 팝업창으로 전달한다.
            이 때 파라미터명은 id이고 전달된 값은 사용자가 입력한 아이디 이다.
        */
        //url, 창이름, 창속성
        window.open("../member/checknickname.do?nickname="+fn.nickname.value,"nicknameover",
        "width=500,height=250");
    }
}
//주소찾기 API
function sample6_execDaumPostcode() {		
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
                document.getElementById("sample6_detailAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_detailAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
    function commonFocusMove(thisObj,numLength,nextObj) {
        var obj2 = document.getElementById(thisObj);
        var strLen2 = obj2.value.length;
        if(strLen2==numLength){
            document.getElementById(nextObj).focus();
        }
   	}
    //메일 선택자
    function mailchange(){
        var mail = document.getElementById("mailselector").value;
        
        console.log(mail);
        if (document.getElementById("mailselector").value=='') {
     		document.getElementById("mailaddr").value=mail;
			document.getElementById("mailaddr").disabled=false;	
		}else{
        document.getElementById("mailaddr").value=mail;
        document.getElementById("mailaddr").disabled=true;
		}
    }
    </script>
    <script>
    $(document).ready(function(){
    	setDateBox();
    });
    function setDateBox(){
    	var dt = new Date();
    	var year = dt.getFullYear();

    	$("#birthyear").append("<option value=''>년도</option>");
    	for(var y = (year); y >= (year-120); y--){
    		$("#birthyear").append("<option value='"+ y +"'>"+ y + "년" +"</option>");
    	}
	    	
    	$("#birthmonth").append("<option value=''>월</option>");
    	for(var i = 1; i <= 12; i++){
    		if(String(i).length == '1'){
    			$("#birthmonth").append("<option value='"+"0" + i +"'>"+"0" + i + "월" +"</option>");
    		}else{
    			$("#birthmonth").append("<option value='"+ i +"'>"+ i + "월" +"</option>");
    		}
    	}
    	$("#birthdate").append("<option value=''>일</option>");
    }
    function lastday(){ //년과 월에 따라 마지막 일 구하기 
    	var Year=document.getElementById('birthyear').value;
    	var Month=document.getElementById('birthmonth').value;
    	var day=new Date(new Date(Year,Month,1)-86400000).getDate();
        /* = new Date(new Date(Year,Month,0)).getDate(); */
    	var dayindex_len=document.getElementById('birthdate').length;
        console.log(dayindex_len+","+day)
    	if(day>dayindex_len){
    		for(var i=(dayindex_len); i<=day; i++){
    			if(String(i).length =='1'){
    			document.getElementById('birthdate').options[i] = new Option("0"+i+"일","0"+i);
    			}else{
    			document.getElementById('birthdate').options[i] = new Option(i+"일",i);
    			}
    		}
    	}
    	else if(day<dayindex_len){
    		for(var i=dayindex_len; i>=day; i--){
    			document.getElementById('birthdate').options[i+1]=null;
    		}
    	}
    }
    </script>
    
    <style>
        td{
            padding: 10px; border:1px solid rgb(229, 240, 245)
        }
        td#gray{
            background-color: #e2e2e2f3;
            font-weight: bold;
        }
        input, select{
            height: 25px;
        }
        span{
            height: 16px;
            line-height: 16px;
        }
        select{
            border: 0.5px solid rgb(163, 163, 163);
            height: 28px;
        }

    </style>
</head>
<body>
	<%@ include file="./NavBar.jsp" %>
	<div>
	<br> <br>
	</div>
	<form action="../member/regist.do" method="post" id="registForm" onsubmit="return isValidate(this);">
    <fieldset style="width: 80%; margin: auto;" >
             
            <table style="border: none; border-collapse: collapse; width:95%; " >
                <tr>
                    <div style="padding-left: 85%;"> <code style="color: red;">* </code>필수입력</div>
                    <td id="gray" > <code style="color: red;">* </code> 아이디</td>
                    <td style="font-size: 15px; color: gray;">
                    <input type="text" name="id" id="id" required="required" onkeydown="uncheckid();">&nbsp;
                    <button type="button" onclick="idCheck(this.form);" id="idcheckbtn"
                    	style="background-color: rgb(70, 70, 70); color:white;"
                    	> 중복확인</button>
                   	<input type="hidden" name="idcheck" id="idcheck" value="N" />
                         </td>
                </tr>
                <tr>
                    <td id="gray"><code style="color: red;">* </code>비밀번호</td>
                    <td><input type="password" style="width:150px;" name="pass2" id="pass2" required="required"></td>
                </tr>
                <tr>
                    <td  id="gray"><code style="color: red;">* </code>비밀번호 확인</td>
                    <td style="font-size: 15px; color: gray;">
                        <input type="password" style="width:150px;" name="pass" id="pass" required="required">(확인을 위해 다시 입력해 주세요.)</td>
                </tr>
                <tr>
                    <td id="gray"><code style="color: red;">* </code>이름</td>
                    <td ><input type="text" name="name" required="required" /></td>
                </tr>
                 <tr>
                    <td id="gray" > <code style="color: red;">* </code> 닉네임</td>
                    <td style="font-size: 15px; color: gray;">
                    <input type="text" name="nickname" id="nickname" onkeydown="unchecknickname();" required/>&nbsp;
                    <button type="button" onclick="nicknameCheck(this.form);" id="nicknamecheckbtn"
                    	style="background-color: rgb(70, 70, 70); color:white;"
                    	> 중복확인</button>  
                   	<input type="hidden" name="nicknamecheck" id="nicknamecheck" value="N" />
                        (게시판에 표현될 이름입니다.)</td>
                </tr>
                <tr>
                    <td id="gray">&nbsp;생년월일</td>
                    <td> 
                        <select name="birthyear" id="birthyear" ></select>
                        <select name="birthmonth" id="birthmonth"  onchange="lastday();"></select>
                        <select name="birthdate" id="birthdate" ></select>
                        &nbsp;
                        <input type="radio" name="gender" value="M" checked="checked"/>남자
                        &nbsp;
                        <input type="radio" name="gender" value="F"/>여자
                    </td>
                </tr>
                <tr>
                    <td rowspan="2"  id="gray"><span style="color:red">*</span>이메일</td>
                    <td style="padding-top: 15px;">
                    <input type="text" name="email1" id="email1" required="required"/>@ 
                    <input type="text" id="mailaddr" value="" name="email2" required="required"/> 
                        <select name="메일주소" id="mailselector" onchange="mailchange();">
                            <option value="">직접입력</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="naver.com">naver.com</option>
                            <option value="yahoo.com">yahoo.com</option>
                            <option value="nate.com">nate.com</option>
                        </select>
                    </td>
                    
                </tr>
                <tr>
                    <td style="color: gray; padding-bottom: 0; margin-bottom: 0;"><p style="font-size: 12px">※hanmail.net은 메일 수신이 어려울 수 있으니 가급적 다른 메일을 이용하시기 바랍니다.<br>email은 비밀번호 분실시 필요한 항목입니다.</p></td>
                </tr>
                <tr>
                    <td rowspan="3"  id="gray">&nbsp;주소</td>
                    <td>
                    <input type="text" style="width:90%px ;" id="sample6_postcode" placeholder="우편번호" name="postcode">(우편번호)
                    &nbsp;<button type="button" onclick="sample6_execDaumPostcode()" style="background-color: rgba(70, 70, 70); color: white;" type="button">주소찾기 </button>
                    </td>
                </tr>
                <tr>
                    <td><input type="text" style="width: 100%;" name="address1" id="sample6_address" placeholder="주소"></td>
                </tr>
                <tr>
                    <td><input type="text" style="width: 70%;" name="address2" id="sample6_detailAddress" placeholder="상세주소">  *나머지 주소</td>
                </tr>
                <tr>
                    <td id="gray">휴대전화 <code style="color: red;">* </code></td>
                    <td>
                        <input type="tel" size="3" name="phonenumber1" id="phone1" required="required" onkeyup="commonFocusMove('phone1',3,'phone2');">-
                        <input type="tel" size="4" style="width:80px" name="phonenumber2" required="required" id="phone2" onkeyup="commonFocusMove('phone2',4,'phone3');" >-
                        <input type="tel" size="4" style="width:80px" name="phonenumber3" required="required" id="phone3">
                    </td>
                </tr>
            </table>
            <br>
            <div style="text-align: center;">
            <button type="submit" style="background-color: rgb(231, 14,22) ;color:white; width:150px; height: 35px; font-size: 16px; border-radius: 5px; border: red;">등록하기</button>
            <button type="reset" style="background-color: rgb(70, 70, 70); color:white; width:150px; height: 35px; font-size: 16px; border-radius: 5px; border: gray;">새로쓰기</button>
            </div>
    </fieldset>
    </form>
</body>
</html>
