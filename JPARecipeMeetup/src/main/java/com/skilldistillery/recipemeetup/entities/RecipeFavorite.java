package com.skilldistillery.recipemeetup.entities;

public class RecipeFavorite {
	
}
//
//import javax.persistence.Entity;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.Table;
//
//@Entity
//@Table(name = "favorite_recipe")
//public class RecipeFavorite {
//	@ManyToOne
//	@JoinColumn(name="user_id")	
//	private User userWhoFavorited;
//	
//	@ManyToOne
//	@JoinColumn(name="recipe_id")
//	private Recipe recipeFavorited;
//	
//	public User getUserWhoFavorited() {
//		return userWhoFavorited;
//	}
//	
//	public void setUserWhoFavorited(User userWhoFavorited) {
//		this.userWhoFavorited = userWhoFavorited;
//	}
//	
//	
//
//	public Recipe getRecipeFavorited() {
//		return recipeFavorited;
//	}
//
//	public void setRecipeFavorited(Recipe recipeFavorited) {
//		this.recipeFavorited = recipeFavorited;
//	}
//
//	@Override
//	public int hashCode() {
//		final int prime = 31;
//		int result = 1;
//		result = prime * result + ((recipeFavorited == null) ? 0 : recipeFavorited.hashCode());
//		result = prime * result + ((userWhoFavorited == null) ? 0 : userWhoFavorited.hashCode());
//		return result;
//	}
//
//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (obj == null)
//			return false;
//		if (getClass() != obj.getClass())
//			return false;
//		RecipeFavorite other = (RecipeFavorite) obj;
//		if (recipeFavorited == null) {
//			if (other.recipeFavorited != null)
//				return false;
//		} else if (!recipeFavorited.equals(other.recipeFavorited))
//			return false;
//		if (userWhoFavorited == null) {
//			if (other.userWhoFavorited != null)
//				return false;
//		} else if (!userWhoFavorited.equals(other.userWhoFavorited))
//			return false;
//		return true;
//	}
//
//	@Override
//	public String toString() {
//		return "FavoriteRecipe [userWhoFavorited=" + userWhoFavorited.getFirstName() + ", recipeFavorited=" + recipeFavorited.getTitle() + "]";
//	}
//	
//	
//	
//
//}
