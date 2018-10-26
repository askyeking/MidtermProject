package com.skilldistillery.recipemeetup.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class Address {
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	int id;
	
	String street;
	String city;
	String state;
	
	@Column(name="postal_code")
	String postalCode;
	

}
