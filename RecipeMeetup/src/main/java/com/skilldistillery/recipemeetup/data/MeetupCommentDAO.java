package com.skilldistillery.recipemeetup.data;

import java.util.List;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.User;


public interface MeetupCommentDAO {
	
	MeetupComment postMeetupComment(MeetupComment comment, User author);
	List<MeetupComment> showAllMeetupComments();
	MeetupComment editMeetupComment(MeetupComment updateComment, User author);
	boolean deleteMeetupComment(MeetupComment comment, User author);
	boolean deleteMeetupCommentById(int id);

}
