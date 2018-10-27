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

	<form action="register.do" method="POST">
		<h1>User name</h1> <br>
		<input type="text" name="username" value="" />
		<h1>Password</h1><br>
		<input type="password" name="password" value="" />
		<h1>Email</h1><br>
		<input type="text" name="email" value="" />
		<h1>First Name</h1><br>
		<input type="text" name="firstName" value="" />
		<h1>Last Name</h1><br>
		<input type="text" name="lastName" value="" />
		<h1>Date of Birth</h1><br>
		<input type="date" class="date" name="dateOfBirth" value="" />
		<h1>Address</h1>
		<input type="text" name="street" value="" />
		<input type="text" name="city" value="" />
		<input type="text" name="state" value="" />
		<br>
		<h1>Tell us a little about yourself</h1>
		<input type="text" style="height:200px;font-size:14pt; name="aboutMe" maxlength="250" value="" />
		<br>
		<input type="submit" value="Submit" />
	</form>


</body>
</html>