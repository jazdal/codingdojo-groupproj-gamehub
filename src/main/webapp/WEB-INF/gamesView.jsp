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
	<title>GameHub: View Game</title>
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
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                        Profile
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/users/view/${currentUser.getId()}">View Profile</a></li>
                            <li><a class="dropdown-item" href="/users/edit/${currentUser.getId()}">Edit Profile</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active fw-bold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
	<div class="container-fluid d-flex flex-column justify-content-center mt-5">
		<img src="${game.getImgUrl()}" style="width:100%; height:auto;" class="shadow-lg">
		<h3 class="my-3 text-center">${game.getTitle()}</h3>
		<c:if test="${currentUser.getId() == game.getUser().getId() }">
			<div class="text-center mb-3">
				<a href="/games/edit/${game.getId()}"><button class="btn btn-sm btn-warning">Edit</button></a>
				<a href="/games/delete/${game.getId()}"><button class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this game?')">Delete</button></a>
			</div>
		</c:if>
		<div class="d-flex align-items-center justify-content-between mb-3">
			<a href="/"><button class="btn btn-sm btn-warning">Add to Owned Games</button></a>
			<div class="d-flex">
				<p>${game.getLikers().size()} people like this game.</p>
				<c:choose>
					<c:when test="${!game.getLikers().contains(currentUser)}">
						<a href="/games/like/${game.getId()}"><button class="btn btn-sm btn-primary ms-3">Like</button></a>
					</c:when>
					<c:otherwise>
						<a href="/games/unlike/${game.getId()}"><button class="btn btn-sm btn-primary ms-3">Unlike</button></a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<table class="mb-4 table table-hover fs-5 align-middle border rounded overflow-hidden bg-gradient shadow">
			<tbody>
				<tr>
					<th>Genre:</th>
					<td>${game.getGenre()}</td>
				</tr>
				<tr>
					<th>Description:</th>
					<td>${game.getDescription()}</td>
				</tr>
			</tbody>
		</table>
		<div>
			<a href="/games/${game.getId()}/review"><button class="btn btn-success">Write a Review</button></a>
		</div>
		<div class="mt-5">
			<h4 class="mb-3">All User Reviews:</h4>
			<c:choose>
				<c:when test="${average >= 1.0 && average <= 1.49}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 1.5 && average <= 1.99}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 2.0 && average <= 2.49}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 2.5 && average <= 2.99}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 3.0 && average <= 3.49}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 3.5 && average <= 3.99}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 4.0 && average <= 4.49}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average >= 4.5 && average <= 4.99}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:when test="${average == 5}">
					<h5>Average Rating: <span class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span> ${average} out of 5.</h5>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="mb-5">
			<c:if test="${empty game.getReviews()}">
				<p>This game has no reviews yet.</p>
			</c:if>
			<c:if test="${not empty game.getReviews()}">
				<table class="mb-4 table table-hover fs-5 align-middle border rounded overflow-hidden bg-gradient shadow">
					<tbody>
						<c:forEach var="oneReview" items="${game.getReviews()}">
						<tr>
							<td class="mt-3">
								<div class="d-flex flex-column justify-content-center align-items-center">
									<img src="${oneReview.getUser().getImgUrl()}" class="profile-pic"/>
									<p>${oneReview.getUser().getUsername()}</p>
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
								<p>Posted: <fmt:formatDate value="${oneReview.getCreatedAt()}" pattern="MMMM dd, yyyy" /></p>
								<p>${oneReview.getGameReview()}</p>
							</td>
							<c:if test="${currentUser.getId() == oneReview.getUser().getId()}">
								<td>
									<div>
										<a href="/games/${game.getId()}/review/edit/${oneReview.getId()}"><button class="btn btn-sm btn-warning my-2">Edit Review</button></a>
										<a href="/games/${game.getId()}/review/delete/${oneReview.getId()}"><button class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this review?')">Delete Review</button></a>
									</div>
								</td>
							</c:if>
							<c:if test="${currentUser.getId() != oneReview.getUser().getId()}">
								<td>
								</td>
							</c:if>
						</tr>
						</c:forEach>
					</tbody>
				</table>
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