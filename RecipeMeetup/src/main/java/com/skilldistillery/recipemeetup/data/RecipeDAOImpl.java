package com.skilldistillery.recipemeetup.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;


@Transactional
@Repository
public class RecipeDAOImpl implements RecipeDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Recipe createRecipe(Recipe recipe, User user) {
		user.addRecipeOwnedByUser(recipe);
		recipe.setRecipeOwner(user);
		
		
		em.persist(recipe);
		em.flush();
		
		return recipe;
	}

	@Override
	public Recipe showRecipe(Recipe recipe) {
		Recipe singleRecipe = em.find(Recipe.class, recipe.getId());
		return singleRecipe;
	}
	
	@Override
	public Recipe showRecipeById(int Id) {
		String jpql = "SELECT recipe from Recipe recipe where id = :id";
		Recipe recipeById = em.createQuery(jpql, Recipe.class).setParameter("id", Id).getSingleResult();
		return recipeById;
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
		Recipe editRecipe = em.find(Recipe.class, updatedRecipe.getId());
		editRecipe.setTitle(updatedRecipe.getTitle());
		editRecipe.setCountry(updatedRecipe.getCountry());
		editRecipe.setDescription(updatedRecipe.getDescription());
		editRecipe.setIngredients(updatedRecipe.getIngredients());
		editRecipe.setServingSize(updatedRecipe.getServingSize());
		editRecipe.setCookTime(updatedRecipe.getCookTime());
		editRecipe.setInstructions(updatedRecipe.getInstructions());
		editRecipe.setCategory(updatedRecipe.getCategory());
		editRecipe.setImgURL(updatedRecipe.getImgURL());
//		editRecipe.setActive(updatedRecipe.getActive());
		
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
	
	@Override
	public List<Recipe> findRecipe(String recipe) {
		List<Recipe> recipes = new ArrayList<>();
		String query = "SELECT r FROM Recipe r WHERE r.title LIKE ?1 OR r.description LIKE ?2 OR r.ingredients LIKE ?3";
		recipes = em.createQuery(query, Recipe.class)
				.setParameter(1, "%" + recipe + "%")
				.setParameter(2, "%" + recipe + "%")
				.setParameter(3, "%" + recipe + "%")
				.getResultList();
		
		return recipes;
	}

	
	@Override
	public Recipe addRecipeToFavorites(Recipe recipe, User user) {
		Recipe favoritedRecipe = em.find(Recipe.class, recipe.getId());
		List<User> recipesFavorited = favoritedRecipe.getUsersWhoFavorited();
		
		if(!recipesFavorited.contains(user)) {
			favoritedRecipe.addUserWhoFavorited(user);
			user.addRecipeFavorited(favoritedRecipe);
			em.persist(favoritedRecipe);
			em.flush();
		}
		return favoritedRecipe;
	}
	
	@Override
	public Recipe addRecipeToLikes(Recipe recipe, User user) { 
		Recipe likedRecipe = em.find(Recipe.class, recipe.getId());
		System.out.println("recipe: " + likedRecipe);
		
		List<User> recipesLiked = likedRecipe.getRecipeLikers();
		System.out.println("size: " + recipesLiked.size());
		
		if(!recipesLiked.contains(user)) {
			likedRecipe.addRecipeLikers(user);
			user.addLikedRecipe(likedRecipe);
			System.out.println("breaks here: ");
			em.persist(likedRecipe);
			System.out.println("broken here");
			em.flush();
		}
		System.out.println("WWOOOOOOOOOOOOOOOOOOOORK!");
		return likedRecipe;
	}
	
}
