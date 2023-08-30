<%@page import="reply.model.GallReplyDTO"%>
<%@page import="reply.model.GallReplyDAO"%>
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
function like() {
	
	window.location.href ="http://localhost:8081/DCSLR/galleryboard/HeartUpdate.do?id=${id}&gallno=${dto.gallno}"
}
</script>
</head>
<body style="background-color: #343434">
	<%@ include file="/View/NavBar.jsp" %>
	<div>
	<br> <br>
	</div>
	<table border="1" style="width: 80%; margin: auto;" class="table table-dark table-borderless ">
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
			<td colspan="6" height="100" style="margin: auto; text-align: center;">
				<c:if test="${isImage eq true }" var="isntImage">
					<p>
						<img src="../Uploads/${dto.nfile }" alt="" width="700px" style="margin: auto;"/>
					</p>
				</c:if>
				${dto.content }
			</td>
		</tr>
		<!-- 첨부된 파일이 있는 경우에는 파일명과 다운로드 링크를 출력한다. 
			다운로드가 완료되면 다운로드 횟수를 1ㅡ증가시키기 위헤 게시물의 일련번호를 파라미터로 전달-->
		<c:if test="${not empty dto.ofile }">
			<tr>
				<td>첨부파일</td>
				<td colspan="2">${dto.ofile } <a
					href="../galleryboard/download.do?ofile=${dto.ofile }&nfile=${dto.nfile }&gallno=${dto.gallno }">
						[Download] </a>
				</td>
				<td></td>
				<td>다운로드수</td>
				<td>${dto.downcount }</td>
			</tr>
		</c:if>
		<tr style="border-top: none;">
			<td colspan="6" style="text-align: center;"><!-- 추천 기능 -->
		<div>
			<div class="w3-border w3-center w3-padding">
				<c:if test="${ id != null }">
					<button type="button" class="btn btn-light" id="like" onclick="like();" >
					  <img src="${pageContext.request.contextPath }/images/good.png" width="50px"/>
					</button>
				</c:if>
			</div>
		</div>
		<span class="heartcount">추천수 &nbsp; ${ dto.heart }</span>
		</td>
		</tr>
		<!-- 아이디가 동일하거나 admin이면 수정 및 삭제 버튼 보기 가능 -->
		<tr>
			<td colspan="6" align="center">
				<c:if test="${id == dto.id  or id eq 'admin'}">
						<c:if test="${id == dto.id or id eq 'admin'}">
						<button type="button" class="btn btn-outline-light"
							onclick="location.href='${pageContext.request.contextPath }/galleryboard/verify.do?mode=edit&gallno=${param.gallno}';">수정하기
						</button>
						</c:if>
						<c:if test="${id == dto.id  or id eq 'admin'}">
						<button type="button" class="btn btn-outline-light"
							onclick="location.href='${pageContext.request.contextPath }/galleryboard/verify.do?mode=delete&gallno=${param.gallno}';">삭제하기</button>
						</c:if>
				</c:if>
				<button type="button" class="btn btn-outline-light" onclick="location.href='${pageContext.request.contextPath }/galleryboard/list.do';">목록
					바로가기</button>
			</td>
		</tr>
		</table>
<%-- 		<iframe src="${pageContext.request.contextPath }/View/Gallery/GallReply.jsp?gallno=${dto.gallno }" style="width: 100%; height: 900px; " ></iframe> --%>
<%-- 		<jsp:include page="./GallReply.jsp"></jsp:include> --%>
	<!-- 댓글창 -->
	
	<%
	// 갤러리 번호 가져오기
	String gallno = request.getParameter("gallno");
	 GallReplyDAO GallReplyDAO = new GallReplyDAO();
	 ArrayList<GallReplyDTO> list = GallReplyDAO.getList(Integer.parseInt(gallno));
	%>
	<div class="container">
		<div class="row">
			<table class="table table-dark table-striped"
				style="text-align: center; margin: auto; width: 80%">
				<tbody>
					<tr>
						<td align="left" bgcolor="yellow">댓글</td>
					</tr>
					<tr>
						<td>
							<!-- 댓글 템플릿 --> <%

 for (int i = 0; i < list.size(); i++) {
 %>
							<div class="container">
								<table class="table table table-dark table-striped"
									style="text-align: center; margin: auto;">
									<tbody>
										<tr>
											<td align="left"><%=list.get(i).getId()%></td>
											<td align="right"><%=list.get(i).getReplyDate()%></td>
										</tr>
										<tr>
											<td align="left"><%=list.get(i).getReplycontent()%></td>
											<td align="right">
											<%
											if (session.getAttribute("id") != null) {
												
											%>
											<% if (((String) session.getAttribute("id")).equals(list.get(i).getId())) {  %>
											<a 	href="${pageContext.request.contextPath}/View/Gallery/ReplyUpdatePage.jsp?gallno=<%=gallno%>&replyno=<%=list.get(i).getReplyno()%>&id=<%=list.get(i).getId()%>"
											onclick='window.open(this.href,"_blank","height=300,width=700, status=yes,toolbar=no,menubar=no,location=no");return false;' 
												class="btn btn-warning">수정</a>  --> 
												<a
												onclick="return confirm('정말로 삭제하시겠습니까?')"
												href="${pageContext.request.contextPath}/View/Gallery/ReplyDelete.jsp?gallno=<%=gallno%>&replyno=<%=list.get(i).getReplyno()%>&id=<%=list.get(i).getId()%>"
												class="btn btn-danger">삭제</a>
												<%} %>
											<%
											}
											%>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<p style="font-size: 2px"></p> <%
 }
 GallReplyDAO.close();
 %>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty id }">
		<div class="container">
			<div class="row">
				<form method="post"
					action="${pageContext.request.contextPath}/View/Gallery/ReplyAction.jsp?gallno=<%=gallno%>">
					<table class="table table-dark "
						style="text-align: center; width: 80%; margin: auto;">
						<tbody>
							<tr>
								<td align="left"><%=session.getAttribute("id")%></td>
							</tr>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="댓글 쓰기" name="replycontent" maxlength="300"></td>
							</tr>
						</tbody>
					</table>
					<div class="col-sm-3" style="text-align: center;">
					&nbsp;&nbsp;<input type="submit" class="btn btn-outline-light btn-sm"
						value="댓글 쓰기">
						</div>
				</form>
			</div>
		</div>
		</c:if>

	</div>
</body>
</html>