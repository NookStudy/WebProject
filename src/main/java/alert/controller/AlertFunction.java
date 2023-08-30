package alert.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class AlertFunction {
	
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
		try {
			//컨텐츠 타입을 설정
			resp.setContentType("text/html;charset=UTF-8");
			//PrintWriter객체를 통해 스크립터를 서블릿에서 직접 출력한다.
			PrintWriter writer = resp.getWriter();
			String script=""
					+"<script>"
					+"		alert('"+msg+"');"
					+" 		location.href='"+url+"';"
					+"</script>";
			writer.print(script);
		} catch (Exception e) {
		}
	}
	
	//이전페이지로 돌아간 후 새로고침
	public static void alertBack(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
					+"<script>"
					+"		alert('"+msg+"');"
					+"		window.location=document.referrer;"
//					+" 		history.back();"
					+"</script>";
			writer.print(script);
		} catch (Exception e) {}
	}
	//알러트창
	public static void alert(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
					+"<script>"
					+"		alert('"+msg+"');"
					+"</script>";
			writer.print(script);
		} catch (Exception e) {}
	}
}
