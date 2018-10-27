<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
			<li class="nav-item"><a class="nav-link" href="#">Recipes</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Meetups</a></li>
			<form class="form-inline" action="/action_page.php">
				<input class="form-control" type="text" placeholder="Search by...">
				<select name="category">
					<option value="category_id">Recipe</option>
					<option value="category_id">Keyword</option>
					<option value="category_id">Ingredient</option>
					<input type="submit" value="Search" />
				</select>
			<li class="nav-item"><a class="nav-link" href="#">Register</a></li>
			
			</form>
		</ul>
	</nav>
	<div class="container-fluid" style="margin-top: 80px">
		<h3>Sign In!</h3>
	</div>

	<form:form action="login.do" method="POST">
		<input type="text" name="username" value="Username" />
		<br>
		<input type="text" name="password" value="Password" />
		<br>
		<input type="submit" value="Login" />
		<br>
	</form:form>
	<form:form action="register.do" method="POST">
		<input type="submit" value="Register" />
		<br><br><br>
	</form:form>

	<form>

		<h3>Recent Posts</h3>

		<p></p>
		
		<br>

	</form>

	<form>

		<h3>About Us</h3>
		<p>
			<strong>Blake Longfield, Anthony King, Newel, Novak</strong>
		</p>
		<p>We are awesome and plan on making $1 bil a piece</p>
	</form>
</body>
</html>