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

@WebServlet("/member/verify.do")
public class MemberVerifyController  extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/View/MemberVerify.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		HttpSession session = req.getSession();
		
		String id =(String)session.getAttribute("id"); 
		dto.setId(id);
		dto.setPass(req.getParameter("pass"));
		
		int result = dao.loginMember(dto);
		//로그인 성공시
		if (result==0) {
			System.out.println(req.getContextPath());
			resp.sendRedirect(req.getContextPath()+"/member/infoedit.do?id="+id);
		}else if (result==1) {
			AlertFunction.alertBack(resp, "잘못된 비밀번호를 입력하셨습니다.");
			dao.close();
		}else{
			AlertFunction.alertBack(resp, "올바른 아이디가 아닙니다.");
			dao.close();
			System.out.println("실패");
		}
	
	}
}
