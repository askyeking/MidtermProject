package com.skilldistillery.recipemeetup.controllers;

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatterBuilder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class HomeController {
	
	// @Autowired autowires repository that implements  the  interface and creates an instance.
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	
	//addedMeetup method adds a meetup to the database
	@RequestMapping(path= "addedMeetup.do", method = RequestMethod.POST)
	public ModelAndView addedMeetup(Meetup meetup, String startDateTime,  Address address, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println(startDateTime);
		//String startTime  formats start dateTime provided by the user in createMeetup.jsp into a format accepted by the DB (MySQL)
		String startTime = startDateTime.substring(0, 10) + " " + startDateTime.substring(11);
		
		//Gets User currently logged in in Session
		User author = (User) session.getAttribute("loggedInUser");
		
		java.util.Date dt = new java.util.Date();
		
		//Defines the format of the DateTime in the DB
		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
			// dt parses from string into date
			dt = sdf.parse(startTime);
			
//			meetup.setStartTime(dt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		/* If meetup taken as a parameter is not null the method below will set startTime to the parsed dateTime.
		 * It will call a MeetupDAO class method which inserts a Meetup into a DB 
		 * (the method is implemented in MeetupDAOImpl and autowired to this class)
		 */
		if (meetup != null) {

			meetup.setStartTime(dt);
			meetup = meetupDAO.createMeetup(meetup, author, address);
			mv.addObject("meetupCreated", meetup);
			mv.setViewName("redirect:showMeetupDetails.do?id="+meetup.getId());
		}
		else {
			mv.setViewName("redirect:createMeetup.do");
		}
		
		return mv;
	}
	
	//The method below will send a user to the homepage
	@RequestMapping(path= "home.do", method = RequestMethod.GET)
	public ModelAndView showMore(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		
		// The homepage shows two lists (recent Meetups and recent Recipes
		// Next 4 lines get the lists from the DB and add them as objects to the ModelAndView
		List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
		List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
		mv.addObject("recentMeetup", recentMeetups);
		mv.addObject("recentRecipe", recentRecipes);
		mv.addObject("user", user);
		mv.setViewName("/WEB-INF/views/home.jsp");
		
		return mv;
				
	}
	
	// The mothod below sends a user to a page that displays all meetups
	@RequestMapping(path="showAllMeetups.do", method=RequestMethod.GET)
	public ModelAndView showAllMeetups(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		List<Meetup> allMeetups = meetupDAO.findAllMeetups();
		
		//mv.addObject adds allMeetups list as an object to the model and view with attribute name 'meetups'
		mv.addObject("meetups", allMeetups);
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		
		return mv;
		
	}
	
	//The method below adds a list of all recipes to the model and view. The list can be obtained in the front end by using ${recipes}
	@RequestMapping(path="showAllRecipes.do", method=RequestMethod.GET)
	public ModelAndView showAllRecipes(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		List<Recipe> allRecipes = recipeDAO.showMoreRecipes();
		mv.addObject("recipes", allRecipes);
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		
		return mv;
		
	}
	
	// The method below sets a view to a page where the user can insert information about a meetup they are trying to create
	@RequestMapping(path="createMeetup.do", method=RequestMethod.GET)
	public ModelAndView createMeetup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createMeetup.jsp");
		
		return mv;
		
	}
	
	// The method below sets a view to a page where the user can insert information about a recipe they are trying to create
	@RequestMapping(path="createRecipe.do", method=RequestMethod.GET)
	public ModelAndView createRecipe() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createRecipe.jsp");
		
		return mv;
		
	}
		
	// The method below takes input string from a textbox and category from a dropdown in the Navbar.jsp search form
	// The method searches for a recipe or meetup (depending on chosen category) and adds a list of that Object to the ModelAndView
	@RequestMapping(path="searchByRecipe.do", method=RequestMethod.GET)
	public ModelAndView findPostByRecipe(String input, String category, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if (category.equals("recipe")) {
			List<Recipe> recipes = recipeDAO.findRecipe(input);
			mv.addObject("recipes", recipes);
		}
		else if (category.equals("meetup")) {
			List<Meetup> meetups = meetupDAO.findMeetup(input);
			mv.addObject("meetups", meetups);
		}
		
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		return mv;
	}
	
	// The method below sets the view to a page where user can edit a Recipe
	@RequestMapping(path="editRecipe.do", method=RequestMethod.GET)
	public ModelAndView editRecipe(Recipe recipe, HttpSession session ) {
		
		ModelAndView mv = new ModelAndView();
		recipe = recipeDAO.showRecipe(recipe);
		mv.addObject("recipe", recipe);
		mv.setViewName("/WEB-INF/views/editMeetup.jsp");
		return mv;
	}
	
	//The method below takes an edited Recipe object and calls a method inside recipeDAO implementor that persists the changes.
	@RequestMapping(path= "editedRecipe.do", method = RequestMethod.POST)
	public ModelAndView editedRecipe(Recipe recipe, HttpSession session) {
		System.out.println("start of editRecipe" + recipe);
		ModelAndView mv = new ModelAndView();
		
		User author = (User) session.getAttribute("loggedInUser");
		
		
		if (recipe != null) {
			recipe = recipeDAO.updateRecipe(recipe);
			mv.addObject("recipeCreated", recipe);
			mv.setViewName("redirect:showRecipeDetails.do?id="+recipe.getId());
		}
		else {
			editRecipe(recipe, session);
		}
		
		return mv;
	}
	
}
