<%@page import="notice.model.NoticeBoardDTO"%>
<%@page import="notice.model.NoticeBoardDAO"%>
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
<title>DCSLR</title>
<script type="text/javascript">
$(function() {
	console.log('${id}');
});
</script>
</head>
<body>
	<%@ include file="../NavBar.jsp" %>
	<div>
	<br/><br/>
	</div>
	<div style="text-align: center;">
	<h2>자유 게시판</h2>
	</div>
	
	<!-- 목록 테이블 -->
	<table border="1" class="table table-hover" style="width: 80%; margin: auto; text-align: center;">
		 <thead class="table-dark">
		<tr>
			<th width="10%">번호</th>
			<th width="*" style="text-align: center;">제목</th>
			<th width="20%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
		</thead>
		<!-- 공지글 -->
		<c:forEach items="${ noticeboardLists }" var="row1" varStatus="loop" begin="0" end="2">
					<tr align="center"></tr>
					<td>
						${ row1.cate} 
					</td>
					<td align="left"><a href=" ../noticeboard/lookup.do?notino=${row1.notino }">${row1.title }</a></td>
					<td>${row1.nickname }</td>
					<td>${row1.visitcount }</td>
					<td>${row1.postdate }</td>
					<td>
						<c:if test="${not empty row1.ofile }">
							<a href="../noticeboard/download.do?ofile=${row1.ofile }&nfile=${row1.nfile}&notino=${row1.notino}">
							[Down]
							</a>
						</c:if>
					</td>
				</c:forEach>
		
		<!-- 게시물이 없을 때 -->
		<c:choose>
			<c:when test="${ empty boardLists }">
				<tr>
					<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ boardLists }" var="row" varStatus="loop">
					<tr align="center"></tr>
					<td>
						${ map.totalCount -(((map.pageNum-1)*map.pageSize)+loop.index)} 
					</td>
					<td align="left"><a href=" ../freeboard/lookup.do?freeno=${row.freeno }">${row.title }
					</a>
					<c:if test="${row.replycount > 0 }"> 
					<span style="color:red">[${row.replycount }]</span>
					</c:if>
					</td>
					
					<td>${row.nickname }</td>
					<td>${row.visitcount }</td>
					<td>${row.postdate }</td>
					<td>
						<c:if test="${not empty row.ofile }">
							<a href="../freeboard/download.do?ofile=${row.ofile }&nfile=${row.nfile}&freeno=${row.freeno}">
							[Down]
							</a>
						</c:if>
					</td>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<!-- 검색자 -->
	<form method="get">
		<table border="1" class="table table-hover" style="width: 80%; margin: auto;">
			<tr>
				<td align="center"><select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nickname">닉네임</option>
						<c:if test="${not empty id }">
							<c:if test="${id=='admin' }">
								<option value="id">아이디</option>
							</c:if>
						</c:if>
				</select> <input type="text" name="searchWord" /> <input type="submit"
					value="검색하기" /></td>
			</tr>
		</table>
	</form>
	<!-- 하단메뉴(바로가기, 글쓰기 -->
	<table style="width:80%; border: none; margin:auto;">
		<tr align="center">
			<td>${map.pagingImg }</td>
	<c:if test="${ id != null }">
			<td width="100"><button type="button" class="btn btn-outline-secondary btn-sm"
					onclick="location.href='../freeboard/write.do';">글쓰기</button></td>
	</c:if>
		</tr>
	</table>
</body>
</html>