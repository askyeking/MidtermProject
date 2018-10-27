package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Meetup;

public interface MeetupDAO {

	Meetup findSingleMeetup(int meetupId);

	List<Meetup> findAllMeetups();


	boolean deleteMeetup(Meetup meetup);

	void createMeetup(Meetup meetup);

	Meetup updateMeetup(Meetup meetup);

	Meetup setActiveToFalse(Meetup meetup);

	List<Meetup> findRecentMeetups();

	
}
