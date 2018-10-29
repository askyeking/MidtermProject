package com.skilldistillery.recipemeetup.data;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import org.springframework.stereotype.Repository;
import com.skilldistillery.recipemeetup.entities.MeetupComment;
import com.skilldistillery.recipemeetup.entities.User;

@Transactional
@Repository
public class MeetupCommentDAOImpl implements MeetupCommentDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public MeetupComment postMeetupComment(MeetupComment comment, User author) {
		comment.setMeetupCommentOwner(author);
		em.persist(comment);
		em.flush();
		
		return comment;
	}

	@Override
	public List<MeetupComment> showAllMeetupComments() {
		String query = "SELECT comments FROM MeetupComment comments";
		List<MeetupComment> allComments = em.createQuery(query, MeetupComment.class)
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

}
