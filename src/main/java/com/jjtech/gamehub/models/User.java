package com.jjtech.gamehub.models;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {
	// MODEL STRUCTURE
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotBlank(message = "Username is required.")
	@Size(min = 3, max = 80, message = "Username length must be between 3-80 characters.")
	private String username;
	
	@NotBlank(message = "First name is required.")
	@Size(min = 3, max = 80, message = "First name length must be between 3-80 characters.")
	private String firstName;
	
	@NotBlank(message = "Last name is required.")
	@Size(min = 3, max = 80, message = "Last name length must be between 3-80 characters.")
	private String lastName;
	
	@NotBlank(message = "Email is required.")
	@Size(min = 5, message = "Email length must be at least 5 characters.")
	@Email
	private String email;
	
	private String imgUrl;
	
	@NotNull(message = "Date of birth is required.")
	@Past(message = "Date of birth must not be in the present or future.")
	private LocalDate birthday;
	
	@Column(columnDefinition = "TEXT")
	private String bio;
	
	@NotBlank(message = "Password is required.")
	@Size(min = 8, max = 80, message = "Password length must be between 8-80 characters.")
    @Pattern(regexp = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!]).*$", message = "Password must contain at least one uppercase letter, one number, and one special character.")
	private String password;
	
	@Transient
	private String confirmPassword;
	
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
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "role_id")
	private Role role;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "status_id")
	private Status status;
	
	@OneToMany(
			mappedBy = "user", 
			fetch = FetchType.LAZY
	)
	private List<Review> reviews;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "owned_games", 
			joinColumns = @JoinColumn(name = "user_id"), 
			inverseJoinColumns = @JoinColumn(name = "game_id")
	)
	private List<Game> ownedGames;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "likes", 
			joinColumns = @JoinColumn(name = "user_id"), 
			inverseJoinColumns = @JoinColumn(name = "game_id")
	)
	private List<Game> likedGames;
	
	// CONSTRUCTORS
	public User() {
	}

	public User(
			String username,
			String firstName,
			String lastName,
			String email,
			String imgUrl,
			LocalDate birthday,
			String bio,
			String password,
			String confirmPassword, 
			Role role, 
			Status status, 
			List<Review> reviews, 
			List<Game> ownedGames,
			List<Game> likedGames
			) {
		super();
		this.username = username;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.imgUrl = imgUrl;
		this.birthday = birthday;
		this.bio = bio;
		this.password = password;
		this.confirmPassword = confirmPassword;
		this.role = role;
		this.status = status;
		this.reviews = reviews;
		this.ownedGames = ownedGames;
		this.likedGames = likedGames;
	}

	// GETTERS AND SETTERS
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public LocalDate getBirthday() {
		return birthday;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
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

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public List<Game> getOwnedGames() {
		return ownedGames;
	}

	public void setOwnedGames(List<Game> ownedGames) {
		this.ownedGames = ownedGames;
	}

	public List<Game> getLikedGames() {
		return likedGames;
	}

	public void setLikedGames(List<Game> likedGames) {
		this.likedGames = likedGames;
	}
}
