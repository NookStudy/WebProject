package notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.model.NoticeBoardDAO;
import utils.FileUtil;
@WebServlet("/noticeboard/download.do")
public class NotiDownloadController extends HttpServlet{
	private static final long serialVersionUID = 1L;

		
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			//파라미터로 받아옴
			String ofile = req.getParameter("ofile");
			String nfile = req.getParameter("nfile");
			String notino = req.getParameter("notino");
			
			FileUtil.download(req, resp, "/Uploads", nfile, ofile);
			
			NoticeBoardDAO dao = new NoticeBoardDAO();
			dao.downCountPlus(notino);
			dao.close();

	}

}
