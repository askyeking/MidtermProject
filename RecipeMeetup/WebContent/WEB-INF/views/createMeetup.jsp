
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/createMeetup.css" />
<title>Create Meetup</title>
</head>
<body>
<img class="center-fit" src="media/tomato.jpg" alt="homescreen" />
<c:if test="${not empty loggedInUser }">
<%@include file="NavBar.jsp" %>
</c:if>
<body >
	<c:choose>
		<c:when test="${not empty loggedInUser }">

		<div class="newMeetup">
			<h3>Create a New Meetup</h3>
			<form action="addedMeetup.do" method="POST">
				<input type="hidden" name="active" value="1" /> 
				<br>
				<h3>Meetup Name</h3>
				<input type="text" name="title" value="" maxlength="45" required /><br>
				<h3>Description</h3>
				<input type="text" name="description" maxlength="250"
					style="height: 100px" /> <br>
				<h3>Maximum Attendance</h3>
				<input type="number" name="maxAttendance" value="" maxlength="45"
					required /><br>
				<h3>Start Date</h3>
				<input type="datetime-local" name="ldt" required /><br>
				<h3>Set a Meetup Picture</h3>
				URL: <input type="url" name="imgURL"><br> <br>
				
				<h3>Address</h3>
				<input type="text" name="street" maxlength="190" placeholder="Street" aria-label="Street" required /><br>
				<input type="text" name="city" maxlength="100" placeholder="City" aria-label="City" required /><br> <input
					type="text" name="state" maxlength="2" placeholder="State" aria-label="State" required /><br>
				<input type="number" name="postalCode" min="00000" max="99999" placeholder="ZIP" aria-label="ZIP" required /><br>
				
				<input type="submit" value="Submit" />
			</form>
		
</div>
				




		</c:when>
		<c:otherwise>
		<div class="notLoggedIn">
		<br><br><br><br><br><br>
			<h3>Only a logged in user can view this page.</h3>
				
				<form:form action="index.do" modelAttribute="user" method="GET">
					<input type="submit" value="Login" />
				</form:form>

				
				<form:form action="registrationLink.do" modelAttribute="user"
					method="GET">
					<input type="submit" value="Register" />
				</form:form>
			</div>
		</c:otherwise>
		</c:choose>
</body>

</html>