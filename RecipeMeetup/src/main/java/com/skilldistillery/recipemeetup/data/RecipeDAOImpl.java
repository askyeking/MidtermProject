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

//This class manages database interactions where Recipe entity is involved.
@Transactional
@Repository
public class RecipeDAOImpl implements RecipeDAO {
	// PersistenceContext - All transactions are automatically started and committed, EntityManagerFactory is not required.
	@PersistenceContext
	private EntityManager em;


	// The method below will persist a Recipe to the database. 
	@Override
	public Recipe createRecipe(Recipe recipe, User user) {
		// if User does not provide a URL for the image, we will set the url to a predifined link.
		if(recipe.getImgURL() == "" || recipe.getImgURL() == null) {
			recipe.setImgURL("https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg");
		}
		
		// A user has a list of recipes they posted, so we add the recipe to that list.
		user.addRecipeOwnedByUser(recipe);
		
		// A recipe has an owner, the user who posted the recipe, so we set the user provided to the method as the owner of the recipe
		recipe.setRecipeOwner(user);
		
		em.persist(recipe);
		em.flush();
		
		return recipe;
	}	
	
	// Retrieves a meetup from the database using an instance of a meetup. Make sure the meetup instance has an id value set.
	@Override
	public Recipe showRecipe(Recipe recipe) {
		Recipe singleRecipe = em.find(Recipe.class, recipe.getId());
		return singleRecipe;
	}
	
	// Retrieves a meetup from the database using an id (int).
	@Override
	public Recipe showRecipeById(int Id) {
		String jpql = "SELECT recipe from Recipe recipe where id = :id";
		Recipe recipeById = em.createQuery(jpql, Recipe.class).setParameter("id", Id).getSingleResult();
		return recipeById;
	}
	
	// Retrieves all recipes from the database and stores them in a list.
	@Override
	public List<Recipe> showMoreRecipes() {
		String query = "SELECT recipes FROM Recipe recipes";
		List<Recipe> moreRecipes = em.createQuery(query, Recipe.class)
				.getResultList();
		return moreRecipes;
	}
	
	// Retrieves three most recently posted recipes
	@Override
	public List<Recipe> showRecentRecipes() {
		String query = "SELECT recipes FROM Recipe recipes where active='1' ORDER BY createDate DESC";
		List<Recipe> recentRecipes = em.createQuery(query, Recipe.class)
				.setMaxResults(3)
				.getResultList();
				
		return recentRecipes;
	}
	
	// Persists changes made to a recipe in a database
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
		
		// ImgURL is only updated if the user gives a new link. Otherwise the recipe imgURL remains the same as before.
		if (updatedRecipe.getImgURL() != "" && updatedRecipe.getImgURL() != null) {
			editRecipe.setImgURL(updatedRecipe.getImgURL());
		}
		
		return editRecipe;
	}

	// removes recipe from the database. Not used. setActiveToFalse method is used when a user deletes an input instead.
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

	// removes recipe from the database. Not used. setActiveToFalse method is used when a user deletes an input instead.
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

	// If it returns true recipe will be shown in the front end, otherwise it will be treated as if it wasn't in the DB.
	@Override
	public boolean isRecipeActive(Recipe recipe) {
		boolean isRecipeActive = true;
		if(recipe.getActive() == false) {
			isRecipeActive = false;
		}		
		return isRecipeActive;
	}
	
	// finds recipe by a keyword (String recipe). Searches for the keyword in title, description and ingredients.
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

	// User owns a list of recipes they favorited. The method below adds a recipe to the list and persists the favorite in the db.
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
	
	// The method below adds a recipe the user liked to the user list of liked recipe, and adds the user to the list of users that liked a recipe that the recipe holds.
	@Override
	public Recipe addRecipeToLikes(Recipe recipe, User user) { 
		Recipe likedRecipe = em.find(Recipe.class, recipe.getId());
		
		List<User> recipesLiked = likedRecipe.getRecipeLikers();
		
		if(!recipesLiked.contains(user)) {
			likedRecipe.addRecipeLikers(user);
			user.addLikedRecipe(likedRecipe);
			em.persist(likedRecipe);
			em.flush();
		}
		return likedRecipe;
	}
	
	// Sets boolean active to false. If false, in the front end it will not be publically shown (deleted from the front-end but kept in the database)
	@Override
	public Recipe setActiveToFalse(Recipe recipe) {
		recipe = em.find(Recipe.class, recipe.getId());
		recipe.setActive(false);
		
		return recipe;
		
	}
}
