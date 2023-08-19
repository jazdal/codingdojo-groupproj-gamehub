package com.jjtech.gamehub.models;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "reviews")
public class Review {
	// MODEL STRUCTURE
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotBlank(message = "Game review is required.")
	@Size(min = 5, message = "Game review length must be at least 5 characters.")
	@Column(columnDefinition = "TEXT")
	private String gameReview;
	
	@NotNull(message = "Game rating is required.")
	private Integer rating;
	
	@Column(updatable = false)
	private Date createdAt;
	
	@PrePersist
	private void onCreate() {
		this.createdAt = new Date();
	}
	
	private Date updatedAt;
	
	@PreUpdate
	private void onUpdate() {
		this.updatedAt = new Date();
	}
	
	// RELATIONSHIPS
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "game_id")
	private Game game;
	
	// CONSTRUCTORS
	public Review() {
	}

	public Review(
			String gameReview,
			Integer rating, 
			User user, 
			Game game
			) {
		super();
		this.gameReview = gameReview;
		this.rating = rating;
		this.user = user;
		this.game = game;
	}

	// GETTERS AND SETTERS
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGameReview() {
		return gameReview;
	}

	public void setGameReview(String gameReview) {
		this.gameReview = gameReview;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}
}
