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

@WebServlet("/member/checkid.do")
public class IdcheckController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("id")!=null) {
			String id = req.getParameter("id");
			System.out.println(id);
			MemberDAO dao = new MemberDAO();
			HttpSession session = req.getSession();
			session.setAttribute("idcheck", true);
			int result = dao.checkId(req.getParameter("id"));
			dao.close();
			System.out.println("컨트롤러 id:"+id);
			if(result==1) {
				session.setAttribute("idpossible", false);
				AlertFunction.alertLocation(resp,"이미 존재하는 ID입니다","../View/Page/Idcheck.jsp");
//				req.getRequestDispatcher("/View/Page/Idcheck.jsp").forward(req, resp);
			}else if(result==0) {
				session.setAttribute("idpossible", true);
				AlertFunction.alert(resp, "사용가능한 ID입니다!");
				req.getRequestDispatcher("/View/Page/Idcheck.jsp?id="+id).forward(req, resp);
			}else {
				System.out.println("크게 잘못됨");
			}
		}else {
			AlertFunction.alertBack(resp, "아이디를 입력해주세요");
		}
	}
}
