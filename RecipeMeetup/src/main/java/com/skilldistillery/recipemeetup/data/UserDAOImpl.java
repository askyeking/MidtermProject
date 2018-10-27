package com.skilldistillery.recipemeetup.data;

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
	public User loginUser(String username, String password) {
		String query = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
		User user = em.createQuery(query, User.class)
				.setParameter("username", username)
				.setParameter("password", password)
				.getSingleResult();
				
		em.close();
		return user;
	}
	
	

}
