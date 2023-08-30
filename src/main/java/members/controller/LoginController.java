package members.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import alert.controller.AlertFunction;
import members.model.MemberDAO;
import members.model.MemberDTO;
import utils.CaptchaUtil;
@WebServlet("/member/login.do")
public class LoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MemberDTO dto = new MemberDTO();
		MemberDAO dao = new MemberDAO();
		MemberDTO savedto = new MemberDTO();
		HttpSession session = req.getSession();
		
		dto.setId(req.getParameter("id"));
		dto.setPass(req.getParameter("pass"));
		
		int result = dao.loginMember(dto);
		
		//로그인 성공시
		if (result==0) {
			req.setAttribute("Login", "success");
			savedto = dao.getMemberInfo(dto);
			session.setAttribute("id", savedto.getId());
			session.setAttribute("nickname", savedto.getNickname());
			dao.close();
			req.getRequestDispatcher("/View/LoginForm.jsp").forward(req, resp);
		}else if (result==1) {
			dao.close();
			AlertFunction.alertBack(resp, "잘못된 비밀번호를 입력하셨습니다.");
		}else{
			dao.close();
			AlertFunction.alertBack(resp, "올바른 아이디가 아닙니다.");
			System.out.println("실패");
		}
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/View/LoginForm.jsp").forward(req, resp);
	}
}
