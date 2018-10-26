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

class RecipeCommentTest {

	private static EntityManagerFactory emf;
	EntityManager em;
	private RecipeComment rc;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("recipemeetup");
		
	}
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		rc = em.find(RecipeComment.class, 1);
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
	void testRecipeCommentEntityMappings() {
		assertEquals("Too much meat for my taste", rc.getComment());
		assertEquals(true, rc.getActive());
		assertEquals("2018-10-",rc.getTimeStamp().toString().substring(0, 8));
		System.out.println(rc.getTimeStamp().toString());
	}
	
	@Test
	void testRecipeCommentHasOwner() {
		assertEquals("Blake", rc.getRecipeCommentOwner().getFirstName());
		assertEquals("Shelton", rc.getRecipeCommentOwner().getLastName());
	}

}
