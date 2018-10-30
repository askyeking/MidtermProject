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

	
	 	<form action = "createRecipe.do" method="POST">
			<input type = "submit" value = "Create A New Recipe">
			</form>
			<form action = "createMeetup.do" method="POST">
			<input type = "submit" value = "Create A New Meetup">
			</form> <hr>
	 	
	 	<h4>${loggedInUser.firstName} ${loggedInUser.lastName}</h4>
	 	<p>${loggedInUser.description}</p><hr>
	 	
	 	<c:choose>
		<c:when test="${not empty loggedInUser}">
		<h4>Recently Posted Recipes</h4>
		<hr>
		
			<c:forEach items="${loggedInUser.recipesPosted}" var="recipesPosted">
	 			<p><strong>${recipesPosted.title}/></strong></p> 
	 			<p>${recipesPosted.description}</p><br> 
	 			<p>Country of Origin: ${recipesPosted.country}</p> 
	 			<p>Cook Time: ${recipesPosted.cookTime}</p> 
	 			<p>Serving Size: ${recipesPosted.servingSize}</p> 
	 			<p>Category: ${recipesPosted.category}</p> 
	 			<p>${recipesPosted.ingredients}</p> 
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
	 			<p>${meetupsOwned.startTime}</p> 
	 			<p>${meetupsOwned.endTime}</p> 
	 			<p>${meetupsOwned.maxAttendance}</p>
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