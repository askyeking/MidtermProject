
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/editUser.css" />

<title>Edit Profile</title>
</head>
<body>
	<img class="center-fit" src="media/eggs.jpg" alt="homescreen" />
	<c:if test="${not empty loggedInUser }">
		<%@include file="NavBar.jsp"%>
	</c:if>
<body>
	<div class="editUser">
		<c:choose>
			<c:when test="${not empty loggedInUser }">
				<br>
				<br>
				<br>
				<br>


				<c:if test="${not empty user }">

					<h3>Edit User</h3>


					<form action="editedUser.do" method="POST">
						<input type="hidden" name="id" value="${user.id}" />

						<c:choose>
							<c:when test="${loggedInUser.admin }">

								<h3>Admin status</h3>
								<div class="dropdown">
									<select name="admin">
										<option value="false">FALSE</option>
										<option value="true">TRUE</option>
									</select>

									<h3>Active</h3>
									<select name="active">
										<option value="true">TRUE</option>
										<option value="false">FALSE</option>
									</select>
								</div>

							</c:when>

							<c:otherwise>
								<input type="hidden" name="admin" value="${user.admin}" />
								<input type="hidden" name="active" value="${user.active}" />
							</c:otherwise>

						</c:choose>
						<h3>User name</h3>


						<input type="text" name="username" value="${user.username }"
							maxlength="45" required /><br>
						<h3>Password</h3>
						<input type="password" name="password" value="${user.password }"
							maxlength="45" required /><br>
						<h3>Email</h3>
						<input type="email" name="email" value="${user.email }"
							maxlength="100" required /><br>
						<h3>First Name</h3>
						<input type="text" name="firstName" value="${user.firstName }"
							maxlength="45" required /><br>
						<h3>Last Name</h3>
						<input type="text" name="lastName" value="${user.lastName }"
							maxlength="45" required /><br>
						<h3>Date of Birth</h3>
						<input type="date" name="dateOfBirth" value="${user.dateOfBirth }"
							required /><br>


						<h3>Address</h3>
						<input type="text" name="street" value="${user.address.street }"
							maxlength="190" required /><br> <input type="text"
							name="city" value="${user.address.city}" maxlength="100" required /><br>
						<input type="text" name="state" value="${user.address.state}"
							maxlength="2" required /><br> <input type="number"
							name="postalCode" value="${user.address.postalCode}" min="00000"
							max="99999" required /><br>

						<h3>Tell us a little about yourself</h3>
						<%-- <input type="text" name="description" value="${user.description}"
							style="height: 200px" /> --%>
						<br>
						<textarea name="description">${user.description }</textarea>

						<h3>Set your profile picture</h3>
						<input type="url" name="imgURL"><br> <br> <br>
						<input type="submit" value="Submit" size="big" class="btn btn-primary" />

					</form>

				</c:if>


			</c:when>



			<c:otherwise>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<h3>Only a logged in user can view this page.</h3>

				<form:form action="index.do" modelAttribute="user" method="GET">
					<input type="submit" value="Login" />
				</form:form>


				<form:form action="registrationLink.do" modelAttribute="user"
					method="GET">
					<input type="submit" value="Register" />
				</form:form>

			</c:otherwise>

		</c:choose>
	</div>