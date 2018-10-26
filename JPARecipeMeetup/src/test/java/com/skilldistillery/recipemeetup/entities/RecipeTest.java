package com.skilldistillery.recipemeetup.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RecipeTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;
	

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("recipemeetupdb");
	}

	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		recipe = em.find(Recipe.class, 1);
	}
	


	@Test
	void test() {
		fail("Not yet implemented");
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
