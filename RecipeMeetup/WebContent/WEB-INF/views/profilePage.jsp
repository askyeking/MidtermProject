<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include file="NavBar.jsp" %></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">



<br>
<br>
<br>
<br>

<h3>Profile Page</h3>
	
	 	<form action = "createRecipe.do" method="POST">
			<input type = "submit" value = "Create A New Recipe">
			</form>
			<form action = "createMeetup.do" method="POST">
			<input type = "submit" value = "Create A New Meetup">
			</form>
	 	
	 	<p>User: ${loggedInUser.firstName} ${loggedInUser.lastName}</p>
	 	
	 	<p>About you: ${loggedInUser.description}</p>
	 	
	 	


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