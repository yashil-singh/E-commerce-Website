<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<div class="header-container">
		<div id="myOverlay" class="overlay">
			<span class="closebtn" onclick="closeSearch()" title="Close Overlay">x</span>
	  		<div class="overlay-content">
	    		<form action="">
	      			<input type="text" placeholder="Search.." name="search">
	      			<button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
	    		</form>
	 		</div>
		</div>
		<div class="logo">
			<h1>LAVEN.</h1>
		</div>
		<div class="header-menu">
			<div class="header-menu-item">
				<a href="${pageContext.request.contextPath}/home.jsp">Home</a>
			</div>
			<div class="header-menu-item">
				<a href="${pageContext.request.contextPath}/pages/products.jsp">Products</a>
			</div>
			<div class="header-menu-item">
				<a href="${pageContext.request.contextPath}/pages/account.jsp">Account</a>
			</div>
		</div>
		<div class="right-container">
			<div class="textbox">
				<i onclick="openSearch()" class="fa fa-search" aria-hidden="true" style="font-size:24px; cursor: pointer"></i>
			</div>
			<div class="cart">
				<a href="${pageContext.request.contextPath}/pages/cart.jsp"><img src="${pageContext.request.contextPath}/images/icons/cart.png"></a>
			</div>
		</div>
	</div>
</body>
<script>
	//Open the full screen search box
	function openSearch() {
	  document.getElementById("myOverlay").style.display = "block";
	}
	
	// Close the full screen search box
	function closeSearch() {
	  document.getElementById("myOverlay").style.display = "none";
	}
</script>
</html>

