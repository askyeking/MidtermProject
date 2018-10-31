<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<!-- <div class="home-pic">
        <img class="center-fit" src="media/basic.jpg"
            alt="homescreen">
        <div class="text-block">
            <h1>Recipe Meetup</h1>
            <h3>Let's meetup and cook together</h3>
        </div>
    </div> -->


<meta charset="UTF-8">
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

<link rel="stylesheet" type="text/css" href="resources/login.css" />
<link rel="stylesheet" href="resources/login.css" />

<title>Login</title>
</head>
<body>
	<img class="center-fit" src="media/HomeScreen.jpg" alt="homescreen" />

	<title>Navigation Bar</title>
</head>
<body style="height: 1500px">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<a class="navbar-brand" href="#">Name of Website</a> <a
			class="nav-link" href="registrationLink.do">Register</a>

		</form>
		</ul>
	</nav>
	<br>
	<br>
	<br>


	<div class="container">
		<div class="row">
			<div class="col-sm"></div>
			<div class="col-sm">
				<h3 id="signIn">Sign In!</h3>
				<form:form action="login.do" modelAttribute="user" method="POST"
					id="login">
					<input type="text" path="username" name="username" value="username" />
					<br>
					<input type="password" path="password" name="password"
						value="password" />
					<br>
					<input type="submit" value="Login" />
					<br>
					<br>
					<%-- 		<form:errors path="username" />
		<form:errors path="password" /> --%>
					<form:errors path="username">Invalid Username</form:errors>
					<form:errors path="password">Invalid password</form:errors>
				</form:form>
			</div>
			<div class="col-sm"></div>
		</div>
	</div>

	<div class="recentContainer">
		<div class="row">
			<div class="col">
				<form>

					<h3>Recent Meetups</h3>
					<hr>

					<c:forEach items="${recentMeetups}" var="meetup">

						<p class="recentMeetups">
							<strong>${meetup.title}</strong><br> ${meetup.description}<br>
						<hr>
						</p>

					</c:forEach>
					<br>
					<h5>Sign-in to See More!</h5>
					<br>
					<br>
				</form>
			</div>
			<div class="col">
				<form>
					<h3>Recent Recipes</h3>
					<hr>
					<c:forEach items="${recentRecipes}" var="recipe">

						<p class="recentRecipes">
							<strong>${recipe.title }</strong><br> ${recipe.description}<br>
						<hr>
						</p>

					</c:forEach>
					<br>
					<h5>Sign-in to See More!</h5>
					<br>
					<br>

				</form>
			</div>
			<div class="w-100"></div>

		</div>
	</div>

	<%-- <form>

		<h3>Recent Meetups</h3> <hr>
			
			<c:forEach items="${recentMeetups}" var="meetup">
			
				<p class="recentMeetups"><strong>${meetup.title}</strong><br>
					${meetup.description}<br> <hr>
				</p>

			</c:forEach>
			<br>
			<h5>Sign-in to See More!</h5>
			<br><br>
		</form> --%>

	<%-- <form>
		<h3>Recent Recipes</h3> <hr>
			<c:forEach items="${recentRecipes}" var="recipe">
			
				<p class="recentRecipes"><strong>${recipe.title }</strong><br>
					${recipe.description}<br> <hr>
				</p>
				
			</c:forEach>
			<br>
			<h5>Sign-in to See More!</h5>
			<br><br>

	</form> --%>

	<form>

		<h3>About The Website Creators</h3>
		<p id="aboutUs">
			<strong>Blake Longfield, Anthony King, Newel Miole, Novak
				Dobrosavljevic</strong>
		</p>
		<p id="aboutUs">We are awesome and plan on making $1 bil a piece</p>
	</form>
</body>
</html>