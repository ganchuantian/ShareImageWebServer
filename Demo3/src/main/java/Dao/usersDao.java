package Dao;

import java.sql.SQLException;
import java.util.ArrayList;

import Bean.Users;

public interface usersDao {
	public boolean loginCheck(String account,String password) throws SQLException;
	public boolean Register(String account,String pw);
	
	public Users getMessage_ById(String account) throws SQLException;
	public String getPassword(String account) throws SQLException;

}
