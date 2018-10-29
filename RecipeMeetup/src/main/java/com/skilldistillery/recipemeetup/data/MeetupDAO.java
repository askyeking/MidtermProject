package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.User;

public interface MeetupDAO {

	Meetup findSingleMeetup(int meetupId);

	List<Meetup> findAllMeetups();


	boolean deleteMeetup(Meetup meetup);

	Meetup createMeetup(Meetup meetup, User user, Address address);

	Meetup updateMeetup(Meetup meetup);

	Meetup setActiveToFalse(Meetup meetup);

	List<Meetup> findRecentMeetups();

	Meetup showMeetup(Meetup meetup);

	List<Meetup> findMeetup(String meetup);

	
}
