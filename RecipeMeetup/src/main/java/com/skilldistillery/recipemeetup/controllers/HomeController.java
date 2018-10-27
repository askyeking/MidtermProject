package com.skilldistillery.recipemeetup.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class HomeController {
	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	
	
	@RequestMapping(path= "home.do", method = RequestMethod.GET)
	public ModelAndView showMore(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
		List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
		mv.addObject("recentMeetup", recentMeetups);
		mv.addObject("recentRecipe", recentRecipes);
		mv.addObject("user", user);
		mv.setViewName("/WEB-INF/views/home.jsp");
		
		return mv;
				
	}
	
	@RequestMapping(path="showAllMeetups.do", method=RequestMethod.GET)
	public ModelAndView showAllMeetups(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		List<Meetup> allMeetups = meetupDAO.findAllMeetups();
		mv.addObject("meetups", allMeetups);
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		
		return mv;
		
	}
	
	@RequestMapping(path="showAllRecipes.do", method=RequestMethod.GET)
	public ModelAndView showAllRecipes(Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		List<Recipe> allRecipes = recipeDAO.showMoreRecipes();
		mv.addObject("recipes", allRecipes);
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		
		return mv;
		
	}
	
	@RequestMapping(path="createMeetup.do", method=RequestMethod.POST)
	public ModelAndView createMeetup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createMeetup.jsp");
		
		return mv;
		
	}
	
	@RequestMapping(path="createRecipe.do", method=RequestMethod.POST)
	public ModelAndView createRecipe() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createRecipe.jsp");
		
		return mv;
		
	}
	
	/*@RequestMapping(path="createMeetup.do", method=RequestMethod.POST)
	public ModelAndView postMeetup(Meetup meetup, Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		Meetup newMeetup = meetupDAO.createMeetup(meetup);
		mv.addObject("meetup", newMeetup);
		mv.setViewName("/WEB-INF/views/home.jsp");
		
		return mv;
		
	}
	
	@RequestMapping(path="createRecipe.do", method=RequestMethod.POST)
	public ModelAndView postRecipe(Recipe recipe, Model model, HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		Recipe newRecipe = recipeDAO.createRecipe(recipe);
		mv.addObject("recipe", newRecipe);
		mv.setViewName("/WEB-INF/views/home.jsp");
		
		return mv;
		
	}*/

	
}
