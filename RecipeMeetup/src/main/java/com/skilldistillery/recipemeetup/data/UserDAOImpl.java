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

//This class manages database interactions where User entity is involved.
@Transactional
@Repository
public class UserDAOImpl implements UserDAO {
	// PersistenceContext - All transactions are automatically started and committed, EntityManagerFactory is not required.
	@PersistenceContext
	private EntityManager em;

	// The method below will retrieve an existing user from a database, based on login and password matching the data in the DB.
	@Override
	public User loginUser(User user) {
		String username = user.getUsername();
		String password = user.getPassword();

		MessageDigest md = null;

		
		// The password is encrypted with MD5
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		md.update(password.getBytes());
		byte[] digest = md.digest();

		
		String hashedPass = DatatypeConverter.printHexBinary(digest).toLowerCase();

		//The hashed pass is saved to the DB instead of the literal
		user.setPassword(hashedPass);

		user = null;
		
		// The query retrieves the user from the DB and the return is set to that user.
		String query = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
		user = em.createQuery(query, User.class).setParameter("username", username).setParameter("password", hashedPass)
				.getSingleResult();

		return user;
	}

	
	// Checks if the username exists in the database and returns a user if one is found. This method is used for error checking on the login page.
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

	// The method below will persist a User to the database. 
	@Override
	public User createUser(User user, Address address) {
		
		// if User does not provide a URL for the image, we will set the url to a predifined link.
		if (user.getImgURL() == "" || user.getImgURL() == null) {
			user.setImgURL("https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg");
		}

		// User's password will be encrypted using MD5
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

		// encrypted password is persisted to the database
		user.setPassword(hashedPass);
		address.addUser(user);
		user.setActive(true);
		user.setAddress(address);
		
		//when address is persisted user is persisted with it (due to cascade type)
		em.persist(address);
//		em.persist(user);
		em.flush();

		return user;

	}

	// The method below takes updated user object and their address and persists the changes to the database
	@Override
	public User updateUser(User user, Address address) {
		User updatedUser = em.find(User.class, user.getId());

		Address updatedAddress = updatedUser.getAddress();

		updatedUser.setAdmin(user.getAdmin());
		updatedUser.setDateOfBirth(user.getDateOfBirth());
		updatedUser.setDescription(user.getDescription());
		updatedUser.setEmail(user.getEmail());
		updatedUser.setFirstName(user.getFirstName());

		// sets the imageURL only if the imageURL field is not left blank
		if (user.getImgURL() != "" && user.getImgURL() != null) {
			updatedUser.setImgURL(user.getImgURL());
		}

		updatedUser.setLastName(user.getLastName());
		// encrypts the password and updates the encrypted value in the DB
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

		updatedUser.setUsername(user.getUsername());

		updatedAddress.setStreet(address.getStreet());
		updatedAddress.setCity(address.getCity());
		updatedAddress.setState(address.getState());
		updatedAddress.setPostalCode(address.getPostalCode());
		updatedUser.setAddress(updatedAddress);

		return updatedUser;
	}

	// removes a user from the database. This method is not used in the app. Instead the user can setActiveToFalse (see method below).
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
	
	// removes a user from the database. This method is not used in the app. Instead the user can setActiveToFalse (see method below).
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

	//retrieves a user where a keyword can be matched to the username, first name or the last name of the user
	@Override
	public List<User> getUserByName(String inputName) {
		String query = "SELECT u FROM User u  where username like :name or firstName like :name or lastName like :name or username like :name";
		List<User> usersFoundByName = em.createQuery(query, User.class).setParameter("name", "%" + inputName + "%")
				.getResultList();
		return usersFoundByName;
	}

	// retrieves a user from the DB whose primary key matches int id
	@Override
	public User getUserById(int id) {
		User user = em.find(User.class, id);
		return user;
	}

	// Sets a boolean Active to false. In the front end, users where Active has a false value will not be displayed.
	@Override
	public User setActiveToFalse(User user) {
		user = em.find(User.class, user.getId());
		user.setActive(false);
		return user;
	}

}
