package com.skilldistillery.recipemeetup.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.User;

@Transactional
@Repository
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User loginUser(User user) {
		String username = user.getUsername();
		String password = user.getPassword();
		user = null;
		
		String query = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
		user = em.createQuery(query, User.class).setParameter("username", username)
				.setParameter("password", password).getSingleResult();

		return user;
	}

	@Override
	public User isLegitimateUsername(String username) {
		User user =null;
		String query = "SELECT u FROM User u WHERE u.username = :username";
		user = em.createQuery(query, User.class).setParameter("username", username).getSingleResult();
		return user;
	}

	@Override
	public User createUser(User user) {
		em.persist(user);
		em.flush();
		
		return user;

	}

	@Override
	public User updateUser(User updatedUser) {
		User editedUser = em.find(User.class, updatedUser.getId());

		editedUser.setActive(updatedUser.getActive());
		editedUser.setAdmin(updatedUser.getAdmin());
		editedUser.setAddress(updatedUser.getAddress());
		editedUser.setCreateDate(updatedUser.getCreateDate());
		editedUser.setDateOfBirth(updatedUser.getDateOfBirth());
		editedUser.setDescription(updatedUser.getDescription());
		editedUser.setEmail(updatedUser.getEmail());
		editedUser.setFavoriteRecipes(updatedUser.getFavoriteRecipes());
		editedUser.setFirstName(updatedUser.getFirstName());
		editedUser.setId(updatedUser.getId());
		editedUser.setImgURL(updatedUser.getImgURL());
		editedUser.setLastName(updatedUser.getLastName());
		editedUser.setLikedMeetupComments(updatedUser.getLikedMeetupComments());
		editedUser.setLikedRecipeComments(updatedUser.getLikedRecipeComments());
		editedUser.setLikedRecipes(updatedUser.getLikedRecipes());
		editedUser.setMeetupCommentsPosted(updatedUser.getMeetupCommentsPosted());
		editedUser.setMeetupsAttended(updatedUser.getMeetupsAttended());
		editedUser.setMeetupsOwned(updatedUser.getMeetupsOwned());
		editedUser.setPassword(updatedUser.getPassword());
		editedUser.setRecipeComments(updatedUser.getRecipeComments());
		editedUser.setRecipesPosted(updatedUser.getRecipesPosted());
		editedUser.setUsername(updatedUser.getUsername());

		return editedUser;
	}

	@Override
	public boolean deleteUser(User user) {
		int id = user.getId();
		boolean isUserDeleted = false;
		if (user != null) {
			em.remove(user);
			if (em.find(User.class, id) == null) {
				isUserDeleted = true;
			}
		}

		return isUserDeleted;
	}

	@Override
	public boolean deleteUserById(int id) {
		User user = em.find(User.class, id);
		boolean isUserDeleted = false;

		if (user != null) {
			em.remove(user);
			if (em.find(User.class, id) == null) {
				isUserDeleted = true;
			}
		}

		return isUserDeleted;
	}

	@Override
	public List<User> getUserByName(String inputName) {
		String query = "SELECT u FROM User u  where username like :name or firstName like :name or lastName like :name";
		List<User> usersFoundByName = em.createQuery(query, User.class).setParameter("name", "%" +inputName + "%").getResultList();
		return usersFoundByName;
	}

}
