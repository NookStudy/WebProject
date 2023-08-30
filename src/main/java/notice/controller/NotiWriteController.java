package notice.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import alert.controller.AlertFunction;
import notice.model.NoticeBoardDAO;
import notice.model.NoticeBoardDTO;
import utils.FileUtil;

@WebServlet("/noticeboard/write.do")
public class NotiWriteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/View/Noticeboard/NoticeWrite.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//파일이 업로드 될 디렉토리의 물리적 경로를 얻어온다.
				String saveDirectory = req.getServletContext().getRealPath("/Uploads");
				
				//application 내장객체를 통해 web.xml에 등록된 초기화 파라미터를 얻어온다.
				//업로드 제한 용량은 현재 1mb로 설정되었다.
				ServletContext application = getServletContext();
				int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
				/*
				 	파일 업로드를 위해 MultipartRequest 객체를 생성한다. 
				 	객체가 정상적으로 생성된다면 파일업로드는 완료된다.
				 */
				MultipartRequest mr = FileUtil.uploaFile(req,saveDirectory,maxPostSize);
				/*
					만약 객체생성이 되지 않았다면 업로드에 실패한 것이다. 
					이때는 파일의 용량이나 디렉토리의 경로를 확인해 본다.
					만약 글작성시 파일을 첨부하지 않았더라도 객체는 생성되므로 폼값은 정상적으로 받을 수 있다. 
				*/
				System.out.println("mr:"+mr);
				
				if (mr==null) {
					AlertFunction.alertLocation(resp,"첨부 파일이 제한 용량을 초과합니다.","../noticeboard/write.do");
					/*
						객체가 생성되지 않아 업로드에 실패하면 나머지 폼값도 받을 수 없으므로
						반드시 리턴을 통해 실행을 중지시켜야 한다.
					 */
					return;
				}
				//여기까지 의 코드로 '파일'업로드 완료
				
				//파일을 제외한 나머지 폼값을 받아서 DTO객체에 저장
				//단, request내장객체가 아닌 mr을 통해 받는다(mr로 받았으므로)
				NoticeBoardDTO dto = new NoticeBoardDTO();
				dto.setId(mr.getParameter("id"));
				dto.setNickname(mr.getParameter("nickname"));
				dto.setTitle(mr.getParameter("title"));
				dto.setContent(mr.getParameter("content"));
				dto.setCate(mr.getParameter("cate"));
				System.out.println("writecontroller:"+mr.getParameter("cate"));
				//서버에 업로드된 파일명을 얻어온다.
				String fileName = mr.getFilesystemName("ofile");
				/*서버에 저장된 파일이 있는 경우에만 파일명 변경 처리를 한다.
				 * 만약 첨부하지 않았다면 아래코드는 실행하지 않는다.*/
				if (fileName != null) {
					//날짜와 시간을 이용해서 파일명을 생성한다.
					String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
					//파일명의 마지막에 있는 .(닷)의 인덱스를 찾은 후 확장자를 반환한다.
					String ext = fileName.substring(fileName.lastIndexOf("."));
					//파일명과 확장자를 연결해서 새로운 파일명을 생성한다.
					//여기서 확장자를 jpg,png,gif만 받을 수 있게하면 사진게시판의 완성
					String newFileName = now+ ext;
					
					//파일 객체를 생성한 후 파일명을 변경한다.
					File oldFile = new File(saveDirectory+File.separator+fileName);
					File newFile = new File(saveDirectory+File.separator+newFileName);
					oldFile.renameTo(newFile);
					
					//DTO객체의 원본파일명과 저장된 파일명을 저장한다.
					dto.setOfile(fileName);
					dto.setNfile(newFileName);
				}
				
				//새로운 게시물을 테이블에 입력한다.
				NoticeBoardDAO dao = new NoticeBoardDAO();
				int result = dao.write(dto);
				//커넥션풀 자원반납
				dao.close();
				
				//서블릿에서 특정 요청명으로 이동할 때는 sendRidirect()메서드를 사용하면 된다.
				if (result==1) {
					//insert에 성공하면 리스트로 이동한다.
					resp.sendRedirect("../noticeboard/list.do");
				}else {
					//실패하면 작성페이지로 다시 돌아간다.
					resp.sendRedirect("../noticeboard/write.do");
				}
			}
	}

