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
<script>
$(function () {	
	<c:if test="${empty flag}" var="result">
		alert("접근권한이 없습니다.");
		location.href='${pageContext.request.contextPath}/noticeboard/list.do';
		
	</c:if>
	<c:if test="${not empty flag}" var="result">
		if (session.getAttribute("flag") != 0 ) {
			alert("관리자만 접근 가능한 페이지입니다.");
			location.href='${pageContext.request.contextPath}/noticeboard/list.do';
		}
	</c:if>
});
$(window).on("beforeunload", function () {
   	 	<% session.removeAttribute("flag");%>
   	
});
// $(function () {
// 	if (${id} != 'admin') {
	
// 		alert('관리자만 접근 가능한 페이지입니다.');
// 		location.href='${pageContext.request.contextPath}/noticeboard/list.do';
// 	}
// });
// 	function validateForm(form) {
// 		if(form.name.value==""){
// 			alert("작성자를 입력하세요");
// 			form.name.focus();
// 			return false;
// 		}
// 		if (form.title.value=="") {
// 			alert("제목을 입력하세요");
// 			form.title.focus();
// 			return false;
// 		}
// 		if (form.content.value=="") {
// 			alert("내용을 입력하세요");
// 			form.content.focus();
// 			return false;
// 		}
// 		if (form.pass.value=="") {
// 			alert("비밀번호를 입력하세요");
// 			form.pass.focus();
// 			return false;
// 		}
// 	}
</script>

</head>
<body>
	<%@ include file="../NavBar.jsp" %>
	<div>
	<br/><br/>
	</div>
	<form action="../noticeboard/edit.do" name="wirteFrm" method="post" enctype="multipart/form-data"	
			onsubmit="return validateForm(this)">
			<input type="hidden" name="id" id="id" value="${ id }" />
			<input type="hidden" name="nickname" id="nickname" value="${ nickname }" />
			<input type="hidden" name="cate" id="cate" value="notice"/>
			<!-- 게시물 수정을 위한 일련번호 -->
			<input type="hidden" name="notino" value="${dto.notino }" />
			<!-- 기존의 원본파일명 : 기존파일을 유지할때와 새로업로드할때를 위해 따로 설정-->
			<input type="hidden" name="prevOfile" value="${dto.ofile }" />
			<!-- 기존은 서버저장 파일명 -->
			<input type="hidden" name="prevNifle" value="${dto.nfile }"/>
	<table border="1" class="table" style="width: 80%; margin: auto;">
		<tr>
			<td>제목</td>
			<td>
				<input type="text"  name="title" style="width:90%;" value="${dto.title }"/>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea name="content" style="width:90%;height:200px">${dto.content }</textarea>
			</td>
		</tr>
		<tr>
			<td>첨부 파일</td>
			<td><input type="file" name="ofile" id="" /> </td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button class="btn btn-light" type="submit" id="sub">작성완료</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="btn btn-light" type="reset">reset</button>	
				<button class="btn btn-light" type="button" onclick="location.href='../noticeboard/list.do';">목록 바로가기</button>
			</td>
		</tr>
	</table>		
	</form>

</body>
</html>