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

	// Creating new database model object
	DbConnection dbConn = new DbConnection();
	
	// Deleting user on database when delete button is clicked.
		if (request.getParameter("deleteId") != null) {
		    String id = request.getParameter("deleteId");
		    dbConn.deleteUser(MyConstants.DELETEUSER, id);
		}
	
		String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Account | LAVEN</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/account.css">
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/laven" user="root" password=""/>
	
	<sql:query var="userData" dataSource="${dbConnection}">
		SELECT * FROM register_user WHERE username= ?
		<sql:param value="<%= user %>"/>
	</sql:query>
	
	<%@ include file="/pages/header.jsp" %>
	<div class="main-container">
	<c:forEach var="user" items="${userData.rows}">
		<h2>Hello, ${user.firstname} ${user.lastname}</h2>
		<div class="user-card">
			<div class="user-image">
				<img src="http://localhost:8080/images/users/${user.image}">
			</div>
			
		  	<div class="user-info">
		    	<h3><b></b></h3>
		    	<h4 style="font-weight: 300;">${user.username}</h4> 
		  	</div>
		  	<div class="user-buttons">
		  		<div>
			  		<form action="${pageContext.request.contextPath}/pages/updateUserAccount.jsp" method="post">
						<input type="submit" class="update-button" value="Update">	   
					</form>
				</div>
				<div>
					<form action="<%out.print(mainPath);%>/LogoutServlet" method="post">
						<input type="submit" class="logout-button" value="Logout">	   
					</form>
				</div>
				<div>
				</div>
		  	</div>
		  	
		  	
		</div>
		</c:forEach>
	</div>
	
	<%@ include file="/pages/footer.jsp" %>
</body>
</html>