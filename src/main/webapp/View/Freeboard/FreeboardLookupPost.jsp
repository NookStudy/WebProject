<%@page import="reply.model.FreeReplyDTO"%>
<%@page import="reply.model.FreeReplyDAO"%>
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
	
	window.location.href ="http://localhost:8081/DCSLR/freeboard/HeartUpdate.do?id=${id}&freeno=${dto.freeno}"
}
</script>
</head>
<body>
	<%@ include file="/View/NavBar.jsp" %>
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
					href="../freeboard/download.do?ofile=${dto.ofile }&nfile=${dto.nfile }&freeno=${dto.freeno }">
						[Download] </a>
				</td>
				<td>다운로드수</td>
				<td>${dto.downcount }</td>
			</tr>
		</c:if>
		<tr style="border-top: none;">
			<td colspan="6" style="text-align: center;"><!-- 추천 기능 -->
		<div>
			<div class="w3-border w3-center w3-padding">
				<c:if test="${ id != null }">
					<button type="button" id="like" onclick="like();" >
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
						<c:if test="${id == dto.id}">
						<button type="button" class="btn btn-warining btn-sm"
							onclick="location.href='${pageContext.request.contextPath }/freeboard/verify.do?mode=edit&freeno=${param.freeno}';">수정하기
						</button>
						</c:if>
						<c:if test="${id == dto.id  or id eq 'admin'}">
						<button type="button" class="btn btn-danger btn-sm"
							onclick="location.href='${pageContext.request.contextPath }/freeboard/verify.do?mode=delete&freeno=${param.freeno}';">삭제하기</button>
						</c:if>
				</c:if>
				<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath }/freeboard/list.do';">목록
					바로가기</button>
			</td>
		</tr>
		</table>
<%-- 		<iframe src="${pageContext.request.contextPath }/View/Freeboard/FreeReply.jsp?freeno=${dto.freeno }" style="width: 100%;margin: auto; height: 900px"></iframe> --%>
<%-- 		<jsp:include page="./GallReply.jsp"></jsp:include> --%>

	<!-- 댓글 -->
		<%
	// 갤러리 번호 가져오기
	String freeno = request.getParameter("freeno");
	%>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd; width:90%; margin: auto;">
				<tbody>
					<tr>
						<td align="left" style="bgcolor: yellow;">댓글</td>
					</tr>
					<tr><td>
					<!-- 댓글 템플릿 -->
					<%
					FreeReplyDAO FreeReplyDAO = new FreeReplyDAO();
					ArrayList<FreeReplyDTO> list = FreeReplyDAO.getList(Integer.parseInt(freeno));
					for (int i = 0; i < list.size(); i++) {
					%>
					<div class="container">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
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
										if (((String) session.getAttribute("id")).equals(list.get(i).getId())) {
									%>
										<a 	href="${pageContext.request.contextPath}/View/Freeboard/ReplyUpdatePage.jsp?freeno=<%=freeno%>&replyno=<%=list.get(i).getReplyno()%>&id=<%=list.get(i).getId()%>"
											onclick='window.open(this.href,"_blank","height=300,width=700, status=yes,toolbar=no,menubar=no,location=no");return false;' class="btn btn-warning">수정</a>  
										<a
										onclick="return confirm('정말로 삭제하시겠습니까?')"
										href="${pageContext.request.contextPath}/View/Freeboard/ReplyDelete.jsp?freeno=<%=freeno%>&replyno=<%=list.get(i).getReplyno()%>&id=<%=list.get(i).getId()%>"
										class="btn btn-danger">삭제</a>
									<%
									}
									}
									%>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p style="font-size: 2px"> </p>
					<%
					}
					FreeReplyDAO.close();
					%>
					</td></tr>
				</tbody>
			</table>
		</div>
		<div class="container">
			<div class="row">
				<form method="post"
					action="${pageContext.request.contextPath}/View/Freeboard/ReplyAction.jsp?freeno=<%=freeno%>">
					<table class="table table-bordered"
						style="text-align: center; border: 1px solid #dddddd; width: 90%; margin: auto;">
						<tbody>
							<tr>
								<td align="left"><%=session.getAttribute("id")%></td>
							</tr>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="댓글을 입력해주세요" name="replycontent" maxlength="300"></td>
							</tr>
						</tbody>
					</table>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="btn btn-success pull-right"
						value="댓글 작성">
				</form>
			</div>
		</div>

	</div>
	
</body>
</html>