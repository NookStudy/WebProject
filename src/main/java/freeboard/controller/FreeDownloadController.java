package freeboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gallery.model.GalleryDAO;
import utils.FileUtil;

@WebServlet("/freeboard/download.do")
public class FreeDownloadController extends HttpServlet{
	private static final long serialVersionUID = 1L;

		
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			//파라미터로 받아옴
			String ofile = req.getParameter("ofile");
			String nfile = req.getParameter("nfile");
			String freeno = req.getParameter("freeno");
			
			FileUtil.download(req, resp, "/Uploads", nfile, ofile);
			
			GalleryDAO dao = new GalleryDAO();
			dao.downCountPlus(freeno);
			dao.close();

	}

}
