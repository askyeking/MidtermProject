<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include file="NavBar.jsp" %></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">



<br>
<br>
<br>
<br>

	
	 	<form action = "createRecipe.do" method="GET">
			<input type = "submit" value = "Create A New Recipe">
			</form>
<form action = "createMeetup.do" method="GET">
			<input type = "submit" value = "Create A New Meetup">
			</form> <br>
	 	
	 	<h4>${loggedInUser.firstName} ${loggedInUser.lastName}</h4>
	 	<p>${loggedInUser.description}</p><hr>
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Recently Posted Recipes</h4>
		<hr>
		
			<c:forEach items="${loggedInUser.recipesPosted}" var="recipesPosted">
	 			<h5>${recipesPosted.title}</h5> 
	 			<p><strong>${recipesPosted.description}</strong></p>
	 			<p>Ingredients: ${recipesPosted.ingredients}</p> 
	 			<p>Country of Origin: ${recipesPosted.country}</p> 
	 			<p>Cook Time: ${recipesPosted.cookTime}</p> 
	 			<p>Serves: ${recipesPosted.servingSize}</p> 
	 			<p>Category: ${recipesPosted.category}</p> 
	 			<p>Instructions: ${recipesPosted.instructions}</p> 
	 			<hr>
	 
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Recently Posted Meetups</h4>
		<hr>
		
			<c:forEach items="${loggedInUser.meetupsOwned}" var="meetupsOwned">
	 			<p><strong>${meetupsOwned.title}</strong></p> 
	 			<p>${meetupsOwned.description}</p> <br>
	 			<p>Start Time: ${meetupsOwned.startTime}</p> 
	 			<p>End Time: ${meetupsOwned.endTime}</p> 
	 			<p>Max Attendance: ${meetupsOwned.maxAttendance}</p>
	 			<hr>
	 
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Favorite Recipes</h4>
		<hr>
		
			<c:forEach items="${loggedInUser.recipesFavorited}" var="favRecipe">
	 			<p>
							<a href="showRecipeDetails.do?id=${favRecipe.id }"><strong>${favRecipe.title}</strong></a>
						</p> 
	 			<p>${favRecipe.description}</p> 
	 			<hr>
	 			
	 	
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Meetups Attended</h4>
		<hr>
		
			<c:forEach items="${loggedInUser.meetupsAttended}" var="attended">
	 			<p>
	 				<a href="showMeetupDetails.do?id=${attended.id }"><strong>${attended.title}</strong></a>
	 			</p> 
	 			<p>${attended.description}</p> 
	 			<hr>
	 
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	
		</c:when>
		<c:otherwise>
		<br><br><br><br><br><br>
			<h3>Only a logged in user can view this page.</h3>
				
				<form:form action="index.do" modelAttribute="user" method="GET">
					<input type="submit" value="Login" />
				</form:form>

				
				<form:form action="registrationLink.do" modelAttribute="user"
					method="GET">
					<input type="submit" value="Register" />
				</form:form>
			
		</c:otherwise>
		</c:choose>

</body>
</html>