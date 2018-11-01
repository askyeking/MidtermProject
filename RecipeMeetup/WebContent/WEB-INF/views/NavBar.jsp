<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Navigation Bar</title> -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>

</head>
<body>

</body>
</html>



<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="home.do"><font face="Comic Sans MS"><h4><strong>&#78&#210&#109&#8901&#951&#211&#109</strong></h4></font></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
       <a class="nav-link" href="home.do">Home<span class="sr-only">(current)</span></a>
            <li class="nav-item"><a class="nav-link" href="showAllRecipes.do">Recipes</a></li>
            <li class="nav-item"><a class="nav-link" href="showAllMeetups.do">Meetups</a></li>
       		<li class="nav-item"><a class="nav-link" href="userProfile.do">${loggedInUser.username }</a></li>
            <li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
    </ul>
    

    <form:form action="searchByRecipe.do" method="GET">
          <input type="text" name="input" placeholder="Search" aria-label="Search">
          &nbsp<select class="btn btn-mini" name="category">
     		 <option value="recipe">Recipe</option>
     		 <option value="meetup">Meetup</option>
  		  </select>

  </div>

          &nbsp&nbsp<button class="btn btn-outline-success my-2 my-sm-0" type="submit" value="Submit">Search</button>
          <ul class="navbar-nav mr-auto">
		  </ul>
  	</form:form>
          
    </div>
    
    
    
    
    
</nav>