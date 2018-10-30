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
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.data.UserDAO;
import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class UserController {
	private boolean loggedIn;

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private MeetupCommentDAO meetupCommentDAO;

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

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public ModelAndView loginPage(User user, Errors error, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		User validUser = null;
		validUser = userDAO.isLegitimateUsername(user);

		if (validUser != null && validUser.getActive()) {
			validUser = null;
			try {
				validUser = userDAO.loginUser(user);
			} catch (NoResultException e) {
			}
			if (validUser != null) {
				loggedIn = true;
				session.setAttribute("loggedIn", loggedIn);
				session.setAttribute("loggedInUser", validUser);
				mv.setViewName("redirect:home.do");
			} else {
				error.rejectValue("password", "error.password", "error message");
				mv.setViewName("WEB-INF/views/login.jsp");
			}

		}

		else {
			error.rejectValue("username", "error.username", "error message");
			mv.setViewName("WEB-INF/views/login.jsp");
		}

		return mv;
	}

	@RequestMapping(path = "registrationLink.do", method = RequestMethod.GET)
	private String registrationPage(HttpSession session) {
		return "WEB-INF/views/register.jsp";
	}

	@RequestMapping(path = "register.do", method = RequestMethod.POST)
	public ModelAndView Register(User user, Address address, Errors error, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		User isUserValid = userDAO.isLegitimateUsername(user);

		if (isUserValid != null) {
			error.rejectValue("username", "error.username", "error message");
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

	@RequestMapping(path = "userProfile.do", method = RequestMethod.GET)
	public ModelAndView showProfile(HttpSession session) {
		ModelAndView mv = new ModelAndView();
//		User activeUser = (User) session.getAttribute("loggedInUser");
//		mv.addObject(activeUser);
		mv.setViewName("WEB-INF/views/profilePage.jsp");
		return mv;
	}

	@RequestMapping(path = "addedRecipe.do", method = RequestMethod.POST)
	public ModelAndView addedRecipe(Recipe recipe, User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Recipe newRecipe = null;
		user = (User) session.getAttribute("loggedInUser");
		if (recipe != null) {
			System.out.println(recipe);
			System.out.println(recipeDAO);
			newRecipe = recipeDAO.createRecipe(recipe, user);
			mv.addObject("recipe", newRecipe);
			mv.setViewName("WEB-INF/views/recipe.jsp");
		} else {
			mv.setViewName("WEB-INF/views/createRecipe.jsp");
		}

		return mv;

	}

	@RequestMapping(path = "viewOtherProfile.do", method = RequestMethod.GET)
	public ModelAndView viewOtherProfile(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User newUser = userDAO.getUserById(id);
		mv.addObject("user", newUser);
		mv.setViewName("/WEB-INF/views/otherUserProfile.jsp");
		return mv;
	}

	@RequestMapping(path = "RSVPMeetup.do", method = RequestMethod.POST)
	public ModelAndView RSVPMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println("***************");
//		Meetup reservedMeetup = meetupDAO.findSingleMeetup(meetup.getId());
//		List<User> attendees = reservedMeetup.getAttendees();
		User user = (User) session.getAttribute("loggedInUser");
		Meetup reservedMeetup = meetupDAO.addRSVPForMeetup(meetup, user);
		System.out.println("***************");

//		List<MeetupComment> listOfComments = meetupCommentDAO.showAllMeetupComments(reservedMeetup.getId());
//		mv.addObject("listOfAttendees", attendees);
//		mv.addObject("meetup", reservedMeetup);
//		mv.addObject("listOfComments", listOfComments);
//		mv.addObject("user", user);
		mv.setViewName("redirect:showMeetupDetails.do?id=" + reservedMeetup.getId());
		System.out.println("***************");

		return mv;
	}

}
