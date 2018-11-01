<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${not empty loggedInUser }"><%@include
		file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/recipe.css" />
<meta charset="UTF-8">
<title>Recipe Details</title>
</head>
<body>
	<!-- <img class="center-fit" src="media/cooking.jpg" alt="homescreen"/> -->
	<%-- <div class="backgroundImg" style="background-image: url('${recipe.imgURL}')"> --%>
	<br>
	<br>
	<br>


	<c:choose>
		<c:when test="${not empty loggedInUser}">
		
			<div class="container">
				<div class="row">
					<!-- <div class="col-sm">
				    </div> -->
					<div class="col-sm" id="title""></div>
					<!--  <div class="col-sm">
				    </div> -->
				</div>

		


				<br>


				


			</div>


			</div>
			<%-- <h3>${recipe.title}</h3> --%>
			<%-- <c:if test="${canEditPost}">
                <form action="editRecipe.do" method="GET">
                    <input type="hidden" name="id" value="${recipe.id}" /> <input
                        type="submit" value="Edit" />
                </form>
                <form action="deleteRecipe.do" method="post">
                    <input type="hidden" name="id" value="${recipe.id}" /> <input
                        type="submit" value="Delete" />
                </form>
            </c:if>

            </p>
            <form:form action="favoriteRecipe.do" method="post">
                <input type="hidden" name="id" value="${recipe.id }" />
                <input type="submit" value="Add to Favorites" />
            </form:form>
            <br>
            <form:form action="likeRecipe.do" method="post">
                <input type="hidden" name="id" value="${recipe.id }" />
                <input type="submit" value="LIKE" />
            </form:form> --%>

           
            
            <h1 align="center"><strong>${recipe.title}</strong></h1>
			<div class="card" style="width: 50rem;">
				<img class="card-img-top" src="${recipe.imgURL }" alt="recipes">
				<br>
            	<br>
				<div class="row">
					<!-- <div class="col-sm-3">
			    </div> -->
					 <div class="col-sm button">
						<form action="favoriteRecipe.do" method="post">
							<input type="hidden" name="id" value="${recipe.id }" /> <input
								type="submit" value="Add to Favorites" class="btn btn-primary" />
						</form>
					 </div> 
					<br>
					 <div class="col-sm button"> 
						<form action="likeRecipe.do" method="post">
							<input type="hidden" name="id" value="${recipe.id }" /> <input
								type="submit" value="LIKE" class="btn btn-primary" />
							${fn:length(recipe.recipeLikers)}
						</form>
					 </div>  

					<%--  <div class="buttons" >
							<a href="favoriteRecipe.do" class="btn btn-primary btn-lg">Add to Favorites</a> 
							<a href="likeRecipe.do" class="btn btn-primary btn-lg">Like</a> ${fn:length(recipe.recipeLikers)} 
						</div>  --%>


					<c:if test="${canEditPost}">
						<div class="col-sm button">
							<form action="editRecipe.do" method="GET">
								<input type="hidden" name="id" value="${recipe.id}" /> <input
									type="submit" value="Edit" class="btn btn-primary" />
							</form>
						</div>

						<div class="col-sm button">
							<form action="deleteRecipe.do" method="post">
								<input type="hidden" name="id" value="${recipe.id}" /> <input
									type="submit" value="Delete" class="btn btn-primary" />
							</form>
						</div>

						<!--  <div class="col-sm-3">
				    </div> -->


					</c:if>
				</div>
				<br>
                <br>
				
				<div class="card-body">
					<!-- <h1 class="card-title">
						
					</h1> -->
					<p class="card-text">${recipe.description}</p>
					<br>
					<p class="card-text">
						<strong>Category: </strong>${recipe.category}</p>
					<p class="card-text">
						<strong>Country of Origin: </strong>${recipe.country}</p>
					<p class="card-text">
						<strong>Serving Size: </strong>${recipe.servingSize}</p>
					<p class="card-text">
						<strong>Cooking Time: </strong>${recipe.cookTime} minutes
					</p>
					<strong>Ingredients: </strong> <br> <br>
					<c:choose>

						<c:when test="${not empty ingredients }">
							<c:forEach items="${ingredients}" var="ingredient">
								<p>${ingredient}</p>
							</c:forEach>

						</c:when>
					</c:choose>
					<p class="card-text">
						<strong>Instructions: </strong><br>
						<br> ${recipe.instructions}
					</p>
					<br>

					<hr>

					<c:choose>

						<c:when test="${not empty listOfComments }">
							<c:forEach items="${listOfComments}" var="comment">
								<a
									href="viewOtherProfile.do?id=${comment.recipeCommentOwner.id}">
									${comment.recipeCommentOwner.firstName}
									${comment.recipeCommentOwner.lastName}</a>
								<br>${comment.comment}<hr>
							</c:forEach>

						</c:when>
					</c:choose>
					<form:form action="submitRecipeComment.do" method="POST">
						<input type="hidden" name="id" value="${recipe.id }" />
						<!-- <input type="text" name="comment" value="Post a comment..."
							rows="5" cols="50" /> -->
						<textarea name="comment"></textarea>
							
						<br>
						<input type="submit" value="Submit Comment" class="btn btn-primary"/>
						<br>
						<br>
						<br>
					</form:form>
					
					
					
					

				</div>
			</div>

			<%--   <hr>    
             <strong>${recipe.description}</strong> <br>
             Category: ${recipe.category}<br>
             Origin: ${recipe.country}<br>
             Serving Size: ${recipe.servingSize}<br>
             Cook Time: ${recipe.cookTime} minutes<br>
              <c:choose>

                    <c:when test="${not empty ingredients }">
                        <c:forEach items="${ingredients}" var="ingredient">
                        <p>${ingredient}</p>
                        </c:forEach>

                    </c:when>
                </c:choose>
                ${recipe.instructions}

                <hr> --%>


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