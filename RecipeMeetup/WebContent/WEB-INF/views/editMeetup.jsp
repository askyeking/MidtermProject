
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


<title>Create Meetup</title>
</head>
<body>
<body style="height: 1500px">
	<c:choose>
		<c:when test="${not empty loggedInUser }">
		<br>
		<br>
		<br>
		<br>
		Inside of Edit Meetup
		<c:if test="${not empty meetup }">

			
			<h3>Edit Meetup</h3>

			<form action="editedMeetup.do" method="POST">
			<input type="hidden" name="id" value="${meetup.id}" /> 
				<br>
				<h3>Meetup Name</h3>
				<input type="text" name="title" value="${meetup.title }" maxlength="45" required /><br>
				<h3>Description</h3>
				<input type="text" name="description" value="${meetup.description }" maxlength="250"
					style="height: 100px" /> <br>
<!-- 				<h3>Start Time</h3>
				<input type="datetime" name="startTime" value="" required /><br>
				<h3>End Time</h3>
				<input type="datetime" name="endTime" value="" required /><br> -->
				<h3>Maximum Attendance</h3>
				<input type="number" name="maxAttendance" value="${meetup.maxAttendance }" maxlength="45"
					required /><br>
<!-- 				<h3>Start time</h3>
				<input type="datetime-local" name="startTime" required /><br>
				<h3>End time</h3>
				<input type="datetime-local" name="endTime"/><br> -->
				<h3>Set a Meetup Picture</h3>
				URL: <input type="url" name="imageURL" value="" maxlength="45"><br> <br> 
				<h3>Start Date<h3></h3>
				<input type="datetime-local" name="ldt" value="" required /><br>
				
				<h3>Address</h3>
				Street: <input type="text" name="street" value="${meetup.meetupAddress.street}" maxlength="190" required /><br>
				City: <input type="text" name="city" value="${meetup.meetupAddress.city }" maxlength="100" required /><br> <input
					type="text" name="state" value="${meetup.meetupAddress.state }" maxlength="2" required /><br>
				Postal code: <input type="number" name="postalCode" value="${meetup.meetupAddress.postalCode }" min="00000" max="99999" required /><br>
				
				<input type="submit" value="Submit" />
			</form>
		</c:if>
		

				




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