<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:if test="${not empty loggedInUser }"><%@include
		file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/card.css">
<meta charset="UTF-8">
<title>User Profile</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty loggedInUser }">



			<br>
			<br>
			<br>
			<br>





			<form action="edituser.do" method="GET">
				<input type="submit" value="Edit Profile">
			</form>

			<form action="deleteUser.do" method="Post">
				<input type="submit" value="Delete Profile"> <input
					type="hidden" name="id" value="${loggedInUser.id }">
			</form>

			<form action="createRecipe.do" method="GET">
				<input type="submit" value="Create A New Recipe">
			</form>
			<form action="createMeetup.do" method="GET">
				<input type="submit" value="Create A New Meetup">
			</form>
			<hr>



			<img src="${loggedInUser.imgURL }" alt="User Profile Picture"
				style="width: 170px; height: 170px;">

			<h4>${loggedInUser.firstName}${loggedInUser.lastName}</h4>
			<p>${loggedInUser.description}</p>
			<hr>

			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Recently Posted Recipes</h4>
					<hr>

					<div class="container-fluid">
					<div class="row">
						<div class="card-deck">
							<c:forEach items="${loggedInUser.recipesPosted}" var="recipe">
								<div class="col-sm-4">
									<div class="card" style="width: 18rem;">
										<c:if test="${not empty recipe.imgURL }">
											<img class="card-img-top" src="${recipe.imgURL  }"
												alt="Card image cap">
										</c:if>
										<div class="card-body">
											<h5 class="card-title">${recipe.title }</h5>
											<p class="card-text">${recipe.description }.</p>
											<a href="showRecipeDetails.do" class="btn btn-primary">Go
												somewhere</a>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					</div>
					
					
					
				</c:when>
			</c:choose>

			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Recently Posted Meetups</h4>
					<hr>

					<c:forEach items="${loggedInUser.meetupsOwned}" var="meetupsOwned">
						<p>
							<strong>${meetupsOwned.title}</strong>
						</p>
						<p>${meetupsOwned.description}</p>
						<br>
						<p>Start Time: ${meetupsOwned.startTime}</p>
						<p>End Time: ${meetupsOwned.endTime}</p>
						<p>Max Attendance: ${meetupsOwned.maxAttendance}</p>
						<hr>

					</c:forEach>
				</c:when>
			</c:choose>


			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Favorite Recipes</h4>
					<hr>

					<c:forEach items="${loggedInUser.recipesFavorited}" var="favRecipe">
						<p>
							<a href="showRecipeDetails.do?id=${favRecipe.id }"><strong>${favRecipe.title}</strong></a>
						</p>
						<p>${favRecipe.description}</p>
						<hr>


					</c:forEach>
				</c:when>
			</c:choose>


			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Meetups Attended</h4>
					<hr>

					<c:forEach items="${loggedInUser.meetupsAttended}" var="attended">
						<p>
							<a href="showMeetupDetails.do?id=${attended.id }"><strong>${attended.title}</strong></a>
						</p>
						<p>${attended.description}</p>
						<hr>

					</c:forEach>
				</c:when>
			</c:choose>


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