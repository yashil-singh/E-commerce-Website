<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="model.Products"%>
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
	String product = (String) session.getAttribute("product");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();
	
%>

<!DOCTYPE html>
<html>
  <head>
  	<meta charset="utf-8">
    <title>Admin Panel | LAVEN</title>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminTables.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
  </head>
  <body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<sql:query var="topProduct" dataSource="${dbConnection}">
		SELECT productID, productName, productPrice, productBrand, productCategory FROM products ORDER BY productPrice DESC LIMIT 3
	</sql:query>
	<sql:query var="totalUsers" dataSource="${dbConnection}">
		SELECT COUNT(username) as userNo FROM register_user
	</sql:query>
	<sql:query var="totalProducts" dataSource="${dbConnection}">
		SELECT COUNT(productID) as productNo FROM products
	</sql:query>
	<sql:query var="totalCategories" dataSource="${dbConnection}">
		SELECT COUNT(productCategory) categoryNO FROM categories
	</sql:query>
	<div class="container">
		<main class="pgmain">
			<%@ include file="/pages/adminNav.jsp" %>
	  		<div class="table-heading">
	    		<h1>Dashboard</h1>
	    		<a href="${pageContext.request.contextPath}/home.jsp">Go To Website</a>
	  		</div>
	  		<div class="cards-container">
		  		<div class="row-3">
		  			<div class="col">
		  				<div class="card">
		  					<div class="card-body">
		  						<div class="card-image">
		  							<img src="${pageContext.request.contextPath}/images/icons/profile.png">
		  						</div>
		  						<h1>Users</h1>
		  						<c:forEach var="userNo" items="${totalUsers.rows}">
 		  							<h3>No. of Users: ${userNo.userNo}</h3>
 		  						</c:forEach>
		  						<a href="${pageContext.request.contextPath}/pages/adminUserInfo.jsp">Click here to view users.</a>
		  					</div>
		  				</div>
		  			</div>
		  		</div>
		  		<div class="row-3">
		  			<div class="col">
		  				<div class="card">
		  					<div class="card-body">
		  						<div class="card-image">
		  							<img src="${pageContext.request.contextPath}/images/icons/delivery-box.png">
		  						</div>
		  						<h1>Products</h1>
		  						<c:forEach var="productNo" items="${totalProducts.rows}">
 		  							<h3>No. of Products: ${productNo.productNo}</h3>
 		  						</c:forEach>
		  						<a href="${pageContext.request.contextPath}/pages/adminProductsInfo.jsp">Click here to view products.</a>
		  					</div>
		  				</div>
		  			</div>
		  		</div>
		  		<div class="row-3">
		  			<div class="col">
		  				<div class="card">
		  					<div class="card-body">
		  						<div class="card-image">
		  							<img src="${pageContext.request.contextPath}/images/icons/options.png">
		  						</div>
		  						<h1>Categories</h1>
		  						<c:forEach var="categoryNo" items="${totalCategories.rows}">
 		  							<h3>No. of Products: ${categoryNo.categoryNo}</h3>
 		  						</c:forEach>
		  						<a href="${pageContext.request.contextPath}/pages/adminCategoryInfo.jsp">Click here to view categories.</a>
		  					</div>
		  				</div>
		  			</div>
		  		</div>
		  	</div>
		  	<div class="cards-container">
		  		<div class="row-2">
		  			<div class="col">
		  				<div class="card">
		  					<div class="card-body">
		  						<div class="card-image">
		  							<img src="${pageContext.request.contextPath}/images/icons/plus.png">
		  						</div>
		  						<h1>Add Products</h1>
		  						<a href="${pageContext.request.contextPath}/pages/addProducts.jsp">Click here to add products.</a>
		  					</div>
		  				</div>
		  			</div>
		  		</div>
		  		<div class="row-2">
		  			<div class="col">
		  				<div class="card">
		  					<div class="card-body">
		  						<div class="card-image">
		  							<img src="${pageContext.request.contextPath}/images/icons/plus.png">
		  						</div>
		  						<h1>Add Categories</h1>
		  						<a href="${pageContext.request.contextPath}/pages/addCategories.jsp">Click here to add categories.</a>
		  					</div>
		  				</div>
		  			</div>
		  		</div>
		  	</div>
		  	
	  		<div class="table-container">
	  			<div class="table-heading">
			  		<h2>Top 3 Most Expensive Products<i class="fas fa-arrow-down"></i></h2>
			  	</div>
			  	<div class="table">
			    	<table>
				    	<tr class="negrita">
					    	<th>Product ID</th>
					        <th>Product Name</th>
					        <th>Price</th>
					        <th>Brand</th>
					        <th>Category</th>
				      	</tr>
				    	<c:forEach var="product" items="${topProduct.rows}">
				      		<tr>
						      	<td>${product.productID}</td>
						      	<td>${product.productName}</td>
						        <td>${product.productPrice}</td>
						        <td>${product.productBrand}</td>
						        <td>${product.productCategory}</td>
				      		</tr>
				    	</c:forEach>
				    </table>
				</div>
	  		</div>
	  		
		</main>
	</div>
  </body>
</html>