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
import org.springframework.web.bind.annotation.RequestParam;

import com.jjtech.gamehub.models.User;
import com.jjtech.gamehub.services.UserService;
import com.jjtech.gamehub.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserValidator userValidator;
	
	@GetMapping("/")
	public String index(
			Principal principal, 
			Model model
			) {
		if (principal == null) {
			return "redirect:/login";
		}
		User user = userService.findUserByUsername(principal.getName());
		if (user != null) {
			if (user.getRole().getName().contains("ROLE_ADMIN")) {
				return "redirect:/admin";
			}
			return "redirect:/dashboard";
		}
		return "redirect:/login";
	}
	
	@PostMapping("/register")
	public String registerUser(
			@Valid @ModelAttribute("user") User user, 
			BindingResult result, 
			Model model, 
			HttpServletRequest request
			) {
		userValidator.validate(user, result);
		String password = user.getPassword();
		if (result.hasErrors()) {
			return "index.jsp";
		}
		if (userService.getAllUsers().size() == 0) {
			userService.createUser(user, "ROLE_ADMIN", "STATUS_ACTIVE");
		} else {
			userService.createUser(user, "ROLE_USER", "STATUS_ACTIVE");
		}
		authWithHttpServletRequest(request, user.getUsername(), password);
		return "redirect:/";
	}
	
	private void authWithHttpServletRequest(
			HttpServletRequest request, 
			String username, 
			String password
			) {
		try {
			request.login(username, password);
		} catch(ServletException e) {
			System.out.println("Error while login" + e);
		}
	}
	
	@GetMapping("/login")
	public String login(
			@ModelAttribute("user") User user, 
			@RequestParam(value = "error", required = false) String error, 
			@RequestParam(value = "logout", required = false) String logout, 
			Model model
			) {
		if (error != null) {
			model.addAttribute("errorMessage", "Invalid credentials. Please try again.");
		}
		
		if (logout != null) {
			model.addAttribute("logoutMessage", "Logout successful!");
		}
		return "index.jsp";
	}
	
	@GetMapping("/admin")
	public String admin(
			Model model,
			Principal principal
			) {
		List<User> allUsers = userService.getAllUsers();
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("users", allUsers);
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
	
	@GetMapping("/users/view/{id}")
	public String viewUser(
			@PathVariable("id") Long id, 
			Model model,
			Principal principal
			) {
		User user = userService.findUserById(id);
		model.addAttribute("currentUser", userService.findUserByUsername(principal.getName()));
		model.addAttribute("user", user);
		return "userProfile.jsp";
	}
	@GetMapping("/games/new")
	public String newGame(
			) {
		return "gamesNew.jsp";
	}
}
