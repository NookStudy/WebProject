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
	
</script>
</head>
<body style="background-color: #343434">
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
											<%
											if (session.getAttribute("id") != null) {
												
											%>
											<td align="right">
											<% if (((String) session.getAttribute("id")).equals(list.get(i).getId())) {  %>
												<!-- 											<a --> <%-- 												href="${pageContext.request.contextPath}/View/Gallery/ReplyUpdate.jsp?gallno=<%=gallno%>&replyno=<%=list.get(i).getReplyno()%>" --%>
												<!-- 												class="btn btn-warning">수정</a>  --> 
												<a
												onclick="return confirm('정말로 삭제하시겠습니까?')"
												href="${pageContext.request.contextPath}/View/Gallery/ReplyDelete.jsp?gallno=<%=gallno%>&replyno=<%=list.get(i).getReplyno()%>&id=<%=list.get(i).getId()%>"
												class="btn btn-danger">삭제</a>
												<%} %>
											</td>
											<%
											}
											%>
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