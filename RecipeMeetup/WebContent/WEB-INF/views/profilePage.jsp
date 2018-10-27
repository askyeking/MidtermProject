<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@include file="NavBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
</head>
<body>

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
	 	
	 	

</body>
</html>