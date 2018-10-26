package com.skilldistillery.recipemeetup.data;

import com.skilldistillery.recipemeetup.entities.User;

public interface UserDAO {
	
	User loginUser (String userName, String password);

}
