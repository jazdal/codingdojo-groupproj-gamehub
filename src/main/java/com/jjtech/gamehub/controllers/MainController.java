package com.jjtech.gamehub.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.jjtech.gamehub.models.Game;
import com.jjtech.gamehub.models.Review;
import com.jjtech.gamehub.models.User;
import com.jjtech.gamehub.services.GameService;
import com.jjtech.gamehub.services.ReviewService;
import com.jjtech.gamehub.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private GameService gameService;
	
	@Autowired
	private ReviewService reviewService;
	
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
		model.addAttribute("games", gameService.getAllGames());
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
	

	@PostMapping("/games/add")
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
		Game game = gameService.findGameById(gameId);
		List<Review> allGameReviews = game.getReviews();
		Double totalRating = 0.0;
		for (Review review: allGameReviews) {
			totalRating += review.getRating();
		}
		Double average = (totalRating/allGameReviews.size());
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("game", gameService.findGameById(gameId));
		model.addAttribute("average", average);
		return "gamesView.jsp";
	}
	
	@GetMapping("/games/edit/{gameId}")
	public String editGame(
			@PathVariable("gameId") Long gameId,
			Principal principal,
			Model model,
			HttpSession session) {
		Game game = gameService.findGameById(gameId);
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("game", game);
		return "gamesEdit.jsp";
	}
	
	@PutMapping("/games/edit/{gameId}/process")
	public String updateGame(
			@Valid @ModelAttribute("game") Game game, 
			BindingResult result, 
			Principal principal, 
			Model model, 
			HttpSession session,
			@PathVariable("gameId") Long gameId
			) {
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
			return "gamesEdit.jsp";
		}
		Game gameToUpdate = gameService.findGameById(gameId);
		gameToUpdate.setTitle(game.getTitle());
		gameToUpdate.setGenre(game.getGenre());
		gameToUpdate.setDescription(game.getDescription());
		gameToUpdate.setImgUrl(game.getImgUrl());
		gameService.updateGame(gameToUpdate);
		return "redirect:/games/view/" + gameId;
	}
	
	@GetMapping("/games/delete/{gameId}")
	public String deleteGame(
			@PathVariable("gameId") Long gameId, 
			Principal principal, 
			Model model
			) {
		gameService.deleteGame(gameId);
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		return "redirect:/dashboard";
	}
	
	@GetMapping("/games/like/{gameId}")
	public String likeGame(
			@PathVariable("gameId") Long gameId, 
			Principal principal, 
			Model model
			) {
		Game thisGame = gameService.findGameById(gameId);
		User currentUser = userService.findUserByUsername(principal.getName());
		gameService.likeGame(thisGame, currentUser);
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("game", thisGame);
		return "gamesView.jsp";
	}
	
	@GetMapping("/games/unlike/{gameId}")
	public String unlikeGame(
			@PathVariable("gameId") Long gameId, 
			Principal principal, 
			Model model
			) {
		Game thisGame = gameService.findGameById(gameId);
		User currentUser = userService.findUserByUsername(principal.getName());
		gameService.unlikeGame(thisGame, currentUser);
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("game", thisGame);
		return "gamesView.jsp";
	}
	
	@GetMapping("/games/{gameId}/review")
	public String reviewGame(
			@PathVariable("gameId") Long gameId,
			Principal principal,
			Model model,
			@ModelAttribute("review") Review review
			) {
		Game thisGame = gameService.findGameById(gameId);
		User currentUser = userService.findUserByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("game", thisGame);
		return "gamesReview.jsp";
	}
	
	@PostMapping("/games/{gameId}/review/add")
	public String addReview(
			@PathVariable("gameId") Long gameId,
			@Valid @ModelAttribute("review") Review review, 
			BindingResult result, 
			Principal principal, 
			Model model
			) {
		if (result.hasErrors()) {
			Game thisGame = gameService.findGameById(gameId);
			model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
			model.addAttribute("game", thisGame);
			return "gamesReview.jsp";
		}
		reviewService.addReview(review);
		return "redirect:/games/view/" + gameId;
	}
	
	@GetMapping("/games/{gameId}/review/edit/{reviewId}")
	public String editReview(
			@PathVariable("gameId") Long gameId,
			@PathVariable("reviewId") Long reviewId,
			Principal principal,
			Model model,
			@ModelAttribute("review") Review review
			) {
		Game thisGame = gameService.findGameById(gameId);
		Review thisReview = reviewService.findReviewById(reviewId);
		User currentUser = userService.findUserByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("game", thisGame);
		model.addAttribute("review", thisReview);
		return "gamesEditReview.jsp";
	}
	
	@PutMapping("/games/{gameId}/review/{reviewId}/process")
	public String updateReview(
			@Valid @ModelAttribute("review") Review review, 
			BindingResult result, 
			Principal principal, 
			Model model, 
			HttpSession session,
			@PathVariable("gameId") Long gameId,
			@PathVariable("reviewId") Long reviewId
			) {
		if (result.hasErrors()) {
			Game thisGame = gameService.findGameById(gameId);
			model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
			model.addAttribute("game", thisGame);
			return "gamesReview.jsp";
		}
		Review reviewToUpdate = reviewService.findReviewById(reviewId);
		reviewToUpdate.setRating(review.getRating());
		reviewToUpdate.setGameReview(review.getGameReview());
		reviewService.updateReview(reviewToUpdate);
		return "redirect:/games/view/" + gameId;
	}
	
	@GetMapping("/games/{gameId}/review/delete/{reviewId}")
	public String deleteReview(
			@PathVariable("reviewId") Long reviewId, 
			@PathVariable("gameId") Long gameId,
			Principal principal, 
			Model model
			) {
		reviewService.deleteReview(reviewId);
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		return "redirect:/games/view/" + gameId;
	}
}
