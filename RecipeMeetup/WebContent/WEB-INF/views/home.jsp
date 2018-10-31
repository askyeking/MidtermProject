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
<link rel="stylesheet" href="resources/home.css" />
<title>Home</title>


<!-- div class="row"><
<div class="col-8">
<img id="narrows" alt="" src="media/narrows.jpg" >
</div> -->

</head>
<body style="height: 1500px">

	<div class="home-pic">
		<img class="center-fit" src="media/cuttingboard.jpg"
			alt="cuttingboard">
		<div class="text-block">
			<h1>Recipe Meetup</h1>
			<h3>Let's meetup and cook together</h3>
		</div>
	</div>

	<c:choose>
		<c:when test="${not empty loggedInUser }">


			<form action="createRecipe.do" method="GET">
				<input type="submit" value="Create A New Recipe">
			</form>
			<form action="createMeetup.do" method="GET">
				<input type="submit" value="Create A New Meetup">
			</form>
			<br>

			<%-- 	<c:choose>
		<c:when test="${not empty user and user.active}">
			
			Login Successful!
			<c:if test="${loggedInUser.admin }">Admin login</c:if>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose> --%>
			<%-- 	<form:errors path="username">Invalid Username</form:errors>
	<form:errors path="password">Bad password</form:errors> --%>

			<c:choose>
				<c:when test="${not empty recentMeetup}">
					<h4>Recent Meetups</h4>
					<hr>

					<c:forEach items="${recentMeetup}" var="meetup">

						<c:if test="${meetup.active }">
							<p>
								<a href="showMeetupDetails.do?id=${meetup.id }"><strong>${meetup.title}</strong></a><br>
								${meetup.description}<br>
							</p>
						</c:if>

					</c:forEach>

					<form action="showAllMeetups.do" method="GET">
						<input type="submit" value="Show More">
					</form>
					<br>
					<br>

				</c:when>
			</c:choose>

			<c:choose>

				<c:when test="${not empty recentRecipe}">
					<h4>Recent Recipes</h4>
					<hr>

					<c:forEach items="${recentRecipe}" var="recipe">
						<c:if test="${recipe.active }">
						
						
							<div class="recipe-card" style="width: 18rem;">
 <img class="card-img-top" src="media/cuttingboard.jpg" alt="Recipe">
 <div class="card-body">
   <h5 class="card-title">Card title</h5>
   <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
   <a href="#" class="btn btn-primary">Go somewhere</a>
 </div>
</div>
							<p>
								<a href="showRecipeDetails.do?id=${recipe.id }"><strong>${recipe.title}</strong></a><br>
								${recipe.description}<br>
							</p>
						</c:if>

					</c:forEach>
					<form action="showAllRecipes.do" method="GET">
						<input type="submit" value="Show More">
					</form>
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