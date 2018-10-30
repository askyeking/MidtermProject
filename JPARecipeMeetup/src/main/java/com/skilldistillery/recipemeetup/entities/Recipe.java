package com.skilldistillery.recipemeetup.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Recipe {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String country;
	
	private String description;
	
	private String ingredients;
	
	@Column(name="serving_size")
	private int servingSize;
		
	@Column(name="cook_time")
	private  String cookTime;
	
	private String instructions;
	
	private String category;
	private boolean active;
	@Column(name="img_url")
	private String imgURL;
	
	@Column(name="post_date")
	@Temporal(TemporalType.TIMESTAMP)
	@CreationTimestamp
	private Date createDate;
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="recipe_like",
	joinColumns=@JoinColumn(name="recipe_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> recipeLikers;
	
	@ManyToOne
	@JoinColumn(name="author_id")
	private User recipeOwner;
	
//	@ManyToMany(mappedBy="favoriteRecipes")
//	private List<User> usersWhoFavorited;
	
	@ManyToMany
	@JoinTable(name="favorite_recipe",
	joinColumns=@JoinColumn(name="recipe_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> usersWhoFavorited;
	
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="recipeCommentedOn")
	private List<RecipeComment> recipeComments;
	
//	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="recipeFavorited")
//	private List<RecipeFavorite> recipeFavorites;
	
	
	public void addRecipeLikers(User recipeLiker) {
        if(recipeLikers== null) {
            recipeLikers = new ArrayList<>();
        }
        
        if(!recipeLikers.contains(recipeLiker)) {
            recipeLikers.add(recipeLiker);
            recipeLiker.addLikedRecipe(this);
        }
        
    }
    
    public void removeRecipeLikers(User recipeLiker) {
        if(recipeLikers != null && recipeLikers.contains(recipeLiker)) {
        recipeLikers.remove(recipeLiker);
        recipeLiker.removeLikedRecipe(this);
        }
    }
    
    
    
    
    public void addUserWhoFavorited(User userWhoFavorited) {
        if(usersWhoFavorited== null) {
            usersWhoFavorited = new ArrayList<>();
        }
        
        if(!usersWhoFavorited.contains(userWhoFavorited)) {
            usersWhoFavorited.add(userWhoFavorited);
            userWhoFavorited.addRecipeFavorited(this);
        }
        
    }
    
    public void removeUserWhoFavorited(User userWhoFavorited) {
        if(usersWhoFavorited != null && usersWhoFavorited.contains(userWhoFavorited)) {
        usersWhoFavorited.remove(userWhoFavorited);
        userWhoFavorited.removeRecipeFavorited(this);
        }
    }
    
  
	
    public void addRecipeComment(RecipeComment recipeComment) {
    	if(recipeComments==null) {
    		recipeComments = new ArrayList<>();
    	}
    	
    	if(!recipeComments.contains(recipeComment)) {
    		recipeComments.add(recipeComment);
    		if(recipeComment.getRecipeCommentedOn() != null) {
    			recipeComment.getRecipeCommentedOn().getRecipeComments().remove(recipeComment);
    		}
    	}
    	
    	recipeComment.setRecipeCommentedOn(this);
    }
    
    public void removeRecipeComment(RecipeComment recipeComment) {
    	recipeComment.setRecipeCommentedOn(null);
    	if(recipeComments!=null) {
    		recipeComments.remove(recipeComment);
    	}
    }
    
    
//    public void addRecipeFavorite(RecipeFavorite recipeFavorite) {
//    	if(recipeFavorites==null) {
//    		recipeFavorites = new ArrayList<>();
//    	}
//    	
//    	if(!recipeFavorites.contains(recipeFavorite)) {
//    		recipeFavorites.add(recipeFavorite);
//    		if(recipeFavorite.getRecipeFavorited() != null) {
//    			recipeFavorite.getRecipeFavorited().getRecipeFavorites().remove(recipeFavorite);
//    		}
//    	}
//    	
//    	recipeFavorite.setRecipeFavorited(this);
//    }
//    
//    public void removeRecipeFavorite(RecipeFavorite recipeFavorite) {
//    	recipeFavorite.setRecipeFavorited(null);
//    	if(recipeFavorites!=null) {
//    		recipeFavorites.remove(recipeFavorite);
//    	}
//    }
    
    
    
    public List<User> getRecipeLikers() {
		return recipeLikers;
	}

	public List<User> getUsersWhoFavorited() {
		return usersWhoFavorited;
	}

	public void setUsersWhoFavorited(List<User> usersWhoFavorited) {
		this.usersWhoFavorited = usersWhoFavorited;
	}

	public void setRecipeLikers(List<User> recipeLikers) {
		this.recipeLikers = recipeLikers;
	}
 
    
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<RecipeComment> getRecipeComments() {
		return recipeComments;
	}

	public void setRecipeComments(List<RecipeComment> recipeComments) {
		this.recipeComments = recipeComments;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIngredients() {
		return ingredients;
	}

	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}

	public int getServingSize() {
		return servingSize;
	}

	public void setServingSize(int servingSize) {
		this.servingSize = servingSize;
	}

	public String getCookTime() {
		return cookTime;
	}

	public void setCookTime(String cookTime) {
		this.cookTime = cookTime;
	}

	public String getInstructions() {
		return instructions;
	}

	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}



	public boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public int getId() {
		return id;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
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
		Recipe other = (Recipe) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "\nPosted: " + createDate + "\nTitle: " + title + "\nOrigin: " + country + "\nDescription: " + description
				+ "\nIngredients: " + ingredients + "\nServing Size: " + servingSize + "\nCook Time: " + cookTime + " minutes"
				+ "\nInstructions: " + instructions + "\nCategory: " + category;
	}
	
	public Recipe() {
		
	}

	public Recipe(int id, String title, String country, String description, String ingredients, int servingSize,
			String cookTime, String instructions, String category, Date createDate, String imgURL, int authorId,
			boolean active) {
		super();
		this.id = id;
		this.title = title;
		this.country = country;
		this.description = description;
		this.ingredients = ingredients;
		this.servingSize = servingSize;
		this.cookTime = cookTime;
		this.instructions = instructions;
		this.category = category;
		this.createDate = createDate;
		this.imgURL = imgURL;
		this.active = active;
	}

	public List<User> getRecipeLikes() {
		return recipeLikers;
	}

	public void setRecipeLikes(List<User> recipeLikes) {
		this.recipeLikers = recipeLikes;
	}

	public User getRecipeOwner() {
		return recipeOwner;
	}

	public void setRecipeOwner(User recipeOwner) {
		this.recipeOwner = recipeOwner;
	}

//	public List<User> getUsersWhoFavorited() {
//		return usersWhoFavorited;
//	}
//
//	public void setUsersWhoFavorited(List<User> usersWhoFavorited) {
//		this.usersWhoFavorited = usersWhoFavorited;
//	}
	
	
	
	
	
}
