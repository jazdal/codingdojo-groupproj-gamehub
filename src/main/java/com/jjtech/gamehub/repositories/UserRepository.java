package com.jjtech.gamehub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.jjtech.gamehub.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	List<User> findAll();
	User findByUsername(String username);
	User findByEmail(String email);
}
