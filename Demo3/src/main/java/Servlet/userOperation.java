package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Photograph;
import Dao.UsersAction;
import Dao.photographDao;
import Factory.UserActionFactory;
import Factory.photographFactory;
import Method.FileMethod;



public class userOperation extends HttpServlet {
	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserActionFactory userActionFactory = UserActionFactory.getUserActionFactory();
		UsersAction ua = userActionFactory.getDao();
		PrintWriter out = response.getWriter();
		photographFactory pf = photographFactory.getPhotographFactory();
    	photographDao pd = pf.getDao();
		try {
			switch(Integer.parseInt(request.getParameter("op"))) 
			{
			case 0:
				if(ua.watchAuthor(request.getParameter("u_id"), request.getParameter("author_id")))
					out.println("true");
				else
					out.println("false");
				break;
			case 1:
				if(ua.deleteWatch(request.getParameter("u_id"), request.getParameter("author_id")))
					out.println("true");
				else
					out.println("false");
				break;
			case 2:
				if(ua.collectionPic(request.getParameter("u_id"), request.getParameter("p_id")))
					out.println("true");
				else
					out.println("false");
				break;
			case 3:
				if(ua.deleteCollection(request.getParameter("u_id"), request.getParameter("p_id")))
					out.println("true");
				else
					out.println("false");
				break;
			case 4:
				out.println(ua.wacthCheck(request.getParameter("u_id"), request.getParameter("author_id")));
				break;
			case 5:
				out.println(ua.collectionCheck(request.getParameter("u_id"), request.getParameter("p_id")));
				break;
			case 6:
				int i = 0;
				i+=ua.wacthCheck(request.getParameter("u_id"), request.getParameter("author_id"));
				i+=ua.collectionCheck(request.getParameter("u_id"), request.getParameter("p_id"));
				out.println(i);
				break;
			case 7:
				Photograph p = pd.getPIc_ById(request.getParameter("p_id"));
				if(pd.delete_ByPId(request.getParameter("p_id")))
				{
					FileMethod.deleteFile(p.getP_path());
					out.println("true");
				}
				else
					out.println("false");
				break;
			default:
				out.println("false");
			}
		}catch(Exception e) {
			e.printStackTrace();
			out.println("false");
		}
	}
	
	public void destroy()
	{
	      // 什么也不做
	}
}
