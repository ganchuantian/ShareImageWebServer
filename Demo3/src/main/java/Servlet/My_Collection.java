package Servlet;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Method.sessionCheck;

public class My_Collection {
public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException{
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) {
		try{
			if(sessionCheck.sessionCheck(request, response))
			{
				request.getRequestDispatcher("My_Collection.jsp").forward(request,response);
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
