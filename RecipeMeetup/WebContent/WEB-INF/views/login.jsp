<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<form:form action=login.do method="GET">
		<input type="text" name="username" value="UserName"/><br>
		<input type="text" name="password" value="PassWord"/><br>
		<input type="submit" value="Login"/><br>
	</form:form>
</body>
</html>