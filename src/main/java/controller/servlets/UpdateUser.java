package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import controller.databaseConnection.DbConnection;
import model.Products;
import model.User;
import resources.MyConstants;

@WebServlet(asyncSupported = true, urlPatterns = { "/UpdateUser" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession(false);  
			DbConnection con = new DbConnection();
			String currentUsername = (String) session.getAttribute("user");
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String  newUsername = request.getParameter("username");
			Part image = request.getPart("image");
			User userModel = new User(firstName, lastName, newUsername, image);
			
			
			
			String savePath = MyConstants.IMGSAVEPATH;
		    String fileName = userModel.getImageUrlFromPart();
		    if(!fileName.isEmpty() && fileName != null)
	    		image.write(savePath + fileName);
			
			int result = con.updateUser(userModel, currentUsername, newUsername);
			if(result == 1) {
				session.setAttribute("user", newUsername);
				request.setAttribute("registerMessage", "Successfully Updated Your Account");
				request.getRequestDispatcher("/pages/account.jsp").forward(request, response);
			}
			else if(result == 0) {
				request.setAttribute("errorMessage", "Username Already Exists");
				request.getRequestDispatcher("/pages/account.jsp").forward(request, response);
			}
			else {
				request.setAttribute("errorMessage", "Failed To Update Your Account");
				request.getRequestDispatcher("/pages/updateUserAccount.jsp").forward(request, response);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
