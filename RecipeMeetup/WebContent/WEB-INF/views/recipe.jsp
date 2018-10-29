<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include
		file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">
			<br>
			<br>
			<br>
			<p>
			<h3>title: ${recipe.title}</h3>
			</p>
			<hr>	
 			Description: ${recipe.description } <br>
 			Ingredients: ${recipe.ingredients} <br>
 			Instructions: ${recipe.instructions}<br>
 			Category: ${recipe.category}<br>
 			Origin: ${recipe.country}<br>
 			Serving Size: ${recipe.servingSize}<br>
 			Cook Time: ${recipe.cookTime} minutes<br>
 			user ID: ${loggedInUser.firstName }	<br>

			<c:choose>

				<c:when test="${not empty listOfComments }">
					<c:forEach items="${listOfComments}" var="comment">
						<p>${comment.recipeCommentOwner.firstName }  ${comment.recipeCommentOwner.lastName }</p>
						<p>${comment.comment}</p>
						<hr>
					</c:forEach>

				</c:when>
			</c:choose>
					<textarea name="comment" rows="5" cols="50">
					Enter a comment here
					</textarea>
		</c:when>

		<c:otherwise>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
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