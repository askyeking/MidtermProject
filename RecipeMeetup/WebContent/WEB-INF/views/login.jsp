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
<%-- 		<ul class="navbar-nav">
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
				</select> --%>
				<a class="nav-link" href="registrationLink.do">Register</a>

			</form>
		</ul>
	</nav>
	<div class="container-fluid" style="margin-top: 80px">
		<h3>Sign In!</h3>
	</div>
	
	<form:form action="login.do" modelAttribute="user" method="POST">
		<input type="text" path="username" name="username" value="username" />
		<br>
		<input type="text" path="password" name="password" value="password" />
		<br>
		<input type="submit" value="Login" />
		<br><br>
<%-- 		<form:errors path="username" />
		<form:errors path="password" /> --%>
		<form:errors path="username">Invalid Username</form:errors>
		<form:errors path="password">Invalid password</form:errors>
	</form:form>

	<form>

		<h3>Recent Meetups</h3>
			
			<c:forEach items="${recentMeetups}" var="meetup">

				<p><li>Meetup: ${meetup.title}</li></p>
				<p>Description: ${meetup.description}</p>

			</c:forEach>


		<h3>Recent Meetups</h3>
			<c:forEach items="${recentRecipes}" var="recipe">
			
				<p><li>Recipe: ${recipe.title }</li></p>
				<p>Description: ${recipe.description}</p>
				
			</c:forEach>

		<br>

	</form>

	<form>

		<h3>About Us</h3>
		<p>
			<strong>Blake Longfield, Anthony King, Newel, Novak Dobrosavljevic</strong>
		</p>
		<p>We are awesome and plan on making $1 bil a piece</p>
	</form>
</body>
</html>