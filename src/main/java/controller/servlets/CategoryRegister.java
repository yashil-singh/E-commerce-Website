package controller.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.databaseConnection.DbConnection;
import model.Categories;

@WebServlet("/CategoryRegister")
public class CategoryRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productCategory = request.getParameter("productCategory");
		Categories userModel = new Categories(productCategory);
		
		DbConnection con = new DbConnection();
		int result = con.registerCategory(userModel);
		if(result == 1) {
			request.setAttribute("registerMessage", "Category Successfully Added");
			request.getRequestDispatcher("/pages/addCategories.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("errorMessage", "Category Already Exists.");
			request.getRequestDispatcher("/pages/addCategories.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMessage", "Failed To Add Category");
			request.getRequestDispatcher("/pages/addCategories.jsp").forward(request, response);
		}
	}
}
