package com.skilldistillery.recipemeetup.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.Recipe;
import com.skilldistillery.recipemeetup.entities.User;

//This class manages database interactions where Meetup entity is involved.
@Transactional
@Repository
public class MeetupDAOImpl implements MeetupDAO {
	
	// PersistenceContext - All transactions are automatically started and committed, EntityManagerFactory is not required.
	@PersistenceContext
	private EntityManager em;
	
	// Returns a single meetup from the DB found by the id which correlates with the primary key
	@Override
	public Meetup findSingleMeetup(int meetupId) {
		Meetup meetup = em.find(Meetup.class, meetupId);
		return meetup;
	}
	
	// Finds a single meetup in the DB
	@Override
	public Meetup showMeetup(Meetup meetup) {
		Meetup singleMeetup = em.find(Meetup.class, meetup.getId());
		return singleMeetup;
	}
	
	// Takes all meetups from the database and returns them as a list
	@Override
	public List<Meetup> findAllMeetups() {
		String jpql = "SELECT meetup FROM Meetup meetup";
		List<Meetup> meetups = em.createQuery(jpql, Meetup.class).getResultList();
		return meetups;
	}
	
	
	// removes a meetup from the database. setActiveToFalse is generally used instead, as it keeps data in the DB.
	@Override
	public boolean deleteMeetup(Meetup meetup) {
		int id = meetup.getId();
		boolean isMeetupDeleted = false;
		if (meetup != null) {
			em.remove(meetup);
			if (em.find(Meetup.class, id) == null) {
				isMeetupDeleted = true;
			}
		}

		return isMeetupDeleted;
		
	}
	
	// removes a meetup from the database. setActiveToFalse is generally used instead, as it keeps data in the DB.
	public boolean deleteMeetupById(int id) {
		Meetup meetup = em.find(Meetup.class, id);
		boolean isMeetupDeleted = false;

		if (meetup != null) {
			em.remove(meetup);
			if (em.find(User.class, id) == null) {
				isMeetupDeleted = true;
			}
		}

		return isMeetupDeleted;
		
	}
	
	// takes a meetup and an address and updates info of an existing meetup and its address to the updated data.
	@Override 
	public Meetup updateMeetup(Meetup meetup, Address address) {
		Meetup updatedMeetup = em.find(Meetup.class, meetup.getId());
		Address updatedAddress = updatedMeetup.getMeetupAddress();
		
		updatedMeetup.setTitle(meetup.getTitle());
		updatedMeetup.setDescription(meetup.getDescription());
		
		if (meetup.getImgURL() != "" && meetup.getImgURL() != null) {
			updatedMeetup.setImgURL(meetup.getImgURL());
		}
		updatedMeetup.setStartTime(meetup.getStartTime());
		updatedMeetup.setEndTime(meetup.getEndTime());
		updatedMeetup.setMaxAttendance(meetup.getMaxAttendance());

		updatedAddress.setStreet(address.getStreet());
		updatedAddress.setCity(address.getCity());
		updatedAddress.setState(address.getState());
		updatedAddress.setPostalCode(address.getPostalCode());
		updatedMeetup.setMeetupAddress(updatedAddress);
		
		return updatedMeetup;
	}
	
	// persists a meetup into the database.
	@Override
	public Meetup createMeetup(Meetup meetup, User user, Address address) {
		
		// if image URL is empty, provide the default url
		if(meetup.getImgURL() == "" || meetup.getImgURL() == null) {
			meetup.setImgURL("https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg");
		}
			
			
		user.addMeetupOwned(meetup);
		meetup.setMeetupOwner(user);
		
		address.addMeetups(meetup);
		meetup.setMeetupAddress(address);
		
		em.persist(address);
		em.flush();
		return meetup;
	}
	
	// if a active is set to 0, the meetup will not be publicly shown in the DB.
	@Override
	public Meetup setActiveToFalse(Meetup meetup) {
		meetup = em.find(Meetup.class, meetup.getId());
		meetup.setActive(false);
		
		return meetup;
		
	}
	
	// Returns a list of 3 most recently posted meetups which hava active set to true.
	@Override
	public List<Meetup> findRecentMeetups(){
		String jpql = "SELECT meetup from Meetup meetup where active='1' ORDER BY createDate DESC";
		//select * from meetup order by date_created asc limit 5;
		List<Meetup> recentMeetups = em.createQuery(jpql, Meetup.class).setMaxResults(3).getResultList();
		return recentMeetups;
	}
	
	// returns a list of meetups, found by keyword which is searched for in the description, title, and city.
	@Override
	public List<Meetup> findMeetup(String meetup) {
	List<Meetup> meetups = new ArrayList<>();
	String query = "SELECT m FROM Meetup m WHERE m.title LIKE :desc OR m.description LIKE :desc OR m.meetupAddress.city LIKE :desc";
	meetups = em.createQuery(query, Meetup.class)
			.setParameter("desc", "%" + meetup + "%")
			.getResultList();
	
	return meetups;
			
	}
	
	//  Adds a meetup to the user's list of attended meetups and the user to the list of attendees of a meetup. Persists changes to the DB.
	@Override
	public Meetup addRSVPForMeetup(Meetup meetup, User user){

		Meetup reservedMeetup = em.find( Meetup.class ,meetup.getId());
		List<User> meetupAttendees = reservedMeetup.getAttendees();
		if(!meetupAttendees.contains(user)) {
			reservedMeetup.addAttendee(user);
			user.addMeetupAttended(reservedMeetup);
			em.persist(reservedMeetup);
			em.flush();

		}
		return reservedMeetup;
	}
}
