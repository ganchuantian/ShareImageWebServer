package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.usersDao;
import Factory.usersFactory;

public class RegisterCheck extends HttpServlet {

	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String me;
		usersFactory uf = usersFactory.getUserFactory();
		usersDao ud = uf.getDao();
		if(ud.Register(request.getParameter("account"), request.getParameter("pw")))
		{
			me="注册成功！";
			request.setAttribute("me",me);
			request.getRequestDispatcher("Register.jsp").forward(request,response);
		}
		else
		{
			me = "注册失败，可能该用户已被注册";
			request.setAttribute("me",me);
			request.getRequestDispatcher("Register.jsp").forward(request,response);
		}
	}
	
	public void destroy()
	{
	      // 什么也不做
	}
}
