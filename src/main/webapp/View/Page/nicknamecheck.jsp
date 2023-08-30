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
<title></title>
<script type="text/javascript">
    function nicknameUse(){
       
        opener.document.getElementById('nickname').value=
            document.overlapFrm.use_nickname.value;
        opener.document.getElementById('nicknamecheck').value ="Y";
        opener.document.getElementById('nicknamecheckbtn').setAttribute("disabled",true);
        opener.document.getElementById('nicknamecheckbtn').style.opacity=0.6;
        
//         $(opner.document,'#id').val($("#use_id").val());
        //아이디 중복 확인창을 닫아준다.
        self.close();
    }
    //문서의 로드가 끝난 후 익명함수를 실행한다.
    window.onload = function(){
	    //현재 주소창에 입력된 URL을 가져온다.
	    
	    console.log("paramnickname:${param.nickname}");
	    console.log("nicknamecheck:${nicknamecheck}");
	    console.log("nicknamepossible:${nicknamepossible}");
	 	var nickname = "${param.nickname}"
	 	var contextRoot = "${pageContext.request.contextPath}"
	    <c:if test="${nicknamecheck eq false}">
	    	window.location.href=contextRoot+'/member/checknickname.do?nickname='+nickname;
	    </c:if>
	    <c:if test="${nicknamecheck eq true}">
	    	<c:if test="${nicknamepossible eq true}">
			    $('#use_nickname').val("${param.nickname}");
			    $('#nickname_check').html("사용가능한 아이디 입니다.");
			    $('#nickname_check').css("color","blue");
		    </c:if>
		    <c:if test="${nicknamepossible eq false}">
			    $('#nickname').val('');
			    $('#nickname').focus();
			    $('#nickname_check').css("color","red");
			    $('#nickname_check').html("다른아이디를 입력해주세요");
		    </c:if>
	    </c:if>
// 	    document.getElementBynickname('retype_nickname').innerHTML = ${param.nickname};
	    
    }
</script>
</head>
<body>
	<div style="margin: 20px;">
	<h2>닉네임 중복확인</h2>
	 <form name="overlapFrm" action='../../member/checknickname.do' method="get">
        <input type="text" name="nickname" id="use_nickname" size="20"/>
        <c:if test="${nicknamepossible eq true}">
        <input type="button" type="button" value="닉네임사용하기" onclick="nicknameUse();"/>
        </c:if>
        <c:if test="${nicknamepossible eq false}">
        <input type="submit" value="닉네임중복체크"/>
        </c:if>
		<h4><span id="nickname_check"></span></h4>
    </form>
    </div>
</body>
</html>