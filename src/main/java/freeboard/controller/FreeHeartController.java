package freeboard.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import alert.controller.AlertFunction;
import freeboard.model.FreeboardDAO;

@WebServlet("/freeboard/HeartUpdate.do")
public class FreeHeartController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		// no와 id값을 map에 저장
		Map<String, Object> m = new HashMap<>();
		m.put("freeno", req.getParameter("freeno"));
		m.put("id", req.getParameter("id"));
		
		FreeboardDAO dao = new FreeboardDAO();
		// 동일 게시글에 대한 이전 추천 여부 검색
		int result = dao.heartCheck(m);
		System.out.println(result);
		if(result == 0){ // 추천하지 않았다면 추천 추가
			//게시물 하트업
			dao.heartUpdate(m);
			//이아이디로 하트업 추가
			dao.heartlistUpadte(m);
			dao.deleteVisitcount(req.getParameter("freeno"));
			dao.close();
			AlertFunction.alertBack(resp, "추천감사합니다");
		}else{ // 추천을 하였다면 추천 삭제
			dao.heartDelete(m);
			dao.heartlistDelete(m);
			dao.deleteVisitcount(req.getParameter("freeno"));
			dao.close();
			AlertFunction.alertBack(resp, "추천을 취소하셨습니다.");
		}
		
	}


}
