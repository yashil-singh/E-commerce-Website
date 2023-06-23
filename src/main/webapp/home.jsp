<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<%! SessionManage mySession = new SessionManage(); %>
<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");
	
	// Creating new database model object
	DbConnection dbConn = new DbConnection();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'/>
		<title>Home | LAVEN</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productCard.css"/>
		<script src="https://kit.fontawesome.com/31e4361ee7.js"></script>
	</head>
	<body>
		<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
		
		<!-- Defining sql query to fetch the product info -->
		<sql:query var="sidemenExclusive" dataSource="${dbConnection}">
			SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
			FROM products
			LEFT JOIN ratings ON products.productID = ratings.productID
			WHERE products.productBrand LIKE '%Sidemen%'
			GROUP BY products.productID LIMIT 5
		</sql:query>
		<sql:query var="shoes" dataSource="${dbConnection}">
			SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
			FROM products
			LEFT JOIN ratings ON products.productID = ratings.productID
			WHERE products.productCategory LIKE '%Shoes%' 
			GROUP BY products.productID LIMIT 5
		</sql:query>
		<sql:query var="men" dataSource="${dbConnection}">
			SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
			FROM products
			LEFT JOIN ratings ON products.productID = ratings.productID
			WHERE products.productCategory = 'Men'
			GROUP BY products.productID LIMIT 5
		</sql:query>
		<sql:query var="women" dataSource="${dbConnection}">
			SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
			FROM products
			LEFT JOIN ratings ON products.productID = ratings.productID
			WHERE products.productCategory LIKE '%Women%' 
			GROUP BY products.productID LIMIT 5
		</sql:query>
		
		<%@ include file="/pages/header.jsp" %>	
		<div class="main-container">
	        <div class="main-content">
	            <div class="main-text">
	            	<div class="welcome-message">
		            	<h1>Improve your closet with LAVEN.</h1>
		                <br/>
		                <p>We offer you quality products at affordable prices. You can't go wrong with LAVEN.</p>
	            	</div>
	                <div class="shop-now-button-container">
	                	<div class="shop-now-button">
	                		<a href="${pageContext.request.contextPath}/pages/products.jsp">Shop now</a>
	                	</div>             
	                </div>
	            </div>
	            <div class="main-img">
	            	<img src="${pageContext.request.contextPath}/images/home/homeImage.png" alt="" />
	            </div>
	        </div>
	    </div>
    	<div class="products-container">
    		<h1>Exclusive Products From Sidemen</h1>
    		<div class="border"></div>
    		<div class="products-wrap">
    			<c:forEach var="product" items="${sidemenExclusive.rows}">
		    		<div class="product-card">
		          		<div class="product-tumb">
		            		<img src="http://localhost:8080/images/products/${product.productImage}" alt="">
			          	</div>
			          	<div class="product-details">
			            	<span class="product-catagory">${product.productCategory}</span>
			            	<h4><a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${product.productID}">${product.productName}</a></h4>
			            	<div class="product-bottom-details">
				            	<div class="product-details-row">
				            		<div class="product-price">Rs ${product.productPrice}</div>
				            		<div class="product-stock">In Stock: ${product.productStock}</div>
				            	</div>
				            	<div class="product-details-row">
				            		<div class="product-rating">Ratings: ${product.productAvgRating} ( ${ product.productRantingCount } ) </div>
				              		<div class="product-links">
				                		<form method="post" action="${pageContext.request.contextPath}/AddToCart">
				            		<input type="hidden" name="productID" value="${Integer.parseInt(product.productID)}">
				            		<button type="submit" class="cart-button"><i class="fa fa-shopping-cart"></i></button>
				           		</form>
				              		</div>
				            	</div>
			            	</div>
			          	</div>
			        </div>
				</c:forEach>
    		</div>
    	</div>
    	<div class="products-container">
    	<h1>For Men</h1>
    	<div class="border-men"></div>
    		<div class="products-wrap">
    			<c:forEach var="product" items="${men.rows}">
		    		<div class="product-card">
		          		<div class="product-tumb">
		            		<img src="http://localhost:8080/images/products/${product.productImage}" alt="">
			          	</div>
			          	<div class="product-details">
			            	<span class="product-catagory">${product.productCategory}</span>
			            	<h4><a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${product.productID}">${product.productName}</a></h4>
			            	<div class="product-bottom-details">
				            	<div class="product-details-row">
				            		<div class="product-price">Rs ${product.productPrice}</div>
				            		<div class="product-stock">In Stock: ${product.productStock}</div>
				            	</div>
				            	<div class="product-details-row">
				            		<div class="product-rating">Ratings: ${product.productAvgRating} ( ${ product.productRantingCount } ) </div>
				              		<div class="product-links">
				                		<form method="post" action="${pageContext.request.contextPath}/AddToCart">
				            		<input type="hidden" name="productID" value="${Integer.parseInt(product.productID)}">
				            		<button type="submit" class="cart-button"><i class="fa fa-shopping-cart"></i></button>
				           		</form>
				              		</div>
				            	</div>
			            	</div>
			          	</div>
			        </div>
				</c:forEach>
    	</div>
    </div>
    <div class="looks-container">
    	<h1>Latest Looks For Men</h1>
    	<div class="border-men"></div>
    	<div class="looks-wrap">
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/look1.jpeg">
    		</div>
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/look2.jpeg">
    		</div>
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/look3.jpeg">
    		</div>
    	</div>
    </div>
    <div class="banner-container">
    	<div class="banner-image">
    		<img src="${pageContext.request.contextPath}/images/banners/banner8.jpg">
    	</div>
    </div>
    <div class="products-container">
    	<h1>For Women</h1>
    	<div class="border-women"></div>
    	<div class="products-wrap">
    		<c:forEach var="product" items="${women.rows}">
		    		<div class="product-card">
		          		<div class="product-tumb">
		            		<img src="http://localhost:8080/images/products/${product.productImage}" alt="">
			          	</div>
			          	<div class="product-details">
			            	<span class="product-catagory">${product.productCategory}</span>
			            	<h4><a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${product.productID}">${product.productName}</a></h4>
			            	<div class="product-bottom-details">
				            	<div class="product-details-row">
				            		<div class="product-price">Rs ${product.productPrice}</div>
				            		<div class="product-stock">In Stock: ${product.productStock}</div>
				            	</div>
				            	<div class="product-details-row">
				            		<div class="product-rating">Ratings: ${product.productAvgRating} ( ${ product.productRantingCount } ) </div>
				              		<div class="product-links">
				                		<form method="post" action="${pageContext.request.contextPath}/AddToCart">
				            				<input type="hidden" name="productID" value="${Integer.parseInt(product.productID)}">
				            				<button type="submit" class="cart-button"><i class="fa fa-shopping-cart"></i></button>
				           				</form>
				              		</div>
				            	</div>
			            	</div>
			          	</div>
			        </div>
				</c:forEach>
    	</div>
    </div>
    <div class="looks-container">
    	<h1>Latest Looks For Women</h1>
    	<div class="border-women"></div>
    	<div class="looks-wrap">
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/WLook1.png">
    		</div>
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/WLook2.png">
    		</div>
    		<div class="looks-image">
    			<img src="${pageContext.request.contextPath}/images/looks/WLook3.png">
    		</div>
    	</div>
    </div>
    <div class="banner-container">
    	<div class="banner-image">
    		<img src="${pageContext.request.contextPath}/images/banners/banner11.png">
    	</div>
    </div>
    <div class="products-container">
    	<h1>Level Up Your Game</h1>
    	<div class="border-orange"></div>
    	<div class="products-wrap">
	    	<c:forEach var="product" items="${shoes.rows}">
				<div class="product-card">
					<div class="product-tumb">
			    		<img src="http://localhost:8080/images/products/${product.productImage}" alt="">
				 	</div>
				 <div class="product-details">
				 	<span class="product-catagory">${product.productCategory}</span>
				   	<h4><a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${product.productID}">${product.productName}</a></h4>
				    <div class="product-bottom-details">
						<div class="product-details-row">
					    	<div class="product-price">Rs ${product.productPrice}</div>
					    	<div class="product-stock">In Stock: ${product.productStock}</div>
						</div>
						<div class="product-details-row">
					    	<div class="product-rating">Ratings: ${product.productAvgRating} ( ${ product.productRantingCount } ) </div>
					        	<div class="product-links">
					            	<form method="post" action="${pageContext.request.contextPath}/AddToCart">
				            		<input type="hidden" name="productID" value="${Integer.parseInt(product.productID)}">
				            		<button type="submit" class="cart-button"><i class="fa fa-shopping-cart"></i></button>
				           		</form>
					           	</div>
					       	</div>
				       	</div>
				   	</div>
				</div>
			</c:forEach>
	   	</div>
    </div>
	<%@ include file="/pages/footer.jsp" %>
</body>
</html>

