package Dao;

import java.util.ArrayList;

import Bean.Users;

public interface usersDao {
	public boolean loginCheck(String account,String password);
	public boolean Register(String account,String pw);
	
	public Users getMessage_ById(String account);
	public String getPassword(String account);
	

}
