<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>



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
				<li class="nav-item"><a class="nav-link" href="#">Profile</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Logout</a></li>

			</form>
		</ul>
	</nav>
	<br>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			Login Successful!
			<c:if test="${loggedInUser.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose>
	<form:errors path="username">Invalid Username</form:errors>
	<form:errors path="password">Bad password</form:errors>

	<c:choose>
		<c:when test="${not empty meetups}">
			<hr>
			<c:forEach items="${meetups}" var="meetup">

				<p>
					Meetup: ${meetup.title}<br> ${meetup.description}<br>
				</p>


				<form action="meetupDetails.do" method="GET">
					<input type="hidden" name="id" value="${meetup.title}" /> <input
						type="submit" value="Details" />
				</form>

			</c:forEach>
			<br>
			<form action=showAllMeetups.do method="GET">
				<input type="submit" value="Show More">
			</form>
			<hr>

		</c:when>
	</c:choose>

	<c:choose>
		<c:when test="${not empty recipes}">
			<c:forEach items="${recipes}" var="recipe">

				<p>
					Recipe: ${recipe.title }<br> ${recipe.ingredients }<br>
				</p>
				<form action="recipeDetails.do" method="GET">
					<input type="hidden" name="id" value="${recipe.title}" /> <input
						type="submit" value="Details" />
				</form>
			</c:forEach>
			<br>
			<form action=showAllRecipes.do method="GET">
				<input type="submit" value="Show More">
			</form>
			<hr>
		</c:when>
	</c:choose>

</body>
</html>