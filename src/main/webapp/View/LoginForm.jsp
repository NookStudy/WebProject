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
<script src="https://code.jquery.com/jquery-3.7.0.js"
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
<title></title>

<script>
//유효성검사
function isValidate(form) {
	if(form.id.value==""){
		alert("아이디를 입력하세요");
		form.name.focus();
		return false;
	}
	if (form.pass.value=="") {
		alert("패스워드를 입력하세요");
		form.pass.focus();
		return false;
	}
}

	$(function() {
		$('#id').focus();
		if ("${Login}"=="success"){
			console.log("${requestScope.Login }");
			console.log("${Login}");
			opener.parent.location.reload();
			window.close();
		}
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 쿠키값 없으면 공백.
	    var userLoginId = getCookie("userLoginId");
	    $("input[name='id']").val(userLoginId); 
	    
	    // ID가 있는경우 아이디 저장 체크박스 체크
	    if($("input[name='id']").val() != ""){
	    	$("#saveId").attr("checked", true);
	    }
	    
	    // 아이디 저장하기 체크박스 onchange
	    $("#saveId").change(function(){
	    	if($("#saveId").is(":checked")){  //checked true
	        	var userLoginId = $("input[name='id']").val();
	            setCookie("userLoginId", userLoginId, 30); // 30일 동안 쿠키 보관
	         }else{ //checked false
	         	deleteCookie("userLoginId");
	        }
	    });
	});
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}


</script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/53a8c415f1.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/login.css">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

.wrap {
	width: 100%;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background: rgba(0, 0, 0, 0.1);
}

.login {
	width: 400px;
	height: 600px;
	background: white;
	border-radius: 20px;
	display: flex;
	justify-content: left;
	align-items: center;
	flex-direction: column;
}

h2 {
	color: tomato;
	font-size: 2em;
}

.login_sns {
	padding: 20px;
	display: flex;
}

.login_sns li {
	padding: 0px 15px;
}

.login_sns a {
	width: 50px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 10px;
	border-radius: 50px;
	background: white;
	font-size: 20px;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px
		rgba(0, 0, 0, 0.1);
}

.login_id {
	margin-top: 20px;
	width: 80%;
}

.login_id input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_pw {
	margin-top: 20px;
	width: 80%;
}

.login_pw input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_etc {
	padding: 10px;
	width: 80%;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
}

.submit {
	margin-top: 50px;
	width: 80%;
}

.submit input {
	width: 100%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>
</head>

<body>
	<div class="wrap">
		<form action="${pageContext.request.contextPath }/member/login.do" method="post" onsubmit="return isValidate(this);" >
			<div class="login">
				<h2>Log-in</h2>
				<div class="login_sns">
<!-- 					<li><a href=""><i class="fab fa-instagram"></i></a></li> -->
<!-- 					<li><a href=""><i class="fab fa-facebook-f"></i></a></li> -->
<!-- 					<li><a href=""><i class="fab fa-twitter"></i></a></li> -->
				</div>
				<div class="login_id">
					<h4>ID</h4>
					<input type="text" name="id" id="id" placeholder="ID">
				</div>
				<div class="login_pw">
					<h4>Password</h4>
					<input type="password" name="pass" id="" placeholder="Password">
				</div>
				<div class="login_etc">
					<div class="checkbox">
						<label for="saveid" style=”cursor:pointer“><input type="checkbox" name="" id="saveId"> Remember Me? </label>
					</div>
<!-- 					<div class="forgot_pw"> -->
<!-- 						<a href="">Forgot Password?</a> -->
<!-- 					</div> -->
				</div>
				<div class="submit">
					<input type="submit" value="submit">
				</div>
			</div>
		</form>
	</div>
</body>
</html>