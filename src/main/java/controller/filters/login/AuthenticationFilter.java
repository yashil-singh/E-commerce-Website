package controller.filters.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.databaseConnection.DbConnection;
import resources.MyConstants;

@WebFilter("/authenticationfilter")
public class AuthenticationFilter implements Filter {
private ServletContext context;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.context = filterConfig.getServletContext();
		this.context.log("AuthenticationFilter initialized");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		DbConnection conn = new DbConnection();
	
        // Check if the request is a login or logout request
        String uri = req.getRequestURI();
        boolean isHomeJsp;
        boolean isRegisterJsp = uri.endsWith("register.jsp");
        boolean isRegisterServlet = uri.endsWith("RegisterServlet");
        boolean isLoginJsp = uri.endsWith("login.jsp");
        boolean isLoginServlet = uri.endsWith("LoginServlet");
		boolean isLogoutServlet = uri.endsWith("LogoutServlet");
		boolean AddToCartServlet = uri.endsWith("AddToCart");
		boolean CategoryRegisterServlet = uri.endsWith("CategoryRegister");
		boolean ProductRegisterServlet = uri.endsWith("ProductRegister");
		boolean UpdateProductServlet = uri.endsWith("UpdateProduct");
		boolean isAccountJsp;
		if (uri.toLowerCase().endsWith("account.jsp") || uri.toLowerCase().endsWith("updateUserAccount.jsp") 
			|| uri.toLowerCase().endsWith("cart.jsp") || AddToCartServlet) {
			isAccountJsp = true;
		}
		else {
			isAccountJsp = false;
		}
		boolean isAdminJsp;
		if (uri.endsWith("addCategories.jsp") || uri.endsWith("admin.jsp")
			|| uri.endsWith("adminCategoryInfo.jsp") || uri.endsWith("addProducts.jsp") 
			|| uri.endsWith("adminProductsInfo.jsp") || uri.endsWith("adminUserInfo.jsp")
			|| uri.endsWith("updateProducts.jsp") || uri.endsWith("CategoryRegister")
			|| uri.endsWith("ProductRegister") || uri.endsWith("UpdateProduct")
			|| CategoryRegisterServlet || ProductRegisterServlet || UpdateProductServlet ) {
			isAdminJsp = true;
		}
		else {
			isAdminJsp = false;
		}
		boolean isProductJsp;
		if (uri.endsWith("products.jsp") || uri.endsWith("productDescription.jsp")) {
			isProductJsp = true;
		}
		else {
			isProductJsp = false;
		}
		if (uri.endsWith("home.jsp") || isAccountJsp || isProductJsp ) {
			isHomeJsp = true;
		}
		else {
			isHomeJsp = false;
		}
		HttpSession session = req.getSession();
		String currentUser = (String) session.getAttribute("user");
		boolean loggedIn;
		if (session != null && currentUser != null) {
			loggedIn = true;
		}
		else {
			loggedIn = false;
		}
		int adminCheck;
		boolean isAdmin;
		if (loggedIn && currentUser.equals(MyConstants.ADMIN)) {
			adminCheck = 1;
		}
		else {
			adminCheck = 0;
		}
		if(adminCheck == 1) {
			isAdmin = true;
		}
		else {
			isAdmin = false;
		}
	        if(!loggedIn && (isAdminJsp || isAccountJsp || isLogoutServlet) && !uri.contains("css") && !uri.toLowerCase().contains("image") && !uri.toLowerCase().contains("error")){
	            res.sendRedirect(req.getContextPath()+"/login.jsp");
	        }
	        else if(loggedIn && !isAdmin && isAdminJsp) {
	        	res.sendRedirect(req.getContextPath()+"/home.jsp");
	        }
	        else if(loggedIn && (isLoginJsp || isLoginServlet || isRegisterJsp || isRegisterServlet)) {
	        	res.sendRedirect(req.getContextPath()+"/home.jsp");
	        }
	        else if(loggedIn && isAdmin && (isHomeJsp || isProductJsp || isAccountJsp)) {
	        	res.sendRedirect(req.getContextPath()+"/pages/admin.jsp");
	        }
	        else{
				chain.doFilter(request, response);
			}	
	        
		}		


	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

}
