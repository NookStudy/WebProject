<%@page import="freeboard.model.FreeboardDAO"%>
<%@page import="reply.model.FreeReplyDAO"%>
<%@page import="java.io.PrintWriter"%>
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
<jsp:useBean id="reply" class="reply.model.FreeReplyDTO" scope="page"/>
<jsp:setProperty name="reply" property="replycontent"/> 
<jsp:setProperty name="reply" property="replyno"/> 
<jsp:setProperty name="reply" property="id"/> 
</head>
<body>
<%
		int freeno=1;
		if(request.getParameter("freeno")!=null){
			freeno=Integer.parseInt(request.getParameter("freeno"));
		}
	
		String userID=null;
		if(session.getAttribute("id")!=null){
			userID=(String)session.getAttribute("id");
		}
		if(userID==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}
		if(!(userID.equals(reply.getId()))){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('본인만 삭제할 수 있습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}
		
		else{
			FreeReplyDAO replyDAO=new FreeReplyDAO();
			int result = replyDAO.delete(reply.getReplyno()); 
			replyDAO.close();
			if(result==-1){
				PrintWriter script= response.getWriter();
				script.println("<script>");
				script.println("alert('댓글삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				FreeboardDAO dao = new FreeboardDAO();
				dao.deleteVisitcount(request.getParameter("freeno"));
				dao.close();
				String url="/freeboard/lookup.do?freeno=";
				PrintWriter script= response.getWriter();
				script.println("<script>");
				script.println("location.href='"+request.getContextPath()+url+freeno+"'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>