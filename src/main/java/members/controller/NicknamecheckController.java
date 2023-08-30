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

@WebServlet("/member/checknickname.do")
public class NicknamecheckController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("nickname")!=null) {
			String nickname = req.getParameter("nickname");
			System.out.println(nickname);
			MemberDAO dao = new MemberDAO();
			HttpSession session = req.getSession();
			session.setAttribute("nicknamecheck", true);
			int result = dao.checkNickname(req.getParameter("nickname"));
			dao.close();
			System.out.println("컨트롤러 nickname:"+nickname);
			if(result==1) {
				session.setAttribute("nicknamepossible", false);
				AlertFunction.alertLocation(resp,"이미 존재하는 닉네임입니다","../View/Page/nicknamecheck.jsp");
//				req.getRequestDispatcher("/View/Page/nicknamecheck.jsp").forward(req, resp);
			}else if(result==0) {
				session.setAttribute("nicknamepossible", true);
				AlertFunction.alert(resp, "사용가능한 닉네임입니다!");
				req.getRequestDispatcher("/View/Page/nicknamecheck.jsp?nickname="+nickname).forward(req, resp);
			}else {
				System.out.println("크게 잘못됨");
			}
		}else {
			AlertFunction.alertBack(resp, "아이디를 입력해주세요");
		}
	}
}
