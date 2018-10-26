package com.skilldistillery.recipemeetup.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.Test;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user; 

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("recipemeetup");		
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}
	
	@Test
	void test_user_is_in_the_database() {
		assertEquals("Blake", user.getFirstName());
		assertEquals("Shelton" , user.getLastName());
		assertEquals("Blake234", user.getUsername());
		assertEquals("1997-03-05", user.getDateOfBirth());
		assertEquals("Blake@gmail.com", user.getEmail());
	}
	
	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
}
