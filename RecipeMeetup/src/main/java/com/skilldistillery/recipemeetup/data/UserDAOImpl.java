package com.skilldistillery.recipemeetup.data;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Repository;

import com.skilldistillery.recipemeetup.entities.Address;
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

		MessageDigest md = null;

		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		md.update(password.getBytes());
		byte[] digest = md.digest();

		String hashedPass = DatatypeConverter.printHexBinary(digest).toLowerCase();

		user.setPassword(hashedPass);

		user = null;

		String query = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
		user = em.createQuery(query, User.class).setParameter("username", username).setParameter("password", hashedPass)
				.getSingleResult();

		return user;
	}

	@Override
	public User isLegitimateUsername(User user) {

		String username = user.getUsername();
		User retrievedUser = null;
		String query = "SELECT u FROM User u WHERE u.username = :username";

		try {
			retrievedUser = em.createQuery(query, User.class).setParameter("username", username).getSingleResult();
			if (retrievedUser.getActive() == false) {
				retrievedUser = null;
			}
		} catch (NoResultException e) {
			retrievedUser = null;
		}

		return retrievedUser;
	}

	@Override
	public User createUser(User user, Address address) {
		if (user.getImgURL() == "" || user.getImgURL() == null) {
			user.setImgURL("https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg");
		}

		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		String password = user.getPassword();

		md.update(password.getBytes());
		byte[] digest = md.digest();

		String hashedPass = DatatypeConverter.printHexBinary(digest).toLowerCase();

		user.setPassword(hashedPass);
		address.addUser(user);
		user.setActive(true);
		user.setAddress(address);
		em.persist(address);
//		em.persist(user);
		em.flush();
		System.out.println(address);

		return user;

	}

	@Override
	public User updateUser(User user, Address address) {

		User updatedUser = em.find(User.class, user.getId());

//		if(user.getImgURL() == "" || user.getImgURL() == null) {
		System.out.println(updatedUser);
		Address updatedAddress = updatedUser.getAddress();
		System.out.println(updatedAddress);

//		updatedUser.setActive(user.getActive());
		updatedUser.setAdmin(user.getAdmin());
//		updatedUser.setCreateDate(user.getCreateDate());
		updatedUser.setDateOfBirth(user.getDateOfBirth());
		updatedUser.setDescription(user.getDescription());
		updatedUser.setEmail(user.getEmail());
//		updatedUser.setRecipesFavorited(user.getRecipesFavorited());
		updatedUser.setFirstName(user.getFirstName());
//		updatedUser.setId(user.getId());

		if (user.getImgURL() != "" && user.getImgURL() != null) {
			updatedUser.setImgURL(user.getImgURL());
		}

		updatedUser.setLastName(user.getLastName());
//		updatedUser.setLikedMeetupComments(user.getLikedMeetupComments());
//		updatedUser.setLikedRecipeComments(user.getLikedRecipeComments());
//		updatedUser.setLikedRecipes(user.getLikedRecipes());
//		updatedUser.setMeetupCommentsPosted(user.getMeetupCommentsPosted());
//		updatedUser.setMeetupsAttended(user.getMeetupsAttended());
//		updatedUser.setMeetupsOwned(user.getMeetupsOwned());
//		updatedUser.setPassword(user.getPassword());

		if (user.getPassword() != "" && user.getPassword() != null) {
			try {
				MessageDigest md = MessageDigest.getInstance("MD5");
				String password = user.getPassword();
				md.update(password.getBytes());

				byte[] digest = md.digest();

				String hashedPass = DatatypeConverter.printHexBinary(digest).toLowerCase();

				user.setPassword(hashedPass);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		}

//		updatedUser.setRecipeComments(user.getRecipeComments());
//		updatedUser.setRecipesPosted(user.getRecipesPosted());
		updatedUser.setUsername(user.getUsername());

		updatedAddress.setStreet(address.getStreet());
		updatedAddress.setCity(address.getCity());
		updatedAddress.setState(address.getState());
		updatedAddress.setPostalCode(address.getPostalCode());
		updatedUser.setAddress(updatedAddress);

		return updatedUser;
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
		List<User> usersFoundByName = em.createQuery(query, User.class).setParameter("name", "%" + inputName + "%")
				.getResultList();
		return usersFoundByName;
	}

	@Override
	public User getUserById(int id) {
		User user = em.find(User.class, id);
		return user;
	}

	@Override
	public User setActiveToFalse(User user) {
		user = em.find(User.class, user.getId());
		user.setActive(false);
		return user;
	}

}
