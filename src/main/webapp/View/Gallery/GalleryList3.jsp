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
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/View/Gallery/assets/css/nicepage.css"
	media="screen">
<link rel="stylesheet" href="${pageContext.request.contextPath }/View/Gallery/assets/css/Home.css" media="screen">
<script class="u-script" type="text/javascript" src="${pageContext.request.contextPath }/View/Gallery/assets/css/jquery.js" defer=""></script>
<script class="u-script" type="text/javascript" src="${pageContext.request.contextPath }/View/Gallery/assets/css/nicepage.js" defer=""></script>
<meta name="generator" content="Nicepage 5.16.3, nicepage.com">
<link id="u-theme-google-font" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i|Open+Sans:300,300i,400,400i,500,500i,600,600i,700,700i,800,800i">
<link id="u-page-google-font" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Oswald:200,300,400,500,600,700|PT+Sans:400,400i,700,700i">
</head>

<body class="u-body u-xl-mode" data-lang="en">
	<%@ include file="../NavBar.jsp"%>
	<section class="u-align-center u-clearfix u-grey-10 u-section-1"
		id="carousel_2d68">
		<div class="u-clearfix u-sheet u-sheet-1">
			<h2 class="u-text u-text-1">Our Gallery</h2>
			<div
				class="data-layout-selected u-clearfix u-expanded-width u-gutter-30 u-layout-wrap u-layout-wrap-1">
				<div class="u-gutter-0 u-layout">
					<div class="u-layout-col">
						<c:choose>
							<c:when test="${ empty boardLists }">
								<tr>
									<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
								</tr>
							</c:when>
							<c:otherwise>
								<div class="u-size-30 u-size-60-md">
									<div class="u-layout-row">
										<c:forEach items="${ boardLists }" var="row" varStatus="loop"											>
											<div
												onclick="location.href='../galleryboard/lookup.do?gallno=${row.gallno }'"
												style="background-image: url('${pageContext.request.contextPath }/Uploads/${row.nfile }'); cursor:pointer;"
												class="u-container-style u-image u-layout-cell u-left-cell u-size-20 u-size-20-md u-image-${loop.count }">
												<div class="u-container-layout"></div>
											</div>
										</c:forEach>
									</div>
								</div>
<!-- 								<div class="u-size-30 u-size-60-md"> -->
<!-- 									<div class="u-layout-row"> -->
<%-- 										<c:forEach items="${ boardLists }" var="row" varStatus="loop"> --%>
<!-- 											<div -->
<%-- 												style="background-image: url('${pageContext.request.contextPath }/Uploads/${row.nfile }');" --%>
<%-- 												class="u-container-style u-image u-layout-cell u-left-cell u-size-20 u-size-20-md u-image-${ map.totalCount -(((map.pageNum-1)*map.pageSize)+loop.index)}"> --%>
<!-- 												<div class="u-container-layout"></div> -->
<!-- 											</div> -->
<%-- 										</c:forEach> --%>
<%-- 										<c:forEach items="${ boardLists }" var="row" varStatus="loop"> --%>
<!-- 											<div -->
<%-- 												style=" background-image: url('${pageContext.request.contextPath }/Uploads/${row.nfile }');" --%>
<%-- 												class="u-container-style u-image u-layout-cell u-left-cell u-size-20 u-size-20-md u-image-${ map.totalCount -(((map.pageNum-1)*map.pageSize)+loop.index)}"> --%>
<!-- 												<div class="u-container-layout"></div> -->
<!-- 											</div> -->
<%-- 										</c:forEach> --%>
<!-- 									</div> -->
<!-- 								</div> -->
							</c:otherwise>
						</c:choose>


					</div>
				</div>
			</div>
		</div>
	</section>



	<!-- 검색자 -->
	<form method="get">
		<table border="1" class="table table-hover"
			style="width: 80%; margin: auto;">
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
	<table style="width: 80%; border: none; margin: auto;">
		<tr align="center">
			<td style="width: *;">${map.pagingImg }</td>
			<c:if test="${ id != null }">
				<td width="100" align="right"><button type="button"
						class="btn btn-outline-secondary btn-sm"
						onclick="location.href='../galleryboard/write.do';">글쓰기</button></td>
			</c:if>
			br
		</tr>
	</table>
</body>
</html>