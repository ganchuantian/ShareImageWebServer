package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Photograph;
import Bean.Users;
import Dao.photographDao;
import Dao.usersDao;
import Factory.photographFactory;
import Factory.usersFactory;
import Method.sessionCheck;

public class AuthorSpace extends HttpServlet {
	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) {
		photographFactory pf = photographFactory.getPhotographFactory();
		photographDao pd = pf.getDao();
		usersFactory uf = usersFactory.getUserFactory();
		usersDao ud = uf.getDao();
		Users u = new Users();
		ArrayList<Photograph> rs = new ArrayList<Photograph>();
		String author_id = new String();
		try{
			if(sessionCheck.sessionCheck(request, response))
			{
				author_id = request.getParameter("author_id");
				rs = pd.getAll_ByAId(author_id);
				request.setAttribute("rs",rs);
				if(!author_id.equals((String) request.getSession().getAttribute("userId")))
				{	
					u = ud.getMessage_ById(author_id);
					request.setAttribute("author_id",u.getAccount());
					request.setAttribute("author_name", u.getUname());
					request.setAttribute("author_info", u.getUInfo());
					request.getRequestDispatcher("personalSpace.jsp").forward(request,response);
				}
				else
					request.getRequestDispatcher("My_Works.jsp").forward(request,response);
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
