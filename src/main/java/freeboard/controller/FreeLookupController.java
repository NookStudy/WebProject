package freeboard.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.FreeboardDAO;
import freeboard.model.FreeboardDTO;

@WebServlet("/freeboard/lookup.do")
public class FreeLookupController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FreeboardDTO dto = new FreeboardDTO();
		FreeboardDAO dao = new FreeboardDAO();
		
		//게시글 번호로 조회수증가 후 게시물 가져오기
		String freeno = req.getParameter("freeno");
		dao.updateVisitcount(freeno);
		dto = dao.lookup(freeno);
		System.out.println("lookupcont:"+dto.getContent());
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		dao.close();
		
		//첨부파일이 이미지인 경우 화면에 출력하기 위한 로직을 추가한다.
		String ext = null, fileName = dto.getNfile();
		//서버에 저장된 파일이 있는 경우라면 확장자를 잘라낸다.
		if (fileName!=null) {
			ext = fileName.substring(fileName.lastIndexOf(".")+1);
		}
		//이미지의 대표적인 확장자를 String배열로 선언한다.
		String[] mineStr= {"png","jpg","gif"};
		//String 배열을 List컬렉션으로 변환
		List<String> mimeList = Arrays.asList(mineStr);
		boolean isImage = false;
		//변환된 List컬렉션에 우리가 첨부한 이미지의 확장자가 있는지 확인한다.
		if(mimeList.contains(ext)) {
			//만약 없다면 true로 변경한다.
			isImage = true;
		}
		//request 영역에 저장한다.
		req.setAttribute("isImage", isImage);
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/View/Freeboard/FreeboardLookupPost.jsp").forward(req, resp);
	}
}
