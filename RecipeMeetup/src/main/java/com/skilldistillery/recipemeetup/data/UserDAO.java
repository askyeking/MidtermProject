package com.skilldistillery.recipemeetup.data;

import java.util.List;

import com.skilldistillery.recipemeetup.entities.User;

public interface UserDAO {

	User loginUser(User user);

	User isLegitimateUsername(String username);

	User createUser(User user);

	User updateUser(User updatedUser);

	boolean deleteUser(User user);

	boolean deleteUserById(int id);

	public List<User> getUserByName(String inputName);

}
