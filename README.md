# codingdojo-groupproj-gamehub

## GameHub: A simple and user-friendly gaming database and review platform.
## Version Number: 0.8a

## Project Description
- GameHub is a simple and user-friendly gaming database and review platform designed for use by all types of gamers (PC, console, mobile) where they can discover and share comprehensive information about their favorite games.

## Features and Capabilities
- User registration and login with validations and authentication.
- The app has two levels of access: Admin level (for the site owner or moderator), and User level (for the rest of the users).
- Admin:
    - Only one user can be Admin (the website owner / moderator).
    - Admin dashboard for viewing and managing all user accounts.
    - Admin can deactivate or ban user accounts.
    - Admin has complete control over the management of the information in the entire webapp (can create, view, edit, and delete any entry, as well as change any entries made by other users).
- User:
    - Upon registration / login, will go directly to the main dashboard.
    - Main Dashboard features information on all the games stored in the database, where users can click and view information about each game. Users can also search games by game title.
    - Users can also create their own entries about a game they want to share that is not yet in the database.
    - Users can rate a particular game, and they can also provide comments or feedback about the game. They can also reply to other users' comments or feedback.

## Technologies Used
- Backend: Java 17 | Maven v.3.9.3 | Spring Boot v.3.1.2 | Spring Security v.6.1.2
- Frontend: HTML5 + JSP | CSS3 | JavaScript | Bootstrap v.5.3.0 | jQuery v.3.7.0
- Version Control: Git | GitHub
- Tools: Spring Tool Suite v.4.19.1 (IDE) | VS Code v.1.81.1 (IDE) | MySQL Workbench v.8.0.34

## Project Developers:
- Backend: Jasper Dalawangbayan (Full-Stack Web Developer)
- Frontend: Jorge Jason Joaquino (Full-Stack Web Developer)

## CHANGELOG:

**v.0.8a (2023-08-23):**
- Added a StatusService class.
- Added functionality for the Ban / Unban, Deactivate / Activate buttons in the Admin dashboard.
- Added additional validation to prevent a banned user from logging in.

**v.0.7a (2023-08-22):**
- Modified some attributes in the Game model.
- Separated the Controller class into UserController and MainController.
- Added additional routes to the UserController and MainController.
- Created a GameService class.
- Modified some JSP files.

**v0.6a (2023-08-21):**
- Added Technologies Used section to README.md
- Added JSP files.
- Added additional custom validation for user birthday (must be at least 13 yrs old to register).

**v.0.5a (2023-08-19):**
- Added *Features and Capabilities* section to the Readme.MD file.
- Added additional dependencies to the *pom.xml* file.
- Added 'css' folder and *style.css* file to src/main/resources/static.
- Added 'WEB-INF' folder to src/main/webapp.
- Added configurations to the *application.properties* file.
- Created additional packages in src/main/java.
- Created database models / entities.
- Created repositories.
