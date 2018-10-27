package com.skilldistillery.recipemeetup.controllers;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.recipemeetup.data.UserDAO;
import com.skilldistillery.recipemeetup.entities.User;

@Controller
public class UserController {
	private boolean loggedIn;

	@Autowired
	private UserDAO userDAO;

	@RequestMapping(path = "index.do")
	public String index() {
		return "WEB-INF/views/login.jsp";

	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public ModelAndView loginPage( User user,Errors error, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		System.out.println(user.getUsername());
//			User user = null;
		User validUser = null;
		try {
		validUser = userDAO.isLegitimateUsername(user.getUsername());
		}
		catch(NoResultException e) {
		}

		if (validUser != null && validUser.getActive()) {
			validUser = null;
			try {
			validUser = userDAO.loginUser(user);
			}
			catch (NoResultException e) {
			}
			if (validUser != null) {
				loggedIn = true;
				session.setAttribute("loggedIn", loggedIn);
				session.setAttribute("loggedInUser", validUser);
//				model.addAttribute("user", validUser);
//						mv.addObject("user", user);
//						mv.setViewName("redirect:home.do");
				mv.setViewName("redirect:home.do");
			} else {
				error.rejectValue("password", "error.password", "error message");
				mv.setViewName("WEB-INF/views/login.jsp");
			}

		}

		else {
			error.rejectValue("username", "error.username", "error message 2");
			mv.setViewName("WEB-INF/views/login.jsp");
		}
		
		return mv;
	}

	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("WEB-INF/views/home.jsp");
		return mv;
	}

	@RequestMapping(path = "registrationLink.do", method = RequestMethod.GET)
	public ModelAndView Register(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("WEB-INF/views/register.jsp");
		return mv;
	}
}
