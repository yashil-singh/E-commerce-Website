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
					<form action="${pageContext.request.contextPath}/ProductRegister" method="post" enctype='multipart/form-data' class="add-product-form">
						<div class="Heading">
						<h2>Add Products</h2>
						</div>
						<div class="row-1">
							<label for="productName">Product Name:</label>
							<input type="text" name="productName" required>
						</div>
						<div class="row-2">
							<div class="input-box">
								<label for="productBrand">Brand:</label>
								<input type="text" name="productBrand" required>
							</div>
							<div class="input-box">
								<label for="productCategory">Category:</label>
								<select name="productCategory" required>
								<c:forEach var="category" items="${allCategory.rows }">
								  <option value="${category.productCategory}">${category.productCategory}</option>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row-2">
							<div class="input-box">
								<label for="productPrice">Price: </label>
								<input type="number" name="productPrice" required>
							</div>
							<div class="input-box">
								<label for="productImage">Product Image: </label>
								<input type="file" name="productImage">
							</div>
						</div>
						<div class="row-1">
							<div class="input-box" style="display: flex;">
								<label for="productBrand">Product Quantity:&nbsp;</label>
								<input type="number" min="0" id="number" value="1" name="productStock" required/>
							</div>
						</div>
						<div class="row-1">
							<label for="productBrand">Product Description:</label>
							<textarea name="productDescription" style="padding: 10px;"></textarea>
						</div>
						
						<div class="row-2">
							<div class="input-box">
      							<input type="Submit" value="Add" class="add-button">
    						</div>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</body>
</html>