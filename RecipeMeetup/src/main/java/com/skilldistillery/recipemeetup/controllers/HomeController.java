package com.skilldistillery.recipemeetup.controllers;

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatterBuilder;
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
	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	
	
	@RequestMapping(path= "addedMeetup.do", method = RequestMethod.POST)
	public ModelAndView addedMeetup(Meetup meetup, String ldt,  Address address, HttpSession session) {
		System.out.println("In Controller");
		ModelAndView mv = new ModelAndView();
		String startTime = ldt.substring(0, 10) + " " + ldt.substring(11);
		
		User author = (User) session.getAttribute("loggedInUser");
		
		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
//			System.out.println(startDate); System.out.println(startTime);
			dt = sdf.parse(startTime);
			meetup.setStartTime(dt);
		} catch (ParseException e) {
			System.out.println("excepton on date parsing");
			e.printStackTrace();
		}
		
		
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
	
	//add session in method????
	@RequestMapping(path="createMeetup.do", method=RequestMethod.GET)
	public ModelAndView createMeetup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createMeetup.jsp");
		
		return mv;
		
	}
	
	//add session in method????
	@RequestMapping(path="createRecipe.do", method=RequestMethod.GET)
	public ModelAndView createRecipe() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/views/createRecipe.jsp");
		
		return mv;
		
	}
		
	@RequestMapping(path="searchByRecipe.do", method=RequestMethod.GET)
	public ModelAndView findPostByRecipe(String input, String category, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println("Input " + input);
		System.out.println("Category " + category);
		
		if (category.equals("recipe")) {
			List<Recipe> recipes = recipeDAO.findRecipe(input);
			mv.addObject("recipes", recipes);
			System.out.println(recipes.size());
		}
		else if (category.equals("meetup")) {
			List<Meetup> meetups = meetupDAO.findMeetup(input);
			mv.addObject("meetups", meetups);
			System.out.println("MEETUP LIST SIZE" + meetups.size());
		}
		
		
		mv.setViewName("/WEB-INF/views/showAll.jsp");
		return mv;
	}
	
//	@RequestMapping(path="deleteRecipe.do", method=RequestMethod.GET)
//	public ModelAndView deleteRecipe(Recipe recipe, HttpSession session) {
//		ModelAndView mv = new ModelAndView();
//		
//		
//		return null;
//		
//	}
	
//	@RequestMapping(path="addedMeetup.do", method=RequestMethod.POST)
//	public ModelAndView postMeetup(Meetup meetup, Model model, HttpSession session, User user, Address address) {
//		ModelAndView mv = new ModelAndView();
//		Meetup newMeetup = meetupDAO.createMeetup(meetup, user, address);
//		mv.addObject("meetup", newMeetup);
//		mv.setViewName("/WEB-INF/views/home.jsp");
//		
//		return mv;
//		
//	}
//	
//	@RequestMapping(path="addedRecipe.do", method=RequestMethod.POST)
//	public ModelAndView postRecipe(Recipe recipe, Model model, HttpSession session, User user) {
//		ModelAndView mv = new ModelAndView();
//		Recipe newRecipe = recipeDAO.createRecipe(recipe);
//		mv.addObject("recipe", newRecipe);
//		mv.setViewName("/WEB-INF/views/home.jsp");
//		
//		return mv;
//		
//	}

	
}
