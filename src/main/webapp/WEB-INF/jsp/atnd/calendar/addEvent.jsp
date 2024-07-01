<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Event</title>
    
  	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    	
<style>

	.eventAdd h2 {
	    text-align: center;
	}

	.eventAdd form {
	    width: 25%; /* Reduced width for smaller form */
	    margin: 0 auto; /* Center the form on the page */
	    padding: 8px; /* Reduced padding */
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	    border-radius: 8px;
	}

    .eventAdd label {
        display: block;
        margin-bottom: 3px; /* Reduced margin */
    }

    .eventAdd input[type="text"],
    .eventAdd input[type="date"],
    .eventAdd textarea,
    .eventAdd select {
        width: 100%; /* Reduced width for form elements */
        padding: 4px; /* Reduced padding */
        margin-bottom: 20px; /* Reduced margin */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 12px; /* Reduced font size */
    }

    .eventAdd textarea {
        height: 60px; /* Reduced height for textarea */
    }
    
    .eventAdd button {
        padding: 6px 12px; /* Reduced padding */
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px; /* Reduced font size */
        transition: background-color 0.3s ease;
    }

    .eventAdd #saveButton {
        background-color: #007bff; /* Blue */
        color: white;
    }

    .eventAdd #saveButton:hover {
        background-color: #0056b3; /* Darker blue */
    }

    .eventAdd #cancelButton {
        background-color: #6c757d; /* Gray */
        color: white;
        margin-left: 3px;
    }

    .eventAdd #cancelButton:hover {
        background-color: #5a6268; /* Darker gray */
    }

	.eventAdd .is-invalid {
	    border-color: #dc3545 !important; /* Add !important to override other styles */
	}
	
	.eventAdd .invalid-feedback {
	    display: none;
	    width: 100%;
	    color: #dc3545;
	    font-size: 12px;
	}
	
	.eventAdd .input-wrapper {
	    position: relative;
	    display: block; /* Use block to ensure the wrapper fills the parent's width */
	}
	
	.eventAdd .input-wrapper input {
	    padding-right: 30px; /* Make padding on the right to prevent text from overlapping the icon */
	    padding-left: 5px; /* Adjusted for consistency */
	    padding-top: 5px;
	    padding-bottom: 5px;
	    margin-bottom: 10px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	    cursor: pointer;
	}
	
	.eventAdd .input-wrapper i {
	    position: absolute;
	    right: 10px; /* Adjust as needed to place the icon inside the input at the end */
	    top: 38%;
	    transform: translateY(-50%);
	    pointer-events: none; /* Prevent the icon from interfering with input field clicks */
	}
</style>

</head>
<body>
	<div id="pageContent" class="eventAdd">
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success" role="alert">
		  		${successMessage}
			</div>
		</c:if>
		
		<h2><i class="fa-solid fa-calendar-plus" style="margin-right: 10px;"></i>Add Event</h2>
	   
		<form id="eventForm" action="addEvent.do" method="post">
			<label for="title">Title:</label>
			<input type="text" id="title" name="title">
			<div class="invalid-feedback" id="titleError"></div>
			<br>
	       
			<label for="startDt">Start Date:</label>
		    <div class="input-wrapper">
		        <input type="text" id="startDt" name="startDt" readonly>
		        <i class="fa fa-calendar-days" id="startDtIcon"></i>
		    </div>
			<div class="invalid-feedback" id="startDtError"></div>
			<br>
			
			<label for="endDt">End Date:</label>
		    <div class="input-wrapper">
		        <input type="text" id="endDt" name="endDt" readonly>
		        <i class="fa fa-calendar-days" id="endDtIcon"></i>
		    </div>
			<div class="invalid-feedback" id="endDtError"></div>
			<br>
			
			<label for="details">Details:</label>
			<textarea id="details" name="details"></textarea>
			<div class="invalid-feedback" id="detailsError"></div><br>
			
			<label for="division">Division:</label>
			<select id="division" name="division">
			    <option value="personal">Personal</option>
			    <option value="project">Project</option>
			    <option value="notice">Notice</option>
			</select><br><br>
	       
			<button id="saveButton">Save</button>
			<button id="cancelButton">Cancel</button>
    	</form>
    </div>
   
   
<script>
$(document).ready(function() {
    $("#title").on("input", function() {
        var inputElement = $(this);
        var inputValue = inputElement.val();
        var correctedValue = inputValue.replace(/\s\s+/g, ' '); // Replace consecutive spaces with a single space
        
        if (correctedValue.length > 50) {
            $("#titleError").text("Please enter a valid title (Max 50 characters)").show();
        } else {
            $("#titleError").hide();
        }
    });
    
    
    $("#title").on("blur", function() {
        var inputElement = $(this);
        var trimmedValue = inputElement.val().trim(); // Trim leading and trailing spaces
        inputElement.val(trimmedValue);
        validateTitle(); // Re-validate title after trimming
    });
});

// Define the validateTitle function outside of $(document).ready()
function validateTitle() {
    var titleInput = $("#title");
    var titleValue = titleInput.val();
    if (titleValue.length > 50 || titleValue.length == 0) {
        titleInput.addClass("is-invalid");
        $("#titleError").text("Please enter a valid title (Max 50 characters)").show();
        return false; // Explicitly return false when validation fails
    } else {
        titleInput.removeClass("is-invalid");
        $("#titleError").hide();
        return true; // Explicitly return true when validation succeeds
    }
}



</script>

<script>
$(document).ready(function() {
    // Initialize datepicker for start date
    $('#startDt').datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        onSelect: function(dateText, inst) {
            // Automatically close the datepicker after selecting a date
            $(this).datepicker('hide');
            
            // Set the minDate of end date to the selected start date
            $('#endDt').datepicker('option', 'minDate', dateText);

            // Validate start date and hide error message
            validateStartDate();
        }
    });

    // Initialize datepicker for end date
    $('#endDt').datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        onSelect: function(dateText, inst) {
            // Automatically close the datepicker after selecting a date
            $(this).datepicker('hide');
            
            // Set the maxDate of start date to the selected end date
            $('#startDt').datepicker('option', 'maxDate', dateText);

            // Validate end date and hide error message
            validateEndDate();
        }
    });
});


function validateStartDate() {
    var startDateInput = $("#startDt");
    var startDateValue = startDateInput.val();
    if (startDateValue === '') {
        startDateInput.addClass("is-invalid");
        $("#startDtError").text("Please select a start date").show();
        return false; // Explicitly return false when validation fails
    } else {
        startDateInput.removeClass("is-invalid");
        $("#startDtError").hide();
        return true; // Explicitly return true when validation succeeds
    }
}

function validateEndDate() {
    var endDateInput = $("#endDt");
    var endDateValue = endDateInput.val();
    if (endDateValue === '') {
        endDateInput.addClass("is-invalid");
        $("#endDtError").text("Please select an end date").show();
        return false; // Explicitly return false when validation fails
    } else {
        endDateInput.removeClass("is-invalid");
        $("#endDtError").hide();
        return true; // Explicitly return true when validation succeeds
    }
}
</script>



<script>
$(document).ready(function() {
	
	document.getElementById("cancelButton").addEventListener("click", function(event){
	    event.preventDefault(); // Prevent any default action
	    window.location.href = "/webProject/syst/main/home.do"; // Redirect as needed
	});

	
    $("#saveButton").click(function(event) {
        event.preventDefault();

        // Perform validation checks for required fields only
        var isTitleValid = validateTitle();
        var isStartDateValid = validateStartDate();
        var isEndDateValid = validateEndDate();

        // Check if the details input is visibly marked as invalid
        var isDetailsValid = !$("#details").hasClass("is-invalid");

        // If all required validations pass and details are not visibly invalid, submit the form data via AJAX
        if (isTitleValid && isStartDateValid && isEndDateValid && isDetailsValid) {
            $.ajax({
                type: "POST",
                url: "addEvent.do",
                data: $("#eventForm").serialize(),
                success: function(response) {
                    alert("Event added successfully!");
                    window.location.href = "/webProject/syst/main/home.do";
                },
                error: function(xhr, status, error) {
                    console.log("Error: " + error);
                    alert("An error occurred while saving the event. Please try again.");
                }
            });
        } else {
            alert("Please fill all the fields properly!.");
        }
    });
});
</script>

</body>
</html>