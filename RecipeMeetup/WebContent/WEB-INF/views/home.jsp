<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome!</title>
</head>
<body>

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




	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			Login Successful!
			<c:if test="${loggedInUser.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>
			
		</c:otherwise>
	</c:choose>
			<%-- <form:errors path="username">Invalid Username</form:errors>
			<form:errors path="password">Bad password</form:errors>
	 --%>
	 
	 

</body>
</html>