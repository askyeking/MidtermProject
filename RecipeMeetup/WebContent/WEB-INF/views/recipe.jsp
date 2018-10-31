<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty loggedInUser }"><%@include
        file="NavBar.jsp"%></c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Details</title>
</head>
<body>
    <br>
    <br>
    <br>
    <c:choose>
        <c:when test="${not empty loggedInUser}">
            <br>

            <p>
            <h3>${recipe.title}</h3>
            <c:if test="${canEditPost}">
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
            </form:form>
            <h1>${recipe.active }</h1>
            <hr>    
             Description: ${recipe.description} <br>
             Ingredients: ${recipe.ingredients} <br>
             Instructions: ${recipe.instructions}<br>
             Category: ${recipe.category}<br>
             Origin: ${recipe.country}<br>
             Serving Size: ${recipe.servingSize}<br>
             Cook Time: ${recipe.cookTime} minutes<br>

                <hr>

                <c:choose>

                    <c:when test="${not empty listOfComments }">
                        <c:forEach items="${listOfComments}" var="comment">
						<a href="viewOtherProfile.do?id=${comment.recipeCommentOwner.id}"> ${comment.recipeCommentOwner.firstName} ${comment.recipeCommentOwner.lastName}</a>
						<br>${comment.comment}<hr>
                        </c:forEach>

                    </c:when>
                </c:choose>

                <form:form action="submitRecipeComment.do" method="POST">
                    <input type="hidden" name="id" value="${recipe.id }" />
                    <input type="text" name="comment" value="Post a comment..." rows="5"
                        cols="50" /><br>
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