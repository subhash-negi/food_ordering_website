package cn.techMahindraProjects.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.techMahindraProjects.connection.DbCon;
import cn.techMahindraProjects.dao.UserDao;
import cn.techMahindraProjects.model.*;
import java.sql.*;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out=response.getWriter()){
			String email=request.getParameter("login-email");
			String password=request.getParameter("login-password");
			
			try {
				UserDao udao=new UserDao(DbCon.getConnection());
				User user=udao.userLogin(email, password);
				
				if(user!=null) {
					request.getSession().setAttribute("auth", user);
					response.sendRedirect("index.jsp");
				}else {
					out.println("user login failed");
				}
				
			}catch(ClassNotFoundException|SQLException e) {
				e.printStackTrace();
			}
			out.print(email+password);
		}
	}

}
