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

@WebServlet("/member/delete.do")
public class MemberDeleteController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();
		int result = dao.deleteMember((String)session.getAttribute("id"));
		dao.close();
		if (result==1) {
			AlertFunction.alertLocation(resp, "회원탈퇴 되었습니다.", req.getContextPath()+"/home.do");
			
		}else {
			AlertFunction.alertBack(resp, "회원탈퇴가 불가능합니다");
		}
		
	}
}
