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
<title>Meetup Details</title>
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


			<h3>${meetup.title }</h3>
			<form action="editMeetup.do" method="post">
				<input type="submit" value="Edit" />
			</form>
			<form action="deleteMeetup.do" method="post">
				<input type="submit" value="Delete" />
			</form>
			<p> <a href="userProfile.do">user ID: ${loggedInUser.firstName }</a></p>
				<c:choose>

				<c:when test="${not empty listOfComments }">
					<c:forEach items="${listOfComments }" var="comment">
						<hr>
						<p><a href="userProfile.do">${comment.meetupCommentOwner.firstName }
							${comment.meetupCommentOwner.lastName }</a></p>
						<p>${comment.textContent}</p>
					</c:forEach>


				</c:when>

			</c:choose>
				<form:form action="submitMeetupComment.do" method="POST">
				Comment
				<input type="hidden" name="id" value="${meetup.id }" />
				<input type="text" name="textContent" rows="5" cols="50" />
				<input type="submit" value="Submit Comment" />
			</form:form>
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