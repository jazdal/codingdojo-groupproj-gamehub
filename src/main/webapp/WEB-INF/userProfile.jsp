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
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />
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
                <ul class="navbar-nav">
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
                            <li><a class="dropdown-item" href="/">Edit Profile</a></li>
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
			<h3 class="mb-5 text-white">Your Profile</h3>
     	</c:if>
     	<c:if test="${currentUser.getId() != user.getId()}">
			<h3 class="mb-5 text-white">${user.getUsername()}'s Profile</h3>
     	</c:if>    
	</div>
	<div class="container-fluid">
		<div class="d-flex">
			<div class="d-flex flex-column align-items-center container border">
				<p>Profile Picture</p>
				<img id="profilePic" src="${user.getImgUrl()}" alt='user_profile_pic'>
			</div>
			<div class="container border">
				<table>
					<tbody>
						<tr>
							<th>Username:</th>
							<td>${user.getUsername()}</td>
						</tr>
						<tr>
							<th>About:</th>
							<c:if test="${user.getBio()}">
								<td>${user.getBio()}</td>
							</c:if>
							<c:if test="${!user.getBio()}">
								<td>User is still a noob.</td>
							</c:if>
						</tr>
						<tr>
							<th>Owned Games:</th>
							<td>Enter Games Here</td>
						</tr>
						<tr>
							<th>Reviewed Games:</th>
							<td>Enter Reviewed Games Here</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="mt-5">
	       	<c:if test="${currentUser.getId() == user.getId()}">
				<h4 class="mb-5 text-white">Your Reviews:</h4>
	     	</c:if>
	     	<c:if test="${currentUser.getId() != user.getId()}">
				<h4 class="mb-5 text-white">Reviews by ${user.getUsername()}:</h4>
	     	</c:if>			
		</div>
	</div>
	<script>
		$(document).ready( function () {
		    $('#myTable').DataTable();
		} );
	</script>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
</body>
</html>