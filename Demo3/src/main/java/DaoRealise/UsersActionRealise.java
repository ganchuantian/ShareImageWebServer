package DaoRealise;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Bean.Users;
import Dao.UsersAction;
import Database.Database;

public class UsersActionRealise implements UsersAction{
	
	@Override
	public int wacthCheck(String u_id, String author_id) {
		// TODO Auto-generated method stub
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		ResultSet rs = null;
		String sql = "Select * From watchTable Where U_id='" + u_id + "' and Author_id='" + author_id + "';";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				return 1;
			}
			else
				return 0;
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return -1;
	}

	@Override
	public int collectionCheck(String u_id, String p_id) {
		// TODO Auto-generated method stub
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		ResultSet rs = null;
		Integer.parseInt(p_id);
		String sql = "Select * From collectionsTable Where U_id='" + u_id + "' and P_id=" + Integer.parseInt(p_id) + ";";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				return 2;
			}
			else
				return 0;
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return -1;
	}

	@Override
	public boolean watchAuthor(String u_id, String author_id) {
		// TODO Auto-generated method stub
		int n = 0;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		java.sql.PreparedStatement st = null;
		String sql = "insert into watchTable(U_id,Author_id) values(?,?)";
		try {
			st=conn.prepareStatement(sql);
			st.setString(1, u_id);
			st.setString(2, author_id);
			n = st.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteWatch(String u_id, String author_id) {
		// TODO Auto-generated method stub
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "DELETE FROM watchTable WHERE u_id='" + u_id + "' and author_id='" + author_id + "'";
		try {
			st = conn.createStatement();
			st.execute(sql);
			return true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return false;
	}

	@Override
	public boolean collectionPic(String u_id, String p_id) {
		// TODO Auto-generated method stub
		int n = 0;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		java.sql.PreparedStatement st = null;
		String sql = "insert into collectionsTable(U_id,P_id) values(?,?)";
		try {
			st=conn.prepareStatement(sql);
			st.setString(1, u_id);
			st.setLong(2, Integer.parseInt(p_id));
			n = st.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteCollection(String u_id, String p_id) {
		// TODO Auto-generated method stub
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "DELETE FROM collectionsTable WHERE u_id='" + u_id + "' and p_id=" + Integer.parseInt(p_id);
		try {
			st = conn.createStatement();
			st.execute(sql);
			return true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return false;
	}

	@Override
	public ArrayList<Users> getWatchAuthor(String u_id) {
		// TODO Auto-generated method stub
		ArrayList<Users> authors = new ArrayList<Users>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "Select account,uName From usersTable Where account in (Select Author_id From watchTable Where u_id='" + u_id + "')";
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next())
			{ 
				Users u = new Users();
				u.setAccount(rs.getString("account"));
				u.setUname(rs.getString("uName"));
				authors.add(u);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return authors;
	}
}
