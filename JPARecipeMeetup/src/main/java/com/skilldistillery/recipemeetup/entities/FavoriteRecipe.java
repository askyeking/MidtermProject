package com.skilldistillery.recipemeetup.entities;

import javax.persistence.*;

@Entity
@Table(name="favorite_recipe")
public class FavoriteRecipe {
	
	@Column(name="user_id")
	private int userId;
	
	@Column(name="recipe_id")
	private int recipeId;

	public int getUserId() {
		return userId;
	}

	public int getRecipeId() {
		return recipeId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + recipeId;
		result = prime * result + userId;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		FavoriteRecipe other = (FavoriteRecipe) obj;
		if (recipeId != other.recipeId)
			return false;
		if (userId != other.userId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FavoriteRecipe [userId=" + userId + ", recipeId=" + recipeId + "]";
	}
	
	public FavoriteRecipe() {
		
	}

	public FavoriteRecipe(int userId, int recipeId) {
		super();
		this.userId = userId;
		this.recipeId = recipeId;
	}
	
	

}
