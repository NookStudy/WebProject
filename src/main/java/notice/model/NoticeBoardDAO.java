package notice.model;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import jdbc.DBconnPool;

public class NoticeBoardDAO extends DBconnPool {

	public NoticeBoardDAO() {
		// TODO Auto-generated constructor stub
	}

	// 게시물의 갯수를 카운트 한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// 만약 검색어가 있다면 조건에 맞는 게시물을 카운트 해야하므로
		// 조건부(where)로 쿼리문을 추가한다.
		String query = "select count(*) from noticeboard";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " " + " like '%" + map.get("searchWord") + "%'";
		}
//			System.out.println("totalCount쿼리: "+query);
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
//				System.out.println(rs.getInt(1));
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		System.out.println(totalCount);
		return totalCount;
	}

	public List<NoticeBoardDTO> selectListpage(Map<String, Object> map) {
		List<NoticeBoardDTO> boardLists = new Vector<NoticeBoardDTO>();
		String query = "Select * from( select tb.*, rownum rnum from (select * from noticeboard";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
		}
		query += " order by notino desc) tb ) where rnum between ? and ?";
			System.out.println("list query: "+query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				NoticeBoardDTO dto = new NoticeBoardDTO();
				dto.setNotino(rs.getString("notino"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setNfile(rs.getString("nfile"));
				dto.setDowncount(rs.getString("downcount"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setCate(rs.getString("cate"));
				
				boardLists.add(dto);
				System.out.println("notiboarcont:line68"+boardLists.get(0).toString());
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return boardLists;
	}
	
	public NoticeBoardDTO lookup(String notino) {
		NoticeBoardDTO dto = new NoticeBoardDTO();
		sql = "select * from noticeboard where notino=?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, notino);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setNotino(rs.getString("notino"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setNfile(rs.getString("nfile"));
				dto.setDowncount(rs.getString("downcount"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setCate(rs.getString("cate"));
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	
	public int write(NoticeBoardDTO dto) {
		int result = 0;
		try {
			/*
			 * ofile: 원본파일명 sfile: 서버에 저장된 파일명 pass: 비회원제 게시판이므로 수정, 삭제를 위한 인증에 사용되는 비밀번호
			 */
			String query = "insert into noticeboard(id,nickname,title,content,ofile,nfile,cate) "
					+ "values(?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			System.out.println(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getNickname());
			psmt.setString(3, dto.getTitle());
			psmt.setString(4, dto.getContent());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getNfile());
			psmt.setString(7, dto.getCate());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public int updatePost(NoticeBoardDTO dto) {
		int result = 0;
		try {
			// 쿼리문 템플릿 준비
			// 일련번호와 패스워드까지 where절에 추가하여 둘다 일치할 때만 수정처리가능.
			// 레디 앤
			sql = "update noticeboard set title=?, nickname=?, content=?, ofile=?, nfile=?  where notino=?";
			// 겟
			psmt = con.prepareStatement(sql);
			// 셋
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getNickname());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getNfile());
			psmt.setString(6, dto.getNotino());
//			System.out.println("updatePost() 의 pass:"+dto.getPass());
			// 고

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateVisitcount(String notino) {
		sql = "update noticeboard set visitcount = visitcount+1  where notino= ?";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, notino);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("조회수 증가중 예외발생");
		}
			return result;
	}
	
	public int deletePost(String notino) {
		sql = "delete noticeboard where notino=?";
		int result=0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, notino);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public void downCountPlus(String idx) {
		sql = "UPDATE noticeboard  set downcount=downcount+1 where notino=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		} catch (Exception e) {
		}
	}
}
