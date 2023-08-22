<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GameHub: User Profile</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css"/>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-black" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
              <img src="/img/gamehub_logo (transparent).png" alt="gamehub_logo (transparent)" width="120" height="34">
            </a>
            <span class="navbar-text">${currentUser.getUsername()}</span>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        	<div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
            	<ul class="navbar-nav justify-content-end align-items-md-center">
                    <li class="nav-item">
	                  <div class="d-flex align-items-center form-check form-switch ps-0">
			            <i class="bi bi-moon-stars-fill text-white me-5"></i>
			            <input class="form-check-input" type="checkbox" role="switch" id="switch" onClick="toggleTheme()" style="max-height: 20px; max-width:50px;">
			            <i class="bi bi-brightness-high-fill text-white ms-2"></i>
		       		 </div>
                    </li>
                	<c:if test="${currentUser.getRole().getName().equals('ROLE_ADMIN')}">
	                	 <li class="nav-item">
	                        <a class="nav-link" aria-current="page" href="/admin">Admin Dashboard</a>
	                    </li>
                	</c:if>                
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active fw-bold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Profile
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/users/view/${currentUser.getId()}">View Profile</a></li>
                            <li><a class="dropdown-item" href="/users/edit/${currentUser.getId()}">Edit Profile</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Games
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/games/new">Add Game</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <form action="/logout" method="POST">
			                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			                <input type="submit" class="btn btn-secondary btn-sm bg-gradient shadow fs-6 fw-semibold" value="Logout">
			            </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
	<div class="d-flex flex-column justify-content-center align-items-center mt-5">
       	<c:if test="${currentUser.getId() == user.getId()}">
			<h3 class="mb-5">Your Profile</h3>
     	</c:if>
     	<c:if test="${currentUser.getId() != user.getId()}">
			<h3 class="mb-5">${user.getUsername()}'s Profile</h3>
     	</c:if>    
	</div>
	<div class="container-fluid">
		<div class="d-flex flex-column flex-md-row">
			<div class="d-flex flex-column align-items-center container col-4 mb-3">
				<p class="fw-bold">Profile Picture</p>
				<c:choose>
					<c:when test="${user.getImgUrl() eq null || user.getImgUrl() eq ''}">
						<img id="blankProfilePic" src="/img/blank_profile_pic.png" alt="blank_user_profile_picture">
					</c:when>
					<c:otherwise>
						<img id="profilePic" src="${user.getImgUrl()}" alt="user_profile_picture">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="container col-md-8">
				<table class="mb-4 table table-hover fs-5 align-middle border rounded overflow-hidden bg-gradient shadow">
					<tbody>
						<tr>
							<th class="custom-bg-color text-dark custom-bottom-border col-2">Username:</th>
							<td>${user.getUsername()}</td>
						</tr>
						<tr>
							<th class="custom-bg-color text-dark custom-bottom-border col-2">About:</th>
							<c:if test="${not empty user.getBio()}">
								<td>${user.getBio()}</td>
							</c:if>
							<c:if test="${empty user.getBio()}">
								<td>User has not provided this yet. Noob.</td>
							</c:if>
						</tr>
						<tr>
							<th class="custom-bg-color text-dark custom-bottom-border col-2">Owned Games:</th>
							<td>
<%-- 								<ul>
									<c:forEach var="oneGame" items="${user.getGames() }">
										<li>${oneGame.title}</li>
									</c:forEach>
								</ul> --%>
							</td>
						</tr>
						<tr>
							<th class="custom-bg-color text-dark border-dark col-2">Reviewed Games:</th>
							<td>
								<ul>
									<c:forEach var="oneReview" items="${user.getReviews()}">
										<li>${oneReview.getGame().getTitle()}</li>
									</c:forEach>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="my-5">
	       	<c:if test="${currentUser.getId() == user.getId()}">
				<h4 class="mb-3">Your Reviews:</h4>
							<table class="mb-4 table table-hover fs-5 align-middle border rounded overflow-hidden bg-gradient shadow">
					<tbody>
						<c:forEach var="oneReview" items="${user.getReviews()}">
						<tr>
							<td class="mt-3">
								<div class="d-flex flex-column justify-content-center align-items-center">
									<a href="/games/view/${oneReview.getGame().getId()}"><img src="${oneReview.getGame().getImgUrl()}" class="game-pic mb-1"/></a>
									<a href="/games/view/${oneReview.getGame().getId()}">${oneReview.getGame().getTitle()}</a>
								</div>
							</td>
							<td>
								<c:choose>
									<c:when test="${oneReview.getRating() == 1}">
										<p>Rating: <span class="star"><i class="fa-solid fa-star"></i></span></p>
									</c:when>
									<c:when test="${oneReview.getRating() == 2}">
										<p>Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span></p>
									</c:when>
									<c:when test="${oneReview.getRating() == 3}">
										<p>Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span></p>
									</c:when>
									<c:when test="${oneReview.getRating() == 4}">
										<p>Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span></p>
									</c:when>
									<c:when test="${oneReview.getRating() == 5}">
										<p>Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span></p>
									</c:when>
								</c:choose>
								<p>Posted: ${oneReview.getCreatedAt()}</p>
								<p>${oneReview.getGameReview()}</p>
							</td>
							<c:if test="${currentUser.getId() == oneReview.getUser().getId()}">
								<td>
									<div>
										<a href="/games/${oneReview.getGame().getId()}/review/edit/${oneReview.getId()}"><button class="btn btn-sm btn-warning">Edit Review</button></a>
										<a href="/games/${oneReview.getGame().getId()}/review/delete/${oneReview.getId()}"><button class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this review?')">Delete Review</button></a>
									</div>
								</td>
							</c:if>
						</tr>
						</c:forEach>
					</tbody>
				</table>
	     	</c:if>
	     	<c:if test="${currentUser.getId() != user.getId()}">
				<h4 class="mb-5">Reviews by ${user.getUsername()}:</h4>
	     	</c:if>			
		</div>
	</div>
	<script>
		$(document).ready( function () {
		    $('#myTable').DataTable();
		} );
	</script>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
</body>
</html>