package com.skilldistillery.recipemeetup.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

public class PostController {

	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	
	
	
	
	@RequestMapping(path="showRecipeDetails.do", method=RequestMethod.GET)
	public ModelAndView showRecipe(Recipe recipe, HttpSession session, User user ) {
		ModelAndView mv = new ModelAndView();
		mv.addObject(user);
		mv.addObject(recipeDAO.showRecipeById(recipe.getId()));
		mv.setViewName("/WEB-INF/view/recipe.jsp");
		return mv;
	}
	
	@RequestMapping(path="showMeetupDetails.do", method=RequestMethod.GET)
	public ModelAndView showMeetup(Meetup meetup, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject(user);
		mv.addObject(meetupDAO.findSingleMeetup(meetup.getId()));
		mv.setViewName("/WEB-INF/view/meetup.jsp");
		return mv;
	}
	
	
	
	
	
}
