<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:if test="${not empty loggedInUser }"><%@include
		file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Details</title>
</head>
<body>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="${not empty loggedInUser}">
			<br>
			
			<p>
			<h3>${recipe.title}</h3> 
			<form action="editRecipe.do" method="post">
				<input type="submit" value="Edit" />
			</form>
			<form action="DeleteRecipe.do" method="post">
				<input type="submit" value="Delete" />
			</form>
			<c:if test="${canEditPost}"></c:if>
		
			</p>
			
			<hr>	
 			Description: ${recipe.description } <br>
 			Ingredients: ${recipe.ingredients} <br>
 			Instructions: ${recipe.instructions}<br>
 			Category: ${recipe.category}<br>
 			Origin: ${recipe.country}<br>
 			Serving Size: ${recipe.servingSize}<br>
 			Cook Time: ${recipe.cookTime} minutes<br>
 			user: ${loggedInUser.firstName }	<br>
			<c:if test="${testBoolean }">At least this worked</c:if>
	
			<c:choose>

				<c:when test="${not empty listOfComments }">
					<c:forEach items="${listOfComments}" var="comment">
						<p>${comment.recipeCommentOwner.firstName }
							${comment.recipeCommentOwner.lastName }</p>
						<p>${comment.comment}</p>
						<hr>
					</c:forEach>

				</c:when>
			</c:choose>
			<form:form action="submitRecipeComment.do" method="POST">
				Comment
				<input type="hidden" name="id" value="${recipe.id }" />
				<input type="text" name="comment" rows="5" cols="50" />
				<input type="submit" value="Submit Comment" />
			</form:form>
			

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