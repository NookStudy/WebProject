package members.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import alert.controller.AlertFunction;

@WebServlet("/member/logout.do")
public class LogoutController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		session.removeAttribute("id");
		session.removeAttribute("nickname");
		System.out.println("세션 id 제거:"+session.getAttribute("id"));
		System.out.println("세션 nickname 제거:"+session.getAttribute("nickname"));
//		AlertFunction.alertLocation(resp, "로그아웃되셨습니다.\n메인페이지로 이동합니다.","/home.do");
		AlertFunction.alertBack(resp, "로그아웃되셨습니다");
	
	}
}
