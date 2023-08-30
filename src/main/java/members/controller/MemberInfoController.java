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

@WebServlet("/member/info.do")
public class MemberInfoController extends HttpServlet{
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
		dto.setPass(req.getParameter("pass2"));
		dto.setEmail(req.getParameter("email"));
		dto.setPostcode(req.getParameter("postcode"));
		dto.setAdress1(req.getParameter("adress1"));
		dto.setAdress2(req.getParameter("adress2"));
		dto.setPhonenumber(req.getParameter("phonenumber"));
		dto.setNickname(req.getParameter("nickname"));
		
		int result = dao.updateMember(dto);
		//업데이트 성공시
		if (result==1) {
			AlertFunction.alertBack(resp,"회원정보가 성공적으로 수정되었습니다");
			req.getRequestDispatcher("/home.do").forward(req, resp);
		}else if (result==0) {
			AlertFunction.alertLocation(resp, "회원정보 수정이 불가능합니다. 관리자에게 문의해주세요", "${pageContext.request.contextPath}/home.do");
			dao.close();
		}else{
			AlertFunction.alertBack(resp, "잘못된 접근입니다.");
			dao.close();
			System.out.println("실패");
		}
	
	}
}
