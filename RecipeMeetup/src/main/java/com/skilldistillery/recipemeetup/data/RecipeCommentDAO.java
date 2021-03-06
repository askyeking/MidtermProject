package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.RecipeComment;
import com.skilldistillery.recipemeetup.entities.User;

public interface RecipeCommentDAO {
	
	RecipeComment postRecipeComment(Recipe recipe, RecipeComment comment, User author);
	List<RecipeComment> showAllRecipeComments(int id);
	RecipeComment editRecipeComment(RecipeComment updateComment, User author);
	boolean deleteRecipeComment(RecipeComment comment, User author);
	boolean deleteRecipeCommentById(int id);
	RecipeComment setActiveToFalse(RecipeComment recipeComment);
	

}
