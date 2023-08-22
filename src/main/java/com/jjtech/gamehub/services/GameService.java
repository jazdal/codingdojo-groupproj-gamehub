package com.jjtech.gamehub.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjtech.gamehub.models.Game;
import com.jjtech.gamehub.models.User;
import com.jjtech.gamehub.repositories.GameRepository;

@Service
public class GameService {
	@Autowired
	private GameRepository gameRepo;
	
	// Gets all games (READ):
	public List<Game> getAllGames() {
		return gameRepo.findAll();
	}
	
	// Adds a new game (CREATE):
	public void addGame(Game game) {
		gameRepo.save(game);
	}
	
	// Updates a game (UPDATE):
	public void updateGame(Game game) {
		gameRepo.save(game);
	}
	
	// Finds a game by ID (READ):
	public Game findGameById(Long id) {
		return gameRepo.findById(id).orElse(null);
	}
	
	// Deletes a game (DELETE):
	public void deleteGame(Long id) {
		gameRepo.deleteById(id);
	}
	
	// Like a game:
	public void likeGame(Game thisGame, User currentUser) {
		List<User> currentLikers = thisGame.getLikers();
		currentLikers.add(currentUser);
		thisGame.setLikers(currentLikers);
		gameRepo.save(thisGame);
	}
	
	// Unlike a game:
	public void unlikeGame(Game thisGame, User currentUser) {
		List<User> currentLikers = thisGame.getLikers();
		currentLikers.remove(currentUser);
		thisGame.setLikers(currentLikers);
		gameRepo.save(thisGame);
	}
}
