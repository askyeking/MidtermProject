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
	
	
<<<<<<< HEAD
	@RequestMapping(path= "home.do", method = RequestMethod.GET)
	public ModelAndView showMore(Model model, HttpSession session) {
=======
	@RequestMapping(path= "showRecentPost.do", method = RequestMethod.GET)
	public ModelAndView showMore(Model model, HttpSession session, Errors errors, User user) {
>>>>>>> 9ff97b0c6132acb7f8501a7b01aa17a611a31730
		ModelAndView mv = new ModelAndView();
		List<Meetup> recentMeetups = meetupDAO.findRecentMeetups();
		List<Recipe> recentRecipes = recipeDAO.showRecentRecipes();
		mv.addObject("recentMeetup", recentMeetups);
		mv.addObject("recentRecipe", recentRecipes);
		mv.addObject("user", user);
		mv.setViewName("/WEB-INF/views/home.jsp");
		
		return mv;
				
	}
	
}
