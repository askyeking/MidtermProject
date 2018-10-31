<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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


<%-- <a href="showMeetupDetails.do?id=${attended.id }"><strong>${attended.title}</strong></a> --%>

			<h4>${meetup.title}</h4> 
			<p>${meetup.description}</p>
			Host: <a href="viewOtherProfile.do?id=${meetupOwner.id }">  ${meetupOwner.firstName} ${meetupOwner.lastName}</a> <br> <br>
			<p>Start Time: ${meetup.startTime}</p>
			<p>End Time: ${meetup.endTime}</p>
			<c:if test="${canEditPost}">
			${meetup.id}
			${meetup.active}
			
			<form action="editMeetup.do" method="GET">
					<input type="hidden" name="id" value="${meetup.id}" /> <input
						type="submit" value="Edit" />
				</form>
				<form action="deleteMeetup.do" method="post">
					<input type="hidden" name="id" value="${meetup.id }" /> <input type="submit"
						value="Delete" />
				</form>

			</c:if>
			<c:if test="${not empty listOfAttendees }">
				Current List of Attendees:
				<c:forEach items="${listOfAttendees }" var="attendee"> <br>
					<a href="viewOtherProfile.do?id=${attendee.id}">${attendee.firstName} ${attendee.lastName}</a>
				</c:forEach> <br> <br>
			Number of people attending: <p>${fn:length(listOfAttendees)} / ${meetup.maxAttendance}</p>
 			<form action="RSVPMeetup.do" method="post">
				<input type="hidden" name="id" value="${meetup.id}" /> <input
					type="submit" value="RSVP" />
					<hr>
			</form>

			</c:if>

			<c:choose>
				<c:when test="${not empty listOfComments }">
					<c:forEach items="${listOfComments }" var="comment">
						<a href="viewOtherProfile.do?id=${comment.meetupCommentOwner.id}"> ${comment.meetupCommentOwner.firstName} ${comment.meetupCommentOwner.lastName}</a>
						<br><p>${comment.textContent}</p><hr>
					</c:forEach>

				</c:when>

			</c:choose>
			<form:form action="submitMeetupComment.do" method="POST">
				<input type="hidden" name="id" value="${meetup.id }" />
				<input type="text" name="textContent" rows="5" cols="50" value="Write a comment..."/> <br>
				<input type="submit" value="Submit" />
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