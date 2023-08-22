package com.jjtech.gamehub.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjtech.gamehub.models.Review;
import com.jjtech.gamehub.repositories.ReviewRepository;


@Service
public class ReviewService {
	@Autowired
	private ReviewRepository reviewRepo;
	
	// Gets all reviews (READ):
	public List<Review> getAllReviews() {
		return reviewRepo.findAll();
	}
	
	// Adds a new review (CREATE):
	public void addReview(Review review) {
		reviewRepo.save(review);
	}
	
	// Updates a review (UPDATE):
	public void updateReview(Review review) {
		reviewRepo.save(review);
	}
	
	// Finds a review by ID (READ):
	public Review findReviewById(Long id) {
		return reviewRepo.findById(id).orElse(null);
	}
	
	// Deletes a review (DELETE):
	public void deleteReview(Long id) {
		reviewRepo.deleteById(id);
	}
}
