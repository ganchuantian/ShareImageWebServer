package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Photograph;
import Dao.photographDao;
import Factory.photographFactory;
import Method.sessionCheck;

public class HomePage extends HttpServlet {
	
	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) {
		photographFactory pf = photographFactory.getPhotographFactory();
		photographDao pd = pf.getDao();
		ArrayList<Photograph> rs = new ArrayList<Photograph>();
		try{
			if(sessionCheck.sessionCheck(request, response))
			{
				rs = pd.getAll();
				request.setAttribute("rs",rs);
				request.getRequestDispatcher("HomePage.jsp").forward(request,response);
			}
			else
			{
				response.sendRedirect("Login.jsp");
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
