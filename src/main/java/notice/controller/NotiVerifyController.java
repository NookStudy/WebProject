package notice.controller;

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
import notice.model.NoticeBoardDAO;
import notice.model.NoticeBoardDTO;
import utils.FileUtil;

@WebServlet("/noticeboard/verify.do")
public class NotiVerifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	//패스워드 검증 페이지로 진입
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			/*
			 	파라미터를 받아오는 작업.
			 	서블릿에서는 2가지 방법으로 받을 수 있는데
			 	방법1: Request 내장객체를 이용한다. => req.getParameter(파라미터명)
			 	방법2: View(JSP파일)에서 EL의 param내장객체를 사용한다.
			 		=> ${param.파라미터명}
			*/
			//파라미터를 받은 후 request영역에 저장하고 View로 포워드 한다.
			req.setAttribute("notino",req.getParameter("notino"));
			req.setAttribute("mode", req.getParameter("mode"));
			req.getRequestDispatcher("/View/Noticeboard/NoticeVerify.jsp").forward(req, resp);
		}
		
		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			HttpSession session =req.getSession();
			//입력한 비밀번호와 hidden박스에서 전송된 파라미터 받기
			String notino = req.getParameter("notino");
			String mode = req.getParameter("mode");
			String pass = req.getParameter("pass");
			String id = (String)session.getAttribute("id");
			System.out.println("verfifycont dopost line47:"+id+","+pass);
			MemberDTO dto = new MemberDTO();
			dto.setPass(pass);
			dto.setId(id);
			
			//DAO 객체 생성 및 패스워드 검증
			MemberDAO dao = new MemberDAO();
			int verify = dao.loginMember(dto);
			System.out.println(verify);
			
			dao.close();

			//패스워드 검증 성공시...
			if (verify==0) {
				System.out.println("비밀번호 검증 성공");
				//getSession()메더드를 통해 세션객체를 얻어온다.
				if (mode.equals("edit")) {
					System.out.println("mode=edit");
					session.setAttribute("flag", 0);
					System.out.println("세션값 저장");
					//비밀번호 검증이 됐다면 수정페이지로 이동한다.
					//플래그를 통해 검증
					System.out.println(req.getContextPath());
					resp.sendRedirect(req.getContextPath()+"/noticeboard/edit.do?notino="+notino);
				}
				else if (mode.equals("delete")){
					System.out.println("delete모드 입장");
					NoticeBoardDAO noticedao = new NoticeBoardDAO();
					//기존 게시물의 내용을 읽어온다.
					NoticeBoardDTO noticedto = noticedao.lookup(notino);
					System.out.println("세션값과 게시판 id 값");
					System.out.println("게시판id:"+noticedto.getId()+", sessionid:"+session.getAttribute("id"));
					//게시판 id 와 session id가 같거나  로그인된 id가 관리자라면
					if((noticedto.getId().equals(session.getAttribute("id")) || session.getAttribute("id").equals("admin"))) {
						//게시물을 삭제한다.
						int result = noticedao.deletePost(notino);
						dao.close();
						
						//게시물 삭제 성공시...
						if (result==1) {
							//파일도 삭제한다.
							String saveFileName = noticedto.getNfile();
							FileUtil.deleteFile(req, "/Uploads", saveFileName);
						}
						//삭제후엔 리스트로 돌아온다.
						AlertFunction.alertLocation(resp, "삭제되었습니다", "../noticeboard/list.do");
					
					}//게시판 id 와 session id가 다르면
					else if (!(noticedto.getId().equals(session.getAttribute("id")))) {
						AlertFunction.alertLocation(resp, "본인의 게시물만 삭제할 수 있습니다.","../noticeboard/lookup.do?notino="+notino);
						return;
					}
					
				}
			} else {
				AlertFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
			}
		}
}
