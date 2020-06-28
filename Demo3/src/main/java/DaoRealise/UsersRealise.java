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
	public boolean loginCheck(String account, String password) throws SQLException {
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
	public Users getMessage_ById(String account) throws SQLException {
		// TODO Auto-generated method stub
		Users user = new Users();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "Select * From usersTable where account=?";
		PreparedStatement preState= (PreparedStatement) conn.prepareStatement(sql);
		preState.setString(1, account);
		ResultSet rs = null;
		try {
			rs = preState.executeQuery();
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
			conn.close();
		}
		return user;
	}
	
	@Override
	public String getPassword(String account) throws SQLException {
		// TODO Auto-generated method stub
		String pw = null;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		//String sql = "Select Password From usersTable where account='" + account + "';";
		String sql = "Select Password From usersTable where account=?";
		PreparedStatement preState= (PreparedStatement) conn.prepareStatement(sql);
		preState.setString(1, account);
		ResultSet rs = null;
		try {
			rs = preState.executeQuery();
			if(rs.next())
			{
				pw = rs.getString("password");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
		return pw;
	}
}
