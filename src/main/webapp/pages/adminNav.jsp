<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.databaseConnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%
	String mainpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
	<section class="top-nav">
	    <div>
			<h1>LAVEN.</h1>
	    </div>
	    <input id="menu-toggle" type="checkbox" />
	    <label class='menu-button-container' for="menu-toggle">
	    <div class='menu-button'></div>
	  	</label>
	    <ul class="menu">	
	      <li><a href="${pageContext.request.contextPath}/pages/admin.jsp">Dashboard</a></li>
	      <li><a href="${pageContext.request.contextPath}/pages/adminProductsInfo.jsp">Products</a></li>
	      <li><a href="${pageContext.request.contextPath}/pages/adminUserInfo.jsp">Users</a></li>
	      <li><a href="${pageContext.request.contextPath}/pages/adminCategoryInfo.jsp">Categories</a></li>
	      <li><a href="${pageContext.request.contextPath}/pages/orderInfo.jsp">Pending Orders</a></li>
	      <li>
	      	<form action="<% out.print(mainpath); %>/LogoutServlet" method="post">
				<input type="submit" value="Logout">	   
			</form>
	      </li>
	    </ul>
  </section>
</body>
</html>