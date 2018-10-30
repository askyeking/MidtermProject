package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

public interface RecipeDAO {
	
	Recipe createRecipe(Recipe recipe, User user);
	Recipe showRecipe(Recipe recipe);
	List<Recipe> showMoreRecipes();
	List<Recipe> showRecentRecipes();
	Recipe updateRecipe(Recipe updateRecipe);
	boolean deleteRecipe(Recipe recipe);
	boolean deleteRecipeById(int id);
	boolean isRecipeActive(Recipe recipe);
	Recipe showRecipeById(int Id);
	List<Recipe> findRecipe(String recipe);
	Recipe addRecipeToFavorites(Recipe recipe, User user);
	Recipe addRecipeToLikes(Recipe recipe, User user);

}
