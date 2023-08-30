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
</head>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid">
			<h1>
				<a class="navbar-brand" href="${pageContext.request.contextPath }/home.do"> DCSLR </a>
			</h1>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse col-6" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath }/noticeboard/list.do">공지사항</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/galleryboard/list.do">갤러리</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/freeboard/list.do">자유게시판</a></li>
					<!-- 					<li class="nav-item dropdown"><a -->
					<!-- 						class="nav-link dropdown-toggle" href="#" role="button" -->
					<!-- 						data-bs-toggle="dropdown" aria-expanded="false"> Forum </a> -->
					<!-- 						<ul class="dropdown-menu"> -->
					<!-- 							<li><a class="dropdown-item" href="#">Canon</a></li> -->
					<!-- 							<li><a class="dropdown-item" href="#">Nikon</a></li> -->
					<!-- 							<li><a class="dropdown-item" href="#">Sony</a></li> -->
					<!-- 						</ul></li> -->
				</ul>
			</div>
			<div class="container-fluid col-6">
				<ul class="navbar-nav">
					<%
					if (session.getAttribute("id") == null) {
					%>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick='window.open("${pageContext.request.contextPath}/View/LoginForm.jsp","_blank","height=650,width=700, status=yes,toolbar=no,menubar=no,location=no");return false'>
							로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/View/MemberRegist.jsp">회원가입</a></li>
					<%
					} else if (session.getAttribute("id") != null) {
					String showId = (String) session.getAttribute("id");
					%><li class="nav-item"><a class="nav-link" href="#"><%=showId%>님</a></li>
					<li class="nav-item"><a class="nav-link"
						href=" ${ pageContext.request.contextPath }/member/logout.do">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/member/verify.do">회원정보</a></li>
					<%  if(((String)session.getAttribute("id")).equals("admin")){ 
					%>
					<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/admin/main.do">관리자모드</a></li>
					<%
						}
					}
					%>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/View/Page/ComingAdress.jsp">오시는 길</a></li>
				</ul>
			</div>
		</div>
	</nav>
</body>
</html>