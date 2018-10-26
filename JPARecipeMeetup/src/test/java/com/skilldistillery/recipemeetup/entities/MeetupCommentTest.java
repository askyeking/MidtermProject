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

class MeetupCommentTest {
	

	 

		private static EntityManagerFactory emf;
		EntityManager em;
		private MeetupComment mc;
		
		@BeforeAll
		static void setUpBeforeClass() throws Exception{
			emf = Persistence.createEntityManagerFactory("recipemeetup");
			
		}
		@BeforeEach
		void setUp() throws Exception {
			em = emf.createEntityManager();
			mc = em.find(MeetupComment.class, 1);
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
	void test() {
		assertEquals("Great idea. I am looking forward to attending", mc.getTextContent());
		assertEquals("2018-10-", mc.getPostDate().toString().substring(0,8 ));
		assertEquals(true, mc.isActive());
	}
	
	@Test
	void testMeetupCommentMappingsWithMeetup() {
		assertEquals(1, mc.getUserMeetupCommentLikes().size());
		assertEquals("Blake", mc.getUserMeetupCommentLikes().get(0).getFirstName());
	}
	
	@Test
	void testMeetupCommentUserMappingAssociation() {
		assertEquals("Anthony",mc.getMeetupCommentOwner().getFirstName());
		assertEquals(1,mc.getMeetupCommentOwner().getLikedMeetupComments().size());
		assertEquals(2, mc.getMeetupCommentOwner().getId());
	}

	}
	
