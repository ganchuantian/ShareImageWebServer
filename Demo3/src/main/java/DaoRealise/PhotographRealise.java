package DaoRealise;

import java.sql.*;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mysql.jdbc.ResultSetMetaData;

import Bean.Photograph;
import Dao.photographDao;
import Database.Database;

public class PhotographRealise implements photographDao {

	@Override
	public ArrayList<Photograph> getAll() {
		// TODO Auto-generated method stub
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "Select * From PhotoTable ORDER BY P_id DESC Limit 0,12";
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next())
			{
				Photograph ph = new Photograph();
				ph.setP_id(rs.getString("P_id"));
				ph.setU_id(rs.getString("U_id"));
				ph.setP_path(rs.getString("P_path"));
				ph.setheadline(rs.getString("Headline"));
				ph.setInfo(rs.getString("Info"));
				photo.add(ph);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return photo;
	}
	
	
	@Override
	public JSONArray getNextPics(int index) throws JSONException {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		Statement st = null;
		String sql = "Select * From PhotoTable ORDER BY P_id DESC Limit " + index*12 + ",12";
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
			int columnCount= metaData.getColumnCount();
			
			while(rs.next())
			{
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i <= columnCount;i++)
				{
					String columnName = metaData.getColumnLabel(i);
					String value =rs.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.put(jsonObj);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return array;
	}
	
	@Override
	public JSONArray getNextPics(int index, String headline) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "Select * From PhotoTable Where headline like ? ORDER BY P_id DESC Limit " + index*12 + ",12";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		st.setString(1,"%"+headline+"%");
		ResultSet rs = null;
		try {
			rs = st.executeQuery();
			ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
			int columnCount= metaData.getColumnCount();
			
			while(rs.next())
			{
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i <= columnCount;i++)
				{
					String columnName = metaData.getColumnLabel(i);
					String value =rs.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.put(jsonObj);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return array;
	}
	
	@Override
	public Photograph getPIc_ById(String id) throws SQLException {
		Photograph p = new Photograph();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "Select * From PhotoTable where P_id=?";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setLong(1, Long.parseLong(id));
			rs = st.executeQuery();
			while(rs.next()){
				p.setP_id(rs.getString("P_id"));
				p.setU_id(rs.getString("U_id"));
				p.setP_path(rs.getString("P_path"));
				p.setheadline(rs.getString("Headline"));
				p.setInfo(rs.getString("Info"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return p;
	}

	@Override
	public boolean insertPhotograph(Photograph p) {
		// TODO Auto-generated method stub
		int n=0;
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		java.sql.PreparedStatement st = null;
		String sql = "insert into phototable(U_id,P_path,Headline,Info)  values(?,?,?,?)";
		try {
			st=conn.prepareStatement(sql);
			st.setString(1, p.getU_id());
			st.setString(2, p.getP_path());
			st.setString(3, p.getheadline());
			st.setString(4, p.getInfo());
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
	public ArrayList<Photograph> getAll_ByAId(String u_id) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "Select * From PhotoTable Where U_id=? ORDER BY P_id DESC Limit 0,6";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1,u_id);
			rs = st.executeQuery();
			while(rs.next())
			{
				Photograph ph = new Photograph();
				ph.setP_id(rs.getString("P_id"));
				ph.setU_id(rs.getString("U_id"));
				ph.setP_path(rs.getString("P_path"));
				ph.setheadline(rs.getString("Headline"));
				ph.setInfo(rs.getString("Info"));
				photo.add(ph);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return photo;
	}

	public JSONArray getNextPics_ByUId(int index,String u_id) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();

		String sql = "Select * From PhotoTable Where U_id=? ORDER BY P_id DESC Limit " + index*6 + ",6";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1,u_id);
			rs = st.executeQuery();
			ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
			int columnCount= metaData.getColumnCount();
			
			while(rs.next())
			{
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i <= columnCount;i++)
				{
					String columnName = metaData.getColumnLabel(i);
					String value =rs.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.put(jsonObj);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return array;
	}


	@Override
	public ArrayList<Photograph> getAll_ByUId(String u_id) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();

		String sql = "select * From phototable where phototable.U_id In (select Author_id from watchtable where U_id=?)"
				+ " ORDER BY P_id DESC Limit 0,6";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1,u_id);
			rs = st.executeQuery();
			while(rs.next())
			{
				Photograph ph = new Photograph();
				ph.setP_id(rs.getString("P_id"));
				ph.setU_id(rs.getString("U_id"));
				ph.setP_path(rs.getString("P_path"));
				ph.setheadline(rs.getString("Headline"));
				ph.setInfo(rs.getString("Info"));
				photo.add(ph);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return photo;
	}
	
	public JSONArray getAll_ByUId(String u_id,int index) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "select * From phototable where phototable.U_id In (select Author_id from watchtable where U_id=?)"
				+ " ORDER BY P_id DESC Limit " + index*6 + ",6";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1,u_id);
			rs = st.executeQuery();
			ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
			int columnCount= metaData.getColumnCount();
			while(rs.next())
			{
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i <= columnCount;i++)
				{
					String columnName = metaData.getColumnLabel(i);
					String value =rs.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.put(jsonObj);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return array;
	}


	@Override
	public boolean delete_ByPId(String p_id) throws SQLException {
		// TODO Auto-generated method stub
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();

		String sql = "delete from phototable where P_id=?";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		try {
			st.setString(1,p_id);
			st.execute();
			return true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return false;
	}


	@Override
	public JSONArray getCollection(String u_id ,int index) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();
		String sql = "select * From phototable where P_id In (select P_id from collectionsTable where U_id=?)"
				+ " ORDER BY P_id DESC Limit " + index*6 + ",6";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1, u_id);
			rs = st.executeQuery();
			ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
			int columnCount= metaData.getColumnCount();
			while(rs.next())
			{
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i <= columnCount;i++)
				{
					String columnName = metaData.getColumnLabel(i);
					String value =rs.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.put(jsonObj);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return array;
	}


	@Override
	public ArrayList<Photograph> getAll_ByHeadline(String headline) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<Photograph> photo = new ArrayList<Photograph>();
		Database db = Database.get_DateBase();
		Connection conn = db.get_DateBase().connect();

		String sql = "Select * From PhotoTable Where headline like ? ORDER BY P_id DESC Limit 0,12";
		PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = null;
		try {
			st.setString(1, "%"+headline+"%");
			rs = st.executeQuery();
			while(rs.next())
			{
				Photograph ph = new Photograph();
				ph.setP_id(rs.getString("P_id"));
				ph.setU_id(rs.getString("U_id"));
				ph.setP_path(rs.getString("P_path"));
				ph.setheadline(rs.getString("Headline"));
				ph.setInfo(rs.getString("Info"));
				photo.add(ph);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			db.close(conn, st);
		}
		return photo;
	}

}
