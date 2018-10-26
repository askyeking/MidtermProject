package com.skilldistillery.recipemeetup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.UserDAO;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDAO;
	
	
	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public ModelAndView homePage(User user) {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("user", user);
		mv.setViewName("WEB-INF/views/home.jsp");
		
		return null;
		
	}
	

}
