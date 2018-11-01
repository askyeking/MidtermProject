package com.skilldistillery.recipemeetup.controllers;

import java.text.ParseException;
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
		
		System.out.println("***************************************");
		System.out.println(user.getImgURL());

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
		mv.setViewName("WEB-INF/views/profilePage.jsp");
		return mv;
	}

	@RequestMapping(path = "addedRecipe.do", method = RequestMethod.POST)
	public ModelAndView addedRecipe(Recipe recipe, User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Recipe newRecipe = null;
		user = (User) session.getAttribute("loggedInUser");
		if (recipe != null) {
			System.out.println("***************************************");
			System.out.println(recipe.getImgURL());
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
	
	@RequestMapping(path="edituser.do", method=RequestMethod.GET)
	public ModelAndView editUser(HttpSession session ) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		
		mv.addObject("user", user);
		mv.setViewName("/WEB-INF/views/editUser.jsp");
		return mv;
	}

	
	
	
	
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
	
	//Add SetActiveToFalse for comments
	@RequestMapping(path="deleteUser.do", method = RequestMethod.POST)
	public ModelAndView deleteUser(int id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = userDAO.getUserById(id);
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
		mv.setViewName("redirect:index.do");
		
		return mv;
	}
	

	

}
