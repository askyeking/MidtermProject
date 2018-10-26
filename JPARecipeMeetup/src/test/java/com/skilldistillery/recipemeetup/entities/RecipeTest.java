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
		emf = Persistence.createEntityManagerFactory("recipemeetup");
	}

	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		recipe = em.find(Recipe.class, 1);
	}
	
	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}
	
	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
	
	@Test
	void test_Recipe_is_in_the_database() {
		assertEquals("Chicken quesadilla", recipe.getTitle());
		assertEquals("Mexico", recipe.getCountry());
		assertEquals("corn tortilla, chicken, etc.", recipe.getIngredients());
		assertEquals(4, recipe.getServingSize());
		assertEquals("put meat inside of tortilla.", recipe.getInstructions());
		assertEquals("\"Quick meal\"", recipe.getCategory());
		assertEquals("2018-10-", recipe.getCreateDate().toString().substring(0, 8));
	}

	@Test
	void testRecipeLikeMappedToUser() {
		assertEquals(5,recipe.getRecipeLikes().size());
		assertEquals("Anthony",recipe.getRecipeLikes().get(0).getFirstName());
	}
}
