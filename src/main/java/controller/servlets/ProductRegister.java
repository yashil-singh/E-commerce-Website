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
import model.Products;
import resources.MyConstants;

@WebServlet(asyncSupported = true, urlPatterns = { "/ProductRegister" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ProductRegister extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		String pp = request.getParameter("productPrice");
		Float productPrice = Float.parseFloat(pp);
		String stock = request.getParameter("productStock");
		int productStock = Integer.parseInt(stock);
		String productBrand = request.getParameter("productBrand");
		String productCategory = request.getParameter("productCategory");
		String productDescription = request.getParameter("productDescription");
		Part image = request.getPart("productImage");
		Products productModel = new Products(productName, productPrice, productStock, productBrand, productCategory, productDescription, image);
		
		String savePath = MyConstants.PRODIMGSAVEPATH;
	    String fileName = productModel.getProductImage();
	    if(!fileName.isEmpty() && fileName != null)
    		image.write(savePath + fileName);
		
		DbConnection con = new DbConnection();
		int result = con.registerProduct(productModel);
		if(result == 1) {
			request.setAttribute("registerMessage", "Product Successfully Added");
			request.getRequestDispatcher("/pages/addProducts.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("errorMessage", "Product Already Exists.");
			request.getRequestDispatcher("/pages/addProducts.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMessage", "Failed To Add Product");
			request.getRequestDispatcher("/pages/addProducts.jsp").forward(request, response);
		}
		
	}

}
