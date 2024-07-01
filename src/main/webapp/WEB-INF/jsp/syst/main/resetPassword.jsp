<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
   
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
     
    <style>
        /* Custom CSS styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 60px;
            width: 400px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        
        .form-control {
            width: 97%; /* Adjusted for padding and eye icon */
            padding: 10px 0px 10px 10px; /* Right padding increased to accommodate the eye button */
            border-radius: 4px;
            border: 1px solid #ccc;
            position: relative;
        }
        
        .btn {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            width: 100%;
            text-align: center;
        }
        
        .btn:hover {
            background-color: #0056b3;
        }
        
        .error-message {
            color: red;
            margin-top: 10px;
            font-size: 12px;
        }
        
        .eye-button {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 2;
        }
        
        .password-container {
            position: relative;
        }
        
        .form-control.is-invalid {
    		border-color: #dc3545; /* A red color, for example */
		}
		
		.form-control.is-valid {
    		border-color: #28a745; /* A green color for valid input */
		}
		
		.success-icon {
		    position: absolute;
		    right: -30px; /* Adjust as needed based on your layout */
		    top: 50%;
		    transform: translateY(-50%);
		    color: #28a745; /* A green color */
		    font-size: 18px; /* Adjust size as needed */
		}
		
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>
        <form id="resetPasswordForm" action="#" method="post">
            <div class="form-group">
                <label for="password" class="form-label">Password:</label>
                <div class="password-container">
                    <input type="password" id="password" name="password" class="form-control" required minlength="8" maxlength="16">
                    <i class="eye-button fas fa-eye-slash"></i> <!-- Changed to slash as default -->
                </div>
                <div id="password-error" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="confirmPassword" class="form-label">Confirm Password:</label>
                <div class="password-container">
                    <input type="password" id="confirmPassword" class="form-control" required minlength="8" maxlength="16">
                    <i class="eye-button fas fa-eye-slash"></i> <!-- Changed to slash as default -->
                </div>
                <div id="confirmPassword-error" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="submit" id="submitBtn" value="Reset Password" class="btn">
            </div>
        </form>
    </div>

<script>
    $(document).ready(function() {
    	
        // Toggle password visibility
        $(".eye-button").click(function() {
            const passwordInput = $(this).siblings("input");
            const isPasswordVisible = passwordInput.attr("type") === "text";
            $(this).toggleClass("fa-eye fa-eye-slash");
            passwordInput.attr("type", isPasswordVisible ? "password" : "text");
        });

            // Corrected Regex Pattern
		function validatePassword() {
		    const passwordInput = $("#password");
		    const password = passwordInput.val();
		    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
		    const successIcon = '<i class="fas fa-check-circle success-icon"></i>'; // Define the success icon HTML
		    
		    // Remove existing success icon if present
		    passwordInput.siblings('.success-icon').remove();
		    
		    if (!passwordRegex.test(password)) {
		        $("#password-error").text("Password must be 8-16 characters long and contain at least 1 alphabet, 1 number, and 1 special character.");
		        passwordInput.addClass("is-invalid").removeClass("is-valid");
		        return false;
		    } else {
		        $("#password-error").text("");
		        passwordInput.removeClass("is-invalid").addClass("is-valid").after(successIcon);
		        return true;
		    }
		}
		
		function checkPasswordMatch() {
		    const passwordInput = $("#password");
		    const confirmPasswordInput = $("#confirmPassword");
		    const password = passwordInput.val();
		    const confirmPassword = confirmPasswordInput.val();
		    const successIcon = '<i class="fas fa-check-circle success-icon"></i>'; // Define the success icon HTML
		    
		    // Remove existing success icons if present
		    confirmPasswordInput.siblings('.success-icon').remove();
		    
		    if (password !== confirmPassword) {
		        $("#confirmPassword-error").text("Passwords do not match.");
		        confirmPasswordInput.addClass("is-invalid").removeClass("is-valid");
		        return false;
		    } else {
		        $("#confirmPassword-error").text("");
		        confirmPasswordInput.removeClass("is-invalid").addClass("is-valid").after(successIcon);
		        return true;
		    }
		}

            $("#confirmPassword").on("input", function() {
                checkPasswordMatch();
            });
            
            $("#password").on("input", function() {
                validatePassword();
                checkPasswordMatch();
                const token = getUrlParameter('token');
                const password = $(this).val();
                checkPasswordExists(token, password);
            });
            
            
            function checkPasswordExists(token, password) {
                $.ajax({
                    url: 'checkPasswordExists.do', // Adjust URL path if necessary
                    type: 'POST',
                    dataType: 'json',
                    data: { token: token, password: password },
                    success: function(response) {
                        const passwordInput = $("#password");
                        if (response.exists) {
                        	passwordInput.siblings('.success-icon').remove();
                            $("#password-error").text("This password already exists. Please choose a different password.");
                            $("#submitBtn").prop("disabled", true); // Disable submit button
                            passwordInput.addClass("is-invalid").removeClass("is-valid"); // Add the invalid class
                        } else {
                            $("#submitBtn").prop("disabled", false); // Enable submit button
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error checking password: ", error);
                    }
                });
            }

            function getUrlParameter(name) {
                const urlParams = new URLSearchParams(window.location.search);
                return urlParams.get(name);
            }

            $("#resetPasswordForm").submit(function(event) {
                event.preventDefault();
                const isPasswordValid = validatePassword();
                const isPasswordMatch = checkPasswordMatch();
                const token = getUrlParameter('token');
                const password = $("#password").val();

                if (isPasswordValid && isPasswordMatch) {
                    checkPasswordExists(token, password);
                    submitPasswordReset(token, password);
                }
            });

            function submitPasswordReset(token, password) {
                $.ajax({
                    type: "POST",
                    url: "resetPassword.do",
                    data: {token: token, password: password},
                    success: function(response) {
                        alert("Password reset successfully.");
                        window.location.href = "login.do";
                    },
                    error: function(xhr, status, error) {
                        console.error("Error resetting password: ", xhr.responseText);
                        alert("Failed to reset password. Please try again.");
                    }
                });
            }
    	});
</script>

</body>
</html>
