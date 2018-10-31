<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include file="NavBar.jsp" %></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Other User Profile</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">
<br>
<br>
<br>
<br>	 	
	 	<%-- <p>User: ${user.firstName} ${user.lastName}</p>
	 	
	 	<p>About you: ${user.description}</p> --%>
	 	
	 <%-- 	<form action="viewOtherProfile.do" method="GET">
			<input type="hidden" name="id" value="${comment.meetupCommentOwner.id }" /> 
			<input type="submit" value="view profile" /> --%>
	 	
	 	<h4>${user.firstName} ${user.lastName}</h4>
	 	<p>${user.description}</p><hr>
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Recently Posted Recipes</h4>
		<hr>
		
			<c:forEach items="${user.recipesPosted}" var="recipesPosted">
	 			<p><h5>${recipesPosted.title}</h5></p> 
	 			<p><strong>${recipesPosted.description}</strong></p>
	 			<p>Country of Origin: ${recipesPosted.country}</p> 
	 			<p>Cook Time: ${recipesPosted.cookTime}</p> 
	 			<p>Serves: ${recipesPosted.servingSize}</p> 
	 			<p>Category: ${recipesPosted.category}</p> 
	 			<p>Ingredients: ${recipesPosted.ingredients}</p> 
	 			<hr>
	 
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Recently Posted Meetups</h4>
		<hr>
		
			<c:forEach items="${user.meetupsOwned}" var="meetupsOwned">
	 			<p><strong>${meetupsOwned.title}</strong></p> 
	 			<p>${meetupsOwned.description}</p>
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
		
			<c:forEach items="${user.recipesFavorited}" var="favRecipe">
	 			<p>
	 				<a href="showRecipeDetails.do?id=${favRecipe.id }"><strong>${favRecipe.title}</strong></a>
	 			</p> 
	 			<p>${favRecipe.description}</p><br>
	 			<hr>
	 			
	 			<%-- <a href="viewOtherProfile.do?id=${meetupOwner.id }" > Meetup Owner: ${meetupOwner.firstName }</a>
	  --%>
	 
	 	</c:forEach>
	 	</c:when>
	 	</c:choose>
	 	
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Meetups Attended</h4>
		<hr>
		
			<c:forEach items="${user.meetupsAttended}" var="attended">
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