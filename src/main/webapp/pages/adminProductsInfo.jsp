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
	
	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	
	//Condition to call delete product method
	if (request.getParameter("deleteProd") != null) {
	    String prodID = request.getParameter("deleteProd");
	    dbConn.deleteProduct(MyConstants.DELETEPROD, Integer.parseInt(prodID));
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>View Products | LAVEN.</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminTables.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allProduct" dataSource="${dbConnection}">
		SELECT * FROM products
	</sql:query>
	<div class="container">
		<main class="pgmain">
		<%@ include file="/pages/adminNav.jsp" %>
			<div class="table-heading">
				<h2>View All Products Here<i class="fas fa-arrow-down"></i></h2>
				<a href="${pageContext.request.contextPath}/pages/addProducts.jsp">Add Products</a>
			</div>
			<div class="table">
			    <table>
			    <tr>
					<th>Product ID</th>
				    	<th>Product Name</th>
				       	<th>Price</th>
				       	<th>Brand</th>
				       	<th>Category</th>
				       	<th>Stock</th>
				       	<th>Description</th>
				       	<th>Image</th>
				       	<th>Edit<th>
			    	</tr>
			    	<c:forEach var="product" items="${allProduct.rows}">
			    		<tr>
					      	<td>${product.productID}</td>
					      	<td>${product.productName}</td>
					        <td>${product.productPrice}</td>
					        <td>${product.productBrand}</td>
					        <td>${product.productCategory}</td>
					        <td>${product.productStock}</td>
					        <td>${product.productDescription}</td>
				        	<td><img src="http://localhost:8080/images/products/${product.productImage}"></td>
				        	<td>
				        		<div class="update-delete">
				        			<a href="${pageContext.request.contextPath}/pages/updateProducts.jsp?productID=${product.productID}">Update</a>
				        			<form method="post">
				                        <input type="hidden" name="deleteProd" value="${product.productID}" />
                        				<button type="submit">Delete</button>
				               		</form>
				        		</div>

				        	</td>
			      		</tr>
			     	</c:forEach>
			 	</table>
			</div>
		</main>
	</div>	
</body>
<script>;
</script>
</html>