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
	function validateForm(form) {
		if(form.pass.value==""){
			alert("비밀번호를 입력하세요.");
			form.pass.focus();
			return false;
		}
	}
</script>
</head>
<body>
	
	<!-- 
		글쓰기 페이지를 복사하여 해당 페이지를 만들 때 비밀번호 검증시에는 첨부파일이 필요 없으므로
		enctype은 제거해야 한다.
		만약 제거하지 않으면 request내장객체로 폼값을 받을 수 없으므로 주의해야 한다. 
	 -->
	<form action="../noticeboard/verify.do" name="wrtieFrm" method="post" onsubmit="return validateForm(this)">
		<!--  
			해당 요청명으로 넘어온 파라미터는 컨트롤러에서 받은 후 request영역에서 저장하여 
			View에서 확인할 수 있지만, EL을 이용하면 해당 과정없이 param내장객체로 즉시 값을 받아올 수 있다.
			
			*hidden박스를 사용하는 경우 웹브라우저에는 숨김처리 되기 때문에 값이 제대로 입력되었는지
			화면으로 확인 할 수 없다.
			따라서 개발자 모드를 사용하거나, type을 디버깅용으로 잠깐 수정한 후 값이 제대로 되었는지
			반드시 확인해야 한다. 
			
		-->
		<input type="hidden" name="notino"  value="${param.notino}"/>
		<input type="hidden" name="mode"  value="${param.mode}"/>
		<div class="container align-items-center"
			style="text-align: center; align-content:center; margin: auto; padding-left: 25%;" 
			>
			<table style="width: 400px;" class="table-borderless">
				<tr>
					<td style="text-align: center;"><img src="${pageContext.request.contextPath }/images/lock1.jpg"
						alt="" width="150px" /></td>
				</tr>
				<tr>
					<td>게시글 보호를 위해 비밀번호 검증이 필요합니다.</td>
				</tr>
				<tr>
					<td>
						<div class="row g-3 align-items-center">
							<div class="col-auto">
								<label for="inputPassword6" class="col-form-label">Password</label>
							</div>
							<div class="col-auto">
								<input type="password" id="inputPassword6" class="form-control"
									name="pass" aria-describedby="passwordHelpInline">
							</div>
						</div> <!-- 					<span>비밀번호</span><input type="password" class="form-control" name="pass" style="width: 100px;" /> -->
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<button type="submit" class="btn btn-primary">입력하기</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-secondary"
							onclick="location.href='../noticeboard/list.do';">목록 바로가기</button>
					</td>
				</tr>
			</table>
			</div>
	</form>
</body>
</html>