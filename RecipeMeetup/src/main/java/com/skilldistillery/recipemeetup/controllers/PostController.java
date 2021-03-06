package com.skilldistillery.recipemeetup.controllers;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupCommentDAO;
import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeCommentDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.data.UserDAO;
import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.RecipeComment;
import com.skilldistillery.recipemeetup.entities.User;


@Controller
public class PostController {

	// Autowires repositories so that making instances of DAO implementing classes is unnecessary.
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	@Autowired
	private RecipeCommentDAO recipeCommentDAO;
	@Autowired
	private MeetupCommentDAO meetupCommentDAO;
	@Autowired
	private UserDAO userDAO;
	
	// The method below shows details of a recipe user wanted a detailed view of
	@RequestMapping(path="showRecipeDetails.do", method=RequestMethod.GET)
	public ModelAndView showRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Boolean canEdit = new Boolean(false);	
		
		//retrieve all info about the recipe user clicked on from the DB
		recipe = recipeDAO.showRecipe(recipe);
		
		String unparsedIngredients = recipe.getIngredients();
		
		//Parses ingredients separated by comma
		List<String> parsedIngredients = new ArrayList<>(Arrays.asList(unparsedIngredients.split(",")));
		
		//retrieves logged in user info from the current session
		User currentUser = (User) session.getAttribute("loggedInUser");
		
		// If the user in session is the recipe owner, or if the user in session ins an administrator, the user can edit
		if ((recipe.getRecipeOwner().getId() == currentUser.getId()) || currentUser.getAdmin()) {
			canEdit = true;
		}
		
		//add all relevant objects to the front end (Recipe.jsp)
		mv.addObject("ingredients", parsedIngredients);
		mv.addObject("canEditPost" , canEdit);
		mv.addObject("recipe", recipeDAO.showRecipeById(recipe.getId()));
		mv.addObject("listOfComments", recipeCommentDAO.showAllRecipeComments(recipe.getId()));
		mv.setViewName("/WEB-INF/views/recipe.jsp");
		return mv;
	}
	
	// Similarly to  showRecipe method, show Meetup prints details of a meetup user wanted a detailed view of.
	@RequestMapping(path="showMeetupDetails.do", method=RequestMethod.GET)
	public ModelAndView showMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Boolean canEdit = new Boolean(false);
		
		meetup = meetupDAO.showMeetup(meetup);
		User currentUser = (User) session.getAttribute("loggedInUser");
		if((meetup.getMeetupOwner().getId() == currentUser.getId()) || currentUser.getAdmin()) {
			canEdit = true;
		}
		List<User> meetupAttendees = meetup.getAttendees();
		User meetupOwner = meetup.getMeetupOwner();
		
		mv.addObject("meetupOwner", meetupOwner);
		mv.addObject("listOfAttendees", meetupAttendees);
		mv.addObject("canEditPost" , canEdit);
		mv.addObject("meetup",meetupDAO.findSingleMeetup(meetup.getId()));
		mv.addObject("listOfComments", meetupCommentDAO.showAllMeetupComments(meetup.getId()));
		mv.setViewName("/WEB-INF/views/meetup.jsp");
		
		return mv;
	}
	
	// The method below takes a meetup that user liked as a command object, and uses session.getAttribute to get a user in session.
	// it then calls a method through meetupDAO that adds a RSVP for meetup

	@RequestMapping(path = "RSVPMeetup.do", method = RequestMethod.GET)
	public ModelAndView RSVPMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		
		//Calling method that adds RSVP to the DB
		Meetup reservedMeetup = meetupDAO.addRSVPForMeetup(meetup, user);
		mv.setViewName("redirect:showMeetupDetails.do?id=" + reservedMeetup.getId());

		return mv;
	}
	
	// the method below adds a recipe to user's list of favorite recipes and persists the change to the DB
	@RequestMapping(path="favoriteRecipe.do", method=RequestMethod.POST)
	public ModelAndView favoriteRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = (User) session.getAttribute("loggedInUser");
		
		Recipe favoriteRecipe = recipeDAO.addRecipeToFavorites(recipe, user);
		
		mv.setViewName("redirect:userProfile.do");
		
		return mv;
		
	}
	
	// The method below adds a a liked recipe to user and vice versa in the DB.
	@RequestMapping(path="likeRecipe.do", method=RequestMethod.POST)
	public ModelAndView likeRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = (User) session.getAttribute("loggedInUser");
		
		Recipe favoriteRecipe = recipeDAO.addRecipeToLikes(recipe, user);
		
		user = userDAO.getUserById(user.getId());
		session.setAttribute("loggedInUser", user);
		mv.setViewName("redirect:showRecipeDetails.do?id=" + favoriteRecipe.getId());
		
		return mv;
	}
	
	// The method below persists a recipe comment to the database
	@RequestMapping(path="submitRecipeComment.do", method=RequestMethod.POST)
	public ModelAndView postRecipeComment(Recipe recipe, RecipeComment comment, HttpSession session) {
		recipe = recipeDAO.showRecipeById(recipe.getId());
		User author = (User) session.getAttribute("loggedInUser");
		RecipeComment recipeComment = recipeCommentDAO.postRecipeComment(recipe, comment, author );
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showRecipeDetails.do?id=" + recipeComment.getRecipeCommentedOn().getId() );
		return mv;
	}
	
	// The method below calls a meetupDAO method that persists a meetup comment to the DB
	@RequestMapping(path="submitMeetupComment.do", method=RequestMethod.POST)
	public ModelAndView postMeetupComment(Meetup meetup, MeetupComment comment, HttpSession session) {
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		User author = (User) session.getAttribute("loggedInUser");
		MeetupComment meetupComment = meetupCommentDAO.postMeetupComment(meetup, comment, author);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showMeetupDetails.do?id=" + meetupComment.getMeetupCommentedOn().getId());
		return mv;
	}
	
	// The method below sets view to a page where the user can update meetup information
	@RequestMapping(path="editMeetup.do", method=RequestMethod.GET)
	public ModelAndView editMeetup(Meetup meetup, HttpSession session ) {
		
		
		ModelAndView mv = new ModelAndView();
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		mv.addObject("meetup", meetup);
		mv.setViewName("/WEB-INF/views/editMeetup.jsp");
		return mv;
	}
	
	// The method below takes updated information of a meetup and call a meetupDAO method that persists changes in the DB
	@RequestMapping(path= "editedMeetup.do", method = RequestMethod.POST)
	public ModelAndView addedMeetup(Meetup meetup, String ldt,  Address address, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String startTime = ldt.substring(0, 10) + " " + ldt.substring(11);
		java.util.Date dt = new java.util.Date();
		// Since MySQL DateTime format is different from ISO (see the MySQL format below)
		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			// parse string into Date
			dt = sdf.parse(startTime);
			meetup.setStartTime(dt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		// if meetup is retrieved, add meetupCreated object to the ModelAndView and redirect 
		// to a page that will show details of that  meetup
		if (meetup != null) {
			
			meetup.setStartTime(dt);
			meetup = meetupDAO.updateMeetup(meetup, address);
			mv.addObject("meetupCreated", meetup);
			mv.setViewName("redirect:showMeetupDetails.do?id="+meetup.getId());
		}
		else {
			// else send the user to the edit page
			editMeetup(meetup, session);
		}
		
		//refresh the user in session
		User user = (User) session.getAttribute("loggedInUser");
		user= userDAO.getUserById(user.getId());
		session.setAttribute("loggedInUser", user);
		
		return mv;
	}
	
	
	// The method below calls a DAO method which will Set Boolean Active to FALSE. posts with value FALSE are not shown in the front.
	@RequestMapping(path="deleteMeetup.do", method = RequestMethod.POST)
	public ModelAndView deleteMeetup(User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Meetup meetup = meetupDAO.findSingleMeetup(user.getId());
		meetupDAO.setActiveToFalse(meetup);
		mv.setViewName("redirect:home.do");
		
		User currentUser = (User) session.getAttribute("loggedInUser");
		currentUser= userDAO.getUserById(currentUser.getId());
		session.setAttribute("loggedInUser", currentUser);
		
		return mv;
	}
	
	// The method below calls a DAO method which will Set Boolean Active to FALSE. posts with value FALSE are not shown in the front.
	@RequestMapping(path="deleteRecipe.do", method = RequestMethod.POST)
	public ModelAndView deleteRecipe(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Recipe recipe = recipeDAO.showRecipeById(id);
		recipeDAO.setActiveToFalse(recipe);
		mv.setViewName("redirect:home.do");
		
		User user = (User) session.getAttribute("loggedInUser");
		user= userDAO.getUserById(user.getId());
		session.setAttribute("loggedInUser", user);
		return mv;
	}
	
	//The method below will call a DAO method that persists a newely created Recipe object (taken from createRecipe.jsp) in the database
	@RequestMapping(path = "addedRecipe.do", method = RequestMethod.POST)
	public ModelAndView addedRecipe(Recipe recipe, User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Recipe newRecipe = null;
		user = (User) session.getAttribute("loggedInUser");
		if (recipe != null) {
			newRecipe = recipeDAO.createRecipe(recipe, user);
			mv.addObject("recipe", newRecipe);
			mv.setViewName("redirect:showRecipeDetails.do?id=" + newRecipe.getId());
		} else {
			mv.setViewName("WEB-INF/views/createRecipe.jsp");
		}

		return mv;

	}
	
	
}
