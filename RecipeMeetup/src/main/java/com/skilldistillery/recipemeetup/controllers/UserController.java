package com.skilldistillery.recipemeetup.controllers;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public ModelAndView loginPage(@RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, HttpSession session, ModelMap model) {
		ModelAndView mv = new ModelAndView();
		
		User user = null;
		try {
			User validUser = userDAO.isLegitimateUsername(username);

			if (validUser != null && validUser.getActive()) {
				try {
					user = userDAO.loginUser(username, password);

				} catch (NoResultException e) {
					mv.setViewName("WEB-INF/views/login.jsp");
					return mv;
				}

				if (user != null) {
					boolean loggedIn = true;
					session.setAttribute("loggedIn", loggedIn);
					session.setAttribute("loggedInUser", user);
					model.addAttribute("user", user);
//					mv.addObject("user", user);
//					mv.setViewName("redirect:home.do");
					return new ModelAndView("redirect:home.do", model);
				}
			}

		} catch (NoResultException e) {
			mv.setViewName("WEB-INF/views/login.jsp");
			return mv;
		}
		
		mv.setViewName("WEB-INF/views/login.jsp");
		return mv;

	}

	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public ModelAndView homePage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("WEB-INF/views/home.jsp");
		return mv;
	}

//	@RequestMapping(path="register.do" method = RequestMethod)

}
