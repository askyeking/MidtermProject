package com.skilldistillery.recipemeetup.entities;

import java.util.Date;

import javax.persistence.*;

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
	
	@Column(name="post_date")
	@Temporal(TemporalType.TIMESTAMP)
	@CreationTimestamp
	private Date createDate;
	
	@Column(name="img_url")
	private String imgURL;
	
	@Column(name="author_id")
	private int authorId;
	
	private boolean active;
	
	
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

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public boolean isActive() {
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
		return "recipe [id=" + id + ", title=" + title + ", country=" + country + ", description=" + description
				+ ", ingredients=" + ingredients + ", servingSize=" + servingSize + ", cookTime=" + cookTime
				+ ", instructions=" + instructions + ", category=" + category + ", createDate=" + createDate + ", imgURL="
				+ imgURL + ", authorId=" + authorId + ", active=" + active + "]";
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
		this.authorId = authorId;
		this.active = active;
	}
	
	
	
}
