package com.skilldistillery.recipemeetup.entities;

import java.util.Date;

import javax.persistence.*;

@Entity
public class Recipe {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String country;
	
	private String description;
	
	private String ingredient;
	
	@Column(name="serving_time")
	private String servingSize;
		
	@Column(name="cook_time")
	private  String cookTime;
	
	private String instruction;
	
	private String category;
	
	@Column(name="post_date")
	private Date createDate;
	
	@Column(name="img_url")
	private String imgURL;
	
	@Column(name="author_id")
	private int authorId;
	
	private boolean active;
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getIngredient() {
		return ingredient;
	}

	public void setIngredient(String ingredient) {
		this.ingredient = ingredient;
	}

	public String getServingSize() {
		return servingSize;
	}

	public void setServingSize(String servingSize) {
		this.servingSize = servingSize;
	}

	public String getCookTime() {
		return cookTime;
	}

	public void setCookTime(String cookTime) {
		this.cookTime = cookTime;
	}

	public String getInstruction() {
		return instruction;
	}

	public void setInstruction(String instruction) {
		this.instruction = instruction;
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
		return "recipe [id=" + id + ", name=" + name + ", country=" + country + ", description=" + description
				+ ", ingredient=" + ingredient + ", servingSize=" + servingSize + ", cookTime=" + cookTime
				+ ", instruction=" + instruction + ", category=" + category + ", createDate=" + createDate + ", imgURL="
				+ imgURL + ", authorId=" + authorId + ", active=" + active + "]";
	}
	
	public Recipe() {
		
	}

	public Recipe(int id, String name, String country, String description, String ingredient, String servingSize,
			String cookTime, String instruction, String category, Date createDate, String imgURL, int authorId,
			boolean active) {
		super();
		this.id = id;
		this.name = name;
		this.country = country;
		this.description = description;
		this.ingredient = ingredient;
		this.servingSize = servingSize;
		this.cookTime = cookTime;
		this.instruction = instruction;
		this.category = category;
		this.createDate = createDate;
		this.imgURL = imgURL;
		this.authorId = authorId;
		this.active = active;
	}
	
	
	
}
