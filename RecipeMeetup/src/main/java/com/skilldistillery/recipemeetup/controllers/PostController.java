package com.skilldistillery.recipemeetup.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.entities.User;

public class PostController {

	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	
	
	
	
	@RequestMapping()
	public ModelAndView showRecipe(HttpSession session, User user) {
		ModelAndView mv = new ModelAndView();
		
		
		
		return mv;
		
	}
	
	
	
	
	
	
}
