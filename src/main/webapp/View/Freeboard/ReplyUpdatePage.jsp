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
</head>
<body>
	<%
	// 갤러리 번호 가져오기
	String freeno = request.getParameter("freeno");
	String id = request.getParameter("id");
	int replyno = Integer.parseInt(request.getParameter("replyno"));
	System.out.println("updatepagereqplyno:" + request.getParameter("replyno"));
	FreeReplyDAO dao = new FreeReplyDAO();
	FreeReplyDTO dto = new FreeReplyDTO();
	dto = dao.getReply(replyno);
	%>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd; width: 90%; margin: auto;">
				<tbody>
					<tr>
						<td align="left" style="bgcolor: yellow;">댓글 수정 페이지</td>
					</tr>
					<tr>
						<td>
							<!-- 댓글 템플릿 -->
							<div class="container">
								<div class="row">
									<form method="post"
										action="${pageContext.request.contextPath}/View/Freeboard/ReplyUpdate.jsp?replyno=<%=replyno%>&id=<%=request.getParameter("id") %>&freeno=<%=request.getParameter("freeno")%>">
										<table class="table table-bordered"
											style="text-align: center; border: 1px solid #dddddd">
											<tbody>
												<tr>
													<td align="left"><%=dto.getId()%></td>
												</tr>
												<tr>
													<td><input type="text" class="form-control"
														value="<%=dto.getReplycontent()%>" name="replycontent"
														maxlength="300"></td>
												</tr>
											</tbody>
										</table>
										<input type="submit" class="btn btn-info" value="댓글 수정하기" />
										<input type="reset" class="btn btn-secondary" value="Reset" />

									</form>
								</div>
							</div>
							<p style="font-size: 2px"></p>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>