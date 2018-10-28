package com.skilldistillery.recipemeetup.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;


@Entity
public class Address {
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String street;
	private String city;
	private String state;
	
	@Column(name="postal_code")
	private String postalCode;

	public int getId() {
		return id;
	}
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="address")
	private List<User> users;
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, mappedBy="meetupAddress")
	private List <Meetup> meetups;
	
	 public void addUser(User user) {
	        if(users==null) {
	            users = new ArrayList<>();
	        }
	        
	        if(!users.contains(user)) {
	            users.add(user);
	            if(user.getAddress() != null) {
	                user.getAddress().getUsers().remove(user);
	            }
	        }
	        
	        user.setAddress(this);
	    }
	    
	    public void removeUser(User user) {
	        user.setAddress(null);
	        if(users!=null) {
	            users.remove(user);
	        }
	    }

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public Address() {}
	
	public Address(int id, String street, String city, String state, String postalCode) {
		super();
		this.id = id;
		this.street = street;
		this.city = city;
		this.state = state;
		this.postalCode = postalCode;
	}


	@Override
	public String toString() {
		return "Address [id=" + id + ", street=" + street + ", city=" + city + ", state=" + state + ", postalCode="
				+ postalCode + "]";
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
		Address other = (Address) obj;
		if (id != other.id)
			return false;
		return true;
	}


	public void setId(int id) {
		this.id = id;
	}

	public List<Meetup> getMeetups() {
		return meetups;
	}

	public void setMeetups(List<Meetup> meetups) {
		this.meetups = meetups;
	}

}
