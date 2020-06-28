package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Photograph;
import Dao.photographDao;
import Factory.photographFactory;
import Method.FileMethod;

public class upload extends HttpServlet {
	
	public void init() throws ServletException{
		
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		photographFactory pf = photographFactory.getPhotographFactory();
    	photographDao pd = pf.getDao();
    	Photograph pg = new Photograph();
    	String b64 = new String();
    	String path = new String();
    	b64=request.getParameter("b64");   
    	PrintWriter out = response.getWriter();
		try{
    		FileMethod b_64 = new FileMethod(b64);
	        path = b_64.New_Img();
	    	pg.setheadline(request.getParameter("headline"));
	    	pg.setU_id(request.getParameter("u_id"));
	    	pg.setInfo(request.getParameter("info"));
	    	pg.setP_path(path);
    		pd.insertPhotograph(pg);
    		out.println("true");
    	}catch(Exception e){
    		e.printStackTrace();
    		out.println("false");
    	}
	}
	
	public void destroy()
	{
	      // 什么也不做
	}
	
}
