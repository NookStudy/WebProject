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
	<%@ include file="../NavBar.jsp" %>
	<div>
	<br> <br>
	</div>
	<table border="1" style="width: 80%; margin: auto;" class="table ">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="*" />
		</colgroup>
		<!-- 게시글 정보 -->
		<tr >
			<td >제목</td>
			<td colspan="5" >${dto.title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${dto.nickname }</td>
			<td>작성일</td>
			<td>${dto.postdate }</td>
			<td>조회수</td>
			<td>${dto.visitcount }</td>
		</tr>
		<tr>
			<td colspan="6" height="100" style="margin: auto; padding: 40px;">${dto.content }
				<c:if test="${isImage eq true }" var="isntImage">
					<p>
						<img src="../Uploads/${dto.nfile }" alt="" width="25%"/>
					</p>
				</c:if>
			</td>
		</tr>
		<!-- 첨부된 파일이 있는 경우에는 파일명과 다운로드 링크를 출력한다. 
			다운로드가 완료되면 다운로드 횟수를 1ㅡ증가시키기 위헤 게시물의 일련번호를 파라미터로 전달-->
		<c:if test="${not empty dto.ofile }">
			<tr>
				<td>첨부파일</td>
				<td>${dto.ofile } <a
					href="../noticeboard/download.do?ofile=${dto.ofile }&nfile=${dto.nfile }&notino=${dto.notino }">
						[Download] </a>
				</td>
				<td>다운로드수</td>
				<td>${dto.downcount }</td>
			</tr>
		</c:if>
		
		<!-- 아이디가 동일하거나 admin이면 수정 및 삭제 버튼 보기 가능 -->
		<tr>
			<td colspan="6" align="center">
				<c:if test="${id == dto.id  or id eq 'admin'}">
						<c:if test="${id == dto.id}">
						<button type="button" class="btn btn-outline-primary btn-sm"
							onclick="location.href='../noticeboard/verify.do?mode=edit&notino=${param.notino}';">수정하기
						</button>
						</c:if>
						<c:if test="${id == dto.id  or id eq 'admin'}">
						<button type="button" class="btn btn-outline-warning btn-sm"
							onclick="location.href='../noticeboard/verify.do?mode=delete&notino=${param.notino}';">삭제하기</button>
						</c:if>
				</c:if>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-outline-info btn-sm" onclick="location.href='http://localhost:8081/DCSLR/noticeboard/list.do';">목록
					바로가기</button>
			</td>
		</tr>
	</table>
</body>
</html>