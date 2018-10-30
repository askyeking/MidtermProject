<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }">
<%@include file="NavBar.jsp" %>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>

<!-- div class="row"><
<div class="col-8">
<img id="narrows" alt="" src="media/narrows.jpg" >
</div> -->

</head>
<body style="height: 1500px">

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
			
<%-- 	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			Login Successful!
			<c:if test="${loggedInUser.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose> --%>
<%-- 	<form:errors path="username">Invalid Username</form:errors>
	<form:errors path="password">Bad password</form:errors> --%>

	<c:choose>
		<c:when test="${not empty recentMeetup}">
		
			<h4>Recent Recipes</h4> <hr>
		
			<c:forEach items="${recentMeetup}" var="meetup">

				<p><strong>${meetup.title}</strong><br>
					${meetup.description}<br>
				</p>
				

				<form action="showMeetupDetails.do" method="GET">
					<input type="hidden" name="id" value="${meetup.id}" /> <input
						type="submit" value="Details" /> <hr>
				</form> 

			</c:forEach>
			<form action = "showAllMeetups.do" method="GET">
			<input type = "submit" value = "Show More">
			</form>
			<br><br>
			
		</c:when>
	</c:choose>

	<c:choose>
		<c:when test="${not empty recentRecipe}">
				<h4>Recent Recipes</h4> <hr>
		
			<c:forEach items="${recentRecipe}" var="recipe">
			
				<p><strong>${recipe.title }</strong><br>
					${recipe.description}<br>
				</p>
				<form action="showRecipeDetails.do" method="GET">
					<input type="hidden" name="id" value="${recipe.id}" /> <input
						type="submit" value="Details" /> <hr>
				</form>
			</c:forEach>
			<form action = "showAllRecipes.do" method="GET">
			<input type = "submit" value = "Show More">
			</form>
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