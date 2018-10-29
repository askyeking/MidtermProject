package com.skilldistillery.recipemeetup.data;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import org.springframework.stereotype.Repository;
import com.skilldistillery.recipemeetup.entities.RecipeComment;
import com.skilldistillery.recipemeetup.entities.User;

@Transactional
@Repository
public class RecipeCommentDAOImpl implements RecipeCommentDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public RecipeComment postRecipeComment(RecipeComment comment, User author) {
		author.addRecipeComment(comment);
		comment.setRecipeCommentOwner(author);
		em.persist(comment);
		em.flush();
		return comment;
	}

	@Override
	public List<RecipeComment> showAllRecipeComments() {
		String query = "SELECT comments FROM RecipeComment comments";
		List<RecipeComment> allComments = em.createQuery(query, RecipeComment.class)
				.getResultList();
		return allComments;
	}
	
	@Override
	public RecipeComment editRecipeComment(RecipeComment updateComment, User author) {
		RecipeComment editComment = em.find(RecipeComment.class, updateComment);
		updateComment.setRecipeCommentOwner(author);
		editComment.setComment(updateComment.getComment());
		return editComment;
	}

	@Override
	public boolean deleteRecipeComment(RecipeComment comment, User author) {
		int id = comment.getId();
		comment.setRecipeCommentOwner(author);
		author.removeRecipeComment(comment);
		boolean isCommentDeleted = false;
		if(comment != null) {
			em.remove(comment);
			if(em.find(RecipeComment.class, id) == null) {
				isCommentDeleted = true;
			}
		}
		return isCommentDeleted;
	}

	@Override
	public boolean deleteRecipeCommentById(int id) {
		RecipeComment deleteComment = em.find(RecipeComment.class, id);
		boolean isCommentDeleted = false;
		if(deleteComment != null) {
			em.remove(deleteComment);
			if(em.find(RecipeComment.class, id) == null) {
				isCommentDeleted = true;
			}
		}
		
		return isCommentDeleted;
	}



}
