	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Meetup</title>
</head>
<body>

	<h3>Create a New Meetup</h3>

	<form action="createMeetup.do" method="POST">
		<br>
		<h3>Meetup Name</h3>
		<input type="text" name="title" value="" maxlength="45" required /><br>
		<h3>Description</h3>
		<input type="text" name="description" maxlength="250"
			style="height: 100px" /> <br>
		<h3>Start Time</h3>
		<input type="datetime" name="startTime" value="" required /><br>
		<h3>End Time</h3>
		<input type="datetime" name="endTime" value="" required /><br>
		<h3>Maximum Attendance</h3>
		<input type="number" name="maxAttendance" value="" maxlength="45" required /><br>
		<h3>Address</h3>
		<input type="text" name="street" value="Street" maxlength="190" required /><br>
		<input type="text" name="city" value="City" maxlength="100" required /><br> <input
			type="text" name="state" value="State" maxlength="2" required /><br>
		<input type="number" name="postalCode" value="PostalCode" min="00000" max="99999" required /><br>
		<h3>Set a Meetup Picture</h3>	
		<input type="url" name="imageURL" maxlength="45"><br><br>
		
		<input type="submit" value="Submit" /> 
	</form>

</body>
</html>