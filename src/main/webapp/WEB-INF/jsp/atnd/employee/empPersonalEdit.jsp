<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Emp Details Edit</title>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/intlTelInput.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/utils.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/css/intlTelInput.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/css/selectize.default.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/js/selectize.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<style>
       
	.userEdit{
	    text-align: center;
	}
       
   	.userEdit .user-details-table {
	    margin-left: auto;
	    margin-right: auto;
	    width: 80%;
	    border-collapse: collapse;
	  	font-family: Calibri, sans-serif;
	}

    .userEdit .user-details-table th, 
    .userEdit .user-details-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
        vertical-align: top;
    }

    .userEdit .user-details-table th {
        background-color: #f2f2f2;
        text-align: right;
        width: 13%;
        font-size: 14px; /* Adjusted font size for th */
        color: #333; /* Adjusted text color for th */
    }

    .userEdit .user-details-table td {
        background-color: #fff;
        font-size: 11px; /* Adjusted font size for td */
         padding: 8px;
         width: 16%;
    }
    
    .userEdit .user-details-table td input{
    	width: 100%;
    	font-size: 11px;
    	padding: 2px;
    }
    
    .userEdit .user-details-table td select{
    	width: 100%;
    	font-size: 11px;
    	padding: 2px;
    }
    
		#pageContent button {
		background-color: #0080ff;
		border: none;
		color: white;
		padding: 5px 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 11px;
		cursor: pointer;
		border-radius: 4px;
		margin-right: 10px;
 	}
 	
 	.form-buttons {
 		display: flex;
    	justify-content: flex-start;
    	margin-left: 155px;
    	margin-bottom: 10px;
 	}
 	
 	.userEdit #cancelButton {
 		background-color: #8c8c8c;
 	}
    
    .userEdit .icon-input-container {
	    position: relative;
	    display: inline-block;
	    width: 100%;
	}
	
	.userEdit .date-icon {
	    position: absolute;
	    right: 10px;
	    top: 50%;
	    transform: translateY(-50%);
	}
	
	.userEdit .eye-icon {
	    position: absolute;
	    right: 10px; /* Adjust as needed */
	    transform: translateY(45%);
	    cursor: pointer;
	    color: #065c9d; /* Adjust the color as needed */
	    z-index: 10;
	}
	
	.userEdit .is-invalid {
     	border-color: #dc3545;
    }

    .userEdit .invalid-feedback {
    	position: relative;
        display: none;
        width: 100%;
        font-size: 80%;
        color: #dc3545;
        margin-top: 4px;
    }

    .userEdit .is-invalid ~ .invalid-feedback {
        display: block;
    }
    
   /* Targets the international telephone input's outer container */
    .userEdit .iti {
        width: 100%;
    }

    /* Specific to the input within the international telephone input */
    .userEdit .iti input[type=tel] {
        padding: 2px;
        width: 85%;
        box-sizing: border-box;
    }
    
    .userEdit .uniform-size {
		  width: 100% !important; /* Adjust the width as needed */
		  height: 20px; /* Optional: Adjust the height as needed */
		  padding: 5px;
		  margin: 2px 0;
		  box-sizing: border-box;
	}
	
   .userEdit .small-select {
	    width: 100%; /* Adjust the width as needed */
	    height: 20px; /* Adjust the height as needed */
	    font-size: 10px; /* Adjust the font size as needed */
	}
	
	.userEdit .cell-size{
	    width: 100% !important; /* Adjust the width as needed */
	    height: 20px; /* Adjust the height as needed */
	    font-size: 10px;
	}
	
	.userEdit .custom-select-small {
	    width: 100%; /* Adjust the width as needed */
	    height: 20px; /* Adjust the height as needed */
	    font-size: 11px; /* Adjust the font size as needed */
	}
	
	.userEdit .selectize-control .selectize-input {
	    padding: 1px 8px;
	}
	
</style>

</head>
<body>
	<div id="pageContent"> 
		<div class="userEdit">
			<h2>Emp Details Edit</h2>
	
     		<form id="userDetailsForm" action="updateEmpDetails.do" method="post" enctype="multipart/form-data">
	    	 	<div class="form-buttons">
				   <button id="saveButton">Save</button>
			       <button id="cancelButton">Cancel</button>
			    </div>
			    
	 			<table class="user-details-table">
     				<tr>
          				<th>Date of Joining</th>
	          				<td>
								<input type="text" class="uniform-size" name="dateOfJoining" id="dateOfJoining" data-fieldname="dateOfJoining" value="<fmt:formatDate value='${userDetails.dateOfJoining}' pattern='yyyy-MM-dd' />" readonly/>
							</td>
							
          				<th>Emp Id</th>
							<td>
							   <input type="text" class="uniform-size" id="empId" name="empId" data-fieldname="empId" value="${userDetails.empId}" readonly />
							</td>
              
          				<th>Security</th>
							<td>
							   <input type="text" class="uniform-size" id="securityLevel" name="securityLevel" data-fieldname="securityLevel" value="${userDetails.securityLevel}" readonly />
							</td>
	 				</tr>
	 						
	  				<tr>
          				<th>Name</th>
							<td>
							   <input type="text" class="uniform-size" id="name" name="name" data-fieldname="name" value="${userDetails.name}"  />
							   <div class="invalid-feedback" id="nameError"></div>
							</td>
          
						<th>Password</th>
							<td>
							    <div class="password-container icon-input-container">
							        <input type="password" id="password" name="password" class="form-control form-control-sm" data-fieldname="password" value="${userDetails.password}" required minlength="8" maxlength="16">
							        <i class="fas fa-eye eye-icon" onclick="togglePasswordVisibility('password')"></i>
							        <div class="invalid-feedback" id="passwordError"></div>
							    </div>
							</td>
							
          				<th>Date of Birth</th>
							<td>
								<div class="icon-input-container">
							 		<input type="text" name="dateOfBirth" id="dateOfBirth" data-fieldname="dateOfBirth" value="<fmt:formatDate value='${userDetails.dateOfBirth}' pattern='yyyy-MM-dd' />" class="datepicker dob" readOnly>
							   		<i class="fa-solid fa-calendar-days date-icon" style="color: #245cbc; cursor: pointer;"></i>
							   		<div class="invalid-feedback" id="dateOfBirthError"></div>
							 	</div> 
							</td>
	 				</tr>
	  				
	  				<tr>
          				<th>Group</th>
							<td>
							    <input type="text" id="group" name="group" class="uniform-size form-control" value="${userDetails.group}" readonly />
							</td>
			
         				<th>Department</th>
							<td>
							    <select id="department">
								    <option value="" disabled selected>Select Department</option>
								    <!-- Existing department option if available -->
								    <c:if test="${not empty userDetails.department}">
								        <option value="${userDetails.department}" selected>${userDetails.department}</option>
								    </c:if>
								</select>
							</td>
							
		 				<th>Designation</th>
							<td>
							    <select id="designation" name="designation" class="form-select custom-select-small">
								    <option value="" disabled selected>Select Designation</option>
								    <!-- Existing designation option if available -->
								    <c:if test="${not empty userDetails.designation}">
								        <option value="${userDetails.designation}" selected>${userDetails.designation}</option>
								    </c:if>
								</select>
							</td>
	 				</tr>
	 				
	  				<tr>
         				<th>Gender</th>
							<td>
							    <input type="text" id="genderText" value="${userDetails.gender}" class="uniform-size" style="display: none;" />
							    <select id="genderSelect"  class="small-select" name="gender">
							        <option value="Male" ${userDetails.gender == 'Male' ? 'selected' : ''}>Male</option>
							        <option value="Female" ${userDetails.gender == 'Female' ? 'selected' : ''}>Female</option>
							        <option value="Other" ${userDetails.gender == 'Other' ? 'selected' : ''}>Other</option>
							    </select>
							</td>

						<th>Religion</th>
							<td>
							   <input type="text" class="uniform-size" id="religion" name="religion" data-fieldname="religion" value="${userDetails.religion}"  />
							</td>
              
          				<th>Address</th>
							<td>
							   	<input type="text"  class="uniform-size" id="address" name="address" data-fieldname="address" value="${userDetails.address}"  />
							</td>
	 				</tr>
	 				
	 				<tr>
          				<th>Cellphone</th>
							<td>
							   	<input type="tel" class="cell-size" id="cellPhone" name="cellPhone" data-fieldname="cellPhone" value="${userDetails.cellPhone}"  />
							    <div class="invalid-feedback" id="cellPhoneError"></div>
							</td>
          
          				<th>Email</th>
							<td>
							   	<input type="text" id="email" class="uniform-size"  name="email" data-fieldname="email" value="${userDetails.email}"  />
							   	<div id="email-error" class="invalid-feedback"></div>
							</td>
              
          				<th>Emergency contact</th>
							<td>
							   	<input type="tel" id="emergencyContact" class="uniform-size" name="emergencyContact" data-fieldname="emergencyContact" value="${userDetails.emergencyContact}"  />
							    <div class="invalid-feedback" id="emergencyContactError"></div>
							</td>
	 				</tr>
	 				
	  				<tr>
          				<th>Final Degree</th>
							<td>
							   	<input type="text"  class="uniform-size" id="finalDegree" name="finalDegree" data-fieldname="finalDegree" value="${userDetails.finalDegree}"  />
							    <div class="invalid-feedback" id="finalDegreeError"></div>
							</td>
          
          				<th>University</th>
							<td>
								<label for="university" class="form-label"></label>
							   	<select id="university" name="university" required class="form-control">
									<option value="">Select a university</option>
									<!-- University options should be added here -->
								</select>
							</td>
              
          				<th>Language</th>
							<td>
							   	<input type="text" class="uniform-size" id="language" name="language" data-fieldname="language" value="${userDetails.language}"  />
							</td>
	 				</tr>
	 				
	 				<tr>
          				<th>Career</th>
							<td>
							  	<input type="number" class="uniform-size" id="career" name="careerExperience" data-fieldname="careerExperience" value="${userDetails.careerExperience}"  />
							</td>
          
          				<th>Year</th>
							<td>
							   	<input type="text" class="uniform-size" id="year" name="yearOfWorking" data-fieldname="yearOfWorking" value="${userDetails.yearOfWorking}"  readonly/>
							</td>
              
          				<th>Salary</th>
							<td>
							   	<input type="text" class="uniform-size" id="salary" name="salary" data-fieldname="salary" value="${userDetails.salary}"  />
							</td>
	 				</tr>
	 				
	  				<tr>
          				<th>Marital Status</th>
							<td>
								<input type="text" id="maritalStatusText" name="maritalStatus" value="${userDetails.maritalStatus}" disabled style="display: none;" />
								<select id="maritalStatusSelect" class="small-select" name="maritalStatus">
							    	<option value="Single" ${userDetails.maritalStatus == 'Single' ? 'selected' : ''}>Single</option>
									<option value="Married" ${userDetails.maritalStatus == 'Married' ? 'selected' : ''}>Married</option>
							    </select>
							</td>
							
          				<th>Disablity</th>
							<td>
							   	<input type="text" class="uniform-size" id="disability" name="disability" data-fieldname="disability" value="${userDetails.disability}"  />
							</td>
              
          				<th>Significant</th>
							<td>
							   	<input type="text" class="uniform-size" id="significant" name="significant" data-fieldname="significant" value="${userDetails.significant}"  />
							</td>
	 				</tr>
	 				
					<tr>
					    <th>Contract File</th>
					    <td>
					        <c:choose>
					            <c:when test="${empty contractFiles}">
					                <input type="text" style="margin-bottom: 5px;" value="No file uploaded" readonly/>
					            </c:when>
					            <c:otherwise>
					                <c:forEach var="file" items="${contractFiles}" varStatus="status">
					                    <div style="margin-bottom: 5px;">
					                        <input value="${file.fileName}" style="width: 93%;" readonly />
					                        <i class="fa-solid fa-x delete-file" data-file-no="${file.no}" style="color: #e32626; margin-left: 3px; font-size: 11px; cursor: pointer;"></i>
					                    </div>
					                </c:forEach>
					            </c:otherwise>
					        </c:choose>
					        <input type="file" id="contractFiles" name="contractFiles" multiple/>
					    </td>
					
					    <th>Certificate</th>
					    <td>
					        <c:choose>
					            <c:when test="${empty certificateFiles}">
					                <input type="text" style="margin-bottom: 5px;" value="No file uploaded" readonly/>
					            </c:when>
					            <c:otherwise>
					                <c:forEach var="file" items="${certificateFiles}" varStatus="status">
					                    <div style="margin-bottom: 5px;">
					                        <input value="${file.fileName}" style="width: 93%;" readonly />
					                        <i class="fa-solid fa-x delete-file" data-file-no="${file.no}" style="color: #e32626; margin-left: 3px; font-size: 11px; cursor: pointer;"></i>
					                    </div>
					                </c:forEach>
					            </c:otherwise>
					        </c:choose>
					         <input type="file" id="certificateFiles" name="certificateFiles" multiple/>
					    </td>
					
					    <th>Resume File</th>
					    <td>
					        <c:choose>
					            <c:when test="${empty resumeFiles}">
					                <input type="text" style="margin-bottom: 5px;" value="No file uploaded" readonly/>
					            </c:when>
					            <c:otherwise>
					                <c:forEach var="file" items="${resumeFiles}" varStatus="status">
					                    <div style="margin-bottom: 5px;">
					                        <input value="${file.fileName}" style="width: 93%;" readonly />
					                        <i class="fa-solid fa-x delete-file" data-file-no="${file.no}" style="color: #e32626; margin-left: 3px; font-size: 11px; cursor: pointer;"></i>
					                    </div>
					                </c:forEach>
					            </c:otherwise>
					        </c:choose>
					         <input type="file" id="resumeFiles" name="resumeFiles" multiple/>
					    </td>
					</tr>
    
	 				<tr>
          				<th>Date of Resignation</th>
							<td>
							   	<div class="icon-input-container" >
							   		<input type="text" name="dateOfResignation" id="dateOfResignation" data-fieldname="dateOfResignation" value="<fmt:formatDate value='${userDetails.dateOfResignation}' pattern='yyyy-MM-dd' />" class="datepicker resign" readOnly>
							   		<i class="fa-solid fa-calendar-days date-icon" style="color: #245cbc; cursor: pointer;"></i>
							   		<div class="invalid-feedback" id="dateOfResignationError"></div>
							   	</div>   
							</td>
              
          				<th>Reason for Resignation</th>
							<td>
							   	<input type="text" class="uniform-size" id="reasonForResignation" name="reasonForResignation" data-fieldname="reasonForResignation" value="${userDetails.reasonForResignation}"  />
							</td>
              
          				<th>Re-Join Date</th>
	          				<td>
								<div class="icon-input-container">
									<input type="text" name="reJoin" id="reJoin" data-fieldname="reJoin" value="<fmt:formatDate value='${userDetails.reJoin}' pattern='yyyy-MM-dd' />" class="datepicker rejoin" readOnly>
									<i class="fa-solid fa-calendar-days date-icon" style="color: #245cbc; cursor: pointer;"></i>
									<div class="invalid-feedback" id="reJoinError"></div>
		         				</div>
	          				</td>
	 				</tr>
	 				
	  				<tr>
	          			<th>Recruitment Route</th>
							<td>
							  	<input type="text" class="uniform-size" id="recruitmentRoute" name="recruitmentRoute" data-fieldname="recruitmentRoute" value="${userDetails.recruitmentRoute}"  />
							</td>
	          
	          			<th>Recommender</th>
							<td>
							   	<input type="text" class="uniform-size"id="recommender" name="recommender" data-fieldname="recommender" value="${userDetails.recommender}"  />
							</td>
	              
	           				<td colspan="2"></td>
	 				</tr>
 				</table>
 				
 				<input type="hidden" id="departmentName" name="department" value="">
 			</form>
 		</div>
 	</div>
 	
	<script>
	$(document).ready(function() {
	    var togglePassword = document.getElementById('togglePassword');
	    var password = document.getElementById('password');

	    if (togglePassword) { // Check if togglePassword element exists
	        togglePassword.addEventListener('click', function (e) {
	            // toggle the type attribute
	            var type = password.getAttribute('type') === 'password' ? 'text' : 'password';
	            password.setAttribute('type', type);

	            // toggle the eye / eye slash icon
	            this.classList.toggle('fa-eye');
	            this.classList.toggle('fa-eye-slash');
	        });
	    }
	});

   </script>
   <script>
    $(document).ready(function() {
        $("#name").on("input", function() {
            var inputElement = $(this);
            var inputValue = inputElement.val();
            var filteredValue = inputValue.replace(/[^A-Za-z\s]/g, '');
            var correctedValue = filteredValue.replace(/\s+/g, ' ');
            var trimmedValue = correctedValue.length > 30 ? correctedValue.substring(0, 30) : correctedValue;
            inputElement.val(trimmedValue);
            validateName();
        });

        $("#name").on("blur", function() {
            var inputElement = $(this);
            var trimmedValue = inputElement.val().trim();
            inputElement.val(trimmedValue);
            validateName();
        });
    });

        function validateName() {
            var nameInput = $("#name");
            var nameValue = nameInput.val();
            var namePattern = /^[A-Za-z]+(?: [A-Za-z]+)*$/;
            if (!namePattern.test(nameValue) || nameValue.length > 30) {
                nameInput.addClass("is-invalid");
                $("#nameError").text("Please enter a valid Name").show();
            } else {
                nameInput.removeClass("is-invalid");
                $("#nameError").hide();
            }
        }
</script>
<script>
    $(document).ready(function() {
        // Attach event handlers
        $('#email').on('input', function() {
            validateEmail();
        });

        $('#email').on('input blur', function() {
            checkEmailExists();
        });
    });

    function checkEmailExists() {
        var email = $('#email').val();
        var empId = $('#empId').val(); // Assuming you have an input field with id="empId" holding the employee ID

        if (!isValidEmail(email)) {
            $('#email').addClass('is-invalid');
            $('#email-error').text('Please enter a valid email address.');
            return;
        }

        $.ajax({
            type: 'GET',
            url: '/webProject/syst/user/checkEmailForOtherEmpId.do',
            data: { 
                email: email,
                empId: empId  // Correctly include empId within the data object
            },
            success: function(response) {
                if (response.exists === 'true') {
                    $('#email').addClass('is-invalid');
                    $('#email-error').text('Email is already in use.');
                } else {
                    $('#email').removeClass('is-invalid');
                }
            },
            error: function(error) {
                alert('Error: ' + error.responseText);
            }
        });
    }

    function validateEmail() {
        var email = $('#email').val();
        return /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(email);
    }

    function isValidEmail(email) {
        var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        return regex.test(email);
    }
</script>

<script>
    $(document).ready(function() {
        // Event listener for Career input
        $('#career').on('input', function() {
            validateCareer();
        });
    });

    function validateCareer() {
        var careerInput = $('#career');
        var careerValue = parseInt(careerInput.val());

        if (isNaN(careerValue) || careerValue < 0) {
            // If the input is not a valid number or less than 0, set it to 0
            careerInput.val(0);
        } else if (careerValue <= 9) {
            // If the input is 0-9, keep it as is
            careerInput.val(careerValue);
        } else if (careerValue > 30) {
            // If the input is greater than 30, set it to 30
            careerInput.val(30);
        } else {
            // If the input is 10-30, keep it as is
            careerInput.val(careerValue);
        }
    }
</script>

<script>
    $(document).ready(function() {
        // Attach the event handler for the password input
        $('#password').on('input', function() {
            validatePassword(); // Call validatePassword function when user inputs into the password field
        });
    });
    
    function togglePasswordVisibility(fieldId) {
        var field = document.getElementById(fieldId);
        var icon = field.nextElementSibling;
        if (field.type === "password") {
            field.type = "text";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        } else {
            field.type = "password";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        }
    }
    
    function validatePassword() {
        const password = $("#password").val();
        // Updated Regex Pattern
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
        					
        if (!passwordRegex.test(password)) {
            $("#password").addClass("is-invalid");
            $("#passwordError").text("Password must be 8-16 characters with at least 1 alphabet, 1 number, and 1 special character.");
            return false;
        } else {
            $("#password").removeClass("is-invalid");
            $("#password").addClass("is-valid"); // Add the valid class
            $("#passwordError").text("");
            return true;
        }
    }

</script>

<script>
$(document).ready(function() {
    $("#finalDegree").on("input", function() {
        var value = $(this).val();
        // Remove numbers and replace multiple spaces or dots with a single space or dot, disallow dot following space
        var validValue = value.replace(/[^A-Za-z .]/g, '') // Remove numbers
                              .replace(/\.{2,}/g, '.') // Replace consecutive dots with a single dot
                              .replace(/\s{2,}/g, ' ') // Replace consecutive spaces with a single space
                              .replace(/\s\./g, '.'); // Disallow dot following space
        $(this).val(validValue.substring(0, 30)); // Trim the value to the first 30 characters
    });

    $("#finalDegree").on("blur", function() {
        var inputElement = $(this);
        var value = inputElement.val();
        var trimmedValue = value.trim() // Trim leading and trailing spaces
                                .substring(0, 30); // Ensure the string does not exceed 30 characters
        inputElement.val(trimmedValue); // Update the input with trimmed value
        validateFinalDegree(inputElement); // Re-validate after trimming
    });
});

function validateFinalDegree(inputElement) {
    var value = inputElement.val();

    // Updated pattern to ensure it matches your specified allowed and disallowed formats
    var pattern = /^[A-Za-z]+(?:\.? ?[A-Za-z]+)*\.?$/;

    if (!pattern.test(value)) {
        inputElement.addClass("is-invalid");
        $("#finalDegreeError").text("Please enter a valid Final Degree").show();
    } else {
        inputElement.removeClass("is-invalid");
        $("#finalDegreeError").hide();
    }
}
</script> 
<script>
$(document).ready(function() {
    var inputFields = ["#cellPhone", "#emergencyContact"];
    var iti = {};

    inputFields.forEach(function(inputId) {
        var inputElement = document.querySelector(inputId);
        if (inputElement) {
            iti[inputId] = window.intlTelInput(inputElement, {
                separateDialCode: true,
                initialCountry: "IN",
                geoIpLookup: function(callback) {
                    $.get('https://ipinfo.io', function() {}, "jsonp").always(function(resp) {
                        var countryCode = (resp && resp.country) ? resp.country : "";
                        callback(countryCode);
                    });
                },
                utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/utils.js"
            });

            // Add a countrychange event listener to log the selected country code
            inputElement.addEventListener('countrychange', function() {
                // Get the current country data
                var currentCountry = iti[inputId].getSelectedCountryData();
                console.log(inputId + " country code: ", currentCountry.dialCode);
            });
        }

        $(inputId).on('blur keyup', function() {
            var cleanedNumber = cleanAndRestrictInput(this.value);
            this.value = cleanedNumber;
            validateInputField(inputId, iti[inputId], cleanedNumber);
        });
    });

    function cleanAndRestrictInput(inputValue) {
        var cleanedInput = inputValue.replace(/\D/g, '');
        return cleanedInput.length > 11 ? cleanedInput.substring(0, 11) : cleanedInput;
    }

    function validateInputField(inputId, itiInstance, cleanedNumber) {
        var errorElementId = inputId + "Error";
        var errorElement = $(errorElementId);
        var isValidLength = cleanedNumber.length >= 9 && cleanedNumber.length <= 11;

        // Clear previous error states
        $(inputId).removeClass("is-invalid");
        errorElement.hide();

        // Check for valid length first
        if (!isValidLength) {
            $(inputId).addClass("is-invalid");
            errorElement.text("Invalid phone number. Please enter a number with 9 to 11 digits.").show();
        } else {
            // If the number is the correct length but fails the format check
            $(inputId).removeClass("is-invalid");
            errorElement.hide();
        }
    }
});


function formatPhoneNumber(inputSelector) {
    var inputElement = $(inputSelector); // jQuery object
    if (inputElement.length > 0) {
        var itiInstance = window.intlTelInputGlobals.getInstance(inputElement[0]);
        console.log("Trying to format number for: ", inputSelector, " with value: ", inputElement.val());

        if (itiInstance) {
            if (itiInstance.isValidNumber() || inputElement.val().trim() !== "") {
                var fullNumber = itiInstance.getNumber(intlTelInputUtils.numberFormat.E164);
                var countryCode = itiInstance.getSelectedCountryData().dialCode;
                console.log("Formatted Number for " + inputSelector + ": " + fullNumber);
                console.log("Country Code for " + inputSelector + ": ", countryCode); 

                var formattedNumber = "+" + countryCode + " " + fullNumber.substring(("+" + countryCode).length);
                inputElement.val(formattedNumber); 
            } else {
                console.log("Number is not valid for " + inputSelector + ".");
            }
        } else {
            console.log("ITI instance is not available for " + inputSelector + ".");
        }
    } else {
        console.log("Input element not found for selector: " + inputSelector);
    }
}


</script>

<script>
$(document).ready(function() {
    var groupName = $('#group').val();
    var isDesignationsLoaded = false;

    function initialLoad() {
        var departmentName = $('#department option:selected').text();
        // Assuming a hidden field or similar for storing the pre-selected designation name
        var preSelectedDesignationName = $('#preSelectedDesignationName').val();

        if (!departmentName || departmentName.trim() === '' || departmentName === "Select Department") {
            loadDepartmentsForGroupName(groupName);
        } else {
            $('#departmentName').val(departmentName);
            // Only set the pre-selected designation name in the dropdown, don't load all designations yet
            if (preSelectedDesignationName) {
                $('#designation').append($('<option>', {
                    value: preSelectedDesignationName,
                    text: preSelectedDesignationName,
                    selected: true
                }));
            }
        }
    }

    $('#designation').focus(function() {
        // Lazy load designations only if not already loaded
        if (!isDesignationsLoaded) {
            var departmentName = $('#department option:selected').text();
            loadDesignationsForCurrentDepartment(departmentName);
            isDesignationsLoaded = true; // Prevent future loads
        }
    });
    function loadDepartmentsForGroupName(groupName) {
        $.ajax({
            url: "/webProject/syst/org/getGroupNoByName.do",
            type: "GET",
            data: { groupName: groupName },
            success: function(groupNo) {
                fetchDepartments(groupNo);
            },
            error: function(xhr, status, error) {
                console.error("Error fetching group number: " + error);
            }
        });
    }

    function fetchDepartments(groupNo) {
        $.ajax({
            url: '/webProject/syst/org/dept/getDepartmentsByGroup.do',
            type: 'GET',            
            data: { groupNo: groupNo },
            success: function(departments) {
                updateDepartmentDropdown(departments);
            },
            error: function(xhr, status, error) {
                console.error("Error fetching departments: " + error);
            }
        });
    }

    function updateDepartmentDropdown(departments) {
        var departmentSelect = $('#department');
        departmentSelect.empty();
        departmentSelect.append($('<option>', {
            value: '',
            text: 'Select a Department',
            selected: true,
            disabled: true
        }));

        $.each(departments, function(index, department) {
            departmentSelect.append($('<option>', {
                value: department.deptNo + "|" + department.deptName,
                text: department.deptName
            }));
        });
    }

    function loadDesignationsForCurrentDepartment(departmentName) {
        if (departmentName && departmentName !== "Select Department") {
            $.ajax({
                url: "/webProject/syst/org/dept/getDeptNoByName.do",
                type: "GET",
                data: { deptName: departmentName },
                success: function(deptNo) {
                    if (deptNo) {
                        fetchDesignations(deptNo);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching department number for " + departmentName + ": " + error);
                }
            });
        }
    }

    function fetchDesignations(deptNo) {
        $.ajax({
            url: '/webProject/syst/org/dsgn/getDesignationByDept.do',
            type: 'GET',
            data: { deptNo: deptNo },
            success: function(designations) {
                updateDesignationDropdown(designations);
            },
            error: function(xhr, status, error) {
                console.error("Error fetching designations: " + error);
                $('#designation').empty().append('<option value="" disabled selected>Error Loading Designations</option>');
            }
        });
    }

    function updateDesignationDropdown(designations) {
        var designationSelect = $('#designation');
        designationSelect.empty();
        designationSelect.append($('<option>', {
            value: '',
            text: 'Select a Designation',
            selected: true,
            disabled: true
        }));

        $.each(designations, function(index, designation) {
            designationSelect.append($('<option>', {
                value: designation.dsgnName,
                text: designation.dsgnName,
                'data-security-level': designation.securityLevel
            }));
        });

        clearSecurityLevelIfDesignationNotSelected();
    }

    function clearSecurityLevelIfDesignationNotSelected() {
        var selectedDesignation = $('#designation').val();
        if (!selectedDesignation || selectedDesignation.trim() === '') {
            $('#securityLevel').val('');
        } else {
            var selectedSecurityLevel = $('#designation').find(':selected').data('security-level');
            $('#securityLevel').val(selectedSecurityLevel);
        }
    }

    // Department change handler to fetch designations
    $('#department').change(function() {
        var selected = $(this).find(':selected').val().split('|');
        var deptNo = selected[0];
        var departmentName = selected[1];

        $('#departmentName').val(departmentName); // Set the hidden input for department name

        if (deptNo) {
            fetchDesignations(deptNo);
        }
    });

    // Add click event listener to reload departments when department dropdown is clicked
    $('#department').one('click', function() {
        loadDepartmentsForGroupName(groupName);
    });

    $('#designation').change(function() {
        clearSecurityLevelIfDesignationNotSelected();
    });

    // Initial load actions
    initialLoad();
});

</script>

<script>
$(document).ready(function() {
    // Enable date picker for input fields with the "datepicker" class
    $('.dob').datepicker({
        dateFormat: 'yy-mm-dd', // Set the desired date format
        changeMonth: true,      // Enable the month drop-down
        changeYear: true,        // Enable the year drop-down
        yearRange: "-100:-15"
    });

    $('.resign').datepicker({
        dateFormat: 'yy-mm-dd', // Set the desired date format
        changeMonth: true,      // Enable the month drop-down
        changeYear: true,        // Enable the year drop-down
        yearRange: "-100:+0"
    });

    $('.rejoin').datepicker({
        dateFormat: 'yy-mm-dd', // Set the desired date format
        changeMonth: true,      // Enable the month drop-down
        changeYear: true,        // Enable the year drop-down
        yearRange: "-100:+0"
    });

    // Event handler to show the datepicker when the calendar icon is clicked
    $('.date-icon').click(function () {
        // Find the datepicker input field related to this icon and show its datepicker
        $(this).siblings('input.datepicker').datepicker('show');
    });
    

    // Function to check the date validity and display messages
    function validateDateInput(inputId, errorMessageId, isValid) {
        var input = $('#' + inputId);
        var messageBox = $('#' + errorMessageId);
        if (!isValid) {
            messageBox.text('Invalid Date. Please select a date from the calendar.');
        } else {
            messageBox.text('');
        }
    }

});

</script>

<script>
// Array to store files to be deleted
var filesToDelete = [];

$(document).ready(function() {
    $('.delete-file').click(function() {
        var fileNo = $(this).data('file-no'); // Retrieve the file number using .data()
        console.log('fileNo to delete:', fileNo);

        // Check if the fileNo is not already in the filesToDelete array
        if (!filesToDelete.includes(fileNo.toString())) { // Convert fileNo to string for consistency
            filesToDelete.push(fileNo.toString()); // Add file number to the array
            console.log('Added fileNo to filesToDelete:', fileNo);
        } else {
            console.log('fileNo already in filesToDelete:', fileNo);
        }

        $(this).parent().remove(); // Remove the file entry from the UI
    });



    // Function to handle file upload
    $('.upload-file').change(function() {
        // Implement the logic to upload the file
        // After successful upload, update the UI to display the uploaded file
        var fileName = $(this).val().split('\\').pop(); // Get the file name
        var $parent = $(this).closest('td'); // Get the parent <td> element
        $parent.find('span').text(fileName); // Update the file name display
        $parent.find('.delete-file').show(); // Show the delete icon
    });
});



// Function to validate file inputs
function validateFileUpload(selector, existingFilesCount, maxFiles, errorMessage) {
   const files = $(selector)[0].files;
   if (files.length + existingFilesCount > maxFiles) {
       alert(errorMessage);
       $(selector).val(''); // Clear the selected files
       event.preventDefault();
   }
}


// Function to validate file inputs
function validateFiles(selector) {
    const files = $(selector)[0].files;
    if (files.length === 0) {
        $(selector).addClass("is-invalid");
    } else {
        $(selector).removeClass("is-invalid");
    }
}

</script>


<script>
$(document).ready(function() {
    
 // Function to extract URL parameters
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }
    
    // Cancel Button Click Handler
    $('#cancelButton').click(function(event) {
        event.preventDefault();
        var empId = getUrlParameter('empId'); // Retrieve the empId parameter from the URL
        window.location.href = 'employeeDetails.do?empId=' + empId; // Redirect to userDetails.do with empId parameter
    });

});
</script>

<script>
$(document).ready(function() {
    // Define maximum lengths for each field
    var maxLengths = {
        '#religion': 10,
        '#recruitmentRoute': 10,
        '#recommender': 30,
        '#maritalStatus': 10, // Assuming you have a field for marital status
        '#disability': 10,
        '#significant': 50,
        '#reasonForResignation': 100,
        '#language': 100
    };

    // String inputs validation: Recruitment Route, Religion, Language, Recommender, Reason for Resignation, Significant, and others
    var stringFields = Object.keys(maxLengths); // Use the keys from the maxLengths object
    stringFields.forEach(function(field) {
        $(field).on('input', function() {
            // Allow letters and dynamically replace multiple consecutive spaces with a single space during typing
            var value = $(this).val();
            var validValue = value.replace(/[^a-zA-Z\s]/g, '') // Allow only letters and spaces
                                  .replace(/\s{2,}/g, ' ') // Replace consecutive spaces with a single space
                                  .substring(0, maxLengths[field]); // Apply the maximum length constraint
            $(this).val(validValue); // Update the field with the valid value
        });

        $(field).on('blur', function() {
            // Trim starting and ending spaces on blur
            var value = $(this).val();
            var trimmedValue = value.trim() // Trim spaces from the start and end
                                    .substring(0, maxLengths[field]); // Ensure it doesn't exceed the maximum length
            $(this).val(trimmedValue); // Update the field with the trimmed value
        });
    });

    // Numeric input validation: Salary
    $('#salary').on('input', function() {
        var value = $(this).val();
        var validValue = value.replace(/[^0-9]/g, ''); // Allow only numbers
        $(this).val(validValue); // Update the field with the valid value
    });
});
</script>

<script>
$(document).ready(function() {
    function loadUniversities() {
        var preselectedUniversity = "${userDetails.university}"; // Dynamically populated server-side value

        $('#university').selectize({
            create: true, // Enable creation of new entries
            sortField: 'text',
            preload: true, // Preload options on initialization
            load: function(query, callback) {
                if (!query.length) return callback();
                $.ajax({
                    url: 'http://universities.hipolabs.com/search?name=' + encodeURIComponent(query),
                    type: 'GET',
                    error: function() {
                        callback();
                    },
                    success: function(res) {
                        callback(res.map(function(item) {
                            return {text: item.name, value: item.name};
                        }));
                    }
                });
            },
            onInitialize: function() {
                var selectize = this;
                if (preselectedUniversity) {
                    // If there's a preselected university, add it as an option and set it as selected
                    selectize.addOption({text: preselectedUniversity, value: preselectedUniversity});
                    selectize.setValue(preselectedUniversity);
                }
            }
        });
    }

    loadUniversities();
});

</script>

<script>

    $(document).ready(function() {
        $('#saveButton').click(function(event) {
            event.preventDefault(); // Prevent the default form submission action

            // Check for any invalid fields
            var invalidFields = $('#userDetailsForm .is-invalid');
            if (invalidFields.length > 0) {
                // If there are invalid fields, stop the form submission
                alert('Please correct the errors before submitting.');
                invalidFields.first().focus(); // Focus on the first invalid field
                return; // Exit the function to prevent further execution
            }

            validateFiles("#resumeFiles");
            validateFiles("#contractFiles");
            validateFiles("#certificateFiles");

            // Format phone numbers before form submission
            formatPhoneNumber('#cellPhone');
            formatPhoneNumber('#emergencyContact');

            // Proceed with form submission if there are no invalid fields
            var formData = new FormData($('#userDetailsForm')[0]);

            // Append each contract file to formData with category
            $.each($("#contractFiles")[0].files, function(i, file) {
                formData.append("contractFiles", file, file.name + "|Contract");
            });

            // Append each certificate file to formData with category
            $.each($("#certificateFiles")[0].files, function(i, file) {
                formData.append("certificateFiles", file, file.name + "|Certificate");
            });

            // Append each resume file to formData with category
            $.each($("#resumeFiles")[0].files, function(i, file) {
                formData.append("resumeFiles", file, file.name + "|Resume");
            });

            $.ajax({
                url: 'updateEmpDetails.do',
                type: 'POST',
                data: formData,
                processData: false,  // Prevent jQuery from automatically processing the data
                contentType: false,  // Tell jQuery not to set contentType
                success: function(response) {
                    // Handle successful form submission
                    alert('User details updated successfully');
                    
                    // Call the deleteFiles function to delete the files
                    deleteFiles(filesToDelete);
                },
                error: function(xhr, status, error) {
                    // Handle errors during form submission
                    alert('Error updating user details: ' + error);
                }
            });
        });
    });

    // Event handlers for file inputs
    $("#contractFiles").on("change", function() {
        var existingFilesCount = $("#contractFiles").siblings('div').length;
        validateFiles("#contractFiles"); // Pass the correct selector
        validateFileUpload("#contractFiles", existingFilesCount, 10, "You can only attach a maximum of 10 contract documents."); // Validate file upload
    });

    $("#certificateFiles").on("change", function() {
        var existingFilesCount = $("#certificateFiles").siblings('div').length;
        validateFiles("#certificateFiles"); // Pass the correct selector
        validateFileUpload("#certificateFiles", existingFilesCount, 10, "You can only attach a maximum of 10 certificate documents."); // Validate file upload
    });

    $("#resumeFiles").on("change", function() {
        var existingFilesCount = $("#resumeFiles").siblings('div').length;
        validateFiles("#resumeFiles"); // Pass the correct selector
        validateFileUpload("#resumeFiles", existingFilesCount, 10, "You can only attach a maximum of 10 resume documents."); // Validate file upload
    });
    
    function deleteFiles(filesToDelete) {
        if (filesToDelete.length > 0) { // Ensure there are files to delete
            console.log('Submitting files to delete:', filesToDelete);
            $.ajax({
                url: '/webProject/syst/user/deleteFiles.do',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(filesToDelete.map(Number)), // Ensure numbers are formatted correctly
                success: function(response) {
                    var empId = $('#empId').val();
                    window.location.href = 'employeeDetails.do?empId=' + encodeURIComponent(empId);
                },
                error: function(xhr, status, error) {
                    // Handle error message
                    alert('Error deleting files: ' + error);
                }
            });
        } else {
            console.log('No files to delete');
            
            var empId = $('#empId').val();
            window.location.href = 'employeeDetails.do?empId=' + encodeURIComponent(empId);
        }
    }



</script>


</body>
</html>