package com.jjtech.gamehub.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;

import com.jjtech.gamehub.models.Role;
import com.jjtech.gamehub.models.Status;
import com.jjtech.gamehub.repositories.RoleRepository;
import com.jjtech.gamehub.repositories.StatusRepository;

public class DatabaseInitializer implements CommandLineRunner {
	@Autowired
	private RoleRepository roleRepo;
	
	@Autowired
	private StatusRepository statusRepo;

	@Override
	public void run(String... args) throws Exception {
		createRole("ROLE_ADMIN");
		createRole("ROLE_USER");
		createStatus("STATUS_ACTIVE");
		createStatus("STATUS_INACTIVE");
		createStatus("STATUS_BANNED");
	}
	
	private void createRole(String roleName) {
		Role role = roleRepo.findByName(roleName);
		
		if (role == null) {
			role = new Role(roleName);
			roleRepo.save(role);
		}
	}
	
	private void createStatus(String statusName) {
		Status status = statusRepo.findByState(statusName);
		
		if (status == null) {
			status = new Status(statusName);
			statusRepo.save(status);
		}
	}
}
