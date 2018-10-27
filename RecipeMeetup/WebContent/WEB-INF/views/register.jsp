<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>

<h3>REGISTER HOMEPAGE</h3>

	<form action="register.do" method="POST">
		<h1>User name</h1> <br>
		<input type="text" name="username" value="" />
		<h1>Password</h1><br>
		<input type="password" name="password" value="" />
		<h1>Email</h1><br>
		<input type="text" name="email" value="" />
		<h1>First Name</h1><br>
		<input type="text" name="firstName" value="" />
		<h1>Last Name</h1><br>
		<input type="text" name="lastName" value="" />
		<h1>Date of Birth</h1><br>
		<input type="text" class="date" name="dateOfBirth" value="" />
		<h1>Address</h1>
		<input type="text" name="street" value="" />
		<input type="text" name="city" value="" />
		<input type="text" name="state" value="" />
		<br>
		<input type="submit" value="Submit" />
	</form>


</body>
</html>