package Dao;

import java.util.ArrayList;

import Bean.Users;

public interface UsersAction {
	public int wacthCheck(String u_id,String author_id);
	
	public int collectionCheck(String u_id,String p_id);
	public boolean watchAuthor(String u_id,String author_id);
	public boolean deleteWatch(String u_id,String author_id);
	public boolean collectionPic(String u_id,String p_id);
	public boolean deleteCollection(String u_id,String p_id);
	
	public ArrayList<Users> getWatchAuthor(String u_id);
}
