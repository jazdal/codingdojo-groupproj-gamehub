package com.jjtech.gamehub.models;

import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "games")
public class Game {
	// MODEL STRUCTURE
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotBlank(message = "Game title is required.")
	@Size(min = 2, max = 160, message = "Game title length must be between 2-160 characters.")
	private String title;
	
	@NotBlank(message = "Genre is required.")
	private String genre;
	
	@NotBlank(message = "Game description is required.")
	@Size(min = 5, message = "Game description must be at least 5 characters long.")
	@Column(columnDefinition = "TEXT")
	private String description;
	
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
	@OneToMany(
			mappedBy = "game", 
			fetch = FetchType.LAZY, 
			cascade = CascadeType.ALL
	)
	private List<Review> reviews;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "owned_games", 
			joinColumns = @JoinColumn(name = "game_id"), 
			inverseJoinColumns = @JoinColumn(name = "user_id")
	)
	private List<User> owners;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "likes", 
			joinColumns = @JoinColumn(name = "game_id"), 
			inverseJoinColumns = @JoinColumn(name = "user_id")
	)
	private List<User> users;
	
	// CONSTRUCTORS
	public Game() {
	}

	public Game(
			String title,
			String genre,
			String description,
			List<Review> reviews, 
			List<User> owners, 
			List<User> users
			) {
		super();
		this.title = title;
		this.genre = genre;
		this.description = description;
		this.reviews = reviews;
		this.owners = owners;
		this.users = users;
	}

	// GETTERS AND SETTERS
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public List<User> getOwners() {
		return owners;
	}

	public void setOwners(List<User> owners) {
		this.owners = owners;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
}
