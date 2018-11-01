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
		System.out.println(meetup.getMeetupOwner().getId());
		System.out.println(currentUser.getId());
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
	
	@RequestMapping(path = "RSVPMeetup.do", method = RequestMethod.POST)
	public ModelAndView RSVPMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		Meetup reservedMeetup = meetupDAO.addRSVPForMeetup(meetup, user);
		mv.setViewName("redirect:showMeetupDetails.do?id=" + reservedMeetup.getId());

		return mv;
	}
	
	@RequestMapping(path="favoriteRecipe.do", method=RequestMethod.POST)
	public ModelAndView favoriteRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = (User) session.getAttribute("loggedInUser");
		
		Recipe favoriteRecipe = recipeDAO.addRecipeToFavorites(recipe, user);
		
		mv.setViewName("redirect:userProfile.do");
		
		return mv;
		
	}
	
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
	
	@RequestMapping(path="submitRecipeComment.do", method=RequestMethod.POST)
	public ModelAndView postRecipeComment(Recipe recipe, RecipeComment comment, HttpSession session) {
		recipe = recipeDAO.showRecipeById(recipe.getId());
		User author = (User) session.getAttribute("loggedInUser");
		RecipeComment recipeComment = recipeCommentDAO.postRecipeComment(recipe, comment, author );
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showRecipeDetails.do?id=" + recipeComment.getRecipeCommentedOn().getId() );
		return mv;
	}
	
	@RequestMapping(path="submitMeetupComment.do", method=RequestMethod.POST)
	public ModelAndView postMeetupComment(Meetup meetup, MeetupComment comment, HttpSession session) {
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		User author = (User) session.getAttribute("loggedInUser");
		MeetupComment meetupComment = meetupCommentDAO.postMeetupComment(meetup, comment, author);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showMeetupDetails.do?id=" + meetupComment.getMeetupCommentedOn().getId());
		return mv;
	}
	
	@RequestMapping(path="editMeetup.do", method=RequestMethod.GET)
	public ModelAndView editMeetup(Meetup meetup, HttpSession session ) {
		System.out.println(meetup);
		
		
		ModelAndView mv = new ModelAndView();
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		System.out.println(meetup);
		mv.addObject("meetup", meetup);
		mv.setViewName("/WEB-INF/views/editMeetup.jsp");
		return mv;
	}
	
	@RequestMapping(path= "editedMeetup.do", method = RequestMethod.POST)
	public ModelAndView addedMeetup(Meetup meetup, String ldt,  Address address, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String startTime = ldt.substring(0, 10) + " " + ldt.substring(11);
		
		User author = (User) session.getAttribute("loggedInUser");
		
		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
			dt = sdf.parse(startTime);
			meetup.setStartTime(dt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		
		if (meetup != null) {
			meetup.setStartTime(dt);
			meetup = meetupDAO.updateMeetup(meetup, address);
			mv.addObject("meetupCreated", meetup);
			mv.setViewName("redirect:showMeetupDetails.do?id="+meetup.getId());
		}
		else {
			editMeetup(meetup, session);
		}
		
		User user = (User) session.getAttribute("loggedInUser");
		user= userDAO.getUserById(user.getId());
		session.setAttribute("loggedInUser", user);
		
		return mv;
	}
	
	@RequestMapping(path="deleteMeetup.do", method = RequestMethod.POST)
	public ModelAndView deleteMeetup(User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Meetup meetup = meetupDAO.findSingleMeetup(user.getId());
		meetupDAO.setActiveToFalse(meetup);
		mv.setViewName("redirect:showMeetupDetails.do?id=" + meetup.getId());
		
		User currentUser = (User) session.getAttribute("loggedInUser");
		currentUser= userDAO.getUserById(currentUser.getId());
		session.setAttribute("loggedInUser", currentUser);
		
		return mv;
	}
	@RequestMapping(path="deleteRecipe.do", method = RequestMethod.POST)
	public ModelAndView deleteRecipe(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Recipe recipe = recipeDAO.showRecipeById(id);
		recipeDAO.setActiveToFalse(recipe);
		mv.setViewName("redirect:showRecipeDetails.do?id=" + recipe.getId());
		
		User user = (User) session.getAttribute("loggedInUser");
		user= userDAO.getUserById(user.getId());
		session.setAttribute("loggedInUser", user);
		return mv;
	}
	
	
}
