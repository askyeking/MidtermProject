<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@include file="NavBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>

</head>
<body style="height: 1500px">
	
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
			
			<hr>
		</c:when>
	</c:choose>

</body>
</html>