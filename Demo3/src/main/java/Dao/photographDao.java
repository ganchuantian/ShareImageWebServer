package Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;

import Bean.Photograph;

public interface photographDao {
	public ArrayList<Photograph> getAll();
	
	public ArrayList<Photograph> getAll_ByHeadline(String headline) throws SQLException;

	public ArrayList<Photograph> getAll_ByAId(String u_id) throws SQLException;
	
	public ArrayList<Photograph> getAll_ByUId(String u_id) throws SQLException;
	
	public JSONArray getNextPics_ByUId(int index,String u_id) throws JSONException, SQLException;

	public JSONArray getNextPics(int index) throws JSONException;
	
	public JSONArray getNextPics(int index,String headline) throws JSONException, SQLException;

	public Photograph getPIc_ById(String id) throws SQLException;

	public boolean insertPhotograph(Photograph p);
	
	public JSONArray getAll_ByUId(String u_id,int index) throws JSONException, SQLException;
	
	public boolean delete_ByPId(String p_id) throws SQLException;
	
	public JSONArray getCollection(String u_id,int index) throws JSONException, SQLException;
}
