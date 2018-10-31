<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include file="NavBar.jsp" %></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>

</head>

<body style="height: 1500px">


	<c:choose>
		<c:when test="${not empty loggedInUser }">







	
	<br>
	<br>
	<br>
	<br>

	<c:choose>
		<c:when test="${not empty meetups}">
		<h3>Meetups</h3>
		<form action = "createMeetup.do" method="GET">
			<input type = "submit" value = "Create A New Meetup">
			</form>
			<hr>
			<c:forEach items="${meetups}" var="meetup">
				<c:if test="${meetup.active}">
				<p>
					<h5><a href="showMeetupDetails.do?id=${meetup.id }"><strong>${meetup.title}</strong></a></h5> 
					${meetup.description}<br>
				</p>

				</c:if>
			</c:forEach>
			<br>
			
			
		</c:when>
	</c:choose>

	<c:choose>
		<c:when test="${not empty recipes}">
		<h3>Recipes</h3>
		<form action = "createRecipe.do" method="GET">
			<input type = "submit" value = "Create A New Recipe">
			</form>
		<hr>
			<c:forEach items="${recipes}" var="recipe">
				<c:if test="${recipe.active}">
				<p>
					<h5><a href="showRecipeDetails.do?id=${recipe.id }"><strong>${recipe.title}</strong></a></h5>
					${recipe.description}<br>
				</p>
				</c:if>
			</c:forEach>
			<br>
		
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