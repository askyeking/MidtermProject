package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.User;


public interface MeetupCommentDAO {
	
	MeetupComment postMeetupComment(Meetup meetup, MeetupComment comment, User author);
	List<MeetupComment> showAllMeetupComments(int id);
	MeetupComment editMeetupComment(MeetupComment updateComment, User author);
	boolean deleteMeetupComment(MeetupComment comment, User author);
	boolean deleteMeetupCommentById(int id);

}
