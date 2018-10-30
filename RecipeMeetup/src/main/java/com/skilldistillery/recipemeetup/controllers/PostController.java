package com.skilldistillery.recipemeetup.controllers;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.recipemeetup.data.MeetupCommentDAO;
import com.skilldistillery.recipemeetup.data.MeetupDAO;
import com.skilldistillery.recipemeetup.data.RecipeCommentDAO;
import com.skilldistillery.recipemeetup.data.RecipeDAO;
import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.RecipeComment;
import com.skilldistillery.recipemeetup.entities.User;


@Controller
public class PostController {

	
	@Autowired
	private MeetupDAO meetupDAO;
	@Autowired
	private RecipeDAO recipeDAO;
	@Autowired
	private RecipeCommentDAO recipeCommentDAO;
	@Autowired
	private MeetupCommentDAO meetupCommentDAO;
	
	
	
	@RequestMapping(path="showRecipeDetails.do", method=RequestMethod.GET)
	public ModelAndView showRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Boolean canEdit = new Boolean(false);
		
		recipe = recipeDAO.showRecipe(recipe);
		User currentUser = (User) session.getAttribute("loggedInUser");
		
		if ((recipe.getRecipeOwner().getId() == currentUser.getId()) || currentUser.getAdmin()) {
			canEdit = true;
		}
		mv.addObject("canEditPost" , canEdit);
		mv.addObject("recipe", recipeDAO.showRecipeById(recipe.getId()));
		mv.addObject("listOfComments", recipeCommentDAO.showAllRecipeComments(recipe.getId()));
		mv.setViewName("/WEB-INF/views/recipe.jsp");
		return mv;
	}
	
	
	@RequestMapping(path="showMeetupDetails.do", method=RequestMethod.GET)
	public ModelAndView showMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Boolean canEdit = new Boolean(false);
		
		meetup = meetupDAO.showMeetup(meetup);
		User currentUser = (User) session.getAttribute("loggedInUser");
		System.out.println(meetup.getMeetupOwner().getId());
		System.out.println(currentUser.getId());
		if((meetup.getMeetupOwner().getId() == currentUser.getId()) || currentUser.getAdmin()) {
			canEdit = true;
		}
		List<User> meetupAttendees = meetup.getAttendees();
		User meetupOwner = meetup.getMeetupOwner();
		
		mv.addObject("meetupOwner", meetupOwner);
		mv.addObject("listOfAttendees", meetupAttendees);
		mv.addObject("canEditPost" , canEdit);
		mv.addObject("meetup",meetupDAO.findSingleMeetup(meetup.getId()));
		mv.addObject("listOfComments", meetupCommentDAO.showAllMeetupComments(meetup.getId()));
		mv.setViewName("/WEB-INF/views/meetup.jsp");
		
		return mv;
	}
	
	@RequestMapping(path = "RSVPMeetup.do", method = RequestMethod.POST)
	public ModelAndView RSVPMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		Meetup reservedMeetup = meetupDAO.addRSVPForMeetup(meetup, user);
		mv.setViewName("redirect:showMeetupDetails.do?id=" + reservedMeetup.getId());

		return mv;
	}
	
	@RequestMapping(path="favoriteRecipe.do", method=RequestMethod.POST)
	public ModelAndView favoriteRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = (User) session.getAttribute("loggedInUser");
		
		Recipe favoriteRecipe = recipeDAO.addRecipeToFavorites(recipe, user);
		
		mv.setViewName("redirect:userProfile.do");
		
		return mv;
		
	}
	
	@RequestMapping(path="likeRecipe.do", method=RequestMethod.POST)
	public ModelAndView likeRecipe(Recipe recipe, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = (User) session.getAttribute("loggedInUser");
		
		Recipe favoriteRecipe = recipeDAO.addRecipeToLikes(recipe, user);
		
		mv.setViewName("redirect:userProfile.do");
		
		return mv;
	}
	
	@RequestMapping(path="submitRecipeComment.do", method=RequestMethod.POST)
	public ModelAndView postRecipeComment(Recipe recipe, RecipeComment comment, HttpSession session) {
		recipe = recipeDAO.showRecipeById(recipe.getId());
		User author = (User) session.getAttribute("loggedInUser");
		RecipeComment recipeComment = recipeCommentDAO.postRecipeComment(recipe, comment, author );
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showRecipeDetails.do?id=" + recipeComment.getRecipeCommentedOn().getId() );
		return mv;
	}
	
	@RequestMapping(path="submitMeetupComment.do", method=RequestMethod.POST)
	public ModelAndView postMeetupComment(Meetup meetup, MeetupComment comment, HttpSession session) {
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		User author = (User) session.getAttribute("loggedInUser");
		MeetupComment meetupComment = meetupCommentDAO.postMeetupComment(meetup, comment, author);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showMeetupDetails.do?id=" + meetupComment.getMeetupCommentedOn().getId());
		return mv;
	}
	
	@RequestMapping(path="editMeetup.do", method=RequestMethod.GET)
	public ModelAndView editMeetup(Meetup meetup, HttpSession session ) {
		System.out.println(meetup);
		
		
		ModelAndView mv = new ModelAndView();
		meetup = meetupDAO.findSingleMeetup(meetup.getId());
		System.out.println(meetup);
		mv.addObject("meetup", meetup);
		mv.setViewName("/WEB-INF/views/editMeetup.jsp");
		return mv;
	}
	
	@RequestMapping(path= "editedMeetup.do", method = RequestMethod.POST)
	public ModelAndView addedMeetup(Meetup meetup, String ldt,  Address address, HttpSession session) {
		System.out.println("start of addedMeetup" + address);
//		System.out.println("In Controller");
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
//			meetup = meetupDAO.createMeetup(meetup, author, address);
			meetup = meetupDAO.updateMeetup(meetup, address);
			mv.addObject("meetupCreated", meetup);
			mv.setViewName("redirect:showMeetupDetails.do?id="+meetup.getId());
		}
		else {
			editMeetup(meetup, session);
		}
		
		return mv;
	}
	
	
}
