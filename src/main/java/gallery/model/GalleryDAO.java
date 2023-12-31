package gallery.model;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import jdbc.DBconnPool;

public class GalleryDAO extends DBconnPool{

	public GalleryDAO() {
		// TODO Auto-generated constructor stub
	}

	// 게시물의 갯수를 카운트 한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// 만약 검색어가 있다면 조건에 맞는 게시물을 카운트 해야하므로
		// 조건부(where)로 쿼리문을 추가한다.
		String query = "select count(*) from Gallery";
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

	public List<GalleryDTO> selectListpage(Map<String, Object> map) {
		List<GalleryDTO> boardLists = new Vector<GalleryDTO>();
		String query = "Select * from( select tb.*, rownum rnum from (select * from Gallery";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
		}
		query += " order by gallno desc) tb ) where rnum between ? and ?";
			System.out.println("list query: "+query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				GalleryDTO dto = new GalleryDTO();
				dto.setGallno(rs.getString("gallno"));
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
				dto.setHeart(rs.getString("heart"));
				
				boardLists.add(dto);
				System.out.println("notiboarcont:line68"+boardLists.get(0).toString());
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return boardLists;
	}
	
	public GalleryDTO lookup(String gallno) {
		GalleryDTO dto = new GalleryDTO();
		sql = "select * from Gallery where gallno=?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, gallno);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setGallno(rs.getString("gallno"));
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
				dto.setHeart(rs.getString("heart"));
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	
	public int write(GalleryDTO dto) {
		int result = 0;
		try {
			/*
			 * ofile: 원본파일명 sfile: 서버에 저장된 파일명 pass: 비회원제 게시판이므로 수정, 삭제를 위한 인증에 사용되는 비밀번호
			 */
			String query = "insert into Gallery(id,nickname,title,content,ofile,nfile,cate) "
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
	
	public int updatePost(GalleryDTO dto) {
		int result = 0;
		try {
			// 쿼리문 템플릿 준비
			// 일련번호와 패스워드까지 where절에 추가하여 둘다 일치할 때만 수정처리가능.
			// 레디 앤
			sql = "update Gallery set title=?, nickname=?, content=?, ofile=?, nfile=?  where gallno=?";
			// 겟
			psmt = con.prepareStatement(sql);
			// 셋
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getNickname());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getNfile());
			psmt.setString(6, dto.getGallno());
//			System.out.println("updatePost() 의 pass:"+dto.getPass());
			// 고

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateVisitcount(String gallno) {
		sql = "update Gallery set visitcount = visitcount+1  where gallno= ?";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, gallno);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("조회수 증가중 예외발생");
		}
			return result;
	}
	
	public int deleteVisitcount(String gallno) {
		sql = "update Gallery set visitcount = visitcount-1  where gallno= ?";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, gallno);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("조회수 다운중 예외발생");
		}
		return result;
	}
	
	public int deletePost(String gallno) {
		sql = "delete Gallery where gallno=?";
		int result=0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, gallno);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	public void downCountPlus(String idx) {
		sql = "UPDATE gallery  set downcount=downcount+1 where gallno=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("다운수 증가중 예외발생");
		}
	}

	public int heartCheck(Map<String, Object> m) {
		int result = 0;
		sql = "select count(*) from hearts where id=? and gallno=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1,(String)m.get("id"));
			psmt.setString(2,(String)m.get("gallno"));
			rs = psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("좋아요 체크중 예외발생");
		}
		
		return result;
	}

	public void heartUpdate(Map<String, Object> m) {
		sql = "update gallery set heart=heart+1 where gallno=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, (String)m.get("gallno"));
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("좋아요 증가중 예외발생");
		}
	}

	public void heartDelete(Map<String, Object> m) {
		sql = "update gallery set heart=heart-1 where gallno=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, (String)m.get("gallno"));
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("좋아요 다운중 예외발생");
		}
		
	}

	public int countHeart(Map<String, Object> m) {
		int count = 0;
		sql = "select heart from gallery gallno=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1,(String)m.get("gallno"));
			rs = psmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("좋아요수 조회중 예외발생");
		}
		
		return count;
	}

	public void heartlistUpadte(Map<String, Object> m) {
		sql = "insert into hearts(id,gallno) values(?,?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, (String)m.get("id"));
			psmt.setString(2, (String)m.get("gallno"));
			psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("좋아요리스트 추가중 예외발생");
		}
	}

	public void heartlistDelete(Map<String, Object> m) {
		sql = "delete hearts where id=? and gallno=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, (String)m.get("id"));
			psmt.setString(2, (String)m.get("gallno"));
			psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("좋아요리스트 삭제중 예외발생");
		}
		
	}
}

