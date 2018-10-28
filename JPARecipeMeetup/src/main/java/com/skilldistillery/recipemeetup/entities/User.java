package com.skilldistillery.recipemeetup.entities;

import java.util.ArrayList;
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

@Entity
public class User {
	
	public User() {
		super();
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String username;
	private String password;

	@Column(name="date_of_birth")
	private String dateOfBirth;
	
	@Column(name="first_name")
	private String firstName;
	@Column(name="last_name")
	private String lastName;
	
	private String description;
	
	@Column(name="create_date")
	private String createDate;
	
	private boolean active;
	private boolean admin;
	
	@Column(name="img_url")
	private String imgURL;
	
	private String email;
	
	@ManyToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@ManyToMany
	@JoinTable(name="favorite_recipe",
	joinColumns=@JoinColumn(name="user_id"),
	inverseJoinColumns=@JoinColumn(name="recipe_id"))
	private List<Recipe> favoriteRecipes;
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="meetupOwner")
	private List<Meetup> meetupsOwned;
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="attendees")
	private List<Meetup> meetupsAttended;
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="meetupCommentOwner")
	private List<MeetupComment> meetupCommentsPosted;
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="userMeetupCommentLikes")
	private List<MeetupComment> likedMeetupComments;
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="recipeLikes")
	private List<Recipe> likedRecipes;
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="recipeOwner")
	private List<Recipe> recipesPosted;
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="recipeCommentOwner")
	private List<RecipeComment> recipeComments;
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="userRecipeCommentLikes")
	private List<RecipeComment> likedRecipeComments;
	
	//add to meetups owned by user
	public void addMeetupOwned(Meetup meetup) {
        if(meetupsOwned==null) {
        	meetupsOwned = new ArrayList<>();
        }
        
        if(!meetupsOwned.contains(meetup)) {
        	meetupsOwned.add(meetup);
            if(meetup.getMeetupOwner() != null) {
                meetup.getMeetupOwner().getMeetupsOwned().remove(meetup);
            }
        }
        
        meetup.setMeetupOwner(this);
    }
    
    public void removeMeetupOwned(Meetup meetup) {
        meetup.setMeetupOwner(null);
        if(meetupsOwned!=null) {
        	meetupsOwned.remove(meetup);
        }
    }
    
    //add attendees to meetup owned by user
    public void addMeetupAttended(Meetup meetup) {
        if(meetupsAttended== null) {
        	meetupsAttended = new ArrayList<>();
        }
        
        if(!meetupsAttended.contains(meetup)) {
        	meetupsAttended.add(meetup);
            meetup.addAttendee(this);
        }
        
    }
    
    public void removeMeetupAttended(Meetup meetup) {
        if(meetupsAttended != null && meetupsAttended.contains(meetup)) {
        	meetupsAttended.remove(meetup);
        meetup.removeAttendee(this);
        }
    }
    
    //add comment to meetup owner of meetup post
    public void addMeetupCommentPosted(MeetupComment meetupComment) {
        if(meetupCommentsPosted==null) {
        	meetupCommentsPosted = new ArrayList<>();
        }
        
        if(!meetupCommentsPosted.contains(meetupComment)) {
        	meetupCommentsPosted.add(meetupComment);
            if(meetupComment.getMeetupCommentOwner() != null) {
                meetupComment.getMeetupCommentOwner().getMeetupCommentsPosted().remove(meetupComment);
            }
        }
        
        meetupComment.setMeetupCommentOwner(this);
    }
    
    public void removeMeetupCommentPosted(MeetupComment meetupComment) {
        meetupComment.setMeetupCommentOwner(null);
        if(meetupCommentsPosted!=null) {
        	meetupCommentsPosted.remove(meetupComment);
        }
    }
    
    //adds a user to the list of users who have liked a comment to a meetup
    public void addMeetupCommentLike(MeetupComment meetupComment) {
        if(likedMeetupComments== null) {
        	likedMeetupComments = new ArrayList<>();
        }
        
        if(!likedMeetupComments.contains(meetupComment)) {
        	likedMeetupComments.add(meetupComment);
            meetupComment.addUserMeetupCommentLiker(this);
        }
        
    }
    
    public void removeMeetupCommentLike(MeetupComment meetupComment) {
        if(likedMeetupComments != null && likedMeetupComments.contains(meetupComment)) {
        	likedMeetupComments.remove(meetupComment);
        meetupComment.removeUserMeetCommentLiker(this);
        }
    }
    
    
	
	public List<RecipeComment> getRecipeComments() {
		return recipeComments;
	}

	public void setRecipeComments(List<RecipeComment> recipeComments) {
		this.recipeComments = recipeComments;
	}

	public List<Recipe> getFavoriteRecipes() {
		return favoriteRecipes;
	}

	public void setFavoriteRecipes(List<Recipe> favoriteRecipes) {
		this.favoriteRecipes = favoriteRecipes;
	}

	public List<Recipe> getRecipesPosted() {
		return recipesPosted;
	}

	public void setRecipesPosted(List<Recipe> recipesPosted) {
		this.recipesPosted = recipesPosted;
	}
	
	public List<RecipeComment> getLikedRecipeComments() {
		return likedRecipeComments;
	}

	public void setLikedRecipeComments(List<RecipeComment> likedRecipeComments) {
		this.likedRecipeComments = likedRecipeComments;
	}


	public List<Recipe> getLikedRecipes() {
		return likedRecipes;
	}


	public void setLikedRecipes(List<Recipe> likedRecipes) {
		this.likedRecipes = likedRecipes;
	}


	public List<MeetupComment> getLikedMeetupComments() {
		return likedMeetupComments;
	}


	public void setLikedMeetupComments(List<MeetupComment> likedMeetupComments) {
		this.likedMeetupComments = likedMeetupComments;
	}


	public List<MeetupComment> getMeetupCommentsPosted() {
		return meetupCommentsPosted;
	}


	public void setMeetupCommentsPosted(List<MeetupComment> meetupCommentsPosted) {
		this.meetupCommentsPosted = meetupCommentsPosted;
	}


	public List<Meetup> getMeetupsAttended() {
		return meetupsAttended;
	}


	public void setMeetupsAttended(List<Meetup> meetupsAttended) {
		this.meetupsAttended = meetupsAttended;
	}


	public List<Meetup> getMeetupsOwned() {
		return meetupsOwned;
	}


	public void setMeetupsOwned(List<Meetup> meetupsOwned) {
		this.meetupsOwned = meetupsOwned;
	}


	public User(int id, String username, String password, String dateOfBirth, String firstName, String lastName,
			String description, String createDate, boolean active, boolean admin, String imgURL, String email,
			Address address) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.dateOfBirth = dateOfBirth;
		this.firstName = firstName;
		this.lastName = lastName;
		this.description = description;
		this.createDate = createDate;
		this.active = active;
		this.admin = admin;
		this.imgURL = imgURL;
		this.email = email;
		this.address = address;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
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
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", dateOfBirth=" + dateOfBirth
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", description=" + description
				+ ", createDate=" + createDate + ", active=" + active + ", admin=" + admin + ", imgURL=" + imgURL
				+ ", email=" + email + ", address=" + address.getCity() + "]";
	}

}
