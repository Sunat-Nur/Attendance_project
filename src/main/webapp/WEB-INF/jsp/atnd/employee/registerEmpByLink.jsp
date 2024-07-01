<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

<head>
    <meta charset="UTF-8">
    <title>Employee Register Link Page</title>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
		.regEmp {
            background-color: #fff;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 550px;
            margin: 15px auto;
        }

        .regEmp h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .regEmp form {
            max-width: 400px;
            margin: 0 auto;
        }

        .regEmp form label {
            display: block;
            margin-bottom: 5px;
        }

        .regEmp form input[type="email"],
        .regEmp form input[type="text"],
        .regEmp form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .regEmp form .error-message {
            color: red;
            margin-bottom: 8px;
        }

        .regEmp form .submitButton {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .regEmp form .submitButton:hover {
            background-color: #0056b3;
        }
        .date-input-container {
		    position: relative;
		    display: inline-block;
		    width: 100%;
		}
		
		.date-input-container input[type="text"] {
		    padding-right: 30px; /* Make space for the icon inside the input */
		    cursor: pointer;
		}
		
		.date-icon {
		    position: absolute;
		    right: 10px;
		    top: 40%;
		    transform: translateY(-50%);
		    pointer-events: none; /* Prevent the icon from being clickable, allowing the input to be focused */
		    color: #245cbc;
		    cursor: pointer;
		}
        
    </style>
</head>
<body>
<div id="pageContent">
    <div class="regEmp">
        <h2>Employee Registration</h2>
        <form id="registrationForm">
            <div>
                <label for="email">Email Address:</label>
                <input type="email" id="email" placeholder="Enter email address">
                <div class="error-message" id="email-error"></div>
            </div>
			<div>
			    <label for="dateOfJoining">Date of Joining:</label>
			    <div class="date-input-container">
			        <input type="text" id="dateOfJoining" placeholder="Select Date of Joining" readonly>
			        <i class="fa-solid fa-calendar-days date-icon" ></i>
			    </div>
			    <div class="error-message" id="date-error"></div>
			</div>

           	<div>
   				<label for="group">Group:</label>
   				<select id="group" name="group">
       				<option value="" disabled selected>Select a Group</option>
       				<c:forEach items="${groupList}" var="group">
           				<option value="${group.groupNo}|${group.groupName}">${group.groupName}</option>
       				</c:forEach>
   				</select>
   				 <div class="error-message" id="group-error"></div>
			</div>
            <div>
                <label for="empId">Generated Emp ID:</label>
                <input type="text" id="empId" placeholder="Emp ID will appear here" readonly>
            </div>
            <input type="hidden" id="year" name="yearOfWorking">
            
            <button type="submit" class="submitButton">Send Register Link</button>
        </form>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Initialize the datepicker
        $('#dateOfJoining').datepicker({
	    dateFormat: 'yy-mm-dd',
	    onClose: function(dateText) {
	        calculateYearBasedOnDateOfJoining(dateText);
	        updateYearOfWorking();
	        validateDateOfJoining();
	        updateEmpId();
	    },
	    changeYear: true,
	    changeMonth: true,
	    yearRange: "-30:+30",
	    onSelect: function(dateText, inst) {
	        calculateYearBasedOnDateOfJoining(dateText);
	        updateYearOfWorking();
	        validateDateOfJoining();
	        updateEmpId();
	    }
	});


       // Handle changes in the Date of Joining and Group dropdown
          $('#dateOfJoining, #group').on('change', function() {
              // Validate each field individually
              validateEmail();
              validateDateOfJoining();
              validateGroup();
              updateEmpId(); // Update Employee ID after selecting the group
          });

          
        
          
          function calculateYearBasedOnDateOfJoining(dateString) {
              if (moment(dateString, 'YYYY-MM-DD', true).isValid()) {
                  var dateOfJoining = moment(dateString, 'YYYY-MM-DD').toDate();
              } else {
                  return;
              }


              var currentDate = new Date();
              var yearElement = $('#year');
              var years = currentDate.getFullYear() - dateOfJoining.getFullYear();
              var monthDiff = currentDate.getMonth() - dateOfJoining.getMonth();
              if (monthDiff < 0 || (monthDiff === 0 && currentDate.getDate() < dateOfJoining.getDate())) {
                  years--;
              }

              yearElement.val(years + 1); // Update the year field with the calculated value
          }
          
          function updateYearOfWorking() {
              var yearOfWorking = $('#year').val(); // Get the value of the year field
              $('#year').val(yearOfWorking);
          }
          
          // Function to update the Employee ID based on the selected group and date
          function updateEmpId() {
              var dateOfJoining = $('#dateOfJoining').val();
              var groupValue = $('#group').val();
              if (dateOfJoining && groupValue) {
                  generateEmpId(dateOfJoining, groupValue);
              } else {
                  $('#empId').val('');  // Clear the empId input if date is removed
              }
          }

        
          function generateEmpId(dateOfJoining, groupValue) {
              var groupName = groupValue.split('|')[1]; // Extract the group name

              $.ajax({
                  type: 'GET',
                  url: '/webProject/syst/reg/generateEmpId.do',
                  data: {
                      dateOfJoining: dateOfJoining,
                      group: groupName // Send only the group name
                  },
                  success: function(response) {
                      $('#empId').val(response.empId);
                  },
                  error: function(error) {
                      alert('Error: ' + error.responseText);
                  }
              });
          }

          // Email input validation
          $('#email').on('input blur', function() {
              validateEmail();
              checkEmailExists();
          });

          $('form').on('submit', function(e) {
              e.preventDefault();  // Prevent the default form submit action

              // Check if any field is empty
              if (!validateForm()) {
                  alert('Please fill out all the fields.');
                  return;
              }

              // If all validations pass, proceed with AJAX request
              $.ajax({
                  type: 'POST',
                  url: '/webProject/syst/reg/sendRegistrationEmail.do',
                  data: JSON.stringify({
                      email: $('#email').val(),
                      empId: $('#empId').val(),
                      dateOfJoining: $('#dateOfJoining').val(),
                      groupName: $('#group').val().split('|')[1],
                      groupNo: $('#group').val().split('|')[0],
                      year: $('#year').val()
                  }),
                  contentType: "application/json",
                  success: function(response) {
                      alert('Email sent successfully!');
                      $('#registrationForm')[0].reset();
                  },
                  error: function(error) {
                      alert('Error: ' + error.responseText);
                  }
              });
          });

          // Function to validate the form
          function validateForm() {
              var isValid = true;

              // Validate email
              var emailValid = validateEmail();
              if (!emailValid) {
                  isValid = false;
              }

              // Validate date of joining
              var dateValid = validateDateOfJoining();
              if (!dateValid) {
                  isValid = false;
              }

              // Validate group selection
              var groupValid = validateGroup();
              if (!groupValid) {
                  isValid = false;
              }

              return isValid;
          }

          // Validation function for email
          function validateEmail() {
              var email = $('#email').val();
              if (email.trim() === '') {
                  $('#email-error').text('Please fill the email field.');
                  return false;
              }
              var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
              if (!regex.test(email)) {
                  $('#email-error').text('Please enter a valid email address.');
                  return false;
              }
              $('#email-error').text('');
              return true;
          }

          // Validation function for date of joining
          function validateDateOfJoining() {
              var dateOfJoining = $('#dateOfJoining').val();
              if (dateOfJoining.trim() === '') {
                  $('#date-error').text('Please fill the date of joining field.');
                  return false;
              }
              $('#date-error').text('');
              return true;
          }

          // Validation function for group selection
          function validateGroup() {
              var group = $('#group').val();
              if (group === null) {
                  $('#group-error').text('Please select a group.');
                  return false;
              }
              $('#group-error').text('');
              return true;
          }

      // Function to validate the date format
      function validateDate() {
          var dateOfJoining = $('#dateOfJoining').val();
          if (!isValidDate(dateOfJoining)) {
              $('#dateOfJoining').addClass('is-invalid');
              $('#date-error').text('Please enter a valid date (yyyy-MM-dd)').show();
          } else {
              $('#dateOfJoining').removeClass('is-invalid');
              $('#date-error').text('').hide();
          }
      }

      // Function to check if the date format is valid
      function isValidDate(date) {
          var regex = /^\d{4}-\d{2}-\d{2}$/;
          return regex.test(date);
      }
      
   // Function to check if the email format is valid
      function isValidEmail(email) {
          var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
          return regex.test(email);
      }


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

    
    });
</script>
</body>
</html>