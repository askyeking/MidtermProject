package com.skilldistillery.recipemeetup.controllers;

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
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;


@Controller
public class PostController {

	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	@Autowired
	private RecipeCommentDAO recipeCommentDAO;
	@Autowired
	private MeetupCommentDAO meetupCommentDAO;
	
	
	
	
	@RequestMapping(path="showRecipeDetails.do", method=RequestMethod.GET)
	public ModelAndView showRecipe(Recipe recipe, HttpSession session, User user ) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("loggedInUser" , session.getAttribute("loggedInUser"));
		mv.addObject("recipe", recipeDAO.showRecipeById(recipe.getId()));
		mv.addObject("listOfComments", recipeCommentDAO.showAllRecipeComments());
		mv.setViewName("/WEB-INF/views/recipe.jsp");
		return mv;
	}
	
	@RequestMapping(path="showMeetupDetails.do", method=RequestMethod.GET)
	public ModelAndView showMeetup(Meetup meetup, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("loggedInUser", session.getAttribute("loggedInUser"));
		mv.addObject("meetup",meetupDAO.findSingleMeetup(meetup.getId()));
		mv.addObject("listOfComments", meetupCommentDAO.showAllMeetupComments());

		mv.setViewName("/WEB-INF/views/meetup.jsp");
		return mv;
	}
	
	
	
	
	
}
