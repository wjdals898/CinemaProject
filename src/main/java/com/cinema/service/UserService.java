package com.cinema.service;

import com.cinema.dto.UserDTO;
import com.cinema.model.UserDAO;

public class UserService {
	
	UserDAO userDao = new UserDAO();
	
	public UserDTO selectByUsername(String username) {
		return userDao.selectByUsername(username);
	}
	public UserDTO login(String username, String password) {
		return userDao.login(username, password);
	}

	public int signup(UserDTO user) {
		return userDao.signup(user);
	}

}
