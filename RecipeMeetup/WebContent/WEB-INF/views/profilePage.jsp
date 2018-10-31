<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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

					<div class="container">
						<div class="center">
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
													<a href="showRecipeDetails.do?id=${recipe.id }"
														class="btn btn-primary">View Details</a>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>

				</c:when>
			</c:choose>























			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Recently Posted Meetups</h4>
					<hr>

					<div class="container">
						<div class="center">
							<div class="row">
								<div class="card-deck">


									<c:forEach items="${loggedInUser.meetupsOwned}" var="meetup">
										<%-- 									<c:if test="${meetup.active}">
 --%>
										
										<c:if test="${fn:length(loggedInUser.meetupsOwned) >= 3}">
											<div class="col-sm-4">
												<div class="card" style="width: 18rem;">
													<c:if test="${not empty meetup.imgURL }">
														<img class="card-img-top" src="${meetup.imgURL  }"
															alt="Card image cap">
													</c:if>
													<div class="card-body">
														<h5 class="card-title">${meetup.title }</h5>
														<p class="card-text">${meetup.description }.</p>
														<a href="showMeetupDetails.do?id=${meetup.id }"
															class="btn btn-primary">View Details</a>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${fn:length(loggedInUser.meetupsOwned) == 2}">
											<div class="col-sm-6">
												<div class="card" style="width: 18rem;">
													<c:if test="${not empty meetup.imgURL }">
														<img class="card-img-top" src="${meetup.imgURL  }"
															alt="Card image cap">
													</c:if>
													<div class="card-body">
														<h5 class="card-title">${meetup.title }</h5>
														<p class="card-text">${meetup.description }.</p>
														<a href="showMeetupDetails.do?id=${meetup.id }"
															class="btn btn-primary">View Details</a>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${fn:length(loggedInUser.meetupsOwned) == 1}">
											<div class="col-sm-12">
												<div class="card" style="width: 18rem;">
													<c:if test="${not empty meetup.imgURL }">
														<img class="card-img-top" src="${meetup.imgURL  }"
															alt="Card image cap">
													</c:if>
													<div class="card-body">
														<h5 class="card-title">${meetup.title }</h5>
														<p class="card-text">${meetup.description }.</p>
														<a href="showMeetupDetails.do?id=${meetup.id }"
															class="btn btn-primary">View Details</a>
													</div>
												</div>
											</div>
										</c:if>
										<%--  										</c:if>
 --%>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>




























			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Favorite Recipes</h4>
					<hr>

					<div class="container">
						<div class="center">
							<div class="row">
								<div class="card-deck">

									<c:forEach items="${loggedInUser.recipesFavorited}"
										var="favRecipe">
										<div class="col-sm-4">
											<div class="card" style="width: 18rem;">
												<c:if test="${not empty favRecipe.imgURL }">
													<img class="card-img-top" src="${favRecipe.imgURL  }"
														alt="Card image cap">
												</c:if>
												<div class="card-body">
													<h5 class="card-title">${favRecipe.title }</h5>
													<p class="card-text">${favRecipe.description }.</p>
													<a href="showRecipeDetails.do?id=${favRecipe.id }"
														class="btn btn-primary">View Details</a>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>

				</c:when>
			</c:choose>






























			<c:choose>
				<c:when test="${not empty loggedInUser}">
					<h4>Meetups Attended</h4>

					<div class="container">
						<div class="center">
							<div class="row">
								<div class="card-deck">

									<c:forEach items="${loggedInUser.meetupsAttended}"
										var="attended">
										<div class="col-sm-4">
											<div class="card" style="width: 18rem;">
												<c:if test="${not empty attended.imgURL }">
													<img class="card-img-top" src="${attended.imgURL  }"
														alt="Card image cap">
												</c:if>
												<div class="card-body">
													<h5 class="card-title">${attended.title }</h5>
													<p class="card-text">${attended.description }.</p>
													<a href="showMeetupDetails.do?id=${attended.id }"
														class="btn btn-primary">View Details</a>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>

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