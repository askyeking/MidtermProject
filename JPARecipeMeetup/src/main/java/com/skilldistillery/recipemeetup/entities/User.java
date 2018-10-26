package com.skilldistillery.recipemeetup.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class User {
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
	
	@OneToMany(mappedBy="meetupOwner")
	private List<Meetup> meetupsOwned;
	
	public User() {
		super();
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
