package controller.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.databaseConnection.DbConnection;
import model.User;
import resources.MyConstants;

@WebServlet(asyncSupported = true, urlPatterns = { "/UserRegister" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class UserRegister extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String  username = request.getParameter("username");
		String  password = request.getParameter("password");
		Part image = request.getPart("image");
		String role = "";
		if (username == "admin") {
			role = "admin";
		}
		else {
			role = "user";
		}
		User userModel = new User(firstName, lastName, username, password, role, image);
		
		String savePath = MyConstants.IMGSAVEPATH;
	    String fileName = userModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
    		image.write(savePath + fileName);
		
		DbConnection con = new DbConnection();
		int result = con.registerUser(userModel);
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Registered");
			request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("registerMessage", "Username Already Exists.");
			request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
		}else {
			request.setAttribute("registerMessage", "Failed To Register Your Account");
			request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
		}
		
	}
}
