package com.skilldistillery.recipemeetup.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

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
		assertEquals("blake234", user.getUsername());
		assertEquals("1997-03-05", user.getDateOfBirth());
		assertEquals("blake@gmail.com", user.getEmail());
	}
	
	@Test
	void test_mapping_User_Address() {
		assertEquals(em.find(Address.class, 1), user.getAddress());
	}
	
	@Test
	void test_mapping_User_Meetup() {
		user = em.find(User.class, 2);
		assertEquals(user.getMeetupsOwned().get(0).getTitle(),"Grill and Chill Denver");
	}
	
	@Test
	void test_user_has_attended_meetups() {
		assertEquals("French Food in Denver", user.getMeetupsAttended().get(0).getTitle());
	}
	
	@Test
	void test_user_has_liked_meetup_comments() {
		assertEquals("Great idea. I am looking forward to attending", user.getLikedMeetupComments().get(0).getTextContent());
		assertEquals(em.find(MeetupComment.class, 1), user.getLikedMeetupComments().get(0));
	}
	
	@Test
	void test_user_has_meetup_comments() {
		assertEquals("I am so hyped", user.getMeetupCommentsPosted().get(0).getTextContent());
		assertEquals(2, user.getMeetupCommentsPosted().get(0).getId());
	}
	
	@Test
	void test_user_has_liked_recipes() {
		user = em.find(User.class, 6);   
		assertEquals(2, user.getLikedRecipes().size());
		assertEquals(1, user.getLikedRecipes().get(0).getId());
		
		user = null;
		
	}
	
	@Test
	void test_user_has_posted_recipes() {
		assertEquals("Mexico", user.getRecipesPosted().get(0).getCountry());
		assertEquals(1, user.getRecipesPosted().get(0).getId());
	}
	
//	@Test
//	void test_user_has_favorite_recipes() {
//		assertEquals("Chicken quesadilla", user.getFavoriteRecipes().get(0).getTitle());
//		assertEquals(1, user.getFavoriteRecipes().get(0).getId());
//	}
	
	@Test
	void test_user_has_recipe_comments() {
		assertEquals(3, user.getRecipeComments().size());
		assertEquals(1, user.getRecipeComments().get(0).getId());
	}
	
	@Test
	void test_user_has_liked_recipe_comments() {
		
		assertEquals(1, user.getLikedRecipeComments().get(0).getId());
		assertEquals(1, user.getLikedRecipeComments().size());
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