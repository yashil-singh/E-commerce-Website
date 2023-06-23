<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Account | Closet Collection</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/messages.css"/>
</head>
<body>
	
	<% String registerMessage = (String) request.getAttribute("registerMessage"); %>
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<%@ include file="/pages/header.jsp" %>
	<div class="form-container">
		<div class="form-wrapper">
		    <h2>Update Profile</h2>
		    <div class="status-message">
				<% if(registerMessage != null) { %>
					<div class="sucess-message"><img src="${pageContext.request.contextPath}/images/status/sucess.png" style="width: 25px;"><%= registerMessage %></div>
				<% } %>
				<% if(errorMessage != null) { %>
					<div class="error-message"><img src="${pageContext.request.contextPath}/images/status/error.png" style="width: 25px;"><%= errorMessage %></div>
				<% } %>
			</div>
            <form action="${pageContext.request.contextPath}/UpdateUser" method="post" enctype='multipart/form-data' class="register-form">
            	<div class="input-box">
		        	<input type="text" name="firstname" placeholder="First Name" required>
		      	</div>
		      	<div class="input-box">
		        	<input type="text" name="lastname" placeholder="Last Name" required>
		      	</div>
		      	<div class="input-box">
		        	<input type="text" name="username" placeholder="Username" required>
				</div>
				<div class="input-box">
		        	<input type="password" name="password" placeholder="Password" required>
				</div>
				<div class="upload-box">
					<label class="custom-file-upload">
	    				<input name="image" type="file"/>Upload Profile Picture
	    			</label>
				</div>
				<div class="input-box button">
					<input type="Submit" value="Update">
				</div>	
             </form>
      	</div>
	</div>
	<%@ include file="/pages/footer.jsp" %>
</body>
</html>