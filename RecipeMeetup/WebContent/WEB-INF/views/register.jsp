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
			<li class="nav-item"><a class="nav-link" href="#">Home</a></li>
			<form class="form-inline" action="/action_page.php">
			</form>
		</ul>
	</nav>

<h3>REGISTER HOMEPAGE</h3>

	<form action="registrationLink.do" method="GET">
	<br>
		<h3>User name</h3>
		<input type="text" name="username" value="" /><br>
		<h3>Password</h3>
		<input type="password" name="password" value="" /><br>
		<h3>Email</h3>
		<input type="text" name="email" value="" /><br>
		<h3>First Name</h3>
		<input type="text" name="firstName" value="" /><br>
		<h3>Last Name</h3>
		<input type="text" name="lastName" value="" /><br>
		<h3>Date of Birth</h3>
		<input type="text" class="date" name="dateOfBirth" value="" /><br>
		<h3>Address</h3>
		<input type="text" name="street" value="Street" /><br>
		<input type="text" name="city" value="City" /><br>
		<input type="text" name="state" value="State" /><br>
		<h3>Tell us a little about yourself</h3>
		<input type="text" name="aboutMe" maxlength="250" style="height:200px"; />
		<br>
		
		<input type="submit" value="Submit">
	</form>
		
		<form action="register.do" method="GET">
				<input type="hidden" name="id" /> <br> 
				<input type="submit" value="Submit" />
		
		
	</form>
</body>
</html>