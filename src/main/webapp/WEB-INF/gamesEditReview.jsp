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
	<title>GameHub: Edit Review</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
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
		<img src="${game.getImgUrl()}" style="width:100%; height:auto;">
		<h3 class="my-3 text-center">${game.getTitle()}</h3>
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
		<div class="mt-5">
			<h4 class="mb-5">Edit Your Review:</h4>
		</div>
		<div>
			<form:form action="/games/${game.getId()}/review/${review.getId()}/process" method="PUT" modelAttribute="review">
			<form:input type="hidden" path="user" value="${currentUser.getId()}"/>
			<form:input type="hidden" path="game" value="${game.getId()}"/>
			<form:input type="hidden" path="id" value="${review.getId()}"/>
			<table class="mb-4 table table-hover fs-5 border rounded overflow-hidden bg-gradient shadow">
				<tbody>
					<tr>
						<th>
							<form:label path="rating">Your Rating:</form:label>
						</th>
						<td>
							<div class="rating d-flex flex-row-reverse justify-content-end">
								<form:radiobutton path="rating" value="5" id="star5"/>
								<form:label class="star" for="star5" aria-hidden="true" path="rating"></form:label>
								<form:radiobutton path="rating" value="4" id="star4"/>
								<form:label class="star" for="star4" aria-hidden="true" path="rating"></form:label>							
								<form:radiobutton path="rating" value="3" id="star3"/>
								<form:label class="star" for="star3" aria-hidden="true" path="rating"></form:label>							
								<form:radiobutton path="rating" value="2" id="star2"/>
								<form:label class="star" for="star2" aria-hidden="true" path="rating"></form:label>							
								<form:radiobutton path="rating" value="1" id="star1"/>
								<form:label class="star" for="star1" aria-hidden="true" path="rating"></form:label>	
							</div>
							<form:errors path="rating" class="text-danger d-block"/>
						</td>
					</tr>
					<tr>
						<th>
						<form:label path="gameReview">Your Review:</form:label>
						</th>
						<td>
							<form:textarea path="gameReview" type="text" class="form-control" rows="10"></form:textarea>
							<form:errors path="gameReview" class="text-danger"/>	
						</td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-between mt-3 mb-5">
				<a href="/games/view/${game.getId()}"><button type="button" class="btn btn-danger btn-sm">Cancel</button></a>
				<input type="submit" value="Edit Review" class="btn btn-success btn-sm" />
			</div>
			</form:form>
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