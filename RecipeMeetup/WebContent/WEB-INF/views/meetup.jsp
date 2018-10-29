<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }">
	<%@include file="NavBar.jsp"%>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>

			<p>${meetup.title }</p>
			<p>user ID: ${loggedInUser.firstName }</p>

			<c:choose>

				<c:when test="${not empty listOfComments }">
					<c:forEach items="${listOfComments }" var="comment">
						<hr>
						<p>${comment.meetupCommentOwner.firstName }
							${comment.meetupCommentOwner.lastName }</p>
						<p>${comment.textContent}</p>
					</c:forEach>


				</c:when>

			</c:choose>
			<form path="submitMeetupComment.do" method="post" >
				<textarea  rows="5" cols="50" >
				</textarea>
				<br>
				<input type="submit" value="Submit Comment" />

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