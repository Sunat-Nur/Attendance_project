<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    
   	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
     	body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        
		.login-container {
		    width: 100%; /* Responsive width */
		    max-width: 400px; /* Maximum width for the container */
		    padding: 2rem; /* Increased padding for a roomy feel */
		    margin: auto; /* Center aligning the container */
		    background: #ffffff; /* White background */
		    border-radius: .5rem; /* Rounded corners */
		    box-shadow: 0 4px 6px rgba(0, 0, 0, .1); /* Soft shadow for depth */
		    border: 1px solid #eff2f7; /* Light border for subtle separation */
		}

        .login-container h2 {
            font-weight: 600;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .login-form {
            display: flex;
            flex-direction: column;
        }
        
		.login-form label {
		    display: block;
		    font-weight: bold;
		    color: #495057;
		    margin-bottom: 0.5rem;
		    font-size: 1rem;
		}
		
		.input-group-text {
		    background-color: #eeeeee; /* Light grey background for the icon area */
		    border: 1px solid #ced4da; /* Consistent border with the input field */
		}
		
		.form-control {
		    border-left: 0; /* Remove left border to seamlessly merge with the icon area */
		}
		
		/* Hover and focus states for input fields to integrate with Bootstrap's styling */
		.form-control:focus, .input-group-text:focus {
		    border-color: #80bdff;
		    box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
		}
        
		.login-form input[type="text"],
		.login-form input[type="password"],
		.login-form input[type="email"] {
		    font-size: 1rem; /* Adequate font size for readability */
		    padding: .75rem 1rem; /* Increased padding for a larger touch area */
		    border: 1px solid #ced4da; /* Subtle border color */
		    border-radius: .25rem; /* Rounded corners */
		    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out; /* Smooth transition for focus */
		}

		.login-form input[type="text"]:focus,
		.login-form input[type="password"]:focus,
		.login-form input[type="email"]:focus {
		    border-color: #80bdff; /* Highlighted border color on focus */
		    outline: 0; /* Removing default focus outline */
		    box-shadow: 0 0 0 .2rem rgba(0,123,255,.25); /* Subtle shadow for depth */
		}

        .login-form .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            display: block;
            width: 100%;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: background-color 0.3s;
        }
        
        .login-form .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .login-form .forgot-password {
            text-align: center;
            display: block;
            margin-top: 20px;
            color: #007bff;
            cursor: pointer;
        }
    
        /* Custom CSS for the modal popup */
        .modal-content {
            margin-top: 100px;
        }
        .modal {
		    display: none;
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0, 0, 0, 0.4);
		}

		.modal-content {
		    background-color: #fefefe;
		    margin: 15% auto;
		    padding: 20px;
		    border: 1px solid #888;
		    width: 30%;
		}
		
		.close {
		    color: #aaa;
		    float: right;
		    font-size: 28px;
		    font-weight: bold;
		}
		
		.close:hover,
		.close:focus {
		    color: black;
		    text-decoration: none;
		    cursor: pointer;
		}
		
		    /* Add this CSS to change input border color when invalid message displays */
	    .invalid-feedback {
	        color: #dc3545;
	        display: block;
	        margin-top: 0.25rem; /* Adjust the margin to create space between input and message */
	        margin-left: 2.6rem;
	    }
	
	    .is-invalid {
	        border-color: #dc3545 !important;
	    }
       
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="text-center"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Miraegisul IT"></h2>
        <!-- Feedback Alert -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger text-center">${errorMessage}</div>
        </c:if>

        <!-- Login Form (combine old JSP form logic with new styling) -->
        <form class="login-form" action="login.do" method="post" onsubmit="return validateForm();">
			<!-- Username Input with Visible Label and Icon -->
			<div class="form-group">
			    <label for="username">Username</label>
			    <div class="input-group mb-3">
			        <div class="input-group-prepend">
			            <span class="input-group-text" id="basic-addon1"><i class="fas fa-user"></i></span>
			        </div>
			        <input type="text" id="username" name="empId" class="form-control" placeholder="Enter your Emp ID" aria-label="Username" aria-describedby="basic-addon1" required>
			    </div>
			</div>
			
			<!-- Password Input with Visible Label, Icon, and Toggle Eye -->
			<div class="form-group">
			    <label for="password">Password</label>
			    <div class="input-group mb-3">
			        <div class="input-group-prepend">
			            <span class="input-group-text"><i class="fas fa-lock"></i></span>
			        </div>
			        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" aria-label="Password" required>
			        <div class="input-group-append">
			            <span class="input-group-text">
			                <i class="fas fa-eye-slash toggle-password" style="cursor: pointer;"></i>
			            </span>
			        </div>
			    </div>
			</div>

            <div class="form-group text-center">
                <input type="submit" value="Login" class="btn btn-primary" id="loginButton">
                <!-- Forgot Password Link -->
                <a href="#" class="btn btn-link" onclick="openForgotPasswordModal()">Forgot Password?</a>
            </div>
        </form>
    </div>


<!-- Forgot Password Modal -->
<div id="forgotPasswordModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeForgotPasswordModal()">&times;</span>
        <h2>Forgot Password</h2>
        <p>Please enter your email address to reset your password.</p>
        <form id="forgotPasswordForm" action="forgotPassword.do" method="post"> <!-- Changed action attribute -->
            <div class="form-group">
                <label for="emailInput">Email:</label>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    </div>
                    <input type="email" name="email" id="emailInput" class="form-control" required placeholder="Enter your email">
                </div>
                <!-- Moved invalid message below the input box -->
                <span id="emailFeedback" class="invalid-feedback" style="color: red;"></span> <!-- Feedback message -->
            </div>
           
            <div class="form-group text-center">
               <input type="submit" value="Reset Password" class="btn btn-primary" id="resetPasswordButton" disabled>
            </div>
            
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    $(document).on('click', '#loginButton', function(e) {
        localStorage.removeItem('activeMenuNo');
    });  
});  
</script>


<script>
    // Function to open the modal
    function openForgotPasswordModal() {
        // Get the modal element
        var modal = document.getElementById('forgotPasswordModal');
        // Display the modal
        modal.style.display = "block";
        // Add the "modal-open" class to the body to prevent scrolling when the modal is open
        document.body.classList.add('modal-open');
    }

    // Function to close the modal
    function closeForgotPasswordModal() {
        // Get the modal element
        var modal = document.getElementById('forgotPasswordModal');
        // Hide the modal
        modal.style.display = "none";
        // Remove the "modal-open" class from the body
        document.body.classList.remove('modal-open');
    }
</script>



<script>
$(document).ready(function() {
    // Toggle password visibility
    $(".toggle-password").click(function() {
        // Toggle the eye/eye-slash icon
        $(this).toggleClass("fa-eye fa-eye-slash");
        // Toggle the password field type attribute
        let input = $($(this).closest(".input-group").find("input[type='password'], input[type='text']"));
        if (input.attr("type") === "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });
});
</script>

<script>
    $(document).ready(function() {
        $('#emailInput').on('input', function() {
            var email = $(this).val();
           
            // Validate email format using regular expression
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                $('#emailFeedback').text('Invalid email format.');
                $('#emailFeedback').show(); // Show the invalid message
                $('#emailInput').addClass('is-invalid'); // Add is-invalid class to input
                $('#resetPasswordButton').prop('disabled', true); // Disable the button
                return; // Return if email format is invalid
            }
           
            $.ajax({
                url: '/webProject/syst/reg/checkEmailExists.do',
                type: 'GET',
                data: { email: email },
                success: function(response) {
                    console.log("Response from server:", response);

                    // Check if the email exists
                    if (response.exists === 'false') {
                        // Email found, clear error message and disable the button
                        $('#emailFeedback').text('Email address not exists.');
                        $('#emailFeedback').show(); // Show the invalid message
                        $('#emailInput').addClass('is-invalid'); // Add is-invalid class to input
                        $('#resetPasswordButton').prop('disabled', true); // Disable the button
                    } else {
                        // Email not found, clear error message and enable the button
                        $('#emailFeedback').text('');
                        $('#emailFeedback').hide(); // Hide the invalid message
                        $('#emailInput').removeClass('is-invalid'); // Remove is-invalid class from input
                        $('#resetPasswordButton').prop('disabled', false); // Enable the button
                    }
                },
                error: function() {
                    // Handle error here
                    console.error('Error occurred during AJAX request.');
                    $('#resetPasswordButton').prop('disabled', true); // Disable the button in case of error
                }
            });
        });
    });
</script>

</body>
</html>