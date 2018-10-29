package com.skilldistillery.recipemeetup.controllers;

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
		mv.addObject("testBoolean" , new Boolean(true));
		mv.addObject("recipe", recipeDAO.showRecipeById(recipe.getId()));
		mv.addObject("listOfComments", recipeCommentDAO.showAllRecipeComments(recipe.getId()));
		mv.setViewName("/WEB-INF/views/recipe.jsp");
		return mv;
	}
	
	@RequestMapping(path="showMeetupDetails.do", method=RequestMethod.GET)
	public ModelAndView showMeetup(Meetup meetup, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("meetup",meetupDAO.findSingleMeetup(meetup.getId()));
		mv.addObject("listOfComments", meetupCommentDAO.showAllMeetupComments(meetup.getId()));
		mv.setViewName("/WEB-INF/views/meetup.jsp");
		
		return mv;
	}
	
	@RequestMapping(path="submitRecipeComment.do", method=RequestMethod.POST)
	public ModelAndView postRecipeComment(Model model, RecipeComment comment, User author, HttpSession session) {
//		ModelAndView mv = new ModelAndView();
		RecipeComment recipeComment = recipeCommentDAO.postRecipeComment(comment, author);
//		mv.addObject("recipeComment", recipeComment);
//		mv.setViewName("/WEB-INF/views/recipe.jsp");
		return showRecipe(comment.getRecipeCommentedOn(), session);		
	}
	
	@RequestMapping(path="submitMeetupComment.do", method=RequestMethod.POST)
	public ModelAndView postMeetupComment(@RequestParam("id") int id, Model model, MeetupComment comment, User author, HttpSession session) {
//		System.out.println("******** MY ID IS: " + id + "****************");
		MeetupComment meetupComment = meetupCommentDAO.postMeetupComment(comment, author);
		ModelAndView mv = new ModelAndView();
		mv.addObject("meetup", meetupDAO.findSingleMeetup(meetupComment.getMeetupCommentedOn().getId()));
		mv.addObject("listOfComments", meetupCommentDAO.showAllMeetupComments(id));
		mv.setViewName("/WEB-INF/views/meetup.jsp");
		return mv;
//		return showMeetup(comment.getMeetupCommentedOn(), session);
		
	}
	
	
}
