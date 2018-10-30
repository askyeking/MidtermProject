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

@Transactional
@Repository
public class MeetupDAOImpl implements MeetupDAO {
	
	
	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Meetup findSingleMeetup(int meetupId) {
		String jpql = "SELECT meetup FROM Meetup meetup";
		Meetup meetup = em.find(Meetup.class, meetupId);
		return meetup;
	}
	
	@Override
	public Meetup showMeetup(Meetup meetup) {
		Meetup singleMeetup = em.find(Meetup.class, meetup.getId());
		return singleMeetup;
	}
	
	@Override
	public List<Meetup> findAllMeetups() {
		String jpql = "SELECT meetup FROM Meetup meetup";
		List<Meetup> meetups = em.createQuery(jpql, Meetup.class).getResultList();
		return meetups;
	}
	
	
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
	
	@Override
	public Meetup updateMeetup(Meetup meetup) {
		Meetup updatedMeetup = em.find(Meetup.class, meetup.getId());
		updatedMeetup.setTitle(meetup.getTitle());
		updatedMeetup.setDescription(meetup.getDescription());
		updatedMeetup.setImgURL(meetup.getImgURL());
		updatedMeetup.setActive(meetup.getActive());
		updatedMeetup.setStartTime(meetup.getStartTime());
		updatedMeetup.setEndTime(meetup.getEndTime());
		updatedMeetup.setMaxAttendance(meetup.getMaxAttendance());
		
		return updatedMeetup;
	}
	
	@Override
	public Meetup createMeetup(Meetup meetup, User user, Address address) {
		// Inside controller set authorId to User ID
//		em.persist(address);
//		meetup.setMeetupAddress(address);
//		meetup.setMeetupOwner(user);
//		em.persist(meetup);
		user.addMeetupOwned(meetup);
		meetup.setMeetupOwner(user);
		
		address.addMeetups(meetup);
		meetup.setMeetupAddress(address);
		//Who should I persist?
		
//		em.persist(add);
		
		em.persist(address);
		
		
		
		em.flush();
		return meetup;
	}
	
	@Override
	public Meetup setActiveToFalse(Meetup meetup) {
		meetup.setActive(false);
		return meetup;
		
	}
	
	@Override
	public List<Meetup> findRecentMeetups(){
		String jpql = "SELECT meetup from Meetup meetup ORDER BY createDate DESC";
		//select * from meetup order by date_created asc limit 5;
		List<Meetup> recentMeetups = em.createQuery(jpql, Meetup.class).setMaxResults(5).getResultList();
		return recentMeetups;
	}
	
	@Override
	public List<Meetup> findMeetup(String meetup) {
	List<Meetup> meetups = new ArrayList<>();
	String query = "SELECT m FROM Meetup m WHERE m.title LIKE :title OR m.description LIKE :desc";
	meetups = em.createQuery(query, Meetup.class)
			.setParameter("title", "%" + meetup + "%")
			.setParameter("desc", "%" + meetup + "%")
			.getResultList();
	
	return meetups;
			
	}
}
