<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="model.Products"%>
<%@page import="resources.MyConstants"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="java.util.List"%>

<% 
	DbConnection con = new DbConnection();
	List<Products> products = con.getAllProducts(MyConstants.GETALLPRODINFO); 
	Products prod = new Products();
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Products | LAVEN.</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productCard.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/products.css"/>
	<script src="https://kit.fontawesome.com/31e4361ee7.js"></script>
</head>
<body>
	<!-- Defining sql query to fetch the product info -->
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<sql:query dataSource="${dbConnection}" var="products">
    SELECT * FROM products p
    <c:if test="${not empty param.category}">
        WHERE p.productCategory= '${param.category}'
        <c:if test="${not empty param.price}">AND</c:if>
		</c:if>
		<c:if test="${empty param.category and not empty param.price}">
        WHERE
    </c:if>
		<c:if test="${not empty param.price}">
        p.productPrice >= ${Integer.parseInt(param.price)}
    </c:if>
		<c:if test="${not empty param.brand}">
			<c:choose>
				<c:when test="${empty param.category and empty param.price}">WHERE</c:when>
				<c:otherwise>AND</c:otherwise>
			</c:choose>
        p.productBrand LIKE '%${param.brand}%'
    </c:if>
	</sql:query>
	
	<!-- Defining sql query to fetch the product info -->
	<sql:query var="allProducts" dataSource="${dbConnection}">
		SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
		FROM products
		LEFT JOIN ratings ON products.productID = ratings.productID
		GROUP BY products.productID
	</sql:query>
	<sql:query var="withName" dataSource="${dbConnection}">
		SELECT products.*, AVG(ratings.productStars) AS productAvgRating, COUNT(ratings.productStars) AS productRantingCount
		FROM products
		LEFT JOIN ratings ON products.productID = ratings.productID
		WHERE products.productName LIKE ?
		GROUP BY products.productID
	<sql:param value="${prodName}"/>
	</sql:query>
	<sql:query var="allCategory" dataSource="${dbConnection}">
		SELECT productCategory FROM categories 
	</sql:query>
	
	<sql:query var="allBrand" dataSource="${dbConnection}">
		SELECT DISTINCT productBrand FROM products
	</sql:query>
	
	<%@ include file="/pages/header.jsp" %>
	
	<div class="big-search">
		<div class="big-search-wrap">
			<form action="products.jsp?productName=prodName">
				<span>
					<form method="get" action="products.jsp?prodName=prodName">
					<input type="text" placeholder="Search.." name="prodName">
					<button type="submit"><i class="fa fa-search"></i></button>
					</form>
				</span>
			</form>
		</div>
	</div>
	
	<div class="filters-container">
        <form method="get" action="products.jsp?category=category&price=price&rating=rating">
          	<label for="category">Category:</label>
          	<select id="category" name="category">
          		<option value="">All Categories</option>
          		<c:forEach var="category" items="${allCategory.rows}">
          			<option value="${category.productCategory}">${category.productCategory}</option>
          		</c:forEach>
          	</select>
      
          	<label for="brand">Brand:</label>
          	<select id="Brand" name="brand">
          		<option value="">All Brands</option>
          		<c:forEach var="brands" items="${allBrand.rows}">
          			<option value="${brands.productBrand}">${brands.productBrand}</option>
          		</c:forEach>
          	</select>
          	
          	<label for="price">Price:</label>
          	<select id="price" name="price">
            	<option value="">All Prices</option>
            	<option value="30000"> >=30,000  </option>
            	<option value="25000"> >=25,000 </option>
            	<option value="20000"> >=20,000</option>
            	<option value="15000"> >=15,000</option>
            	<option value="10000"> >=10,000</option>
            	<option value="5000"> >=5,000</option>
            	<option value="1000"> >=1,000</option>
            	<option value="500"> >=500</option>
            	<option value="0"> >=0</option>
          	</select>
          	<button type="submit">Filter</button>
    	</form>
    </div>
      
    <div class="products-wrap">
    <c:forEach var="product" items="${products.rows}">
		<div class="product-card">
			<a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${Integer.parseInt(product.productID)}">
				<div class="product-tumb">
		    		<img src="http://localhost:8080/images/products/${product.productImage}" alt="">
			 	</div>
			</a>
			<div class="product-details">
			 	<span class="product-catagory">${product.productCategory}</span>
			   	<h4><a href="${pageContext.request.contextPath}/pages/productDescription.jsp?productID=${Integer.parseInt(product.productID)}">${product.productName}</a></h4>
			    <div class="product-bottom-details">
					<div class="product-details-row">
				    	<div class="product-price">Rs ${product.productPrice}</div>
				    	<div class="product-stock">In Stock: ${product.productStock}</div>  
					</div>
					<div class="product-details-row">
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
	
	<%@ include file="/pages/footer.jsp" %>
</body>
</html>
