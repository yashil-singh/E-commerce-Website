<%@page import="resources.MyConstants"%>
<%@page import="model.Cart"%>
<%@page import="model.Products"%>
<%@page import="java.util.List"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>

<% 
	int totalProducts = 0;
	ArrayList<Cart> cartItems =(ArrayList<Cart>) session.getAttribute("cartItems");
	List<Cart> cartProduct = null;
	DbConnection dbConn = new DbConnection();
	if(cartItems != null) {
		 cartProduct = dbConn.getCartProd(cartItems);
		 request.setAttribute("cartItems", cartItems);
	}
%>
<% String sucessMessage = (String) request.getAttribute("sucessMessage"); %>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>My Cart | LAVEN.</title>
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/cart.css" rel="stylesheet">
</head>
<body>

	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	<c:set var="username" value="${cookie.user.value}"/>
	<sql:query dataSource="${dbConnection }" var="cartProducts">
		SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
		FROM products
		LEFT JOIN ratings ON products.productID = ratings.productID
		GROUP BY products.productID
	</sql:query>
	
	
	<%@ include file="/pages/header.jsp" %>
	
		<div class="cart-wrapper">
			<h1>Shopping Cart</h1>
			<div class="status-message">
				<% if(sucessMessage != null) { %>
					<div class="sucess-message"><img src="${pageContext.request.contextPath}/images/status/sucess.png" style="width: 25px;"><%= sucessMessage %></div>
				<% } %>
				<% if(errorMessage != null) { %>
				    <div class="error-message"><img src="${pageContext.request.contextPath}/images/status/error.png" style="width: 25px;"><%= errorMessage %></div>
				<% } %>
			</div>
			
			<% if(cartItems == null) {%>
					<h2>There are currently no items in your cart.</h2>
				<% }
				else {
					for(Cart cart: cartProduct) { %>
					<div class="cart-project">
						<div class="cart-shop">
							<div class="cart-box">
								<img src="http://localhost:8080/images/products/<%=cart.getProductImage()%>">
								<div class="cart-content">
									<h3><%= cart.getProductName() %></h3>
									<h4>Price: Rs<%= cart.getProductPrice() %></h4>
									<p class="unit">Quantity: <input type="number" min="0" name="quantity" value="1"></p>
								</div>
							</div>
						</div>
					</div>	
					<% } 
					}%>
					<div class="total-details">
						<a href="#"><i class="fa fa-shopping-cart"></i>Checkout</a>
					</div>
				
			</div>
			
	<%@ include file="/pages/footer.jsp" %>
</body>
</html>