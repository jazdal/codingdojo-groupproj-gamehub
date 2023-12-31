<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GameHub: Registration and Login</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-dark">
    <nav class="navbar navbar-expand-lg bg-black" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
              <img src="/img/gamehub_logo (transparent).png" alt="gamehub_logo (transparent)" width="120" height="34">
            </a>
            <ul class="navbar-nav justify-content-end align-items-md-center">
            	<li class="nav-item">
           			<div class="d-flex align-items-center form-check form-switch ps-0">
			           <i class="bi bi-moon-stars-fill text-white me-5"></i>
			           <input class="form-check-input" type="checkbox" role="switch" id="switch" onClick="toggleTheme()" style="max-height: 20px; max-width:50px;">
			           <i class="bi bi-brightness-high-fill text-white ms-2"></i>
     		 		</div>
               </li>
            </ul>
        </div>
    </nav>
	<div id="regForm" class="p-3 container-fluid">
		<c:if test="${logoutMessage != null}">
			<h2 class="mb-3 text-center text-success fw-bold"><c:out value="${logoutMessage}"/></h2>
		</c:if>
		<div class="d-flex flex-column justify-content-center align-items-center">
			<img class="mb-3" src="/img/gamehub_logo (transparent).png" alt="gamehub_logo" width="40%">
			<h3 class="mb-5 text-white">A platform for Gamers.</h3>
		</div>
		<div class="row justify-content-between mx-0">
			<form:form class="p-2 col-sm-6 card bg-dark-subtle bg-gradient shadow" action="/register" method="POST" modelAttribute="user">
				<div class="card-body">
					<h3 class="mb-4 card-title text-center fw-bold">CREATE PROFILE</h3>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="username" class="col-form-label fs-5 fw-semibold">Username:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="text" class="form-control fs-5" path="username" placeholder="Enter username"/>
							<form:errors path="username" class="text-danger"/>
						</div>
					</div>
                    <div class="row mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <form:label path="firstName" class="col-form-label fs-5 fw-semibold">First Name:</form:label>
                        </div>
                        <div class="col-sm-8">
                            <form:input type="text" class="form-control fs-5" path="firstName" placeholder="Enter first name" />
                            <form:errors path="firstName" class="text-danger"/>
                        </div>
                    </div>
                    <div class="row mb-4 align-items-center justify-content-between">
                    	<div class="col-auto">
                    		<form:label path="lastName" class="col-form-label fs-5 fw-semibold">Last Name:</form:label>
                    	</div>
                    	<div class="col-sm-8">
                    		<form:input type="text" class="form-control fs-5" path="lastName" placeholder="Enter last name" />
                    		<form:errors path="lastName" class="text-danger" />
                    	</div>
                    </div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="email" class="col-form-label fs-5 fw-semibold">Email:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="email" class="form-control fs-5" path="email" placeholder="Enter email" />
							<form:errors path="email" class="text-danger"/>
						</div>
					</div>
                    <div class="row mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <form:label path="birthday" class="col-form-label fs-5 fw-semibold">Birthday:</form:label>
                        </div>
                        <div class="col-sm-8">
                            <form:input type="date" class="form-control fs-5" path="birthday" placeholder="Enter birthday" />
                            <form:errors path="birthday" class="text-danger"/>
                        </div>
                    </div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="password" class="col-form-label fs-5 fw-semibold">Password:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="password" placeholder="Enter password"/>
							<form:errors path="password" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-5 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="confirmPassword" class="col-form-label fs-5 fw-semibold">Confirm PW:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="confirmPassword" placeholder="Confirm password"/>
							<form:errors path="confirmPassword" class="text-danger"/>
						</div>
					</div>
					<div class="row g-2 align-items-center">
						<input type="submit" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold" value="Register">
					</div>
				</div>
			</form:form>
			<form:form class="p-2 col-sm-6 card bg-warning-subtle bg-gradient shadow" action="/login" method="POST" modelAttribute="user">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="card-body">
					<h3 class="mb-4 card-title text-center fw-bold">LOGIN</h3>
					<div class="mb-4 row align-items-center justify-content-between">
						<div class="col-auto">
							<form:label class="col-form-label fs-5 fw-semibold" path="username">Username:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="text" class="form-control fs-5" path="username" placeholder="Enter username"/>
						</div>
					</div>
					<div class="mb-5 row align-items-center justify-content-between">
						<div class="col-auto">
							<form:label class="col-form-label fs-5 fw-semibold" path="password">Password:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="password" placeholder="Enter password"/>
						</div>
					</div>
					<c:if test="${errorMessage != null}">
						<p class="text-danger text-center fs-5 fw-semibold">
							<c:out value="${errorMessage}"/>
						</p>
					</c:if>
					<div class="row g-2 align-items-center">
						<input type="submit" class="btn btn-warning bg-gradient shadow fs-5 fw-semibold" value="Login">
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>