package com.skilldistillery.recipemeetup.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;


@Transactional
@Repository
public class RecipeDAOImpl implements RecipeDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Recipe createRecipe(Recipe recipe, User user) {
		recipe.setRecipeOwner(user);
		em.persist(recipe);
		em.flush();
		return recipe;
	}

	@Override
	public Recipe showRecipe(Recipe recipe) {
		Recipe singleRecipe = em.find(Recipe.class, recipe);
		return singleRecipe;
	}
	
	@Override
	public List<Recipe> showMoreRecipes() {
		String query = "SELECT recipes FROM Recipe recipes";
		List<Recipe> moreRecipes = em.createQuery(query, Recipe.class)
				.getResultList();
		return moreRecipes;
	}

	@Override
	public List<Recipe> showRecentRecipes() {
		String query = "SELECT recipes FROM Recipe recipes ORDER BY createDate DESC";
		List<Recipe> recentRecipes = em.createQuery(query, Recipe.class)
				.setMaxResults(5)
				.getResultList();
				
		return recentRecipes;
	}
	
	@Override
	public Recipe updateRecipe(Recipe updatedRecipe) {
		Recipe editRecipe = em.find(Recipe.class, updatedRecipe);
		editRecipe.setTitle(updatedRecipe.getTitle());
		editRecipe.setCountry(updatedRecipe.getCountry());
		editRecipe.setDescription(updatedRecipe.getDescription());
		editRecipe.setIngredients(updatedRecipe.getIngredients());
		editRecipe.setServingSize(updatedRecipe.getServingSize());
		editRecipe.setCookTime(updatedRecipe.getCookTime());
		editRecipe.setInstructions(updatedRecipe.getInstructions());
		editRecipe.setCategory(updatedRecipe.getCategory());
		editRecipe.setImgURL(updatedRecipe.getImgURL());
		editRecipe.setActive(updatedRecipe.getActive());
		
		return editRecipe;
	}

	@Override
	public boolean deleteRecipe(Recipe recipe) {
		int id = recipe.getId();
		boolean isRecipeDeleted = false;
		if(recipe != null) {
			em.remove(recipe);
			if(em.find(Recipe.class, id) == null) {
				isRecipeDeleted = true;
			}
		}
		return isRecipeDeleted;
	}

	@Override
	public boolean deleteRecipeById(int id) {
		Recipe deleteRecipe = em.find(Recipe.class, id);
		boolean isRecipeDeleted = false;
		if(deleteRecipe != null) {
			em.remove(deleteRecipe);
			if(em.find(Recipe.class, id) == null) {
				isRecipeDeleted = true;
			}
		}
		
		return isRecipeDeleted;
	}

	@Override
	public boolean isRecipeActive(Recipe recipe) {
		boolean isRecipeActive = true;
		if(recipe.getActive() == false) {
			isRecipeActive = false;
		}		
		return isRecipeActive;
	}



}
