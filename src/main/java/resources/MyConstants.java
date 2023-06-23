package resources;

import java.io.File;

public class MyConstants {
	//Database Configuration
	public static final String DRIVERNAME = "com.mysql.cj.jdbc.Driver";
	public static final String DATABASEURL = "jdbc:mysql://localhost:3306/laven";
	public static final String DATABASEUSERNAME = "root";
	public static final String DATABASEPASSWORD = "";
	public static final String ADMIN = "admin";
	public static final String USER = "user";
	
	//Image Directory and Save Path
	public static final String IMGDIRECTORY = "xampp\\tomcat\\webapps\\images\\users\\";
	public static final String IMGSAVEPATH = "C:" + File.separator + IMGDIRECTORY;
	
	public static final String PRODIMGDIRECTORY = "xampp\\tomcat\\webapps\\images\\products\\";
	public static final String PRODIMGSAVEPATH = "C:" + File.separator + PRODIMGDIRECTORY;
	
	//Insert Query
	public static final String REGISTERUSER = "INSERT INTO register_user"
			+ "(username, firstname, lastname, password, role, image)"
			+ " VALUES(?,?,?,?,?,?)";
	public static final String REGISTERPROD = "INSERT INTO products"
			+ "(productName, productPrice, productStock, productBrand, productCategory, productDescription, productImage)"
			+ " VALUES(?,?,?,?,?,?,?)";
	public static final String ADDTOCART = "INSERT INTO cart_products"
			+"(productID)"+"VALUES(?)";
	public static final String REGISTERCATEGORY = "INSERT INTO categories" + "(productCategory)" + " VALUES(?)";
	public static final String CREATECART = "INSERT INTO cart"+"(username)"+"VALUES(?)";
	public static final String ADDTOCARTDB = "INSERT INTO cart_products VALUES (productID) VALUES(?)";
	
	
	// Select Query
	public static final String CARTCHECK = "SELECT COUNT(*) FROM cart WHERE username=?";
	public static final String CHECKLOGININFO = "SELECT "
			+ "username, password FROM register_user "
			+ "WHERE username = ?";
	public static final String CHECKCATEGORYINFO = "SELECT "
			+ "productCategory FROM categories "
			+ "WHERE productCategory = ?";
	public static final String GETALLINFO = "SELECT * FROM register_user";
	public static final String GETUSERBYUSERNAME = "SELECT * FROM register_user WHERE username = ?";
	public static final String GETPRODINFOBYID = "SELECT * FROM products WHERE productID = ?";
	public static final String GETALLPRODINFO = "SELECT * FROM products";
	public static final String ISUSER = "SELECT role FROM register_user WHERE username = ?";
	
	public static final String CHECKPRODUCTINFO = "SELECT "
			+ "productName, productBrand FROM products "
			+ "WHERE productName = ? AND productBrand = ?";
	public static final String GETPRODUCTSTARS = "SELECT AVG(productStars) FROM ratings WHERE productID = ?";
	public static final String FILTERPROD = "SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount"
			+ "FROM products"
			+ "LEFT JOIN ratings ON products.productID = ratings.productID"
			+ "WHERE ratings.productAvgRating = ? AND UPPER(products.productCategory) = UPPER(?) AND products.productPrice >= ?"
			+ "GROUP BY products.productID";
	public static final String GETCARTBYUSERNAME = "SELECT cartID FROM cart WHERE username=? ";
	public static final String GETUSERPASSWORD = "SELECT password FROM register_user WHERE username=?";
		
	// Start Region: Update Query
	public static final String UPDATEUSERINFO = "UPDATE register_user SET username=?, "
					+ "firstname=?, lastname=?, password=?, image=? WHERE username=?";
	public static final String UPDATEPRODUCTINFO = "UPDATE products SET productName=?, "
			+ "productPrice=?, productStock=?, productBrand=?, productCategory=?, "
			+ "productDescription=?, productImage=? WHERE productID=?";
	// End Region: Update Query
			
	// Start Region: Delete Query
	public static final String DELETEUSER = "DELETE FROM register_user WHERE username=?";
	public static final String DELETEPROD = "DELETE FROM products WHERE productID=?";
	public static final String DELETECATEGORY = "DELETE FROM categories WHERE productCategory=?";
	// End Region: Delete Query
}
