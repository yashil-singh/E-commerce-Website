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
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Users</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminTables.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allUser" dataSource="${dbConnection}">
		SELECT firstname, lastname, username, image  FROM register_user WHERE role="user"
	</sql:query>
	<div class="container">		
		<main class="pgmain">
			<%@ include file="/pages/adminNav.jsp" %>
			<div class="table-heading">
				<h2>View All Users Here<i class="fas fa-arrow-down"></i></h2>
			</div>
			<div class="table">
		    	<table cellpadding="0" cellspacing="0" >
		    	<tr class="table-header">
		    		<th>Username</th>
			    	<th>First Name</th>
			        <th>Last Name</th>
			        <th>Image</th>
		      	</tr>
		    	<c:forEach var="user" items="${allUser.rows}">
		      		<tr>
		      			<td>${user.username}</td>
				      	<td>${user.firstname}</td>
				      	<td>${user.lastname}</td>
				        <td><img src="http://localhost:8080/images/users/${user.image}"></td>
			      	</tr>
			     </c:forEach>
			    </table>
			  </div>
		</main>
	</div>
</body>
</html>