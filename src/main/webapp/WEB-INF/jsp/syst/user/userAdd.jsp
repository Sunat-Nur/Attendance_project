<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/intlTelInput.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/utils.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/css/intlTelInput.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    
<style>
	.addUser .form-row {
		display: flex;
		flex-wrap: wrap;
		gap: 20px;
		margin-bottom: 10px;
		font-size: 13px;
	}
	
	.addUser .form-column {
		display: flex;
		flex-direction: column;
		flex-basis: calc(50% - 20px);
		margin-right: 10px;
		font-size: 13px;
	}
	
	.addUser .form-column:last-child {
		margin-right: 0;
	}
	
	.addUser .form-input,
	.addUser .form-select {
		padding: 6px;
		margin-bottom: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
		width: 100%;
		box-sizing: border-box;
		font-size: 12px;
	}
	
	.addUser label {
		padding-left: 4px;
		padding-bottom: 3px;
	}
	
	.addUser .form-button-panel {
		text-align: right;
	}
	
	/* Style the buttons to match the image */
	.addUser .form-button {
		background-color: #0080ff;
		border: none;
		color: white;
		padding: 5px 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 12px;
		margin: 0;
		cursor: pointer;
		border-radius: 4px;
	}
	
	.addUser .form-button-cancel {
     	background-color: #8c8c8c;
     	margin-right: 10px;
	}
	
	.addUser {
		max-width: 700px;
		margin: auto;
		overflow: hidden;
		font-size: 12px;
	}
	
	.addUser .input-icon-wrapper {
		position: relative;
		display: flex;
		align-items: center;
	}
	
	.addUser .input-icon-wrapper i {
		position: absolute;
		right: 10px;
		top: 7px;
		cursor: pointer;
	}
	
	.addUser .is-invalid {
		border-color: #dc3545;
	}
	
	.addUser .invalid-feedback {
		display: none;
		width: 100%;
		margin-top: .25rem;
		font-size: 80%;
		color: #dc3545;
		font-size: 12px;
	}
	
	.addUser .is-invalid ~ .invalid-feedback {
		display: block;
	}
	
	/* Ensure container and form-row are designed for responsiveness */
	.addUser form {
		border: 1px solid #ccc;
		padding: 20px;
		border-radius: 8px;
		font-size: 12px;
	}
	
	/* Targets the international telephone input's outer container */
	.addUser .iti {
		width: 100%;
	}
	
	/* Specific to the input within the international telephone input */
	.addUser .iti input[type=tel] {
		padding: 6px;
		margin-bottom: 10px;
		border-radius: 4px;
		width: 100%;
		box-sizing: border-box;
	}
	
	/* Adjusting the container to match form input styles if necessary */
	.addUser .iti--allow-dropdown {
		border-radius: 4px;
	}
</style>
   
</head>
<body>
	<div id="pageContent">
		<div class="addUser">
    		<h2>Add User</h2>
    		
    		<form action="addUser.do" method="post">
        		<div class="form-row">
					<div class="form-column">
   						<label for="name">Name:</label>
   						<input type="text" id="name" name="name" class="form-input">
   						<!-- Placeholder for the validation error message -->
   						<div class="invalid-feedback" id="nameError"></div>
					</div>
					
            		<div class="form-column">
	                	<label for="dateOfJoining">Date of Joining:</label>
	                	<div class="input-icon-wrapper">
	                    	<input type="text" id="dateOfJoining" name="dateOfJoining" class="form-input" readonly>
	                    	<i class="fas fa-calendar-alt"></i>
	                	</div>
	          			<div class="invalid-feedback" id="dateOfJoiningError"></div>
	            	</div>
        		</div>

        		<div class="form-row">
					<div class="form-column">
   						<label for="cellPhone">Cell Phone:</label>
						<input type="tel" class="cell-size" id="cellPhone" name="cellPhone" data-fieldname="cellPhone" value="${userDetails.cellPhone}"  />
						<div class="invalid-feedback" id="cellPhoneError"></div>
					</div>
					
    				<div class="form-column">
        				<label for="career">Career:</label>
        				<input type="number" id="career" name="careerExperience" class="form-input" min="0" max="30">
    				</div>
        		</div>
        		
        		<div class="form-row">
            		<div class="form-column">
                		<label for="group">Group:</label>
                		<select id="group" class="form-select">
                        <option value="" disabled selected>Select a Group</option>
                        	<c:forEach items="${allGroup}" var="group">
                            	<option value="${group.groupNo}|${group.groupName}">${group.groupName}</option>
                        	</c:forEach>
                		</select>
                		<div class="invalid-feedback" id="groupError"></div>
            		</div>
            		
            		<div class="form-column">
                		<label for="empId">Employee ID:</label>
                		<input type="text" id="empId" name="empId" class="form-input" readonly>
            		</div>
        		</div>

				<div class="form-row">
   					<div class="form-column">
			       		<label for="department">Department:</label>
			       		<select id="department" class="form-select"> <!-- Changed class here -->
           					<option value="">Select a Department</option>
       					</select>
       					<div class="invalid-feedback" id="departmentError"></div>
   					</div>
   					
   					<div class="form-column">
       					<label for="designation">Designation:</label>
      					<select id="designation" name="designation" class="form-select"> <!-- And here -->
			           		<option value="">Select a Designation</option>
			       		</select>
       					<div class="invalid-feedback" id="designationError"></div>
   					</div>
				</div>

        		<div class="form-row">
            		<div class="form-column">
                		<label for="email">Email:</label>
   						<input type="email" id="email" name="email" class="form-input">
   						<div id="email-error" class="invalid-feedback"></div>
            		</div>
            		
            		<div class="form-column">
                		<label for="gender">Gender:</label>
                		<select id="gender" name="gender" class="form-select">
		                    <option value="Male">Male</option>
		                    <option value="Female">Female</option>
                		</select>
            		</div>
        		</div>

        		<div class="form-row">
           			<div class="form-column">
   						<label for="year">Year:</label>
   						<input type="number" id="year" name="yearOfWorking" class="form-input" readonly>
					</div>
					
					<div class="form-column">
   						<label for="finalDegree">Final Degree:</label>
   						<input type="text" id="finalDegree" name="finalDegree" class="form-input">
   						<!-- Error message container for Final Degree -->
   						<div class="invalid-feedback" id="finalDegreeError"></div>
					</div>
        		</div>
        		<!-- Add a hidden input field to store the full phone number -->
          		<input type="hidden" id="securityLevel" name="securityLevel" value="">
          		<input type="hidden" id="groupName" name="group" value="">
				<input type="hidden" id="departmentName" name="department" value="">
         
        		<div class="form-button-panel">
            		<button type="submit" class="form-button form-button-save">Save</button>
            		<button type="button" id="cancelButton" class="form-button form-button-cancel">Cancel</button>
        		</div>
    		</form>
		</div>
	</div>
	

<script>
$(document).ready(function() {
	
    // Event listener for the Cancel button
    $('#cancelButton').click(function() {
        window.location.href = 'allUsersList.do'; // Redirect to the allUsersList.do endpoint
    });

   // Initialize the datepicker
  $('#dateOfJoining').datepicker({
        dateFormat: 'yy-mm-dd',
        changeYear: true,
        changeMonth: true,
        maxDate: new Date(), // Prevent future dates
        yearRange: "-30:+0", // Adjust based on requirement
        onSelect: function(dateText, inst) {
        	calculateYearBasedOnDateOfJoining(dateText); // Call year calculation on date select
            validateDateOfJoining(); // Additional validation, if needed
            generateEmpIdIfReady(); // Example function, if EMP ID generation is required
        }
    });

    // Validation logic for dateOfJoining
    function validateDateOfJoining() {
        var dateOfJoining = $('#dateOfJoining').val();
        var isValid = moment(dateOfJoining, 'YYYY-MM-DD', true).isValid() && moment(dateOfJoining).isSameOrBefore(moment());
        // Toggle validation message and input field style based on validity
        if (!isValid) {
            $('#dateOfJoining').addClass('is-invalid');
            $('#dateOfJoiningError').text('Invalid Date. Please select a valid date.').show();
        } else {
            $('#dateOfJoining').removeClass('is-invalid');
            $('#dateOfJoiningError').text('').hide();
        }
    }

    // Event listener for manual changes to Date of Joining input field
    $('#dateOfJoining').on('change', function() {
        calculateYearBasedOnDateOfJoining($(this).val());
        generateEmpIdIfReady(); // Assuming you have a function to generate Emp ID
    });

   // Trigger datepicker on calendar icon click
   $('.fa-calendar-alt').click(function() {
       $('#dateOfJoining').datepicker('show');
   });
});



    // Event listener for Group field change
    $('#group').change(function() {
        var selectedValue = $(this).val();
        console.log("group: selected value: " + selectedValue);
        var parts = selectedValue.split('|');
        var groupName = parts[1]; // Extract the group name
        console.log("group: groupName: " + groupName);

        // Set the hidden input field value for groupName
        $('#groupName').val(groupName);

        // Continue with fetching departments
        var groupNo = parts[0];
        
        console.log("group: groupNo: " + groupNo);       
        
        if (groupNo) {
        	fetchDepartments(groupNo);
            generateEmpIdIfReady(); // Also, check if we can generate the Emp ID
        } else {
            $('#department').empty().append('<option value="" disabled selected>Select a Department</option>');
        }
    });
   
   
   
    // Event listener for Department field change
    $('#department').change(function() {
        var selected = $(this).val().split('|');
        var deptNo = selected[0]
        var departmentName = selected[1];
        
        // Set the hidden input field value for departmentName
        $('#departmentName').val(departmentName);

        if (deptNo) {
            fetchDesignations(deptNo);
        } else {
            $('#designation').empty().append('<option value="" disabled selected>Select a Designation</option>');
        }
    });
   
 // Function to calculate and update the year based on date of joining
function calculateYearBasedOnDateOfJoining(dateString) {
   if(moment(dateString, 'YYYY-MM-DD', true).isValid()) {
       var dateOfJoining = moment(dateString, 'YYYY-MM-DD').toDate();
   } else {
       alert("Please enter the date in YYYY-MM-DD format.");
       return;
   }

   var currentDate = new Date();
   var yearElement = $('#year');
   var years = currentDate.getFullYear() - dateOfJoining.getFullYear();
   var monthDiff = currentDate.getMonth() - dateOfJoining.getMonth();
   if (monthDiff < 0 || (monthDiff === 0 && currentDate.getDate() < dateOfJoining.getDate())) {
       years--;
   }
   
   yearElement.val(years + 1); // Update the year field
}


function generateEmpIdIfReady() {
   var dateOfJoining = $('#dateOfJoining').val();
   var group = $('#group').val();
   if (dateOfJoining && group) {
       generateEmpId();
   }
}

function generateEmpId() {
   var dateOfJoining = $('#dateOfJoining').val();
   var groupValue = $('#group').val().split('|');
   var groupName = groupValue.length > 1 ? groupValue[1] : '';

   $.ajax({
       url: '/webProject/syst/reg/generateEmpId.do',
       type: 'GET',
       data: { dateOfJoining: dateOfJoining, group: groupName },
       success: function(response) {
           $('#empId').val(response.empId);
       },
       error: function(xhr, status, error) {
           console.error("Error generating employee ID: " + error);
       }
   });
}

function fetchDepartments(selectedGroup) {
   var groupNo = selectedGroup.split('|')[0];
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
   departmentSelect.append($('<option>', { value: '', text: 'Select a Department' }));

   $.each(departments, function(index, department) {
	   departmentSelect.append($('<option>', {
		    value: department.deptNo + "|" + department.deptName, // Combining both ID and Name
		    text: department.deptName
		}));
   });
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
       text: 'Select a Designation'
   }));

   $.each(designations, function(index, designation) {
       designationSelect.append($('<option>', {
           value: designation.dsgnName, // Assuming the designation object has a dsgnName property
           text: designation.dsgnName, // Assuming the designation object has a dsgnName property
           'data-security-level': designation.securityLevel // If applicable
       }));
   });
}

$('#designation').change(function() {
   var selectedSecurityLevel = $(this).find(':selected').data('security-level');
   $('#securityLevel').val(selectedSecurityLevel);
});


function validateCareer() {
    // Implement career validation logic here
    // Example: Check if the career input is a valid number and within a specific range
    var careerInput = $('#career').val();
    if (isNaN(careerInput) || careerInput < 0 || careerInput > 30) {
        $('#career').addClass("is-invalid");
        // Optionally, display an error message
        $("#careerError").text("Please enter a valid Career value between 0 and 30").show();
    } else {
        $('#career').removeClass("is-invalid");
        $("#careerError").hide();
    }
}

function validateGroup() {
    var groupSelect = $("#group");
    var groupValue = groupSelect.val();
    var errorElement = $("#groupError"); // Assuming you have an error display element with this ID

    if (!groupValue) { // If no group is selected
        groupSelect.addClass("is-invalid");
        errorElement.text("Please select a group.").show(); // Display an error message
        return false; // Indicate that the group selection is invalid
    } else {
        groupSelect.removeClass("is-invalid");
        errorElement.hide(); // Hide the error message if valid
        return true; // Indicate that the group selection is valid
    }
}

function validateDepartment() {
    var departmentSelect = $("#department");
    var departmentValue = departmentSelect.val();
    var errorElement = $("#departmentError"); // Ensure you have this element in your HTML

    if (!departmentValue) { // If no department is selected
        departmentSelect.addClass("is-invalid");
        errorElement.text("Please select a department.").show(); // Show error message
        return false; // Return false indicating invalid department selection
    } else {
        departmentSelect.removeClass("is-invalid");
        errorElement.hide(); // Hide error message if valid
        return true; // Return true indicating valid selection
    }
}

function validateDesignation() {
    var designationSelect = $("#designation");
    var designationValue = designationSelect.val();
    var errorElement = $("#designationError"); // You might need to add this element for displaying errors

    if (!designationValue) { // If no designation is selected
        designationSelect.addClass("is-invalid");
        errorElement.text("Please select a designation.").show(); // Show error message
        return false; // Indicate invalid designation selection
    } else {
        designationSelect.removeClass("is-invalid");
        errorElement.hide(); // Hide the error message if valid
        return true; // Indicate valid selection
    }
}
</script>

<script>
$(document).ready(function() {
    // Initialize a flag to track email validity
    window.isEmailValid = false;

    // Event listener for email field change
    $('#email').on('keyup blur', function() {
        var email = $(this).val();
        validateEmail(email);
    });
});

    // Function to validate email
    function validateEmail(email) {
        if (!email) {
            showError('Email cannot be empty.');
            window.isEmailValid = false;
            return;
        }
        $.ajax({
            url: '/webProject/syst/reg/checkEmailExists.do',
            type: 'GET',
            data: { email: email },
            success: function(response) {
                if (response.exists) {
                    showError('Email already exists.');
                    window.isEmailValid = false;
                } else {
                    hideError();
                    window.isEmailValid = true;
                }
            },
            error: function(xhr, status, error) {
                console.error("Error checking email existence: " + error);
                window.isEmailValid = false;
            }
        });
    }

    function showError(message) {
        $('#emailError').text(message).show();
        $('#email').addClass('is-invalid');
    }

    function hideError() {
        $('#emailError').hide();
        $('#email').removeClass('is-invalid');
    }

</script>

<script>
$(document).ready(function() {
// Event listener for the name field to validate and clean up on input
$("#name").on("input", function() {
   var inputElement = $(this);
   var inputValue = inputElement.val();
   // Remove characters that are not alphabets or spaces
   var filteredValue = inputValue.replace(/[^A-Za-z\s]/g, '');
   // Replace multiple consecutive spaces with a single space
   var correctedValue = filteredValue.replace(/\s+/g, ' ');
   // Enforce maximum length of 30 characters
   var trimmedValue = correctedValue.length > 30 ? correctedValue.substring(0, 30) : correctedValue;
   inputElement.val(trimmedValue);
   validateName();
});


   // Event listener for the name field to trim and validate on blur
   $("#name").on("blur", function() {
       var inputElement = $(this);
       var trimmedValue = inputElement.val().trim(); // Trim leading and trailing spaces only
       inputElement.val(trimmedValue); // Update the input with trimmed value
       validateName(); // Re-validate the trimmed input
   });
});

// Validation function for Name
function validateName() {
   var nameInput = $("#name");
   var nameValue = nameInput.val();
   // Allows alphabets and single spaces between words, but not at the start or end
   var namePattern = /^[A-Za-z]+(?: [A-Za-z]+)*$/;

   // Check if name matches the pattern and does not exceed 30 characters
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
    var inputFields = ["#cellPhone"];
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
	// Attach event handlers
	$('#email').on('input', function() {
	   validateEmail();
	});
	
	$('#email').on('input blur', function() {
	   checkEmailExists();
	});
});


// Function to check if the email already exists
function checkEmailExists() {
   var email = $('#email').val();

   if (!isValidEmail(email)) {
       $('#email').addClass('is-invalid');
       $('#email-error').text('Please enter a valid email address.');
       return;
   }

   $.ajax({
       type: 'GET',
       url: '/webProject/syst/reg/checkEmailExists.do',
       data: { email: email },
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

// Function to validate the email format
function validateEmail() {
   var email = $('#email').val();
   
   if (!isValidEmail(email)) {
       $('#email').addClass('is-invalid');
   } else {
       $('#email').removeClass('is-invalid');
   }
}

// Function to check if the email format is valid
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
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('dateOfJoining').addEventListener('change', function() {
        var dateString = this.value;
        if(moment(dateString, 'YYYY-MM-DD', true).isValid()) {
            var dateOfJoining = moment(dateString, 'YYYY-MM-DD').toDate();
        } else {
            alert("Please enter the date in YYYY-MM-DD format.");
            return;
        }

        var currentDate = new Date();
        var yearElement = document.getElementById('year');
       
        var years = currentDate.getFullYear() - dateOfJoining.getFullYear();
        var monthDiff = currentDate.getMonth() - dateOfJoining.getMonth();
        if (monthDiff < 0 || (monthDiff === 0 && currentDate.getDate() < dateOfJoining.getDate())) {
            years--;
        }
       
        yearElement.value = years + 1;
    });
});


function validateDateOfJoining() {
    var dateInput = $('#dateOfJoining');
    var dateValue = dateInput.val();
    var isValidDate = moment(dateValue, 'YYYY-MM-DD', true).isValid();
    var dateErrorElement = $('#dateOfJoiningError'); // Assuming you have this element for displaying the error

    if (!isValidDate) {
        dateInput.addClass('is-invalid');
        dateErrorElement.text('Please enter a valid date in YYYY-MM-DD format.').show();
    } else {
        dateInput.removeClass('is-invalid');
        dateErrorElement.hide();
    }
}


</script>
<script>
//This function checks all fields before allowing form submission.
function validateAndSubmitForm() {
    var isFormValid = true; // Initialize form validity status.

    // Call validation functions for all fields.
    validateName(); // Assuming this function updates the UI for validity.
    validateEmail($('#email')); // Assuming this function exists and validates the email.
    validateCareer(); // Assuming this function updates the UI for validity.
    validateDateOfJoining(); // Validate Date of Joining
    validateDepartment(); // Validate Department selection
    validateDesignation(); // Validate Designation selection
    validateFinalDegree($('#finalDegree')); // Validate Final Degree

    // Check if any field is invalid by looking for '.is-invalid' class presence.
    if ($('.is-invalid').length > 0) {
        isFormValid = false; // Mark form as invalid if any field is invalid.
    }

    return isFormValid; // Return the overall form validity.
}


// Attach the validation logic to form submission event.
$('form').on('submit', function(e) {
    // Prevent the default form submission.
    e.preventDefault();
   
    // Format phone numbers before form submission
    formatPhoneNumber('#cellPhone');
    formatPhoneNumber('#emergencyContact');
    if (validateAndSubmitForm()) {
   
        var formData = $(this).serialize(); // Serialize form data.
        // AJAX submission example (adjust URL and handling as needed).
        $.ajax({
            url: 'addUser.do', // Your submission endpoint
            type: 'POST',
            data: formData,
            success: function(response) {
                // Handle success (e.g., redirect or display a success message).
                window.location.href = 'allUsersList.do'; // Example redirection.
            },
            error: function(xhr, status, error) {
                // Handle errors (e.g., display error messages).
                console.error("Error saving user: " + error);
            }
        });
    } else {
        // Optional: Alert the user or scroll to the first invalid input.
        alert('Please fill all the fields correctly.');
        $('html, body').animate({
            scrollTop: $('.is-invalid').first().offset().top
        }, 500);
    }
});
</script>


</body>
</html>