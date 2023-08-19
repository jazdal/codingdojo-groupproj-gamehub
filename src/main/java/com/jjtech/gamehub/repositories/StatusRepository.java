package com.jjtech.gamehub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.jjtech.gamehub.models.Status;

public interface StatusRepository extends CrudRepository<Status, Long> {
	List<Status> findAll();
	Status findByState(String state);
}
