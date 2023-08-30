package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBconnPool {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	public String sql;
	/*
	 	커넥션풀 설정을 위해 server.xml context.xml 파일에 엘리먼트를 추가해야 한다.
	 	자세한 내용은 교재 194p 참조
	 */
	//기본 생성자
	public DBconnPool() {
		try {
			//1.Context 객체를 생성한다. (Tomcat 서버라 생각하면 된다.)
			Context initCtx = new InitialContext();
			/*
			 	앞에서 생성한 객체를 통해 JNDI 서비르 구조의 초기 ROOT 디렉토리를 얻어온다.
			 	여기서 얻어오는 톰캣의 루트 디렉토리 명은 java:comp/env로 이미 정해져 있으므로
			 	그대로 사용하면 된다.
			 */
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			/*
			 	3.server.xml에 등록한 네이밍을 lookup하여 DataSource를 얻어온다. 
 				  해당 데이터 소스는 DB에 연결하기 위한 정보를 가지고 있다.
			 */
			DataSource source = (DataSource) ctx.lookup("dbcp_myoracle");
			// 4. 커넥션 풀에 생성해 놓은 커넥션 객체를 가져다가 사용한다.
			con = source.getConnection();
			System.out.println("DB 커넥션 풀 연결 성공");
		} catch (Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
			e.printStackTrace();
		}
	}
	/*
	 	사용이 끝난 객체는 Pool에 반납한다. 
	 	즉 여기서 close()는 객체의 소멸이 아닌 반납이다.
	*/
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();
			if( sql != null) 
				sql=null;

			System.out.println("DB 커넥션 풀 자원 반납");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
