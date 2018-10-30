
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${not empty loggedInUser }">
<%@include file="NavBar.jsp" %>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Create Meetup</title>
</head>
<body>
<body style="height: 1500px">
	<c:choose>
		<c:when test="${not empty loggedInUser }">
		<br>
		<br>
		<br>
		<br>
		Inside of Edit Meetup
		
		<c:choose>
		<c:when test="${not empty meetup }">

			
			<h3>Edit Meetup</h3>

			<form action="editedMeetup.do" method="POST">
			
			<input type="hidden" name="id" value="${meetup.id}" /> 
			<input type="hidden" name="active" value="${meetup.active}" /> 
				<br>
				<h3>Meetup Name</h3>
				<input type="text" name="title" value="${meetup.title }" maxlength="45" required /><br>
				<h3>Description</h3>
				<input type="text" name="description" value="${meetup.description }" maxlength="250"
					style="height: 100px" /> <br>
<!-- 				<h3>Start Time</h3>
				<input type="datetime" name="startTime" value="" required /><br>
				<h3>End Time</h3>
				<input type="datetime" name="endTime" value="" required /><br> -->
				<h3>Maximum Attendance</h3>
				<input type="number" name="maxAttendance" value="${meetup.maxAttendance }" maxlength="45"
					required /><br>
<!-- 				<h3>Start time</h3>
				<input type="datetime-local" name="startTime" required /><br>
				<h3>End time</h3>
				<input type="datetime-local" name="endTime"/><br> -->
				<h3>Set a Meetup Picture</h3>
				URL: <input type="url" name="imageURL" value="" maxlength="45"><br> <br> 
				<h3>Start Date<h3></h3>
				<input type="datetime-local" name="ldt" value="" required /><br>
				
				<h3>Address</h3>
				Street: <input type="text" name="street" value="${meetup.meetupAddress.street}" maxlength="190" required /><br>
				City: <input type="text" name="city" value="${meetup.meetupAddress.city }" maxlength="100" required /><br> <input
					type="text" name="state" value="${meetup.meetupAddress.state }" maxlength="2" required /><br>
				Postal code: <input type="number" name="postalCode" value="${meetup.meetupAddress.postalCode }" min="00000" max="99999" required /><br>
				
				<input type="submit" value="Submit" />
			</form>
		</c:when>
		
		
		<c:when test="${not empty recipe }">
		
		
		
		
		
		
		
		
		
		
		
		
		
		<h3>Edit Recipe</h3>
		<!--id, title, country, description, ingredients, servingSize, cookTime, instructions, category  -->
	<form action="editedRecipe.do" method="POST">
			<input type="hidden" name="id" value="${recipe.id}" /> 
			<input type="hidden" name="active" value="${recipe.active}" /> 
			
		<br>
		<h3>Recipe Name</h3>
		<input type="text" name="title" value="${recipe.title }" maxlength="45" required /><br>
		<h3>Description</h3>
		<input type="text" name="description" value="${recipe.description }" style="height: 100px" maxlength=300 /> <br>
		<h3>Ingredients</h3>
		<input type="text" name="ingredients" value="${recipe.ingredients }" maxlength="250" style="height: 100px" required /> <br>
		<h3>Serving Size</h3>
		<input type="number" name="servingSize" value="${recipe.servingSize }"  maxlength="50" /><br>
		<h3>Cook Time</h3>
		<input type="number" name="cookTime" value="${recipe.cookTime }" /> minutes<br>
		<h3>Category</h3>
		<input type="text" name="category" value="${recipe.category }" required /><br>
		
		<h3>Origin</h3>
		<select name="country" value="${recipe.country }">
		    <option value="AF">Afghanistan</option>
			<option value="AL">Albania</option>
			<option value="DZ">Algeria</option>
			<option value="AS">American Samoa</option>
			<option value="AR">Argentina</option>
			<option value="AM">Armenia</option>
			<option value="AW">Aruba</option>
			<option value="AU">Australia</option>
			<option value="AT">Austria</option>
			<option value="BS">Bahamas</option>
			<option value="BD">Bangladesh</option>
			<option value="BB">Barbados</option>
			<option value="BE">Belgium</option>
			<option value="BZ">Belize</option>
			<option value="BM">Bermuda</option>
			<option value="BW">Botswana</option>
			<option value="BR">Brazil</option>
			<option value="BG">Bulgaria</option>
			<option value="KH">Cambodia</option>
			<option value="CM">Cameroon</option>
			<option value="CA">Canada</option>
			<option value="KY">Cayman Islands</option>
			<option value="CF">Central African Republic</option>
			<option value="CL">Chile</option>
			<option value="CN">China</option>
			<option value="CX">Christmas Island</option>
			<option value="CO">Colombia</option>
			<option value="CK">Cook Islands</option>
			<option value="CR">Costa Rica</option>
			<option value="HR">Croatia</option>
			<option value="CU">Cuba</option>
			<option value="CZ">Czech Republic</option>
			<option value="DK">Denmark</option>
			<option value="DM">Dominica</option>
			<option value="DO">Dominican Republic</option>
			<option value="EC">Ecuador</option>
			<option value="EG">Egypt</option>
			<option value="SV">El Salvador</option>
			<option value="ET">Ethiopia</option>
			<option value="FJ">Fiji</option>
			<option value="FI">Finland</option>
			<option value="FR">France</option>
			<option value="GF">French Guiana</option>
			<option value="PF">French Polynesia</option>
			<option value="DE">Germany</option>
			<option value="GH">Ghana</option>
			<option value="GR">Greece</option>
			<option value="GL">Greenland</option>
			<option value="GD">Grenada</option>
			<option value="GU">Guam</option>
			<option value="GT">Guatemala</option>
			<option value="GY">Guyana</option>
			<option value="HT">Haiti</option>
			<option value="HN">Honduras</option>
			<option value="HK">Hong Kong</option>
			<option value="HU">Hungary</option>
			<option value="IS">Iceland</option>
			<option value="IN">India</option>
			<option value="ID">Indonesia</option>
			<option value="IQ">Iraq</option>
			<option value="IE">Ireland</option>
			<option value="IL">Israel</option>
			<option value="IT">Italy</option>
			<option value="JM">Jamaica</option>
			<option value="JP">Japan</option>
			<option value="JE">Jersey</option>
			<option value="JO">Jordan</option>
			<option value="KZ">Kazakhstan</option>
			<option value="KE">Kenya</option>
			<option value="KI">Kiribati</option>
			<option value="KW">Kuwait</option>
			<option value="KG">Kyrgyzstan</option>
			<option value="LV">Latvia</option>
			<option value="LB">Lebanon</option>
			<option value="LS">Lesotho</option>
			<option value="LR">Liberia</option>
			<option value="LY">Libya</option>
			<option value="LI">Liechtenstein</option>
			<option value="LT">Lithuania</option>
			<option value="LU">Luxembourg</option>
			<option value="MO">Macao</option>
			<option value="MY">Malaysia</option>
			<option value="MT">Malta</option>
			<option value="MX">Mexico</option>
			<option value="MA">Morocco</option>
			<option value="NP">Nepal</option>
			<option value="NL">Netherlands</option>
			<option value="NZ">New Zealand</option>
			<option value="NI">Nicaragua</option>
			<option value="NE">Niger</option>
			<option value="NG">Nigeria</option>
			<option value="NO">Norway</option>
			<option value="PK">Pakistan</option>
			<option value="PW">Palau</option>
			<option value="PA">Panama</option>
			<option value="PG">Papua New Guinea</option>
			<option value="PY">Paraguay</option>
			<option value="PE">Peru</option>
			<option value="PH">Philippines</option>
			<option value="PL">Poland</option>
			<option value="PT">Portugal</option>
			<option value="PR">Puerto Rico</option>
			<option value="QA">Qatar</option>
			<option value="RO">Romania</option>
			<option value="WS">Samoa</option>
			<option value="SM">San Marino</option>
			<option value="SA">Saudi Arabia</option>
			<option value="RS">Serbia</option>
			<option value="SL">Sierra Leone</option>
			<option value="SG">Singapore</option>
			<option value="SI">Slovenia</option>
			<option value="SB">Solomon Islands</option>
			<option value="SO">Somalia</option>
			<option value="ZA">South Africa</option>
			<option value="SS">South Sudan</option>
			<option value="ES">Spain</option>
			<option value="SD">Sudan</option>
			<option value="SE">Sweden</option>
			<option value="CH">Switzerland</option>
			<option value="TH">Thailand</option>
			<option value="TG">Togo</option>
			<option value="TK">Tokelau</option>
			<option value="TO">Tonga</option>
			<option value="TR">Turkey</option>
			<option value="UG">Uganda</option>
			<option value="UA">Ukraine</option>
			<option value="AE">United Arab Emirates</option>
			<option value="US">United States of America</option>
			<option value="UY">Uruguay</option>
			<option value="VE">Venezuela, Bolivarian Republic of</option>
			<option value="VN">Viet Nam</option>
			<option value="YE">Yemen</option>
			<option value="ZW">Zimbabwe</option>
  		</select> 
  		
		<h3>Instructions</h3>
		<input type="text" name="instructions" value="${recipe.instructions }" style="height: 100px" required/> <br>
		<h3>Set a Recipe Picture</h3>	
		<input type="url" name="imageURL" maxlength="100"><br><br>
		
		<input type="submit" value="Submit" /> 
			</form>
		</c:when>
		</c:choose>	




		</c:when>
		<c:otherwise>
		<br><br><br><br><br><br>
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
</body>

</html>