package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.Address;
import com.skilldistillery.recipemeetup.entities.User;

public interface UserDAO {

	User loginUser(User user);

	User isLegitimateUsername(User user);

	User createUser(User user, Address address);

	User updateUser(User updatedUser);

	boolean deleteUser(User user);

	boolean deleteUserById(int id);

	public List<User> getUserByName(String inputName);

}
