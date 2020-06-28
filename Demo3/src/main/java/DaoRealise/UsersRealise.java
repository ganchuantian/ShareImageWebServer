package DaoRealise;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import Bean.Users;
import Dao.usersDao;
import Database.*;

public class UsersRealise implements usersDao {

	@Override
	public boolean loginCheck(String account, String password) {
		// TODO Auto-generated method stub
		if(password.equals(getPassword(account)))
			return true;
		else
			return false;
	}
	
	@Override
	public boolean Register(String account,String pw) {
		int n=0;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		java.sql.PreparedStatement st = null;
		String sql = "insert into usersTable(account,password,uName) values(?,?,?)";
		try {
			st=conn.prepareStatement(sql);
			st.setString(1, account);
			st.setString(2, pw);
			st.setString(3, account);
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
	public Users getMessage_ById(String account) {
		// TODO Auto-generated method stub
		Users user = new Users();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "Select * From usersTable where account='" + account + "'";
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next())
			{
				user.setAccount(rs.getString("account"));
				user.setPassword(rs.getString("password"));
				user.setUname(rs.getString("uName"));
				user.setUInfo(rs.getString("uInfo"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return user;
	}
	
	@Override
	public String getPassword(String account) {
		// TODO Auto-generated method stub
		String pw = null;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "Select Password From usersTable where account='" + account + "';";
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				pw = rs.getString("password");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return pw;
	}
}
