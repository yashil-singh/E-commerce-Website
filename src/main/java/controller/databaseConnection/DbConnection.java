package controller.databaseConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.management.InstanceNotFoundException;

import com.mysql.cj.protocol.Resultset;

import model.Cart;
import model.Categories;
import model.PasswordEncryptionWithAes;
import model.Products;
import model.User;
import resources.MyConstants;

public class DbConnection {
	
	//Database Connection Method
	public Connection connectDatabase() {
		try {
			Class.forName(MyConstants.DRIVERNAME);
			Connection connection = DriverManager.getConnection(
					MyConstants.DATABASEURL, 
					MyConstants.DATABASEUSERNAME,
					MyConstants.DATABASEPASSWORD);
			return connection;
			
		}
		catch(SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	//	Start region Read operation
	public List<User> getAllUsers(String query) {
        List<User> dataList = new ArrayList();
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
	            Statement stmt = dbConnection.createStatement();
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	            	User data = new User();
	                data.setFirstName(rs.getString("first_name"));
	                data.setLastName(rs.getString("last_name"));
	                data.setUsername(rs.getString("username"));
	                data.setRole(rs.getString("role"));
	                dataList.add(data);
	            }
	            rs.close();
	            stmt.close();
	            dbConnection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		}
        return dataList;
	}
	
	//User Registration Check Method
	public Boolean isUserAlreadyRegistered(String username) {
		Connection con = connectDatabase();
		if(con != null) {
			try {
				PreparedStatement statement = con.prepareStatement(MyConstants.CHECKLOGININFO);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;		
				}
				else {
					return false;
				}
			} 
			catch (SQLException e) { 
				return null; 
			}
		}
		else { 
			return null; 
		}
	}
	
	//Register User Method 
	public int registerUser(User userModel) {
		Connection connection = connectDatabase();
		if(connection != null) {
			if(isUserAlreadyRegistered(userModel.getUsername())) {
				return -1;
			}
			else {
				try {
					PreparedStatement ps = connection.prepareStatement(MyConstants.REGISTERUSER);
					ps.setString(1, userModel.getUsername());
					ps.setString(2, userModel.getFirstName());
					ps.setString(3, userModel.getLastName());
					ps.setString(4, PasswordEncryptionWithAes.encrypt(
							userModel.getUsername(), userModel.getPassword()));
					ps.setString(5, userModel.getRole());
					ps.setString(6, userModel.getImageUrlFromPart());
					
					int result = ps.executeUpdate();
					if(result>=0) {
						return 1;
					}
					else {
						return 0;
					}
				}
				catch(SQLException e) {
					e.printStackTrace();
					return -2;
				}
			}	
		}
		else {
			return -3;
		}
	}
	
	//User Registration Check For Login Method
	public Boolean isUserRegistered(String query, String username, String password) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String userDb = result.getString("username");
					String passwordDb  = result.getString("password");
					String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, username);
					if(decryptedPwd!=null && userDb.equals(username) && decryptedPwd.equals(password)) return true;
					else return false;
				}else return false;
			} 
			catch (SQLException e) { 
				e.printStackTrace();
				return null; 
			}
		}
		else { 
			return null; 
		}
	}
	

	public int isAdmin(String username) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.ISUSER);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String role = result.getString("role");
					if(role.toLowerCase() == MyConstants.ADMIN) {
						return 1;
					}
					else {
						return 0;
					}
				}
				else {
					return -1;
				}
			} 
			catch (SQLException e) { 
				return -2; 
			}
		}
		else { 
			return -3; 
		}
	}
	
	//To check if the user name is same or not to update account
	public Boolean checkUserUpdateDetailes(User model, String cUser) {
		if(model.getUsername() == cUser ) {
			return true;
		}
		else {
			return false;
		}
	}
	
	
//	Start region Update operation
	public int updateUser(User userModel, String currentUsername, String newUsername) {
		Connection connection = connectDatabase();
		if(connection != null) {
			boolean usernameCheck;
			System.out.println("Current: "+ currentUsername);
			System.out.println("New: "+ newUsername);
			if(currentUsername == newUsername) {
				 usernameCheck = true;
			}
			else {
				 usernameCheck = false;
			}
			System.out.println("UsernameCheck: "+ usernameCheck);
			if((usernameCheck==false && isUserAlreadyRegistered(newUsername))) {
				return 0;
			}
			
			else {
				try {
					PreparedStatement ps = connection.prepareStatement(MyConstants.GETUSERPASSWORD);
					ps.setString(1, currentUsername);
					ResultSet result1 = ps.executeQuery();
					if(result1.next()) {
						String cPassword = result1.getString("password");
						String decryptedPassword = PasswordEncryptionWithAes.decrypt(cPassword, currentUsername);
						System.out.println(decryptedPassword);
						ps = connection.prepareStatement(MyConstants.UPDATEUSERINFO);
						ps.setString(1, newUsername);
						ps.setString(2, userModel.getFirstName());
						ps.setString(3, userModel.getLastName());
						ps.setString(4, PasswordEncryptionWithAes.encrypt(userModel.getUsername(),decryptedPassword));
						ps.setString(5, userModel.getImageUrlFromPart());
						ps.setString(6, currentUsername);
						
						int result = ps.executeUpdate();
						if(result>=0) {
							return 1;
						}
						else {
							return 0;
						}
					}
					else {
						return -1;
					}
				}
				catch(SQLException e) {
					e.printStackTrace();
					return -2;
				}
			}
		}
		else {                                            
			return -3;
		}
	}
		

	//	End region Update operation
	
	//	Start region Delete operation
	public Boolean deleteUser(String query, String username) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation
	
	//	Start region Read operation
	public List<Products> getAllProducts(String query) {
        List<Products> dataList = new ArrayList();
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
	            Statement stmt = dbConnection.createStatement();
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	            	Products data = new Products();
	                dataList.add(data);
	            }
	            rs.close();
	            stmt.close();
	            dbConnection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		}
        return dataList;
	}
	
	//Product Registration Check Method
		public Boolean isProductAlreadyRegistered(String productName, String productBrand) {
			Connection con = connectDatabase();
			if(con != null) {
				try {
					PreparedStatement statement = con.prepareStatement(MyConstants.CHECKPRODUCTINFO);
					statement.setString(1, productName);
					statement.setString(2, productBrand);
					ResultSet result = statement.executeQuery();
					if(result.next()) {
						return true;		
					}
					else {
						return false;
					}
				} 
				catch (SQLException e) { 
					return null; 
				}
			}
			else { 
				return null; 
			}
		}
		
	//Register User Method 
	public int registerProduct(Products productModel) {
		Connection connection = connectDatabase();
		if(connection != null) {
			if(isProductAlreadyRegistered(productModel.getProductName(), productModel.getProductBrand())) {
				return -1;
			}
			else {
				try {
					PreparedStatement ps = connection.prepareStatement(MyConstants.REGISTERPROD);
					ps.setString(1, productModel.getProductName());
					ps.setFloat(2, productModel.getProductPrice());
					ps.setInt(3, productModel.getProductStock());
					ps.setString(4, productModel.getProductBrand());
					ps.setString(5, productModel.getProductCategory());
					ps.setString(6, productModel.getProductDescription());
					ps.setString(7, productModel.getProductImage());
					int result = ps.executeUpdate();
					if(result>=0) {
						return 1;
					}
					else {
						return 0;
					}
				}
				catch(SQLException e) {
					e.printStackTrace();
					return -2;
				}
			}
		}	
		else {
			return -3;
		}
	}
	
	

	//Start region Update operation
	public int updateProduct(Products productModel, int productID) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement ps = dbConnection.prepareStatement(MyConstants.UPDATEPRODUCTINFO);
				ps.setString(1, productModel.getProductName());
				ps.setFloat(2, productModel.getProductPrice());
				ps.setInt(3, productModel.getProductStock());
				ps.setString(4, productModel.getProductBrand());
				ps.setString(5, productModel.getProductCategory());
				ps.setString(6, productModel.getProductDescription());
				ps.setString(7, productModel.getProductImage());
				ps.setInt(8, productID);
				int result = ps.executeUpdate();
				if(result>=0)return 1;
				else return -1;
				} 
			catch (SQLException e) { 
				return -2; 
			}
		}
		else { 
			return -3; 
		}
	}
	//	End region Update operation
	
	//	Start region Delete operation
	public Boolean deleteProduct(String query, int productID) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setInt(1, productID);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} 
			catch (SQLException e) { 
				return null; 
			}
		}
		else { 
			return null; 
		}
	}
	//	End region Delete operation
	
	//Category Registration Check Method
	public Boolean isCategoryAlreadyRegistered(String productCategory) {
		Connection con = connectDatabase();
		if(con != null) {
			try {
				PreparedStatement statement = con.prepareStatement(MyConstants.CHECKCATEGORYINFO);
				statement.setString(1, productCategory);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;		
				}
				else {
					return false;
				}
			} 
			catch (SQLException e) { 
				return null; 
			}
		}
		else { 
			return null; 
		}
	}
	//Register User Method 
	public int registerCategory(Categories categoryModel) {
		Connection connection = connectDatabase();
		if(connection != null) {
			if(isCategoryAlreadyRegistered(categoryModel.getCategory())) {
				return -1;
			}
			else {
				try {
					PreparedStatement ps = connection.prepareStatement(MyConstants.REGISTERCATEGORY);
					ps.setString(1, categoryModel.getCategory());
					int result = ps.executeUpdate();
					if(result>=0) {
						return 1;
					}
					else {
						return 0;
					}
				}
				catch(SQLException e) {
					e.printStackTrace();
					return -2;
				}
			}
		}	
		else {
			return -3;
		}
	}
	
	//	Start region Delete operation
	public Boolean deleteCategory(String query, String productCategory) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productCategory);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} 
			catch (SQLException e) { 
				return null; 
			}
		}
		else { 
			return null; 
		}
	}
	//	End region Delete operation
	
	public List<Cart> getCartProd(ArrayList<Cart> cartList){
		List<Cart> cartItems= new ArrayList<>();
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				if(cartList.size()>0) {
					for(Cart cartProd: cartList) {
						PreparedStatement statement = dbConnection.prepareStatement(MyConstants.GETPRODINFOBYID);
						statement.setInt(1, cartProd.getProductID());
						ResultSet rs = statement.executeQuery();
						while(rs.next()) {
							Cart cart = new Cart();
							cart.setProductID(rs.getInt("productID"));
							cart.setProductName(rs.getString("productName"));
							cart.setProductCategory(rs.getString("productCategory"));
							cart.setProductStock(rs.getInt("productStock"));
							cart.setProductBrand(rs.getString("productBrand"));
							cart.setProductPrice(rs.getFloat("productPrice"));
							cart.setProductImage(rs.getString("productImage"));
							cart.setProductDescription(rs.getString("ProductDescription"));
							cart.setQuantity(cartProd.getQuantity());
							cartItems.add(cart);
						}
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
			return cartItems;
		}
		else {
			return null;
		}

	}

	public ResultSet selectUserByUsername(String username) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.GETUSERBYUSERNAME);
				statement.setString(1,username);
				ResultSet rs = statement.executeQuery();
				return rs;
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else {
			return null;
		}
		return null;
	}	
	
	public Boolean createCart(String username) {
		try {
			Connection con = connectDatabase();
			PreparedStatement statement = con.prepareStatement(MyConstants.CREATECART);
			statement.setString(1, username);
			int result = statement.executeUpdate();
			if(result < 0) {
				return false;
			}
			else {
				return true;
			}
		}
		catch(Exception e) {
			return false;
		}
	}
	
	public Boolean cartCheck(String username) {
		try {
			Connection con = connectDatabase();
			PreparedStatement statement = con.prepareStatement(MyConstants.CARTCHECK);
			statement.setString(1, username);
			Resultset rs = (Resultset) statement.executeQuery();
			int count= 0;
			while(((ResultSet) rs).next()) {
				count = ((ResultSet) rs).getInt(1);
				return false;
			}
			if(count == 0) {
				return true;
			}
			else {
				return false;
			}
		}
		catch(Exception e) { 
			return false;
		}
	}
	
	public int getCartID(String username) throws InstanceNotFoundException{
		try {
			Connection con = connectDatabase();
			PreparedStatement statement = con.prepareStatement(MyConstants.GETCARTBYUSERNAME);
			statement.setString(1, username);
			Resultset rs = (Resultset) statement.executeQuery();
			while(((ResultSet) rs).next()) {
				return ((ResultSet) rs).getInt(1);
			}
			throw new InstanceNotFoundException("Cart Not Found");
		}
		catch(Exception e) {
			throw new InstanceNotFoundException("Cart Not Found");
		}
	}
	
	public boolean AddToCart(String username, int productID) {
		Connection dbConnection = connectDatabase();
		if(dbConnection != null) {
			
			if(!this.cartCheck(username) ) {
				this.createCart(username);
			}
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.ADDTOCART);
				statement.setInt(1, productID);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else {
			return false;
		}
		return false;
	}
	
}

