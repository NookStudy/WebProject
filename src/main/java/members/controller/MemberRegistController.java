package members.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import alert.controller.AlertFunction;
import members.model.MemberDAO;
import members.model.MemberDTO;

@WebServlet("/member/regist.do")
public class MemberRegistController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/View/MemberRegist.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDTO dto = new MemberDTO();
		MemberDAO dao = new MemberDAO();
		dto.setId(req.getParameter("id"));
		dto.setPass(req.getParameter("pass"));
		dto.setName(req.getParameter("name"));
		dto.setNickname(req.getParameter("nickname"));
		dto.setGender(req.getParameter("gender"));
		dto.setEmail(req.getParameter("email1")+"@"+req.getParameter("email2"));
		dto.setAdress1(req.getParameter("address1"));
		dto.setAdress2(req.getParameter("address2"));
		dto.setPhonenumber(req.getParameter("phonenumber1")+"-"+req.getParameter("phonenumber2")+"-"+req.getParameter("phonenumber3"));
		dto.setPostcode(req.getParameter("postcode"));
		dto.setBirth(req.getParameter("birthyear")+"/"+req.getParameter("birthmonth")+"/"+req.getParameter("birthdate"));
		int result = dao.registMember(dto);
		System.out.println(result);
		dao.close();
		
		if (result==1) {
			AlertFunction.alertLocation(resp, "회원등록이 완료되었습니다.","../home.do");
		} else {
			resp.sendError(result, "실패");
		}
	}
	
}
