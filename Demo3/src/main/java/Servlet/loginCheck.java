package Servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Users;
import Dao.usersDao;
import Factory.usersFactory;


public class loginCheck extends HttpServlet{
	
	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		usersFactory uf = usersFactory.getUserFactory();
		usersDao ud = uf.getDao();
		try {
			if(ud.loginCheck(request.getParameter("account"), request.getParameter("pw")))
			{
				Users u = ud.getMessage_ById(request.getParameter("account"));
				request.getSession().setAttribute("userId",u.getAccount());
				request.getSession().setAttribute("userName",u.getUname());
				request.getSession().setAttribute("userChatHead",u.getUInfo());
				request.getRequestDispatcher("HomePage").forward(request,response);
			}
			else
			{
				String fal = "密码错误！";
				request.setAttribute("fal",fal);
				request.getRequestDispatcher("Login.jsp").forward(request,response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void destroy()
	{
	      // 什么也不做
	}
}
