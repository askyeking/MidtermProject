package com.skilldistillery.recipemeetup.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="recipe_comment")
public class RecipeComment {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String comment;
	
	@Temporal(TemporalType.TIMESTAMP)
	@CreationTimestamp
	private Date timeStamp;
	
	private Boolean active;
	
	@ManyToMany
	@JoinTable(name="recipe_comment_like",
	joinColumns=@JoinColumn(name="recipe_comment_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> userRecipeCommentLikers;
	
	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinColumn(name="user_id")
	private User recipeCommentOwner;
	
	
	@ManyToOne
	@JoinColumn(name="recipe_id")
	private Recipe recipeCommentedOn;
	
	
	public void addUserRecipeCommentLiker(User commentLiker) {
        if(userRecipeCommentLikers== null) {
            userRecipeCommentLikers = new ArrayList<>();
        }
        
        if(!userRecipeCommentLikers.contains(commentLiker)) {
            userRecipeCommentLikers.add(commentLiker);
            commentLiker.addRecipeCommentLike(this);
        }
        
    }
    
    public void removeUserRecipeCommentLiker(User commentLiker) {
        if(userRecipeCommentLikers != null && userRecipeCommentLikers.contains(commentLiker)) {
        userRecipeCommentLikers.remove(commentLiker);
        commentLiker.removeRecipeCommentLike(this);
        }
    }
    
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Date timeStamp) {
		this.timeStamp = timeStamp;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "recipeComment [id=" + id + ", comment=" + comment
				+ ", timeStamp=" + timeStamp + ", active=" + active + "]";
	}
	
	public RecipeComment() {}

	public RecipeComment(int id, int userId, int recipeId, String comment, Date timeStamp, Boolean active) {
		super();
		this.id = id;
		this.comment = comment;
		this.timeStamp = timeStamp;
		this.active = active;
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
		RecipeComment other = (RecipeComment) obj;
		if (id != other.id)
			return false;
		return true;
	}

	public User getRecipeCommentOwner() {
		return recipeCommentOwner;
	}

	public void setRecipeCommentOwner(User recipeCommentOwner) {
		this.recipeCommentOwner = recipeCommentOwner;
	}

	public List<User> getUserRecipeCommentLikes() {
		return userRecipeCommentLikers;
	}

	public void setUserRecipeCommentLikes(List<User> userRecipeCommentLikes) {
		this.userRecipeCommentLikers = userRecipeCommentLikes;
	}

	public Recipe getRecipeCommentedOn() {
		return recipeCommentedOn;
	}

	public void setRecipeCommentedOn(Recipe recipeCommentedOn) {
		this.recipeCommentedOn = recipeCommentedOn;
	}

}
