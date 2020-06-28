package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Dao.photographDao;
import Factory.photographFactory;

public class HP_GetNextPics extends HttpServlet {

	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		photographFactory pf = photographFactory.getPhotographFactory();
		photographDao pd = pf.getDao();
		JSONArray array = new JSONArray();
		try{
			PrintWriter out = response.getWriter();
			switch(Integer.parseInt(request.getParameter("op")))
			{
			case 0:
				array = pd.getNextPics(Integer.parseInt(request.getParameter("index")));
				out.print(array);
				break;
			case 1:
				array = pd.getNextPics_ByUId(Integer.parseInt(request.getParameter("index")),request.getParameter("author_id"));
				out.print(array);
				break;
			case 2:
				array = pd.getCollection((String) request.getSession().getAttribute("userId"),Integer.parseInt(request.getParameter("index")));
				out.print(array);
				break;
			case 3:
				array = pd.getNextPics(Integer.parseInt(request.getParameter("index")),request.getParameter("headline"));
				out.print(array);
				break;
			default:
				out.print("false");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void destroy()
	{
	      // 什么也不做
	}
}
