package com.skilldistillery.recipemeetup.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.UserDAO;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDAO;

	@RequestMapping(path = "index.do")
	public String index() {
		return "WEB-INF/views/login.jsp";

	}

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public ModelAndView homePage(@RequestParam(value = "username") String username, 
			                     @RequestParam(value = "password") String password,
			                     HttpSession session, Errors errors) {
		ModelAndView mv = new ModelAndView();
		
		User user = userDAO.loginUser(username, password);

//		if (loggedInUser == null) {
//			
//		} else {
//			errors.rejectValue("user", "error.username", "Invalid Username");
//		}
		boolean loggedIn = true;
		session.setAttribute("loggedIn", loggedIn);
		mv.addObject("user", user);
		mv.setViewName("WEB-INF/views/home.jsp");

		return mv;

	}

}
