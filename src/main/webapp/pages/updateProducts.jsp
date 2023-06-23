<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="model.Products"%>
<%@page import="java.util.List"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/status-messages.css">
	<title>Add Products | LAVEN</title>
	
</head>
<body>
	<% String registerMessage = (String) request.getAttribute("registerMessage"); %>
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allCategory" dataSource="${dbConnection}">
		SELECT productCategory  FROM categories 
	</sql:query>
	
	<!-- Setting the value of parameter to a variable -->
	<c:set var="productId" value="${param.productID}" />
	
	<sql:query var="productInfo" dataSource="${dbConnection}">
		SELECT * FROM products
		WHERE products.productID = ?
		<sql:param value="${productId}"/>
	</sql:query>
	
	<div class="container">
		<main class="pgmain">
			<%@ include file="/pages/adminNav.jsp" %>
			<div class="form-container">
				<div class="form-wrapper">
					<div class="status-message">
						<% if(registerMessage != null) { %>
				           	<div class="sucess-message"><img src="${pageContext.request.contextPath}/images/status/sucess.png" style="width: 25px;"><%= registerMessage %></div>
				      	<% } %>
				      	<% if(errorMessage != null) { %>
				          	<div class="error-message"><img src="${pageContext.request.contextPath}/images/status/error.png" style="width: 25px;"><%= errorMessage %></div>
				      	<% } %>
					</div>
					<form action="${pageContext.request.contextPath}/UpdateProduct" method="post" enctype='multipart/form-data' class="add-product-form">
						<div class="Heading">
						<h2>Update Product</h2>
						</div>
						<div class="row-1">
							<label for="productName">Product Name:</label>
							<c:forEach var="product" items="${productInfo.rows}">
								<input type="text" name="productName" value="${product.productName}" required>
							</c:forEach>
						</div>
						<div class="row-2">
							<div class="input-box">
								<label for="productBrand">Brand:</label>
								<c:forEach var="product" items="${productInfo.rows}">
									<input type="text" name="productBrand" value="${product.productBrand}" required>
								</c:forEach>
							</div>
							<div class="input-box">
								<label for="productCategory">Category:</label>
								<select name="productCategory" value="${category.productCategory}" required>
								<c:forEach var="category" items="${allCategory.rows}">
								  <option value="${category.productCategory}">${category.productCategory}</option>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row-2">
							<div class="input-box">
								<label for="productPrice">Price: </label>
								<c:forEach var="product" items="${productInfo.rows}">
									<input type="number" name="productPrice" value="${product.productPrice}" required>
								</c:forEach>
							</div>
							<div class="input-box">
								<label for="productImage">Product Image: </label>
								<c:forEach var="product" items="${productInfo.rows}">
									<input type="file" name="productImage" value="${product.productImage}">
								</c:forEach>
							</div>
						</div>
						<div class="row-1">
							<div class="input-box" style="display: flex;">
								<label for="productBrand">Product Quantity:&nbsp;</label>
								<c:forEach var="product" items="${productInfo.rows}">
									<input type="number" name="productStock" value="${product.productStock}" required>
								</c:forEach>
							</div>
						</div>
						<div class="row-1">
							<label for="productBrand">Product Description:</label>
							<c:forEach var="product" items="${productInfo.rows}">
								<textarea name="productDescription" >${product.productDescription}</textarea>
							</c:forEach>
						</div>
						<div class="row-2">
							<div class="input-box">
								<c:forEach var="product" items="${productInfo.rows}">
									<input type="hidden" name="productID" value="${product.productID}" required>
								</c:forEach>
       							<input type="Submit" value="Update" class="add-button">
    						</div>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</body>
</html>