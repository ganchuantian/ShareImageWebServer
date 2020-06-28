package Dao;

import java.sql.SQLException;
import java.util.ArrayList;

import Bean.Users;

public interface UsersAction {
	public int wacthCheck(String u_id,String author_id) throws SQLException;
	
	public int collectionCheck(String u_id,String p_id) throws SQLException;
	public boolean watchAuthor(String u_id,String author_id);
	public boolean deleteWatch(String u_id,String author_id) throws SQLException;
	public boolean collectionPic(String u_id,String p_id);
	public boolean deleteCollection(String u_id,String p_id) throws SQLException;
	
	public ArrayList<Users> getWatchAuthor(String u_id);
}
