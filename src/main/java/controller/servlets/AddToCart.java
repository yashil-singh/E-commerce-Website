package controller.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.databaseConnection.DbConnection;
import model.Cart;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try{
		
			ArrayList<Cart> cartItems= new ArrayList<>() ;
			int prodID = Integer.parseInt(request.getParameter("productID"));
			Cart item = new Cart() ;
			item.setProductID(prodID);
			
			HttpSession session = request.getSession();
			ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartItems");
			if(cartList==null) {
				cartItems.add(item);
				session.setAttribute("cartItems", cartItems);
				response.sendRedirect(request.getContextPath()+"/pages/cart.jsp?productID="+prodID);
			}else {
				cartItems=cartList;
				boolean exists = false;
				for(Cart cart: cartList) {
					if(cart.getProductID()==prodID) {
						exists=true;
					}
				}
				
				if(exists==false) {
					session.setAttribute("cartItems", cartItems);
					cartItems.add(item);
					request.setAttribute("sucessMessage", "Product Successfully Added");
					response.sendRedirect(request.getContextPath()+"/pages/cart.jsp?productID="+prodID);
				}else {
					request.setAttribute("errorMessage", "Product Is Already In Your Cart");
					response.sendRedirect(request.getContextPath()+"/pages/cart.jsp?productID="+prodID);
				}
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
