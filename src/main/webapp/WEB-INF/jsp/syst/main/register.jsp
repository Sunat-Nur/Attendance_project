<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/css/intlTelInput.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/css/selectize.default.min.css" />
   
<style>
	     .error-message {
	     color: red;
	     }
	       
		 .container {
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  height: 130vh;
		  padding: 20px;
		  background-color: #f8f9fa;
		  }
	
		 form {
		  width: 60vw; /* Set the width to 70% of the viewport width */
		  max-width: 100%; /* Make sure it doesn't exceed 100% */
		  margin: 40px auto;
		}

	   .reduced-font-form {
	       font-size: 0.85em;  /* Adjust this value as per your requirements. */
	   }
	
	   .reduced-font-form .form-control {
	       font-size: 0.85em; /* Adjust as needed */
	       padding: 5px 10px; /* Adjust as needed */
		}
		
		 
		#department,
		#designation {
		  width: 100%;
		}
	
	   /* Style the dropdown container */
	   .select2-container--default .select2-selection--single {
	       font-size: 12px; /* Adjust the font size as needed */
	   }
	
	   /* Style the dropdown options */
	   .select2-container--default .select2-results__option {
	       font-size: 12px; /* Adjust the font size as needed */
	   }
	   
	   /* Set a fixed height for the container div */
	   .password-container {
	       height: 30px; /* Adjust the height as needed */
	   }
	
	   /* Set a fixed height for both password fields and eye buttons */
	   /* Set a fixed height for both password fields and eye buttons */
	   #password,
	   #confirmPassword,
	   .eye-button {
	       height: 50%; /* Make the height 100% to fill the container */
	   }
	
	   .eye-toggle {
	       font-size: 0.8em; /* Adjust the size as needed */
	       color: grey; /* This sets the color to grey */
	       position: absolute;
	       right: 17px;
	       top: 35px;
	       cursor: pointer;
	   }
	
		/* Adjust the position of the error message and set color to red */
		#passwordError {
		  margin-top: 5px; /* Adjust the top position as needed */
		   left: 12px; /* Align with the left edge of the password field */
		   width: 95%; /* Make the width fill the container */
		   font-size: 12px;
		   color: red; /* Set the color to red */
		}
		   
		      /* Adjust the position of the error message */
		   #confirmPasswordError {
		      margin-top: 5px;  /* Adjust the top position as needed */
		       left: 20px; /* Align with the left edge of the confirm password field */
		       width: 100%; /* Make the width fill the container */
		            font-size: 12px;
		            color: red;
	   }
	
		.iti {
		   width: 100%;
		}
		
		.invalid-feedback
		{
		font-size: 13px;
		color:red;
		}
		 
		 .invalid-feeback
		{
		font-size: 13px;
		color:red;
		}
		#cellPhone {
		   width: 200px; /* Adjust the width as needed to match the width of other fields */
		}
		
		
		#nameError
		{
		font-size: 13px;
		color:red;
		}
		
		#cellPhoneError
		{
		font-size: 13px;
		color:red;
		}
		
		/* Style for invalid input */
		.is-invalid {
		   border-color: red; /* Change border color to red */
		} 
  </style>
  
</head>
<body class="bg-light">

<div class="container">
    <form action="register.do" method="post" id="registrationForm" enctype="multipart/form-data" class="bg-white p-4 rounded shadow reduced-font-form">
   
        <!-- Title and hidden fields -->
        <h3 class="mb-5 text-center">Registration</h3>
        <input type="hidden" name="email" value="${employee.email}">
        <input type="hidden" id="group" name="group" value="${groupName}">
        <input type="hidden" name="empId" value="${empId}">
        <input type="hidden" name="securityLevel" value="">
        <input type="hidden" id="departmentName" name="department">
        <input type="hidden" id="designationName" name="designation">
        <input type="hidden" id="careerExperience" name="careerExperience">


<!-- Name and Mobile -->
<div class="form-group row justify-content-center field-pair">
   <!-- Name Field -->
   <div class="col-sm-5">
       <label for="name" class="form-label">Name:</label>
       <input type="text" id="name" name="name" class="form-control" maxlength="50">
       <div class="error-message" id="nameError" style="display: none;">Please enter your name.</div>
   </div>
 
<!-- Mobile Field -->
<div class="col-sm-5"> <!-- Increased width from col-sm-5 to col-sm-7 -->
   <label for="cellPhone" class="form-label">Cell phone :</label>
   <div>
       <input type="tel" id="cellPhone" name="cellPhone" class="form-input" maxlength="11" style="width: 100%;"> <!-- Added inline style to set width to 100% -->
   </div>
   <div class="error-message" id="cellPhoneError" style="display: none;">Please enter your mobile number.</div>
</div>
     </div>

       <!-- Password and Confirmpassword -->
<div class="form-group row justify-content-center field-pair">
   <!-- Password Field -->
      <div class="col-sm-5 position-relative">
       <label for="password" class="form-label">Password:</label>
       <input type="password" id="password" name="password" class="form-control form-control-sm" required minlength="8" maxlength="16">
       <i class="fa fa-eye-slash eye-toggle" onclick="togglePasswordVisibility('password')"></i>
       <div id="passwordError" class="invalid-feedback position-absolute"></div> <!-- Add position-absolute class for fixed positioning -->
   </div>
   
   <!-- Confirm Password Field -->
   <div class="col-sm-5 position-relative">
   <label for="confirmPassword" class="form-label">Confirm Password:</label>
   <input type="password" id="confirmPassword" name="confirmPassword" class="form-control form-control-sm" required minlength="8" maxlength="16" onkeyup="checkPasswordMatch()">
   <i class="fa fa-eye-slash eye-toggle" onclick="togglePasswordVisibility('confirmPassword')"></i>
   <div id="confirmPasswordError" class="invalid-feedback position-absolute"></div> <!-- Error message container -->
   </div>
</div>
<br>  
         
    <!-- Address Line 1 and Address Line 2 -->
    <div class="form-group row justify-content-center field-pair spacing-top">
   <!-- Address Line 1 Field -->
  <div class="col-sm-5">
      <label for="addressLine1" class="form-label">Address Line 1:</label>
      <input type="text" id="addressLine1" name="addressLine1" class="form-control" required maxlength="50">
       <div class="invalid-feedback">Please enter address</div>
  </div>

  <!-- Address Line 2 Field -->
  <div class="col-sm-5">
      <label for="addressLine2" class="form-label">Address Line 2:</label>
      <input type="text" id="addressLine2" name="addressLine2" class="form-control" maxlength="50">
       <div class="invalid-feedback">Please enter address</div>
  </div>
    </div>
   
   
   
    <!-- City and State -->
    <div class="form-group row justify-content-center field-pair">
        <!-- City Dropdown -->
        <div class="col-sm-5">
            <label for="city" class="form-label">City:</label>
            <select id="cityDropdown" name="city" class="form-control form-control-sm" required>
                <option value="" selected disabled>Select City</option>
                <!-- City options -->
            </select>
        </div>

        <!-- State Dropdown -->
        <div class="col-sm-5">
            <label for="state" class="form-label">State:</label>
            <select id="stateDropdown" name="state" class="form-control form-control-sm" required>
                <option value="" selected disabled>Select State</option>
                <!-- State options -->
            </select>
        </div>
    </div>

    <!-- Country and Zip/Postal Code -->
    <div class="form-group row justify-content-center field-pair">
        <!-- Country Dropdown -->
        <div class="col-sm-5">
            <label for="country" class="form-label">Country:</label>
            <select id="country" name="country" class="form-control form-control-sm" required>
                <option value="" selected disabled>Select Country</option>
                <!-- Country options -->
            </select>
        </div>

        <!-- Zip/Postal Code Field -->
        <div class="col-sm-5">
            <label for="postalCode" class="form-label">Zip/Postal:</label>
          <input type="text" id="postalCode" name="zipCode" class="form-control form-control-sm" required>
        <div class="invalid-feedback">Please enter valid postal code.</div>
        </div>
    </div>

    <!-- Group and Department -->
    <div class="form-group row justify-content-center field-pair">
        <!-- Group Field -->
        <div class="col-sm-5">
            <label for="groupNameDisplay" class="form-label">Group:</label>
            <input type="text" id="groupNameDisplay" name="groupNameDisplay" class="form-control form-control-sm" value="${groupName}" readonly>
        </div>

        <!-- Department Dropdown -->
        <div class="col-sm-5">
            <label for="department" class="form-label">Department:</label>
            <select id="department" class="form-control form-control-sm">
            <option value="">Select a Department</option>
            </select>
        </div>
    </div>

    <!-- Designation and Security Level -->
    <div class="form-group row justify-content-center field-pair">
        <!-- Designation Dropdown -->
        <div class="col-sm-5">
            <label for="designation" class="form-label">Designation:</label>
            <select id="designation" name="designation" class="form-control form-control-sm">
                <option value="">Select a Designation</option>
            </select>
        </div>

        <!-- Security Level Input -->
        <div class="col-sm-5">
            <label for="securityLevel" class="form-label">Security Level:</label>
            <input type="text" id="securityLevelDisplay" class="form-control" placeholder="Security Level" readonly>
        </div>
    </div>

     <div class="form-group row justify-content-center field-pair">
           <!-- Career Experience Years Input -->
          <div class="col-sm-5">
       <label for="years" class="form-label">Career Experience (Years):</label>
       <input type="number" id="years" name="years" class="form-control" placeholder="Years" min="0" max="30" required>
       <div class="invalid-feedback">Please specify your career experience in years.</div>
   </div>

   <!-- Career Experience Months Input -->
   <div class="col-sm-5">
       <label for="months" class="form-label">Career Experience (Months):</label>
       <input type="number" id="months" name="months" class="form-control" placeholder="Months" min="0" max="11" required>
       <div class="invalid-feedback">Please specify your career experience in months.</div>
   </div>
        </div>
       
        <!-- Hidden input to store the total experience -->
        <input type="hidden" id="totalExperience" name="totalExperience">
     

<!-- University and Final Degree -->
<div class="form-group row justify-content-center field-pair">
   <div class="col-sm-5">
       <!-- University Input -->
       <label for="university" class="form-label">University:</label>
       <select id="university" name="university" required class="form-control">
           <option value="">Select a university</option>
           <!-- University options should be added here -->
       </select>
       <div class="invalid-feedback">Please specify your university.</div>
   </div>

   <div class="col-sm-5">
       <!-- Final Degree Input -->
       <label for="finalDegree" class="form-label">Final Degree:</label>
       <input type="text" id="finalDegree" name="finalDegree" class="form-control" maxlength="50" required>
       <div class="invalid-feedback">Please specify your final degree.</div>
   </div>
</div>

     
<!-- Resume and KYC Documents -->
<div class="form-group row justify-content-center field-pair">
   <!-- Resume Input -->
   <div class="col-sm-5">
       <label for="resumeFiles" class="form-label">Resume:</label>
       <input type="file" id="resumeFiles" name="resumeFiles" required multiple class="form-control" accept=".pdf, .doc, .docx">
       <div class="invalid-feedback">Please attach your resume (PDF, DOC, DOCX).</div>
   </div>

   <!-- KYC Documents Input -->
   <div class="col-sm-5">
       <label for="kycFiles" class="form-label">KYC Documents:</label>
       <input type="file" id="kycFiles" name="kycFiles" required multiple class="form-control">
       <div class="invalid-feedback">Please attach your KYC documents.</div>
   </div>
</div>

    <!-- Submit Button -->
    <div class="form-group row justify-content-center">
        <div class="col-12 text-center">
            <button type="submit" class="btn btn-primary">Submit Request</button>
        </div>
    </div>
</form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/intlTelInput.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/utils.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.13.3/js/standalone/selectize.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<!-- Name -->
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


<!-- Cellphone -->
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
<!-- Password -->
<script>
// Function to toggle password visibility
 
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


function checkPasswordMatch() {
    const password = $("#password").val();
    const confirmPassword = $("#confirmPassword").val();

    if (password !== confirmPassword) {
        $("#confirmPassword").addClass("is-invalid");
        $("#confirmPassword").removeClass("is-valid"); // Remove the valid class
        $("#confirmPasswordError").text("Passwords do not match.");
    } else {
        $("#confirmPassword").removeClass("is-invalid");
        $("#confirmPassword").addClass("is-valid"); // Add the valid class
        $("#confirmPasswordError").text("");
    }
}

$(document).ready(function() {
	// Event listener for password input
	$("#password").on("input", function() {
	    validatePassword();
	    checkPasswordMatch();
	});
	
	// Event listener for confirm password input
	$("#confirmPassword").on("input", function() {
	    checkPasswordMatch();
	});
});

</script>

<!-- Address -->
<script>

//Add this function to validate dropdowns
function validateDropdown(dropdownId) {
   const dropdown = $(dropdownId);
   if (!dropdown.val()) {
       dropdown.addClass("is-invalid");
   } else {
       dropdown.removeClass("is-invalid");
   }
}

// Call the function for City, State, and Country
$("#cityDropdown, #stateDropdown, #country").on("change", function () {
   validateDropdown(this);
});

const minLength = 6; // Set your desired minimum length
const maxLength = 8; // Set your desired maximum length

// Define the validatePostalCode function outside $(document).ready
function validatePostalCode() {
    const postalCode = $("#postalCode").val().trim();
    const regexPostal = /^[0-9]+$/; // Ensure it's numeric

    // Check for numeric and length constraints
    if (!regexPostal.test(postalCode) || postalCode.length < minLength || postalCode.length > maxLength) {
        $("#postalCode").addClass("is-invalid");
        return false; // Return false when validation fails
    } else {
        $("#postalCode").removeClass("is-invalid");
        return true; // Return true when validation succeeds
    }
}


$(document).ready(function() {


  // Handle input events
  $("#postalCode").on("input", function() {
      this.value = this.value.replace(/[^0-9]/g, ""); // Remove non-numeric characters
      if (this.value.length > maxLength) {
          this.value = this.value.slice(0, maxLength); // Truncate if too long
      }
      validatePostalCode(); // Validate the postal code after each input
  });

  // Handle focus event
  $("#postalCode").on("focus", function() {
      // Clear the error state when the input is focused
      $("#postalCode").removeClass("is-invalid");
  });

  // Handle blur event
  $("#postalCode").on("blur", function() {
      // Validate the postal code when the input loses focus (blurs)
      validatePostalCode();
  });


});


// Address Validation
function validateAddressLine(input) {
  // Allow only alphabets, space, ",", "#", "/", "." and numbers.
  input.value = input.value.replace(/[^a-zA-Z\s,\/#.0-9]/g, '');

  // Not allow more than 3 consecutive special characters (combination included).
  input.value = input.value.replace(/([,\/#.\s]{3,})/g, match => match.slice(0, 3));

  // Not allow more than 2 same consecutive special characters.
  input.value = input.value.replace(/(,|\/|#|\.|\s)\1{1,}/g, '$1$1');
}

function isEmptyField(inputElement) {
  if(!inputElement.value.trim()) {
      $(inputElement).addClass("is-invalid");
      return true;
  } else {
      $(inputElement).removeClass("is-invalid");
      return false;
  }
}

$(document).ready(function() {
  $("#addressLine1, #addressLine2").on("input", function() {
      validateAddressLine(this);
  });

  $("#addressLine1, #addressLine2").on("blur", function() {
      // Trim spaces at the start and end of the string.
      this.value = this.value.trim();
      // Check if the field is empty.
      isEmptyField(this);
  });

  $("#postalCode").on("input", function() {
      validatePostalCode(this);
  });

  $("#postalCode").on("blur", function() {
      // Check if the postal code field is empty.
      isEmptyField(this);
  });
});
</script>

<!-- Address -->
<script>
$(document).ready(function() {
   
function populateCountries() {
   $.ajax({
       url: "https://api.countrystatecity.in/v1/countries",
       type: "GET",
       headers: {
           "X-CSCAPI-KEY": "NVF3ODVWT1lqY0l4V1VjU21vNDJiZHVoUXFlOGl2d3FFWHJRTlU3ag=="
       },
       success: function(data) {
           const countryDropdown = $("#country");
           countryDropdown.empty();
           countryDropdown.append($("<option>").val("").text("Select Country"));
           data.forEach(function(country) {
               countryDropdown.append($("<option>").val(country.name).data("ciso", country.iso2).text(country.name));
           });
       },
       error: function(error) {
           console.log("Error fetching countries:", error);
       }
   });
}


function populateStates(countryISO2 = null) {
   let url;

   if (countryISO2) {
       url = "https://api.countrystatecity.in/v1/countries/" + countryISO2 + "/states";
   } else {
       url = "https://api.countrystatecity.in/v1/states";
   }

   $.ajax({
       url: url,
       type: "GET",
       headers: {
           "X-CSCAPI-KEY": "NVF3ODVWT1lqY0l4V1VjU21vNDJiZHVoUXFlOGl2d3FFWHJRTlU3ag=="
       },
       success: function(data) {
           const stateDropdown = $("#stateDropdown");
           stateDropdown.empty();
           stateDropdown.append($("<option>").val("").text("Select State"));
           data.forEach(function(state) {
               stateDropdown.append($("<option>").val(state.name).data("siso", state.iso2).text(state.name));
           });
           stateDropdown.prop("disabled", false);
           // Load cities for the selected country and state (if any)
           populateCities($("#country").val(), stateDropdown.val());
       },
       error: function(error) {
           console.log("Error fetching states:", error);
           $("#stateDropdown").prop("disabled", false);
       }
   });
}


function populateCities(countryISO2 = null, stateISO2 = null) {
   let url;

   if (countryISO2 && stateISO2) {
       url = "https://api.countrystatecity.in/v1/countries/" + countryISO2 + "/states/" + stateISO2 + "/cities";
   } else if (countryISO2) {
       url = "https://api.countrystatecity.in/v1/countries/" + countryISO2 + "/cities";
   }

   $.ajax({
       url: url,
       type: "GET",
       headers: {
           "X-CSCAPI-KEY": "NVF3ODVWT1lqY0l4V1VjU21vNDJiZHVoUXFlOGl2d3FFWHJRTlU3ag=="
       },
       success: function(data) {
           const cityDropdown = $("#cityDropdown");
           cityDropdown.empty();
           cityDropdown.append($("<option>").val("").text("Select City"));
           data.forEach(function(city) {
               cityDropdown.append($("<option>").val(city.name).text(city.name));
           });
           cityDropdown.prop("disabled", false);
       },
       error: function(error) {
           console.log("Error fetching cities:", error);
           $("#cityDropdown").prop("disabled", false);
       }
   });
}


    $("#country").change(function() {
        const selectedCountry = $("#country option:selected");
        const countryISO2 = selectedCountry.data("ciso");
        // Load states for the selected country
        populateStates(countryISO2);
    });

    $("#stateDropdown").change(function() {
        const selectedState = $("#stateDropdown option:selected");
        const stateISO2 = selectedState.data("siso");
        const countryISO2 = $("#country option:selected").data("ciso");
        // Load cities for the selected country and state
        populateCities(countryISO2, stateISO2);
    });

    // Initial population of countries
    populateCountries();
});
</script>

<!-- Group Designation Department -->
<script>
var globalDesignations = []; // Global array to hold designation data

$(document).ready(function() {
    var urlParams = new URLSearchParams(window.location.search);
    var groupNo = urlParams.get('groupNo');
    var groupName = urlParams.get('groupName');
    $('#groupNameDisplay').val(groupName);

    if (groupNo) {
        fetchDepartments(groupNo);
    }

    $('#groupNumberSelect').on('change', function() {
        fetchDepartments($(this).val());
    });

 // Modify change event handler for department
    $('#department').change(function() {
        var selected = $(this).val().split('|');
        var deptNo = selected[0];
        var departmentName = selected[1];

        // Set the hidden input field value for departmentNo and departmentName
        $('#departmentNo').val(deptNo);
        $('#departmentName').val(departmentName.trim());

        if (deptNo) {
            fetchDesignations(deptNo);
        } else {
            $('#designation').empty().append('<option value="" disabled selected>Select a Designation</option>');
        }
    });

//Modify change event handler for designation
$('#designation').on('change', function() {
  var selectedDsgnNo = $(this).val();
  var selectedDsgnName = $(this).find('option:selected').data('dsgn-name');
  updateSecurityLevelDisplay(selectedDsgnNo);
});
});

function fetchDepartments(groupNumber) {
    $.ajax({
        url: '/webProject/syst/org/dept/getDepartmentsByGroup.do',
        type: 'GET',
        data: { groupNo: groupNumber },
        success: function(departments) {
            updateDepartmentDropdown(departments);
        },
        error: function(xhr, status, error) {
            console.error("Error fetching departments: " + error);
        }
    });
}

//Modify updateDepartmentDropdown
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
            console.log("Designations fetched:", designations); // Debug log
            globalDesignations = designations; // Update global array
            updateDesignationDropdown(designations);
        },
        error: function(xhr, status, error) {
            console.error("Error fetching designations:", error);
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
            value: designation.dsgnName, // Use dsgnNo as the value
            text: designation.dsgnName, // Display dsgnName in the dropdown
            'data-security-level': designation.securityLevel
        }));
    });
}

function updateSecurityLevelDisplay(dsgnNo) {
    var selectedOption = $('#designation option[value="' + dsgnNo + '"]');
    var securityLevel = selectedOption.data('security-level');
    $('#securityLevelDisplay').val(securityLevel);

    // Set the value of the hidden input field for security level
    $('input[name="securityLevel"]').val(securityLevel);
}


</script>

<!-- Career Experience -->
<script>
$(document).ready(function() {
    function updateCareerExperience() {
        let yearsInput = $("#years").val();
        let monthsInput = $("#months").val();

        let years = parseInt(yearsInput) || 0;
        let months = parseInt(monthsInput) || 0;

        // Validate and adjust years and months according to specified ranges
        years = Math.max(0, Math.min(30, years)); // Ensure years is between 0 and 30
        months = Math.max(0, Math.min(11, months)); // Ensure months is between 0 and 11

        // Adjust input values if they exceed the max allowed values
        $("#years").val(years);
        $("#months").val(months);

        let careerExperience = years;
        if (months >= 6) {
            careerExperience += 1; // Increment the year if months are more than or equal to 6
        }

        // Set the calculated career experience to the hidden input field
        $("#careerExperience").val(careerExperience);

        // Do not show error message if both years and months are at their default (0)
        if (years === 0 && months === 0) {
            $(".invalid-feeback").hide(); // Assuming "invalid-feeback" is a typo and should be "invalid-feedback"
        } else {
            // Implement any needed logic here if you want to handle non-default cases
        }
    }

    // Bind the updateCareerExperience function to the years and months input fields
    $("#years, #months").on("input", updateCareerExperience);

    // Call it once initially to set the default value
    updateCareerExperience();
});
</script>


<!-- University -->
<script>
// This function loads the university list using Selectize
function loadUniversities() {
    const universitySelect = $('#university').selectize({
        create: true, // Allow creating new options
        render: {
            option_create: function(data, escape) {
                return '<div class="create">Create <strong>' + escape(data.input) + '</strong>&hellip;</div>';
            }
        },
        load: function(query, callback) {
            if (!query.length) return callback();
            $.ajax({
                url: 'http://universities.hipolabs.com/search',
                type: 'GET',
                dataType: 'json',
                data: {
                    q: query
                },
                error: function() {
                    callback();
                },
                success: function(res) {
                    callback(res.map(function(item) {
                        return {
                            value: item.name,
                            text: item.name
                        };
                    }));
                }
            });
        }
    });

    // Load universities when the select element is clicked
    $('#university').on('click', function() {
        universitySelect[0].selectize.load(function(callback) {
            // Callback is not used here; the universities will be fetched when clicked
        });
    });
}

// This will execute the function once the page's content is fully loaded
$(document).ready(function() {
    loadUniversities();
});
</script>

<!-- FinalDegree -->
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

<!--Files  -->
<script>
function validateFileUpload(selector, minFiles, maxFiles, errorMessage) {
   const files = $(selector)[0].files;
   if (files.length < minFiles || files.length > maxFiles) {
       alert(errorMessage);
       event.preventDefault();
   }

// Additional check to ensure that the number of selected KYC files does not exceed 10
if (selector === "#kyc" && files.length > 10) {
   alert("You can only attach a maximum of 10 KYC documents.");
   event.preventDefault();
}
}

    // Function to validate file inputs
    function validateFiles(selector) {
        const files = $(selector)[0].files; // Correctly select the file input using the selector
        if (files.length === 0) {
            $(selector).addClass("is-invalid");
        } else {
            $(selector).removeClass("is-invalid");
        }
    }

    // Event handlers for file inputs
    $("#resumeFile").on("change", function() {
        validateFiles("#resumeFile"); // Pass the correct selector
    });

    $("#kyc").on("change", function() {
        validateFiles("#kyc"); // Pass the correct selector
    });

</script>

<!-- Error message -->
<script>
$(document).ready(function() {
    // Function to check if any required field is non-empty
    function checkAnyFieldNonEmpty(inputField) {
        // Check if the input field is empty
        const isError = $(inputField).val().trim() === "";
       
        // Update error message visibility for the specific field
        $(inputField).siblings(".invalid-feedback").toggle(isError);
    }

    // Bind the checkAnyFieldNonEmpty function to input events on all required fields, including address fields
    $("#university, #finalDegree, #resumeFile, #kyc, #addressLine1, #addressLine2").on("input change", function() {
        checkAnyFieldNonEmpty(this);
    });
});

</script>

<!-- Submit Form -->
<script>
$(document).ready(function() {
    $("#registrationForm").submit(function(event) {
        event.preventDefault(); // Prevent the default form submission
        formatPhoneNumber('#cellPhone');
        // Perform all validations here
        validateName();
        validateFinalDegree($("#finalDegree"));
        validateFiles("#resumeFiles");
        validateFiles("#kycFiles");
        
        // Validate number of resume files
        validateFileUpload("#resumeFiles", 1, 10, "Please attach at least 1 and at most 10 resume files.");

        // Additional validation for KYC files (already implemented)
        validateFileUpload("#kycFiles", 1, 10, "Please attach at least 1 and at most 10 KYC documents.");
        
        const isPasswordValid = validatePassword();
        checkPasswordMatch();

        // Get the selected security level from the display field
        var securityLevel = $("#securityLevelDisplay").val();

        // Check postal code validation
        if (!validatePostalCode()) {
            // Postal code validation failed, stop form submission
            console.log("Postal code validation failed.");
            return; // Exit the function
        }
        
        // Prepare formData for submission
        var formData = new FormData();
        formData.append("empId", "${empId}");
        formData.append("group", $("#group").val()); // Group field
        formData.append("careerExperience", $("#careerExperience").val());
        formData.append("cellPhone", $("#cellPhone").val());
        formData.append("name", $("#name").val()); // Name field
        formData.append("password", $("#password").val()); // Password field
        formData.append("department", $("#departmentName").val());
        formData.append("designation", $("#designation").val());
        formData.append("university", $("#university").val()); // University field
        formData.append("finalDegree", $("#finalDegree").val()); // Final Degree field
/*         formData.append("resumeFiles", $("#resumeFiles")[0].files); // Resume File field
        formData.append("kycFiles", $("#kycFiles")[0].files); // KYC Documents field */
        formData.append("addressLine1", $("#addressLine1").val()); // Address Line 1 field
        formData.append("addressLine2", $("#addressLine2").val()); // Address Line 2 field
        formData.append("city", $("#cityDropdown").val()); // City field
        formData.append("state", $("#stateDropdown").val()); // State field
        formData.append("country", $("#country").val()); // Country field
        formData.append("postalCode", $("#postalCode").val()); // Postal Code field

        // Append the security level to formData
        formData.append("securityLevel", securityLevel);
        
     // Append each resume file to formData with category
        $.each($("#resumeFiles")[0].files, function(i, file) {
            formData.append("resumeFiles", file, file.name + "|Resume");
        });

        // Append each KYC file to formData with category
        $.each($("#kycFiles")[0].files, function(i, file) {
            formData.append("kycFiles", file, file.name + "|KYC");
        });


        // Check for any validation errors
        if ($("#registrationForm").find(".is-invalid").length === 0 && isPasswordValid && !$("#confirmPassword").hasClass("is-invalid")) {
            // If all validations pass, submit formData using AJAX
            $.ajax({
                url: 'register.do',
                type: 'POST',
                data: formData,
                processData: false,  // Prevent jQuery from processing data or converting to query string
                contentType: false,  // Set content type to false for FormData
                success: function(response) {
                    console.log("Data saved:", response);
                    // Redirect to a new JSP page with a success message
                    window.location.href = "registrationSucess.do?message=Registration form submitted successfully";
                },

                error: function(xhr, status, error) {
                    console.error("Error saving data:", error);
                }
            });
        } else {
            // Handle the case where the form is invalid
            console.log("Form validation failed. Please correct the errors and try again.");
        }

    });
});


</script>
</body>
</html>