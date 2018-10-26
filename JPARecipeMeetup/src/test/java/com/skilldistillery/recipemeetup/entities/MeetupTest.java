package com.skilldistillery.recipemeetup.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;

class MeetupTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Meetup meetup; 

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("recipemeetup");		
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		meetup = em.find(Meetup.class, 1);
	}
	
	@Test
	void test_meetup_is_in_the_database() {
		assertEquals("French Food in Denver", meetup.getTitle());
		assertEquals("Let's get together and make some Creme Brule!", meetup.getDescription());
		assertEquals("2018-10-26 11:21:07", meetup.getCreateDate().toString().substring(0, 21));
		assertEquals("2018-11-09 12:00:00", meetup.getStartTime().toString());
		assertEquals("2018-11-09 18:00:00", meetup.getEndTime().toString());
		assertEquals(6, meetup.getMaxAttendance());
		
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