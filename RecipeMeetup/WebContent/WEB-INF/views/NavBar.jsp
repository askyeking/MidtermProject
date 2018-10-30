<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<a class="navbar-brand" href="#">Name of Website</a>
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="home.do">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="showAllRecipes.do">Recipes</a></li>
			<li class="nav-item"><a class="nav-link" href="showAllMeetups.do">Meetups</a></li>
			
			<!-- <form class="form-inline" action="searchByRecipe.do">
				<input class="form-control" type="text" placeholder="Search by...">
				<select class="form-control" name="search">
					<option value="recipe">Recipe</option>
					<option value="category_id">Keyword</option>
					<option value="category_id">Ingredient</option>
					<input type="submit" value="Search" />
				</select>  --> 
				
				<form action="searchByRecipe.do" method="GET">
					<input type="text" name="input" value="Search..."/>
					<select name="category">
   						 <option value="recipe">Recipe</option>
   						 <option value="meetup">Meetup</option>
					</select>
					<input type="submit" value="Submit"/>
				</form>
				
				<li class="nav-item"><a class="nav-link" href="userProfile.do">Profile</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Logout</a></li>

			</form>
		</ul>
	</nav>
</body>
</html>