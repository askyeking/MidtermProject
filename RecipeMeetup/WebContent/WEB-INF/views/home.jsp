<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome!</title>
</head>
<body>
	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			Login Successful!
			<c:if test="${user.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
			<%-- <form:errors path="username">Invalid Username</form:errors>
			<form:errors path="password">Bad password</form:errors>
	 --%>

</body>
</html>