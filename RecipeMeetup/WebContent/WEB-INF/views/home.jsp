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

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="d-block w-100" src="media/People Eating Together/adult-casual-chef-1418355.jpg" alt="1" height="1000" width="auto">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="media/family.jpg" alt="2" height="1000" width="auto">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="media/People Eating Together/adults-aerial-barbecue-1260310.jpg" alt="3" height="1000" width="auto">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="media/People Eating Together/appetite-asian-food-bowls-1321731.jpg" alt="4" height="1000" width="auto">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="media/People Eating Together/rawpixel-754045-unsplash.jpg" alt="5" height="1000" width="auto">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="media/People Eating Together/beer-beverage-delicious-1246957.jpg" alt="6" height="1000" width="auto">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>

	<c:choose>
		<c:when test="${not empty loggedInUser }">


			<!-- <div class="home-pic">
				<img class="center-fit" src="media/cuttingboard.jpg"
					alt="cuttingboard">
				<div class="text-block">
					<h1>Recipe Meetup</h1>
					<h3>Let's meetup and cook together</h3>
				</div>
			</div> -->
			<br>
			<br>
			<br>
			<br>

			<div class="buttons">
				<a href="createRecipe.do" class="btn btn-primary btn-lg">Create
					A New Recipe</a> <a href="createMeetup.do"
					class="btn btn-primary btn-lg">Create A New Meetup</a>
			</div>
			<%-- <form action="createRecipe.do" method="GET"> 
				<button type="button" class="btn btn-primary btn-lg">Create A New Recipe</button>
			</form>  
			<form action="createMeetup.do" method="GET"> 
				<button type="button" class="btn btn-primary btn-lg">Create A New Meetup</button>
			 </form>  --%>


			<br>
			<br>
			<br>
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

					<h4 align="center">Recent Meetups</h4>

					<hr>

					<div class="center">
						<div class="card-deck">
							<c:forEach items="${recentMeetup}" var="meetup">

								<c:if test="${meetup.active }">

									<div class="meetup-card" style="width: 18rem;">
										<img class="card-img-top" src="${meetup.imgURL }" alt="Meetup" height="300" width="auto">
										<div class="card-body">
											<h5 class="card-title">
												<a href="showMeetupDetails.do?id=${meetup.id }"><strong>${meetup.title}</strong></a>
											</h5>
											<p class="card-text">${meetup.description}</p>
										</div>
									</div>
								</c:if>

							</c:forEach>
						</div>
					</div>
					<br>
					<br>
					<br>
						<div class="buttons">
							<a href="showAllMeetups.do" class="btn btn-primary">Show More</a>
						</div>
				</c:when>
			</c:choose>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>

			<c:choose>

				<c:when test="${not empty recentRecipe}">

					<h4 align="center">Recent Recipes</h4>

					<hr>

					<div class="center">
						<div class="card-deck">
							<c:forEach items="${recentRecipe}" var="recipe">
								<c:if test="${recipe.active }">

									<div class="recipe-card" style="width: 18rem;">
										<img class="card-img-top" src="${recipe.imgURL }" alt="Recipe" height="300" width="auto">
										<div class="card-body">
											<h5 class="card-title">
												<a href="showRecipeDetails.do?id=${recipe.id }"><strong>${recipe.title}</strong></a>
											</h5>
											<p class="card-text">${recipe.description}</p>
										</div>
									</div>
									<%-- <p>
								<a href="showRecipeDetails.do?id=${recipe.id }"><strong>${recipe.title}</strong></a><br>
								${recipe.description}<br>
							</p> --%>
								</c:if>

							</c:forEach>
						</div>
						<%-- <form action="showAllRecipes.do" method="GET">
						<input type="submit" value="Show More">
					</form>  --%>
					</div>
					<br>
					<br>
					<br>
						<div class="buttons">
							<a href="showAllRecipes.do" class="btn btn-primary">Show More</a>
						</div>
				</c:when>
			</c:choose>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>



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