package com.jjtech.gamehub.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.jjtech.gamehub.models.Game;
import com.jjtech.gamehub.services.GameService;
import com.jjtech.gamehub.services.UserService;

import jakarta.validation.Valid;

@Controller
public class MainController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private GameService gameService;
	
	@GetMapping("/admin")
	public String admin(
			Model model,
			Principal principal
			) {
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("users", userService.getAllUsers());
		return "admin.jsp";
	}
	
	@GetMapping("/dashboard")
	public String dashboard(
			Model model,
			Principal principal
			) {
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		return "userdash.jsp";
	}

	@GetMapping("/games/new")
	public String newGameForm(
			Principal principal, 
			Model model, 
			@ModelAttribute("game") Game game
			) {
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		return "gamesNew.jsp";
	}
	
	@PostMapping("/games/new")
	public String addGame(
			@Valid @ModelAttribute("game") Game game, 
			BindingResult result, 
			Principal principal, 
			Model model
			) {
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
			return "gamesNew.jsp";
		}
		gameService.addGame(game);
		return "redirect:/games/view/" + game.getId();
	}
	
	@GetMapping("/games/view/{gameId}")
	public String viewGame(
			Principal principal, 
			Model model, 
			@PathVariable("gameId") Long gameId
			) {
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("game", gameService.findGameById(gameId));
		return "gamesView.jsp";
	}
}
