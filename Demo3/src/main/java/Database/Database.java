package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class Database {
	//数据库位置参数
		static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		static final String DB_URL = "jdbc:mysql://localhost:3306/demo";
		
		//数据库身份验证
		static final String USER = "root";
		static final String PASS = "zxcvbnm";
		
		private static Database datebase = null;
		private Database(){
		}
		
		public static Database get_DateBase() {
			if(datebase == null)
				datebase = new Database();
			return datebase;
		}
		public Connection connect() {
			Connection conn = null;
			try{
			      //Register JDBC driver
			      Class.forName(JDBC_DRIVER);
			      //Open a connection
			      conn = DriverManager.getConnection(DB_URL, USER, PASS);
			      System.out.println("数据库连接成功");
			}catch(SQLException se){
			      //Handle errors for Class.forName
			      se.printStackTrace();
			}catch(Exception e){
			      //Handle errors for JDBC
			      e.printStackTrace();
			}
			return conn;
		}
		
		public boolean close(Connection conn, Statement st) {
			boolean result = false;
			try{
				if(st != null)
				{
					st.close();
					if(conn != null)
						conn.close();
				}
				result = true;
				}catch(SQLException se) {
					se.printStackTrace();
				}
			return result;
		}
		
		public boolean close(Connection conn, PreparedStatement st) {
			boolean result = false;
			try{
				if(st != null)
				{
					st.close();
					if(conn != null)
						conn.close();
				}
				result = true;
				}catch(SQLException se) {
					se.printStackTrace();
				}
			return result;
		}
}
