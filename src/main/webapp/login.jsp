<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Login | LAVEN</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css"/>
</head>
<body>
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <div class="main">
    <h1 class="heading"><a href="${pageContext.request.contextPath}/home.jsp">LAVEN.</a></h1>
        <div class="form-container">
            <div class="form-wrapper">
                <h2 class="form-title">Login</h2>
                <% if(errorMessage != null) { %>
        			<div class="status-message"><%= errorMessage %></div>
        		<% } %>
                <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="register-form">
                    <div class="input-box">
		        		<input type="text" name="username" placeholder="Username" required>
				    </div>
				    <div class="input-box">
				        <input type="password" name="password" placeholder="Password" required>
				    </div>				    
				    <div class="input-box button">
				        <input type="Submit" value="Login">
				    </div>
				    <div class="text">
				        <h3>Don't have an account? <a href="${pageContext.request.contextPath}/pages/register.jsp">Register now</a></h3>
				    </div>		
                </form>
            </div>
        </div>
    </div>
</body>
</html>