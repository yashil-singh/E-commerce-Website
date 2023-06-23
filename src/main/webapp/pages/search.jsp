<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8895-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
</head>
<body>
	<div id="myOverlay" class="overlay">
		<span class="closebtn" onclick="closeSearch()" title="Close Overlay">x</span>
	  	<div class="overlay-content">
	    	<form action="">
	      		<input type="text" placeholder="Search.." name="search">
	      		<button type="submit"><i class="fa fa-search"></i></button>
	    	</form>
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