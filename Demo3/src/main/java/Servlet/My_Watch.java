package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Bean.Photograph;
import Bean.Users;
import Dao.UsersAction;
import Dao.photographDao;
import Dao.usersDao;
import Factory.UserActionFactory;
import Factory.photographFactory;
import Factory.usersFactory;
import Method.sessionCheck;

public class My_Watch extends HttpServlet {
	public void init() throws ServletException {
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) {
		String author_id = new String();
		author_id = request.getParameter("author_id");
		int index = Integer.parseInt(request.getParameter("index"));
		try{
			if(sessionCheck.sessionCheck(request, response))
			{
				switch(author_id)
				{
					case "all":
						getAll(request,response,index);
						break;
					default:
						getWorks_ById(request,response,author_id);
				}
			}
			else
			{
				response.sendRedirect("Login.jsp");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	private void getWorks_ById(HttpServletRequest request,HttpServletResponse response,String author_id) {
		// TODO Auto-generated method stub
		photographFactory pf = photographFactory.getPhotographFactory();
		photographDao pd = pf.getDao();
		JSONArray array = new JSONArray();
		try{
			PrintWriter out = response.getWriter();
			array = pd.getNextPics_ByUId(Integer.parseInt(request.getParameter("index")),author_id);
			out.print(array);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public void getAll(HttpServletRequest request,HttpServletResponse response,int index) {
		photographFactory pf = photographFactory.getPhotographFactory();
		photographDao pd = pf.getDao();
		UserActionFactory uaf = UserActionFactory.getUserActionFactory();
		UsersAction ua = uaf.getDao();
		ArrayList<Photograph> p_rs = new ArrayList<Photograph>();
		ArrayList<Users> a_rs = new ArrayList<Users>();
		String u_id = (String) request.getSession().getAttribute("userId");
		try{
			if(index==0)
			{
				p_rs = pd.getAll_ByUId(u_id);
				request.setAttribute("p_rs",p_rs);
				a_rs = ua.getWatchAuthor(u_id);
				request.setAttribute("a_rs",a_rs);
				request.getRequestDispatcher("My_Watch.jsp").forward(request,response);
			}
			else
			{
				PrintWriter out = response.getWriter();
				JSONArray array = new JSONArray();
				array = pd.getAll_ByUId(u_id,index);
				out.print(array);
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
