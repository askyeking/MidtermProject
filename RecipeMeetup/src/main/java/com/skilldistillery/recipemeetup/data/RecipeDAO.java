package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Recipe;

public interface RecipeDAO {
	
	void createRecipe(Recipe recipe);
	Recipe showRecipe(Recipe recipe);
	List<Recipe> showMoreRecipes();
	List<Recipe> showRecentRecipes();
	Recipe updateRecipe(Recipe updateRecipe);
	boolean deleteRecipe(Recipe recipe);
	boolean deleteRecipeById(int id);
	boolean isRecipeActive(Recipe recipe);

}
