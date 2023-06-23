<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>
	<div class="footer">
		<div class="footer-container">
			<div class="footer-title">
				<h1>LAVEN.</h1>
      			<p>The one stop shop.</p>
			</div>
			<div class="footer-items">
				<h3>Quick Links</h3>
      			<div class="border1"></div> <!--for the underline -->
        		<ul>
          			<li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
          			<li><a href="${pageContext.request.contextPath}/pages/products.jsp">Products</a></li>
          			<li><a href="${pageContext.request.contextPath}/pages/account.jsp">Account</a></li>
        		</ul>
			</div>
			<div class="footer-items">
				<h3>Contact Us</h3>
				<div class="border1"></div>
				<ul>
					<li><img src="${pageContext.request.contextPath}/images/address.png">&#160; Kamal Pokhari, Kathmandu</li>
					<li><img src="${pageContext.request.contextPath}/images/phone.png">&#160; 9836471635</li>
					<li><img src="${pageContext.request.contextPath}/images/email.png">&#160; closetcollection@gmail.com</li>
				</ul>
				<div class="social-media">
				<ul>
					<img src="${pageContext.request.contextPath}/images/instagram.png" alt="instagram">
					<img src="${pageContext.request.contextPath}/images/facebook.png" alt="facebook">
					<img src="${pageContext.request.contextPath}/images/twitter.png" alt="twitter">
				</ul>
			</div>
			</div>
		</div>
		<div class="footer-bottom">
			Copyright &copy; Closet Collection 2023.
		</div>
	</div>
</body>
</html>