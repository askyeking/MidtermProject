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
<title>Insert title here</title>
</head>
<body>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="${not empty loggedInUser }">
			<br>
			
			<p>
			<h3>title: ${recipe.title}</h3> 
			<c:if test="${canEditPost}">delete     edit</c:if>
			
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
			<form path="submitRecipeComment.do" method="post">
				<textarea rows="5" cols="50">
				</textarea>
				<br> <input type="submit" value="Submit Comment" />
			</form>

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