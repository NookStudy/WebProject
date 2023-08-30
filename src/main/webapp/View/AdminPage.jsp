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
//admin아니면 진입불가
$(function () {	
	<c:if test="${empty id}" >
		alert("접근권한이 없습니다.");
		location.href='${pageContext.request.contextPath}/home.do';
		
	</c:if>
	<c:if test="${id!='admin'}">
			alert("관리자만 접근 가능한 페이지입니다.");
			location.href='${pageContext.request.contextPath}/home.do';
	</c:if>
});
</script>
</head>
<body>
	<jsp:include page="./NavBar.jsp"></jsp:include>
	<div>
		<br />
		<br />
	</div>
	<div style="text-align: center;">
		<h2>회원관리 테이블</h2>
	</div>
	<!-- 목록 테이블 -->
	<table border="1" class="table table-hover"
		style="width: 80%; margin: auto;">
		<thead class="table-dark">
			<tr>
				<th width="15%">회원번호</th>
				<th width="15%" style="">ID</th>
				<th width="20%">Name</th>
				<th width="25%">Nickname</th>
				<th width="25%">Email</th>
			</tr>
		</thead>

		<!-- 게시물이 없을 때 -->
		<c:choose>
			<c:when test="${ empty memberLists }">
				<tr>
					<td colspan="6" align="center">현재 회원이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ memberLists }" var="row" varStatus="loop">
					<tr align="center"></tr>
<%-- 					<td>${ map.totalCount -(((map.pageNum-1)*map.pageSize)+loop.index)} --%>
<!-- 					</td> -->
					<td>${row.userno }</td>
					<td align="left"><a
						href="${pageContext.request.contextPath}/admin/infoedit.do?id=${row.id}">${row.id }</a></td>
					<td>${row.name }</td>
					<td>${row.nickname }</td>
					<td>${row.email }</td>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<!-- 검색창 -->
	<form method="get">
		<table border="1" class="table table-hover" style="width: 80%; margin: auto;">
			<tr>
				<td align="center"><select name="searchField">
						<option value="id">아이디</option>
						<option value="nickname">닉네임</option>
						<option value="name">이름</option>
						<option value="userno">회원번호</option>
				</select> <input type="text" name="searchWord"  value="${param.searchWord}"/> 
				<input type="submit" value="검색하기" /></td>
			</tr>
		</table>
	</form>
	<!-- 페이징 -->
	<table style="width:80%; border: none;">
		<tr align="center">
			<td>${map.pagingImg }</td>
		</tr>
	</table>
</body>
</html>