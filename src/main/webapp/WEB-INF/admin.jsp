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
	<title>GameHub: Admin Dashboard</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
                <ul class="navbar-nav justify-content-end align-items-md-center">
                    <li class="nav-item">
	                  <div class="d-flex align-items-center form-check form-switch ps-0">
			            <i class="bi bi-moon-stars-fill text-white me-5"></i>
			            <input class="form-check-input" type="checkbox" role="switch" id="switch" onClick="toggleTheme()" style="max-height: 20px; max-width:50px;">
			            <i class="bi bi-brightness-high-fill text-white ms-2"></i>
		       		 </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold" aria-current="page" href="/admin">Admin Dashboard</a>
                    </li>
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
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Games
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/contractor/projects/create">Add Game</a></li>
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
		<h3 class="mb-5">Admin Dashboard</h3>
	</div>
	<div class="container-fluid mb-5">
		<h4 class="mb-3">All Users:</h4>
		<table id="myTable" class="table table-striped align-middle border rounded overflow-hidden bg-gradient shadow">
			<thead>
				<tr>
					<th class="custom-bg-color text-dark">Username</th>
					<th class="custom-bg-color text-dark">First Name</th>
					<th class="custom-bg-color text-dark">Last Name</th>
					<th class="custom-bg-color text-dark">Email</th>	
					<th class="custom-bg-color text-dark">Actions</th>									
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<c:forEach var="oneUser" items="${users}">
					<tr>
						<td class="d-flex flex-column align-items-center">
							<c:choose>
								<c:when test="${oneUser.getImgUrl() eq null || oneUser.getImgUrl() eq ''}">
									<img id="blankProfilePic" src="/img/blank_profile_pic.png" alt="blank_user_profile_picture">
								</c:when>
								<c:otherwise>
									<img id="blankProfilePic" src="${oneUser.getImgUrl()}" alt="user_profile_picture">
								</c:otherwise>
							</c:choose>
							<a href="/users/view/${oneUser.getId()}" class="h5">${oneUser.getUsername()}</a>
						</td>
						<td>${oneUser.getFirstName()}</td>
						<td>${oneUser.getLastName()}</td>
						<td>${oneUser.getEmail()}</td>
						<td>
							<a href=""><button class="btn btn-sm btn-warning my-1">Ban</button></a>
							<a href=""><button class="btn btn-sm btn-danger my-1">Deactivate</button></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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