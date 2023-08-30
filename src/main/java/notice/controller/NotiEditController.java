package notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import alert.controller.AlertFunction;
import notice.model.NoticeBoardDAO;
import notice.model.NoticeBoardDTO;
import utils.FileUtil;

@WebServlet("/noticeboard/edit.do")
public class NotiEditController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String notino = req.getParameter("notino");
		NoticeBoardDAO dao = new NoticeBoardDAO();
		NoticeBoardDTO dto = new NoticeBoardDTO(); 
				dto =  dao.lookup(notino);
		//인출된 내용은 request영역에 전달한 후 forward로 이동한다. 
		req.setAttribute("dto", dto);
		System.out.println("controller"+dto.toString());
		System.out.println("editcontroller"+req.getContextPath());
		dao.close();
		req.getRequestDispatcher("/View/Noticeboard/NoticeEdit.jsp").forward(req, resp);
	}
	
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//디렉토리의 물리적 경로 얻어오기
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		//파일업로드 제한 용량 얻어오기(web.xml 에 저장된걸 servletcontext 객체 생성하여 내장객체얻어옴)
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		//파일 업로드 처리. 객체생성과 동시에 업로드 완료
		MultipartRequest mr = FileUtil.uploaFile(req, saveDirectory, maxPostSize);
		if(mr==null) {
			AlertFunction.alertBack(resp, "첨부 파일이 제한 용량을 초과합니다");
			return;
		}
		
		//파일을 제외한 나머지 폼값을 얻어온다.
		//hidden박스에 저장된 내용(게시물 수정 및 파일수정에 필요함)을 얻어옴
		String notino = mr.getParameter("notino");
		String prevOfile = mr.getParameter("prevOfile");
		String prevSfile = mr.getParameter("prevNfile");
		String nickname = mr.getParameter("nickname");
		String cate = mr.getParameter("cate");
		//사용자가 직접 입력한 값
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		//Nook_수정된 패스워드는 알아서 세션으로 넘어옴
		
		
		/*
			패스워드의 경우 인증완료시 session영역에서 저장해 둔것을 얻어온다.
			update쿼리 실행시 wehre에 조건으로 추가된다.
			즉, 검증이 완료된 사용자만 게시물을 수정할 수 있다.
		 */
		HttpSession session = req.getSession();
		
		//DTO에 데이터 저장
		NoticeBoardDTO dto = new NoticeBoardDTO();
		dto.setNotino(notino);
		dto.setNickname(nickname);
		dto.setTitle(title);
		dto.setContent(content);
		
		//수정 페이지에서 첨부한 파일이 있는경우  파일명을 변경한다.
		String fileName = mr.getFilesystemName("ofile");
		if(fileName!=null) {
			//날짜와 시간으로 파일명을 생성한 후 확장자와 합쳐서 서버에 저장된 파일명을 만든다.
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now+ext;
			
			//파일 객체 생성 후 파일명을 변경한다.
			File oldFile = new File(saveDirectory+File.separator+fileName);
			File newFile = new File(saveDirectory+File.separator+newFileName);
			oldFile.renameTo(newFile);
			
			//업로드된 파일명을 DTO에 저장한다.
			dto.setOfile(fileName);
			dto.setNfile(newFileName);
			
			//새로운 파일이 등록되었으므로 기존파일은 삭제한다.
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}else {
			//새로운 파일을 등록하지 않은 경우 기존 파일명을 DTO에 저장한다.
			dto.setOfile(prevOfile);
			dto.setNfile(prevSfile);
		}
		
		//DB연결 및 업데이트 처리
		NoticeBoardDAO dao = new NoticeBoardDAO();
		int result = dao.updatePost(dto);
		dao.close();
		System.out.println("업데이트 result: "+result);
		
		if(result ==1) {
			//수정이 완료되면 session영역에 저장된 패스워드는 삭제한다.
			session.removeAttribute("flag");
			//내용보기 화면으로 이동하여 수정된 내용을 확인한다.
			resp.sendRedirect("../noticeboard/lookup.do?notino="+notino);
		}else {
			AlertFunction.alertLocation(resp, "비밀번호 검증을 다시 진행해주세요","../noticeboard/lookup.do?notino="+notino);
		}
	}
}
