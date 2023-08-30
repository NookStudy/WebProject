package notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.model.NoticeBoardDAO;
import notice.model.NoticeBoardDTO;

@WebServlet("/noticeboard/lookup.do")
public class NotiLookupController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeBoardDTO dto = new NoticeBoardDTO();
		NoticeBoardDAO dao = new NoticeBoardDAO();
		
		//게시글 번호로 조회수증가 후 게시물 가져오기
		String notino = req.getParameter("notino");
		dao.updateVisitcount(notino);
		dto = dao.lookup(notino);
		System.out.println("lookupcont:"+dto.getContent());
		dao.close();
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/View/Noticeboard/NoticeLookupPost.jsp").forward(req, resp);
	}
}
