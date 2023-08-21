package com.jjtech.gamehub.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.jjtech.gamehub.services.UserService;

@Controller
public class MainController {
	@Autowired
	private UserService userService;
	
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
}
