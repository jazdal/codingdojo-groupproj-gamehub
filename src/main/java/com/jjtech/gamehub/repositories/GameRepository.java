package com.jjtech.gamehub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.jjtech.gamehub.models.Game;

public interface GameRepository extends CrudRepository<Game, Long> {
	List<Game> findAll();
}
