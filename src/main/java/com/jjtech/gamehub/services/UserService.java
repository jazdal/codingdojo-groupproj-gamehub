package com.jjtech.gamehub.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.jjtech.gamehub.models.Status;
import com.jjtech.gamehub.models.User;
import com.jjtech.gamehub.repositories.RoleRepository;
import com.jjtech.gamehub.repositories.StatusRepository;
import com.jjtech.gamehub.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private RoleRepository roleRepo;
	
	@Autowired
	private StatusRepository statusRepo;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPwEncoder;
	
	// Gets all users (READ):
	public List<User> getAllUsers() {
		return userRepo.findAll();
	}
	
	public List<User> getAllUsersByStatus(Status status) {
		return userRepo.findAllByStatus(status);
	}
	
	// Creates a new user (CREATE):
	public void createUser(User user, String role, String status) {
		user.setPassword(bCryptPwEncoder.encode(user.getPassword()));
		user.setRole(roleRepo.findByName(role));
		user.setStatus(statusRepo.findByState(status));
		userRepo.save(user);
	}
	
	// Updates a user (UPDATE):
	public void updateUser(User user) {
		userRepo.save(user);
	}
	
	// Finds a user by ID (READ):
	public User findUserById(Long id) {
		return userRepo.findById(id).orElse(null);
	}
	
	// Finds a user by username (READ):
	public User findUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	
	// Finds a user by email (READ):
	public User findUserByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	// Ban a user:
	public User banUser(Long id) {
		User badUser = userRepo.findById(id).orElse(null);
		
		if (badUser != null) {
			badUser.setStatus(statusRepo.findByState("STATUS_BANNED"));
		}
		return userRepo.save(badUser);
	}
	
	// Deactivate a user:
	public User deactivateUser(Long id) {
		User lazyUser = userRepo.findById(id).orElse(null);
		
		if (lazyUser != null) {
			lazyUser.setStatus(statusRepo.findByState("STATUS_INACTIVE"));
		}
		return userRepo.save(lazyUser);
	}

	// Unban or activate a user:
	public User activateUser(Long id) {
		User activeUser = userRepo.findById(id).orElse(null);
		
		if (activeUser != null) {
			activeUser.setStatus(statusRepo.findByState("STATUS_ACTIVE"));
		}
		return userRepo.save(activeUser);
	}
}
