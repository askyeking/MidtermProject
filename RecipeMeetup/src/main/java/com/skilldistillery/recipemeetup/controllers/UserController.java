package com.skilldistillery.recipemeetup.controllers;

import java.util.List;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
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
public class UserController {
	private boolean loggedIn;
	
	// Autowires repositories so that making instances of DAO implementing classes is unnecessary.
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	@Autowired
	private RecipeCommentDAO recipeCommentDAO;
	@Autowired
	private MeetupCommentDAO meetupCommentDAO;
	
	// The method below sends a user to the login page, and adds a list of recent Recipes and recently added Meetups to the model
	@RequestMapping(path = "index.do")
	public ModelAndView index() {
		List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
		List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
		ModelAndView mv = new ModelAndView();
		mv.addObject("recentRecipes", recentRecipes);
		mv.addObject("recentMeetups", recentMeetups);
		mv.setViewName("WEB-INF/views/login.jsp");

		return mv;

	}

	// The method below  selects a user from a database if username and password match an existing user in the DB
	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public ModelAndView loginPage(User user, Errors error, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		
		User validUser = null;
		
		// userDAO.isLegitimateUsername returns a user object if there is a user with a matching usrename in the database
		validUser = userDAO.isLegitimateUsername(user);

		
		// if validUser was returned, password is checked in the userDAO.loginUser(user) method. Else an error is printed.
		if (validUser != null && validUser.getActive()) {
			validUser = null;
			try {
				validUser = userDAO.loginUser(user);
			} catch (NoResultException e) {
			}
			// if valid user, set loggedInUser attribute to that user. Lasts for the duration of the session.
			if (validUser != null) {
				loggedIn = true;
				session.setAttribute("loggedIn", loggedIn);
				session.setAttribute("loggedInUser", validUser);
				mv.setViewName("redirect:home.do");
			} else {
				// if password is wrong, print error
				error.rejectValue("password", "error.password", "error message");
				List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
				List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
				mv.addObject("recentRecipes", recentRecipes);
				mv.addObject("recentMeetups", recentMeetups);
				mv.setViewName("WEB-INF/views/login.jsp");
			}

		}

		else {
			// If username is non-existent, reject value with an error
			error.rejectValue("username", "error.username", "error message");
			List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
			List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
			mv.addObject("recentRecipes", recentRecipes);
			mv.addObject("recentMeetups", recentMeetups);
			mv.setViewName("WEB-INF/views/login.jsp");
		}

		return mv;
	}

	// the method below will send a user to the page where they can create an account.
	@RequestMapping(path = "registrationLink.do", method = RequestMethod.GET)
	private String registrationPage(HttpSession session) {
		return "WEB-INF/views/register.jsp";
	}

	// The method below will persist a newly created user object (taken as a parameter), and user's address to the database.
	@RequestMapping(path = "register.do", method = RequestMethod.POST)
	public ModelAndView Register(User user, Address address, Errors error, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User isUserValid = userDAO.isLegitimateUsername(user);
		
		if (isUserValid != null) {
			mv.setViewName("WEB-INF/views/register.jsp");
		} else {
			
			user = userDAO.createUser(user, address);
			mv.addObject("user", user);
			loggedIn = true;
			session.setAttribute("loggedIn", loggedIn);
			session.setAttribute("loggedInUser", user);
			
			mv.setViewName("redirect:home.do");
		}

		return mv;
	}
	
	// The method below lets sets a view to user's profile page
	@RequestMapping(path = "userProfile.do", method = RequestMethod.GET)
	public ModelAndView showProfile(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("WEB-INF/views/profilePage.jsp");
		return mv;
	}


	//The method below lets a user view a profile of another user. it takes an int id which is used to identify the user who's info will be viewed;
	// If a user viewing the profile is an admin or the account owner, they can chose to deactivate profile, as the Boolean pushed to the front-end is true;
	@RequestMapping(path = "viewOtherProfile.do", method = RequestMethod.GET)
	public ModelAndView viewOtherProfile(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User userViewed = userDAO.getUserById(id);
		User currentUser = (User) session.getAttribute("loggedInUser");
		
		Boolean canEditProfile = new Boolean(false);		
		
		if ((userViewed.getId() == currentUser.getId()) || currentUser.getAdmin()) {
			canEditProfile = true;
		}

		mv.addObject("user", userViewed);
		mv.addObject("canEditProfile", canEditProfile);
		mv.setViewName("/WEB-INF/views/otherUserProfile.jsp");
		return mv;
	}
	
	// The method below will logout a user (the user in session is removed). 
	@RequestMapping(path="logout.do", method=RequestMethod.GET)
	public ModelAndView logout(User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		user = (User) session.getAttribute("loggedInUser");
		session.removeAttribute("loggedInUser");
		session.invalidate();
		List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
		List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
		mv.addObject("recentMeetups", recentMeetups);
		mv.addObject("recentRecipes", recentRecipes);
		mv.setViewName("WEB-INF/views/login.jsp");
		return mv;	
	}
	
	// The method below will send user to a page where they can edit their information
	@RequestMapping(path="edituser.do", method=RequestMethod.GET)
	public ModelAndView editUser(HttpSession session ) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		
		mv.addObject("user", user);
		mv.setViewName("/WEB-INF/views/editUser.jsp");
		return mv;
	}

	
	
	
	// The method below will submit changes made in users to the database by calling userDAO.updateUser method and passing in updated user and address information.
	@RequestMapping(path= "editedUser.do", method = RequestMethod.POST)
	public ModelAndView editedUser(User user, Address address, HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		
		if (user != null) {
			user = userDAO.updateUser(user, address);
			System.out.println(user.equals(session.getAttribute("loggedInUser")));
			if(user.equals(session.getAttribute("loggedInUser"))) {
			session.setAttribute("loggedInUser", user);
			}
			mv.setViewName("redirect:userProfile.do?id="+user.getId());
		}
		else {
			editUser(session);
		}
		
		return mv;
	}
	
	// The method below will set user account to inactive. 
	// In addition, the method will call DAO methods that will set all recipes, meetups and comments the user posted to inactive;
	@RequestMapping(path="deleteUser.do", method = RequestMethod.GET)
	public ModelAndView deleteUser(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = userDAO.getUserById(id);
		User currentUser = (User) session.getAttribute("loggedInUser");
		
		List<Recipe> recipesPosted = user.getRecipesPosted();
		List<Meetup> meetupsPosted = user.getMeetupsOwned();
		
		List<RecipeComment> recipeCommentsPosted = user.getRecipeComments();
		List<MeetupComment> meetupCommentsPosted = user.getMeetupCommentsPosted();
		
		
		for (Meetup meetup : meetupsPosted) {
			meetupDAO.setActiveToFalse(meetup);
		}
		
		for (Recipe recipe2 : recipesPosted) {
			recipeDAO.setActiveToFalse(recipe2);
		}
		
		for (MeetupComment meetupComment : meetupCommentsPosted) {
			meetupCommentDAO.setActiveToFalse(meetupComment);
		}
		
		for (RecipeComment recipeComment : recipeCommentsPosted) {
			recipeCommentDAO.setActiveToFalse(recipeComment);
		}
		
		
		userDAO.setActiveToFalse(user);
		
		session.setAttribute("loggedInUser", user);
		
		
		if(currentUser.getAdmin()) {
			mv.setViewName("redirect:home.do");
		}
		else {
			mv.setViewName("redirect:index.do");
		}
		
		return mv;
	}
	

	

}
