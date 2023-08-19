package com.jjtech.gamehub.models;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "status")
public class Status {
	// MODEL STRUCTURE
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String state;
	
	// RELATIONSHIPS
	@OneToMany(
			mappedBy = "status", 
			fetch = FetchType.EAGER
	)
	private List<User> users;
	
	// CONSTRUCTORS
	public Status() {
	}

	public Status(String state) {
		super();
		this.state = state;
	}

	public Status(String state, List<User> users) {
		super();
		this.state = state;
		this.users = users;
	}

	// GETTERS AND SETTERS
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
}
