<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title> Product Description | LAVEN. </title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/productDescription.css">
</head>
<body>
	<!-- Defining the data source -->
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<!-- Setting the value of parameter to variable -->
	<c:set var="productId" value="${param.productID}" />
	
	<sql:query var="productInfo" dataSource="${dbConnection}">
		SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
		FROM products
		LEFT JOIN ratings ON products.productID = ratings.productID
		WHERE products.productID = ?
		GROUP BY products.productID
		<sql:param value="${productId}"/>
	</sql:query>
	
	<%@ include file="/pages/header.jsp" %>		
	<main class="container">
 		<c:forEach var="info" items="${productInfo.rows}">
	        <!-- Left Column / Headphones Image -->
	        <div class="left-column">
	          <img src="http://localhost:8080/images/products/${info.productImage}" alt="">
	        </div>
        	<!-- Right Column -->
        	<div class="right-column">
        		<!-- Product Description -->
	      		<div class="product-description">
	        		<span>${info.productCategory}</span>
	            	<h1>${info.productName}</h1>
	            	<p>${info.productDescription}</p>
	       		</div>
	          	<!-- Product Configuration -->
	          	<div class="product-configuration">
	       
	            	<!-- Cable Configuration -->
	            	<div class="cable-config">
	              		<span>Choose Your Size</span>
	       
	              		<div class="cable-choose">
	                		<button>S</button>
	                		<button>M</button>
	                		<button>L</button>
	                		<button>XL</button>
	              		</div>
	            	</div>
	          	</div>
	       
	          	<!-- Product Pricing -->
	          	<div class="product-price">
	            	<span>Rs${info.productPrice}</span>
	            	<a href="#" class="cart-btn">Add to cart</a>
	        	</div>
        	</div>
        	<div class="ratings-container">
        		
        	</div>
        </c:forEach>
      </main>
	
	<%@ include file="/pages/footer.jsp" %>	
</body>
</html>