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
	<title>GameHub: Edit User</title>
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
		<h3 class="mb-5">Edit User Profile</h3>
	</div>
	<div class="container-fluid">
		<form:form action="/users/process" method="PUT" modelAttribute="user">
			<form:input type="hidden" path="id" value="${user.getId()}" />
			<form:input type="hidden" path="password" value="${user.getPassword()}" />
			<table class="mb-4 table fs-5 shadow">
				<tbody>
					<tr>
						<td rowspan="9" class="text-center align-middle border-bottom-0">
							<c:choose>
								<c:when test="${user.getImgUrl() eq null || user.getImgUrl() eq ''}">
									<img id="profilePic" src="/img/blank_profile_pic.png" alt="blank_user_profile_picture">
								</c:when>
								<c:otherwise>
									<img id="profilePic" src="${user.getImgUrl()}" alt="user_profile_picture">
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<form:label path="username" class="col-form-label fw-semibold">Username:</form:label>
						</td>
						<td>
							<form:input type="text" class="form-control fs-5" path="username" placeholder="Enter username" />
							<form:errors path="username" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="firstName" class="col-form-label fw-semibold">First Name:</form:label>
						</td>
						<td>
							<form:input type="text" class="form-control fs-5" path="firstName" placeholder="Enter first name" />
							<form:errors path="firstName" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="lastName" class="col-form-label fw-semibold">Last Name:</form:label>
						</td>
						<td>
							<form:input type="text" class="form-control fs-5" path="lastName" placeholder="Enter last name" />
							<form:errors path="lastName" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="email" class="col-form-label fw-semibold">Email:</form:label>
						</td>
						<td>
							<form:input type="text" class="form-control fs-5" path="email" placeholder="Enter email address" />
							<form:errors path="email" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="imgUrl" class="col-form-label fw-semibold">Profile Pic Url:</form:label>
						</td>
						<td>
							<form:input type="text" class="form-control fs-5" path="imgUrl" placeholder="Enter profile pic url" />
							<form:errors path="imgUrl" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="bio" class="col-form-label fw-semibold">About Myself:</form:label>
						</td>
						<td>
							<form:textarea class="form-control fs-5" rows="3" path="bio" placeholder="Tell something about yourself." />
							<form:errors path="bio" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<form:label path="birthday" class="col-form-label fw-semibold">Birthday:</form:label>
						</td>
						<td>
							<form:input type="date" class="form-control fs-5" path="birthday" placeholder="Enter your birthday" value="${user.getBirthday()}" />
							<form:errors path="birthday" class="text-danger" />
						</td>
					</tr>
					<tr>
						<td>
							<label class="col-form-label fw-semibold">Owned Games:</label>
						</td>
						<td class="align-middle">List of Owned Games</td>
					</tr>
					<tr>
						<td>
							<label class="col-form-label fw-semibold">Reviewed Games:</label>
						</td>
						<td class="align-middle">List of Reviewed Games</td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-warning bg-gradient fs-5 fw-semibold" value="Update Profile">
		</form:form>
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