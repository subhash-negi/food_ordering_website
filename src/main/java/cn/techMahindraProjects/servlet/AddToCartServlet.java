package cn.techMahindraProjects.servlet;
import cn.techMahindraProjects.model.*;
import java.io.IOException;
import java.util.*;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out=response.getWriter()){
			ArrayList<Cart>cartList=new ArrayList<>();
			
			int id=Integer.parseInt(request.getParameter("id"));
			Cart cm=new Cart();
			
			cm.setQuantity(1);
			cm.setId(id);
			HttpSession session=request.getSession();
			
			ArrayList<Cart>cart_list=(ArrayList<Cart>) session.getAttribute("cart-list");
			
			if(cart_list==null) {
				 cartList.add(cm);
				 session.setAttribute("cart-list",cartList);
				
				 response.sendRedirect("index.jsp");
			}
			else {
				cartList=cart_list;
				boolean exist=false;
				
				for(Cart c:cart_list) {
					out.println(c.getId());
					if(c.getId()==id) {
						exist=true;
						out.println("<h3 style='color:crimson; text-align:center'>Item already exist in the cart.<a href='cart.jsp'>Go to cart page</a></h3>");
					}
				}
				if(exist==false) {
					cartList.add(cm);
					response.sendRedirect("index.jsp");
				}
					
			}
		}
	}

}
