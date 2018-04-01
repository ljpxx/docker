package com.dao;

import java.util.List;

import com.domain.User;

public interface Userdao {
	void save(User user);
	User findbyusername(String name);
	void delete(String id);
	void update(User user);
	User findById(String id);
	List<User> findAll();
	User savefindsame(String id,String name);
	
}
