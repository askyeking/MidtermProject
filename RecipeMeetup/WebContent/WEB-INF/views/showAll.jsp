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
<%-- 	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			
			<c:if test="${loggedInUser.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose> --%>

	<c:choose>
		<c:when test="${not empty meetups}">
		<h3>Meetups</h3>
			<hr>
			<c:forEach items="${meetups}" var="meetup">

				<p>
					Meetup: ${meetup.title}<br> ${meetup.title}<br>
				</p>


				<form action="showMeetupDetails.do" method="GET">
					<input type="hidden" name="id" value="${meetup.id}" /> <input
						type="submit" value="Details" />
				</form>

			</c:forEach>
			<br>
			
			<hr>

		</c:when>
	</c:choose>

	<c:choose>
		<c:when test="${recipes}">
		<h3>Recipes</h3>
		<hr>
			<c:forEach items="${recipes}" var="recipe">

				<p>
					Recipe: ${recipe.title }<br> 
					Ingredients: ${recipe.ingredients }<br>
				</p>
				<form action="showRecipeDetails.do" method="GET">
					<input type="hidden" name="id" value="${recipe.id}" /> <input
						type="submit" value="Details" />
				</form>
			</c:forEach>
			<br>
			
			<hr>
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