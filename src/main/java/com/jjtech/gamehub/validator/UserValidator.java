package com.jjtech.gamehub.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.jjtech.gamehub.models.User;
import com.jjtech.gamehub.repositories.UserRepository;

@Component
public class UserValidator implements Validator {
	@Autowired
	UserRepository userRepo;

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		User usernameUser = userRepo.findByUsername(user.getUsername());
		User emailUser = userRepo.findByEmail(user.getEmail());
		
		if (usernameUser != null) {
			errors.rejectValue("username", "Invalid", "Username must be unique.");
		}
		
		if (emailUser != null) {
			errors.rejectValue("email", "Invalid", "Email must be unique.");
		}
		
		if (!user.getConfirmPassword().equals(user.getPassword())) {
			errors.rejectValue("confirmPassword", "Match", "Passwords must match.");
		}
	}
}
