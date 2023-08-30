package reply.model;

import java.sql.PreparedStatement;
import java.util.ArrayList;


import jdbc.*;

public class GallReplyDAO extends DBconnPool
{
	public GallReplyDAO() {
		
	}

	public String getDate()
	{ 
		// 현재 서버 시간 가져오기
		String SQL = "select sysdate from dual"; // 현재 시간을 가져오는 SQL문
		try
		{
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);	//실행결과 가져오기
			if (rs.next())
			{
				return rs.getString(1);	//현재 날짜 반환
			}

		} catch (Exception e)
		{
			e.printStackTrace();	//오류 발생
			System.out.println("시간가져오기 오류");
		}
		return "";	//데이터베이스 오류
	}

	public int getNext()
	{
		String SQL = "SELECT replyno from replygall order by replyno DESC";	//마지막 게시물 반환
		try
		{
			PreparedStatement stmt = con.prepareStatement(SQL);
			rs = stmt.executeQuery();
			if (rs.next())
			{
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}

	public int write( int gallno, String userID, String replycontent)
	{
		String SQL = "insert into replygall(id,gallno,replycontent) VALUES (?, ?, ?)";
		try
		{
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, userID);
			psmt.setInt(2, gallno);
			psmt.setString(3, replycontent);
			return psmt.executeUpdate();

		} catch (Exception e)
		{ 
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<GallReplyDTO> getList(int bbsID)
	{
		//특정한 리스트를 받아서 반환
		//마지막 게시물을 가져옴
		
		String SQL = "SELECT * FROM ( SELECT * FROM replygall WHERE gallno = :1 AND replyAvailable = 1 ORDER BY replyno DESC ) WHERE ROWNUM <= 10";
		ArrayList<GallReplyDTO> replylist = new ArrayList<GallReplyDTO>();
		try
		{
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, bbsID);
			rs = psmt.executeQuery();
			while (rs.next())
			{
				GallReplyDTO reply = new GallReplyDTO();
				reply.setReplyno(rs.getInt("replyno"));
				reply.setReplycontent(rs.getString("replycontent"));
				reply.setId(rs.getString("id"));
				reply.setReplyAvailable(rs.getInt("replyavailable"));
				reply.setReplyDate(rs.getDate("replydate"));
				reply.setGallno(rs.getInt("gallno"));
				replylist.add(reply);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return replylist; //댓글 리스트 반환
	}

	public GallReplyDTO getReply(int replyno) {
		//하나의 댓글 내용을 불러오는 함수
		String SQL = "SELECT * from gallreply where replyno = ?";
		try
		{
			PreparedStatement stmt = con.prepareStatement(SQL);
			stmt.setInt(1, replyno);
			rs = stmt.executeQuery();// select
			if (rs.next())
			{ //결과가 있다면
				GallReplyDTO reply = new GallReplyDTO();
				reply.setReplyno(rs.getInt("replyno"));
				reply.setReplycontent(rs.getString("replycontent"));
				reply.setId(rs.getString("id"));
				reply.setReplyAvailable(rs.getInt("replyavailable"));
				reply.setReplyDate(rs.getDate("replydate"));
				reply.setGallno(rs.getInt("gallno"));
				return reply;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	public int update(int gallno, int replyno, String replyContent)
	{
		//특정한 아이디에 해당하는 제목과 내용을 바꿔줌
		String SQL = "UPDATE replygall SET replycontent = ? WHERE replyno = ?";
		try
		{
			psmt = con.prepareStatement(SQL);
			//물음표의 순서
			psmt.setString(1, replyContent); 
			psmt.setInt(2, replyno);
			// insert,delete,update
			return psmt.executeUpdate();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int replyno)
	{
		String SQL = "UPDATE replygall SET replyAvailable = 0 WHERE replyno = ?";
		try
		{
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, replyno);
			return psmt.executeUpdate();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}

}
