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
<!-- <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
        <a class="navbar-brand" href="#">Name of Website</a>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="home.do">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="showAllRecipes.do">Recipes</a></li>
            <li class="nav-item"><a class="nav-link" href="showAllMeetups.do">Meetups</a></li>

<<<<<<< HEAD
				<form action="searchByRecipe.do" method="GET">
					<input type="text" name="input" value="Search..."/>
					<select name="category">
   						 <option value="recipe">Recipe</option>
   						 <option value="meetup">Meetup</option>
					</select>
					<input type="submit" value="Submit"/>
				</form>
				
				<li class="nav-item"><a class="nav-link" href="userProfile.do">${loggedInUser.username }</a></li>
				<li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
=======
                <form action="searchByRecipe.do" method="GET">
                    <input type="text" name="input" value="Search..."/>
                    <select name="category">
                            <option value="recipe">Recipe</option>
                            <option value="meetup">Meetup</option>
                    </select>
                    <input type="submit" value="Submit"/>
                </form>
                
                <li class="nav-item"><a class="nav-link" href="userProfile.do">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
>>>>>>> f11499c940dca9d1ee994d63a709a5f938e8920c

            </form>
        </ul>
        
        </div>
    </nav> -->
</body>
</html>



<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <!-- <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li> -->
       <a class="nav-link" href="home.do">Home<span class="sr-only">(current)</span></a>
            <li class="nav-item"><a class="nav-link" href="showAllRecipes.do">Recipes</a></li>
            <li class="nav-item"><a class="nav-link" href="showAllMeetups.do">Meetups</a></li>
       		<li class="nav-item"><a class="nav-link" href="userProfile.do">${loggedInUser.username }</a></li>
            <li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
    </ul>
    
    
    
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form> -->
    <form action="searchByRecipe.do" method="GET">
          <input type="text" name="input" placeholder="Search" aria-label="Search">
          <select class="btn btn-mini" name="category">
     		 <option value="recipe">Recipe</option>
     		 <option value="meetup">Meetup</option>
  		  </select>
          
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit" value="Submit">Search</button>
          <ul class="navbar-nav mr-auto">
		  </ul>
  	</form>
          
    </div>
    
    
    
    
    
</nav>