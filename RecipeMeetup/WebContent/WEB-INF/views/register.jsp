<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>

	<title>Navigation Bar</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</head>
<body style="height: 1500px">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<a class="navbar-brand" href="#">Name of Website</a>
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="home.do">Home</a></li>
			<form class="form-inline" action="/action_page.php"></form>
		</ul>
	</nav>

	<h3>REGISTER HOMEPAGE</h3>

	<form action="register.do" method="POST">
		<br>
		<h3>User name</h3>
		<input type="text" name="username" value="" maxlength="45" required /><br>
		<h3>Password</h3>
		<input type="password" name="password" value="" maxlength="45" required /><br>
		<h3>Email</h3>
		<input type="email" name="email" value="" maxlength="100" required /><br>
		<h3>First Name</h3>
		<input type="text" name="firstName" value="" maxlength="45" required /><br>
		<h3>Last Name</h3>
		<input type="text" name="lastName" value="" maxlength="45" required /><br>
		<h3>Date of Birth</h3>
		<input type="date" name="dateOfBirth" value="" required /><br>
		<h3>Address</h3>
		<input type="text" name="street" value="Street" maxlength="190" required /><br>
		<input type="text" name="city" value="City" maxlength="100" required /><br> <input
			type="text" name="state" value="State" maxlength="2" required /><br>
		<input type="number" name="postalCode" value="PostalCode" min="00000" max="99999" required /><br>
		
		<h3>Tell us a little about yourself</h3>
		<input type="text" name="aboutMe" maxlength="250"
			style="height: 200px" /> <br> 
		<h3>Set your profile picture</h3>	
		<input type="url" name="imageURL" maxlength="45"><br><br><br>
		
		<input type="submit" value="Submit" size="big" /> 
	</form>

</body>
</html>