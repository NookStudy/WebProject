package members.model;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.spi.DirStateFactory.Result;

import jdbc.DBconnPool;
import notice.model.NoticeBoardDTO;

public class MemberDAO extends DBconnPool{


	public MemberDAO() {
		// TODO Auto-generated constructor stub
	}

	public int registMember(MemberDTO dto) {
		sql= " insert into members(id,pass,name,nickname,email,adress1,adress2,gender,birth,phonenumber,postcode) "
				+ "values (?,?,?,?,?,?,?,?,?,?,?)";
		int result =  0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getNickname());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getAdress1());
			psmt.setString(7, dto.getAdress2());
			psmt.setString(8, dto.getGender());
			psmt.setString(9, dto.getBirth());
			psmt.setString(10, dto.getPhonenumber());
			psmt.setString(11, dto.getPostcode());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원가입중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public int loginMember(MemberDTO dto) {
		int result = 3;
		sql= "select pass from members where id=?";
			
		try {
		psmt = con.prepareStatement(sql);
		psmt.setString(1,dto.getId());
		rs = psmt.executeQuery();
		if(rs.next()) {
			
			String tablepass = rs.getString("pass");
		
			if (dto.getPass().equals(tablepass)) {
				//로그인 성공
				result = 0;
			}else {
				System.out.println("패스워드 다름");
				//패스워드 다름
				result = 1;
			}
		}else {
			//아이디 없음
			System.out.println("아이디 없음");
			result=-1;
		}
		} catch (Exception e) {
			result = 5;
			System.out.println("로그인 실패");
			e.printStackTrace();
		}
		return result;
		
	}
	
	public MemberDTO getMemberInfo(MemberDTO dto) {
		sql =  "select * from members Where id=? and pass=?";
		MemberDTO memberInfoDTO = new MemberDTO();
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				//정보가 있다면 DTO객체에 회원정보를 저장한다.
				memberInfoDTO.setUserno(rs.getString("userno"));
				memberInfoDTO.setId(rs.getString("id"));
				memberInfoDTO.setPass(rs.getString("pass"));
				memberInfoDTO.setName(rs.getString("name"));
				memberInfoDTO.setNickname(rs.getString("nickname"));
				memberInfoDTO.setEmail(rs.getString("email"));
				memberInfoDTO.setAdress1(rs.getString("adress1"));
				memberInfoDTO.setAdress2(rs.getString("adress2"));
				memberInfoDTO.setGender(rs.getString("gender"));
				memberInfoDTO.setBirth(rs.getString("birth"));
				memberInfoDTO.setRegidate(rs.getDate("regidate"));
				memberInfoDTO.setPhonenumber(rs.getString("phonenumber"));
				memberInfoDTO.setPostcode(rs.getString("postcode"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//호출한 지점으로 DTO 객체를 반환한다.
		return memberInfoDTO;
	}
	public MemberDTO getMemberInfdto(MemberDTO dto) {
		sql =  "select * from members Where id=?";
		MemberDTO memberInfoDTO = new MemberDTO();
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				//정보가 있다면 DTO객체에 회원정보를 저장한다.
				memberInfoDTO.setUserno(rs.getString("userno"));
				memberInfoDTO.setId(rs.getString("id"));
				memberInfoDTO.setPass(rs.getString("pass"));
				memberInfoDTO.setName(rs.getString("name"));
				memberInfoDTO.setNickname(rs.getString("nickname"));
				memberInfoDTO.setEmail(rs.getString("email"));
				memberInfoDTO.setAdress1(rs.getString("adress1"));
				memberInfoDTO.setAdress2(rs.getString("adress2"));
				memberInfoDTO.setGender(rs.getString("gender"));
				memberInfoDTO.setBirth(rs.getString("birth"));
				memberInfoDTO.setRegidate(rs.getDate("regidate"));
				memberInfoDTO.setPhonenumber(rs.getString("phonenumber"));
				memberInfoDTO.setPostcode(rs.getString("postcode"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//호출한 지점으로 DTO 객체를 반환한다.
		return memberInfoDTO;
	}
	
	
	public int checkId(String id) {
		sql = "select count(*) from members where id=?";
		int result= -1;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("아이디 조회중 오류발생");
			e.printStackTrace();
		}
		return result;
	}
	public int checkNickname(String nickname) {
		sql = "select count(*) from members where nickname=?";
		int result= -1;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, nickname);
			rs = psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("닉네임 조회중 오류발생");
			e.printStackTrace();
		}
		return result;
	}

	public int updateMember(MemberDTO dto) {
		sql="update members set pass=?,email=?,postcode=?,adress1=?,adress2=?,phonenumber=?, nickname=?  where id=? ";
		int result = -1;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getEmail());
			psmt.setString(3, dto.getPostcode());
			psmt.setString(4, dto.getAdress1());
			psmt.setString(5, dto.getAdress2());
			psmt.setString(6, dto.getPhonenumber());
			psmt.setString(7, dto.getNickname());
			psmt.setString(8, dto.getId());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 수정중 오류발생");
		}
		return result;
		
	}
	
	
	public List<MemberDTO> selectmemberpage(Map<String, Object> map) {
		List<MemberDTO> memberLists = new Vector<MemberDTO>();
		String query = "Select * from( select tb.*, rownum rnum from (select * from members";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
		}
		query += " order by userno desc) tb ) where rnum between ? and ?";
			System.out.println("list query: "+query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setUserno(rs.getString("userno"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPostcode(rs.getString("postcode"));
				dto.setAdress1(rs.getString("adress1"));
				dto.setAdress2(rs.getString("adress2"));
				dto.setGender(rs.getString("gender"));
				dto.setBirth(rs.getString("birth"));
				dto.setRegidate(rs.getDate("regidate"));
				dto.setPhonenumber(rs.getString("phonenumber"));
				
				memberLists.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
//		System.out.println("notiboarcont:line231"+memberLists.get(0).toString());
		return memberLists;
	}
	
	// 멤버명 카운트
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// 만약 검색어가 있다면 조건에 맞는 게시물을 카운트 해야하므로
		// 조건부(where)로 쿼리문을 추가한다.
		String query = "select count(*) from members";
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
	
	public int deleteMember(String id) {
		sql = "delete from members where id=?";
		int result=-1;
		try {
			psmt=con.prepareStatement(sql);
			psmt.setString(1, id);
			result=psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원 탈퇴 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	
	public void close() {
		try {
			if (psmt!=null) {
				psmt.close();
			}
			if (con!=null) {
				con.close();
			}
			if(stmt!=null)	stmt.close();
			if(sql!=null) sql=null;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	
}
