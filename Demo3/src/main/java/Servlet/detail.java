package Servlet;

import java.io.IOException;

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

public class detail extends HttpServlet{

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
		Photograph p = new Photograph();
		try{
			if(sessionCheck.sessionCheck(request, response))
			{
				p = pd.getPIc_ById(request.getParameter("p_id"));
				request.setAttribute("author_id",p.getU_id());
				request.setAttribute("p_id",p.getP_id());
				request.setAttribute("p_path",p.getP_path());
				request.setAttribute("headline",p.getheadline());
				request.setAttribute("p_info",p.getInfo());
				u = ud.getMessage_ById(p.getU_id());
				request.setAttribute("author_name", u.getUname());
				request.setAttribute("author_header", u.getUInfo());
				request.getRequestDispatcher("detail.jsp").forward(request,response);
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
