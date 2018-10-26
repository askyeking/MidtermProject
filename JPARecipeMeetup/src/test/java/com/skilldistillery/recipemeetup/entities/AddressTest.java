package com.skilldistillery.recipemeetup.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class AddressTest {
	private static EntityManagerFactory emf;
	EntityManager em;
	private Address address;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("recipemeetup");
		
	}
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		address = em.find(Address.class, 1);
	}
	
	@AfterAll
	static void tearDownAfterClasS() {
		emf.close();
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}

	@Test
	void testAdressEntityFields() {
		assertEquals("889 South Dampton Rd", address.getStreet());
		assertEquals("Denver", address.getCity());
		assertEquals("CO", address.getState());
		assertEquals("80202", address.getPostalCode());
	}
	
	@Test
	void testMappingAddressUserReturnsFullUserList() {
		assertEquals("Blake",address.getUsers().get(0).getFirstName());
	}
	
	@Test
	void testMappingMeetupAddressReturnsMeetup() {
		assertEquals(1, address.getMeetups().size());
	}

}
