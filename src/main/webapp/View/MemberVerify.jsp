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
<script type="text/javascript">
	function validateForm(form) {
		if (form.pass.value == "") {
			alert("비밀번호를 입력하세요.");
			form.pass.focus();
			return false;
		}
	}
	$(function() {
		if ("${id}"=="") {
			alert("로그인 후 이용하세요");
			location.href="${pageContext.request.contextPath}/home.do"
		}
		$('#pass').focus();
	});
</script>
</head>
<body>
		<%@ include file="./NavBar.jsp" %>
	<form action="${pageContext.request.contextPath }/member/verify.do" name="verify" method="post"
		onsubmit="return validateForm(this)">
		<div class="container"
			style="align-content: center; margin: auto; top: 20px; padding-left: 25%;"
			class="col-4 ">
			<table style="width: 400px;">
				<tr>
					<td style="text-align: center;"><img src="../images/lock1.jpg"
						alt="" width="150px" /></td>
				</tr>
				<tr>
					<td>회원정보 보호를 위해 비밀번호 검증이 필요합니다.</td>
				</tr>
				<tr>
					<td>
						<div class="row g-3 align-items-center">
							<div class="col-auto">
								<label for="inputPassword6" class="col-form-label">Password</label>
							</div>
							<div class="col-auto">
								<input type="password" id="pass" class="form-control"
									name="pass" aria-describedby="passwordHelpInline">
							</div>
						</div> <!-- 					<span>비밀번호</span><input type="password" class="form-control" name="pass" style="width: 100px;" /> -->
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<button type="submit" class="btn btn-primary">입력하기</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-secondary"
							onclick='location.herf="${pageContext.request.contextPath }/home.do"'>돌아가기</button>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>