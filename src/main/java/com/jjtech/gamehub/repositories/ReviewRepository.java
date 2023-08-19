package com.jjtech.gamehub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.jjtech.gamehub.models.Review;

public interface ReviewRepository extends CrudRepository<Review, Long> {
	List<Review> findAll();
}
