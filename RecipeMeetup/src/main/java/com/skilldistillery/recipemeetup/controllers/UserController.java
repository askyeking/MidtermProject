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

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public ModelAndView homePage(@RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User validUser = userDAO.isLegitimateUsername(username);
		if (validUser != null && validUser.getActive()) {

			User user = userDAO.loginUser(username, password);

			if (user != null) {
				boolean loggedIn = true;
				session.setAttribute("loggedIn", loggedIn);
				session.setAttribute("loggedInUser", user);
				mv.addObject("user", user);
			}else {
//				errors.rejectValue("user", "error.password");
				
			}
		} else {
//			errors.rejectValue("user", "error.username");

		}

		mv.setViewName("WEB-INF/views/home.jsp");
		return mv;

	}

}
