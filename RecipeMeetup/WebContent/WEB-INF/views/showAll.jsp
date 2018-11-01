<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }"><%@include
		file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/showAll.css" />
<meta charset="UTF-8">
<title>Home</title>

</head>

<body style="height: 1500px">

	<c:choose>
		<c:when test="${not empty loggedInUser }">


			<br>
			<br>
			<br>
			<br>

			<c:choose>
				<c:when test="${not empty meetups}">
					<h3 align="center">Meetups</h3>
					<div class="buttons">
						<form action="createMeetup.do" method="GET">
							<input type="submit" value="Create A New Meetup" class="btn btn-primary">
						</form>
					</div>
					<hr>

					<c:forEach items="${meetups}" var="meetup">
						<c:if test="${meetup.active}">

							<div class="center">
<<<<<<< HEAD
								<div class="card text-center">
									<div class="card-body" style="width: 40rem">
										<img class="card-img-top" src="${meetup.imgURL }" alt="Meetup"
											height="300" width="100">
=======
								<div class="card" style="width: 35rem;">
									<img class="card-img-top" src="${meetup.imgURL }" alt="meetups">
									<div class="card-body">
>>>>>>> d4b6dc4e6447203bff509d46bc7e7f128b797cb4
										<h5 class="card-title">
											<a href="showMeetupDetails.do?id=${meetup.id }"><strong>${meetup.title}</strong></a>
										</h5>
										<p class="card-text">${meetup.description}</p>
									</div>
								</div>
							</div>
							
						</c:if>
					</c:forEach>
					<br>


				</c:when>
			</c:choose>

			<c:choose>
				<c:when test="${not empty recipes}">
					<h3 align="center">Recipes</h3>
					<div class="buttons">
						<form action="createRecipe.do" method="GET">
							<input type="submit" value="Create A New Recipe" class="btn btn-primary">
						</form>
					</div>
					<hr>
					<c:forEach items="${recipes}" var="recipe">
						<c:if test="${recipe.active}">

							<div class="center">					
							<div class="card" style="width: 35rem;">
									<img class="card-img-top" src="${recipe.imgURL }" alt="recipes">
									<div class="card-body">
										<h5 class="card-title">
											<a href="showRecipeDetails.do?id=${recipe.id }"><strong>${recipe.title}</strong></a>
										</h5>
										<p class="card-text">${recipe.description}</p>
									</div>
								</div>
							</div>


						</c:if>
					</c:forEach>
					<br>

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