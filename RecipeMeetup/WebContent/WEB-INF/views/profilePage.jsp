<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
</head>
<body>

<h3>Profile Page</h3>
	
	 	<form action="userProfilePage.do" method="GET">
	 	
	 	<p>${user.firstName} ${user.lastName}</p>
	 	
	 	<p>${user.description}
	 	
	 	</form>

</body>
</html>