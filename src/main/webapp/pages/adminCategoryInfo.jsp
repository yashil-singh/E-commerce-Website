<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="model.Products"%>
<%@page import="java.util.List"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<% 
	SessionManage mySession = new SessionManage(); 

	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();
	
	if (request.getParameter("deleteCategory") != null) {
	    String deleteCategory = request.getParameter("deleteCategory");
	    dbConn.deleteCategory(MyConstants.DELETECATEGORY, deleteCategory);
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>View Categories | LAVEN</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminTables.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allCategory" dataSource="${dbConnection}">
		SELECT productCategory  FROM categories 
	</sql:query>
	
	<div class="container">
		<main class="pgmain">
		<%@ include file="/pages/adminNav.jsp" %>
			<div class="table-heading">
				<h2>View All Categories Here<i class="fas fa-arrow-down"></i></h2>
				<a href="${pageContext.request.contextPath}/pages/addCategories.jsp">Add Categories</a>
			</div>
			<div class="table">
			    <table>
			    	<tr>
						<th>Category Name</th>
						<th>Edit</th>
			    	</tr>
			    	<c:forEach var="product" items="${allCategory.rows}">
			    		<tr>
					      	<td>${product.productCategory}</td>
				        	<td>
				        		<div class="update-delete">
				        			<form method="post">
				                        <input type="hidden" name="deleteCategory" value="${product.productCategory}" />
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
</html>