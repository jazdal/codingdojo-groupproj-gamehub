package com.jjtech.gamehub.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjtech.gamehub.models.Status;
import com.jjtech.gamehub.repositories.StatusRepository;

@Service
public class StatusService {
	@Autowired
	private StatusRepository statusRepo;
	
	// Finds a status
	public Status findStatus(String state) {
		return statusRepo.findByState(state);
	}
}
