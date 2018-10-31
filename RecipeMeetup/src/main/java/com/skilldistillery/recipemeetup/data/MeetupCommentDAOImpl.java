package com.skilldistillery.recipemeetup.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.Meetup;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.User;

@Transactional
@Repository
public class MeetupCommentDAOImpl implements MeetupCommentDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public MeetupComment postMeetupComment(Meetup meetup, MeetupComment comment, User author) {
		author.addMeetupCommentPosted(comment);
		comment.setMeetupCommentOwner(author);
		
		meetup.addMeetupComment(comment);
		comment.setMeetupCommentedOn(meetup);
		
		em.persist(comment);
		em.flush();
		
		return comment;
	}

	@Override
	public List<MeetupComment> showAllMeetupComments(int id) {
		String query = "SELECT comments FROM MeetupComment comments WHERE comments.meetupCommentedOn.id = :id";
		List<MeetupComment> allComments = em.createQuery(query, MeetupComment.class)
				.setParameter("id", id)
				.getResultList();
		return allComments;
	}

	@Override
	public MeetupComment editMeetupComment(MeetupComment updateComment, User author) {
		MeetupComment editComment = em.find(MeetupComment.class, updateComment);
		updateComment.setMeetupCommentOwner(author);
		editComment.setTextContent(updateComment.getTextContent());
		return editComment;
	}

	@Override
	public boolean deleteMeetupComment(MeetupComment comment, User author) {
		int id = comment.getId();
		comment.setMeetupCommentOwner(author);
		author.removeMeetupCommentPosted(comment);
		boolean isCommentDeleted = false;
		if(comment != null) {
			em.remove(comment);
			if(em.find(MeetupComment.class, id) == null) {
				isCommentDeleted = true;
			}
		}
		return isCommentDeleted;
	}

	@Override
	public boolean deleteMeetupCommentById(int id) {
		MeetupComment deleteComment = em.find(MeetupComment.class, id);
		boolean isCommentDeleted = false;
		if(deleteComment != null) {
			em.remove(deleteComment);
			if(em.find(MeetupComment.class, id) == null) {
				isCommentDeleted = true;
			}
		}
		return isCommentDeleted;
	}
	
	@Override
	public MeetupComment setActiveToFalse(MeetupComment meetupComment) {
		meetupComment = em.find(MeetupComment.class, meetupComment.getId());
		meetupComment.setActive(false);
		return meetupComment;
	}

}
