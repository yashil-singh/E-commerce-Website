<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminNav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/status-messages.css">
	<title>Add Categories | LAVEN</title>
</head>
<body>
	<% String registerMessage = (String) request.getAttribute("registerMessage"); %>
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
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
					<form action="${pageContext.request.contextPath}/CategoryRegister" method="post" class="add-product-form">
						<div class="Heading">
						<h2>Add Categories</h2>
						</div>
						<div class="row-1">
							<label for="productName">Category Name:</label>
							<input type="text" name="productCategory" required>
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