<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>


<html>
<head>
    <title>Daily Login</title>
   
<style>

form {
width: 500px;
   background-color: #ffffff;
   border: 1px solid #ccc;
   border-radius: 10px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   display: flex;
   flex-wrap: wrap;
   justify-content: center;
   align-items: center;
   text-align: center;
  margin: auto;
  margin-top: 50px;
  padding: 50px;
}
     
.column {
  width: 50%;
  box-sizing: border-box;
  padding: 0 10px;
  align-self: stretch;  
}

label {
   display: block;
   margin-bottom: 10px;
   font-weight: bold;
}

input[type="text"], select {
   border: 1px solid #ccc;
   padding: 10px;
   width: 100%;
   border-radius: 5px;
}

button {
   background-color: #000000;
   color: white;
   border: none;
   padding: 10px 20px;
   border-radius: 5px;
   cursor: pointer;
    margin-top: 20px;
}

#startButton {
margin-right: 20px;
}

button:disabled {
background-color: #cccccc;
cursor: not-allowed;
}

#ipAddress, #lateTime, #workHour {
display: none;
}

label[for="ipAddress"], label[for="lateTime"], label[for="workHour"] {
display: none;
}

.checkbox-container {
display: flex;
justify-content: start;
gap: 20px;
margin-top: 10px;
}
</style>
</head>

<body>
<div id="pageContent">
<%-- Render the page content only if the user is not an admin --%>
<c:if test="${not isAdmin}">
<form id="myForm" action="saveAttendance.do" method="post">
        <div class="column">
            <label for="selectedTime">Select Start Time:</label>
			<select id="selectedTime" name="timeSetting" onchange="handleTimeSelection()">
			    <option value="08:00:00">08:00 AM</option>
			    <option value="00:00:00">OverTime</option>
			</select>


            <label for="ipAddress">IP Address:</label>
            <input type="text" id="ipAddress" name="ipAddress" readonly>
           
            <div class="checkbox-container">
		    <label><input type="checkbox" id="businessTrip" name="businessTrip" value="1"> Business Trip</label>
		    <label><input type="checkbox" id="training" name="training" value="1"> Training</label>
		    </div>
   
            <input type="hidden" id="startTime" name="startTime" readonly>
            <input type="hidden" id="gpsInformation" name="gpsInformation" value="">
            <input type="hidden" name="outsideWork" value="0">
        </div>
       
        <div class="column">
        <label for="workType">Work Type:</label>
			<select id="workType" name="workType">
			  <option value="null">--Select--</option>
			  <option value="Office">Office</option>
			  <option value="Home">Home</option>
			  <option value="Outside">Outside</option>
			</select>

    		<input type="hidden" id="no" name="no">
            <label for="lateTime">Late Time:</label>
           
            <input type="text" id="lateTime" name="late" readonly>
			<input type="hidden" id="accessType" name="accessType">
			<input type="hidden" name="businessTrip" value="0">
			<input type="hidden" name="training" value="0">
			<input type="hidden" id="endTime" name="endTime" readonly>
			<label for="workHour">Total Work Time:</label>
           <input type="text" id="workHour" name="workHour" readonly>
           <input type="hidden" id="aewCount" name="aewCount" value="0">
        </div>
       
<button type="button" id="startButton">Start</button>
<button id="endButton" disabled>End</button>

</form>
</c:if>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {

    var startButton = document.getElementById('startButton');
    var endButton = document.getElementById('endButton');
    var selectedTime = document.getElementById('selectedTime');

    // Check the latest attendance and initialize form state
    checkLatestAttendanceAndInitializeForm();
    var storedStartTime = localStorage.getItem('attendanceStartTime');
    if (storedStartTime) {
        document.getElementById('startTime').value = storedStartTime;
        document.getElementById('startButton').disabled = true;
        document.getElementById('endButton').disabled = false;
    }
    // Attach event listeners for business trip and training checkboxes
    document.getElementById('businessTrip').addEventListener('change', handleCheckboxChange);
    document.getElementById('training').addEventListener('change', handleCheckboxChange);

    // Attach an event listener for work type changes
    document.getElementById('workType').addEventListener('change', handleWorkTypeChange);

    // Programatically attach click event listeners to the start and end buttons
    startButton.addEventListener('click', startLog);
    endButton.addEventListener('click', endLog);

    var loggedInUserEmpId = "${loggedInUser.empId}";
 // Call this function immediately to apply the disabled state for admin on page load
 if(loggedInUserEmpId === "admin") {
     disableFormElements();
 }
    // Pre-select "Office" as the default work type
    document.getElementById('workType').value = "Office";
    handleTimeSelection();
});

function disableStartButton() {
    document.getElementById('startButton').disabled = false;
}

function disableStartAndEndButtons() {
    document.getElementById('startButton').disabled = true;
    document.getElementById('endButton').disabled = true;
}


var formSubmissionStarted = false;
function startLog() {
    // Check if the user is an admin before proceeding
    var loggedInUserEmpId = "${loggedInUser.empId}";
    if (loggedInUserEmpId === "admin") {
        alert("You are not allowed to start");
        return; // Stop the function execution here
    }
   
    if (formSubmissionStarted) return;
    
    var currentTime = new Date();
    var currentHour = currentTime.getHours();

    var currentDateTime = new Date();
    var currentHour = currentDateTime.getHours();

    // Assume selectedTime is the value from the 'selectedTime' element
    var selectedTime = document.getElementById('selectedTime').value;

    formSubmissionStarted = true;
    document.getElementById('startButton').disabled = true;
    
    var now = new Date();
    document.getElementById('startTime').value = formatDate(now);
    setAccessType();
    getGPSInformation(); // Calls submitFormAjax within its success callback
    localStorage.setItem('attendanceStartTime', document.getElementById('startTime').value);
    console.log('startTime set:', document.getElementById('startTime').value);
    
    var selectedTimeOption = document.getElementById('selectedTime').value;
    var currentTime = new Date();
    var currentHour = currentTime.getHours();
    
    // Check if the current time is within the allowed time range before proceeding
    if (selectedTimeOption === '08:00:00' && (currentHour < 8 || currentHour >= 17)) {
        alert("Not allowed to start outside 8 AM to 5 PM for normal time setting.");
        return; // Stop the function execution here
    } else if (selectedTimeOption === '00:00:00' && (currentHour >= 8 && currentHour < 17)) {
        alert("Not allowed to start between 8 AM to 5 PM for overtime setting.");
        return; // Stop the function execution here
    }
    
    
    //disableTimeSettingAndType();
}

function checkLatestAttendanceAndInitializeForm() {
    fetch('getLatestAttendance.do', {
        method: 'GET',
        credentials: 'include'
    })
    .then(response => response.json())
    .then(data => {
        if (data.hasOngoingSession) {
            document.getElementById('startButton').disabled = true;
            document.getElementById('endButton').disabled = false;

            // Check if the startTime is provided and populate it
            if (data.startTime) {
                document.getElementById('startTime').value = data.startTime;
                // Since the session is ongoing, you likely also need to adjust the UI to reflect this
                // For example, showing the recorded start time to the user
            }
        } else {
            document.getElementById('startButton').disabled = false;
            document.getElementById('endButton').disabled = true;
        }
    })
    .catch(error => console.error('Error checking latest attendance:', error));
}

var loggedInUserEmpId = "${loggedInUser.empId}";
//Call this function immediately to apply the disabled state for admin on page load
if(loggedInUserEmpId === "Admin") {
 disableFormElements();
}

function disableFormElements() {
    document.getElementById('selectedTime').disabled = true;
    document.getElementById('ipAddress').disabled = true;
    document.getElementById('businessTrip').disabled = true;
    document.getElementById('training').disabled = true;
    document.getElementById('workType').disabled = true;
    document.getElementById('startButton').disabled = true;
    document.getElementById('endButton').disabled = true;
}

function getGPSInformation() {
    if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function(position) {
            updateFormWithGPS(position.coords.latitude, position.coords.longitude);
            submitFormAjax("Attendance log started successfully!", function() {
                document.getElementById('endButton').disabled = false;
            });
        }, function(error) {
            console.error('Error getting GPS information:', error);
            submitFormAjax("Attendance log started successfully!", function() {
                document.getElementById('endButton').disabled = false;
            });
        });
    } else {
        console.error('Geolocation is not available in this browser.');
        submitFormAjax("Attendance log started successfully!", function() {
            document.getElementById('endButton').disabled = false;
        });
    }
}

function handleTimeSelection() {
    var selectedTimeOption = document.getElementById('selectedTime').value;
    var currentTime = new Date();
    var currentHour = currentTime.getHours();
    var currentDay = currentTime.getDay(); // Get the current day of the week (0 for Sunday, 1 for Monday, etc.)
    
    if (selectedTimeOption === '08:00:00') { // Normal time setting selected
        // Check both time and day of the week restrictions for the 8 AM setting
        if ((currentHour >= 8 && currentHour < 17) && !(currentDay === 0 || currentDay === 6)) {
            // It's between 8 AM and 5 PM, and it's not Saturday or Sunday
            document.getElementById('startButton').disabled = false;
        } else {
            // It's either outside of 8 AM to 5 PM, or it's Saturday/Sunday
            document.getElementById('startButton').disabled = true;
        }
    } else if (selectedTimeOption === '00:00:00') { // Overtime setting selected
        // For overtime, do not restrict based on the day of the week
        if (currentHour < 8 || currentHour >= 17) {
            // It's outside of 8 AM to 5 PM, allow starting
            document.getElementById('startButton').disabled = false;
        } else {
            // It's within 8 AM to 5 PM, restrict starting
            document.getElementById('startButton').disabled = true;
        }
    }
}


function updateFormWithGPS(latitude, longitude) {
    var gpsInfo = '' + latitude + ',' + longitude;
    document.getElementById('gpsInformation').value = gpsInfo;
    var selectedTime = document.getElementById('selectedTime').value;
    var capturedStartTime = new Date(document.getElementById('startTime').value);
    var lateTime = calculateLateTime(selectedTime, capturedStartTime);
    document.getElementById('lateTime').value = lateTime;
}
 
function endLog(event) {
    event.preventDefault();

    var startTimeStr = document.getElementById('startTime').value;
    if (!startTimeStr) {
        alert("Start time is not set. Please ensure your session is correctly started.");
        return; // Prevent further execution if start time is missing
    }
    
    // Capture end time in the required format
    var endTime = new Date();
    document.getElementById('endTime').value = formatDate(endTime);

    // Retrieve and format the start time
    var startTime = startTimeStr ? new Date(startTimeStr) : null;
    localStorage.removeItem('attendanceStartTime'); // Clear the stored start time
    // Check if we have a valid start time
    if (startTime && !isNaN(startTime.getTime())) {
        // Calculate and set the work hours
        var workHours = calculateWorkHour(startTime, endTime);
        document.getElementById('workHour').value = workHours;
        localStorage.removeItem('attendanceStartTime');
        // Submit the form via AJAX
        submitFormAjax("Attendance log ended successfully!", function() {
            resetForm();
        });  
    } else {
        console.error('Start time is not set or invalid.');
        // Handle the error appropriately
    }
}

function calculateWorkHour(startTime, endTime) {
    var difference = endTime.getTime() - startTime.getTime();
    
    // Convert difference from milliseconds to minutes
    var minutes = Math.floor(difference / (1000 * 60));

    // Convert minutes to hours and then to a number with two decimals
    var totalHours = Number((minutes / 60).toFixed(2));

    console.log('Total Hours:', totalHours);
    
    return totalHours;
}

function formatDate(date) {
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    var hours = ('0' + date.getHours()).slice(-2);
    var minutes = ('0' + date.getMinutes()).slice(-2);
    var seconds = ('0' + date.getSeconds()).slice(-2);
    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
}

function submitFormAjax(successMessage, callback) {
    var form = document.getElementById('myForm');
    var formData = new FormData(form);

    var formBody = new URLSearchParams();
    for (var pair of formData.entries()) {
        formBody.append(pair[0], pair[1]);
    }

    fetch('saveAttendance.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formBody
    })
    .then(function(response) {
        return response.json(); // Parse the JSON response body
    })
    .then(function(responseData) {
        if (responseData && responseData.message) {
            showSuccessPopup(responseData.message); // Use the message from the response
        } else {
            showSuccessPopup(successMessage); // Fallback to the passed success message
        }
        if (typeof callback === "function") {
            callback(); // Call the callback function if it exists
        }
    })
    .catch(function(error) {
        console.error('Error:', error);
        alert("Error submitting form."); // Show error popup
    })
    .finally(function() {
        formSubmissionStarted = false; // Reset the submission flag
    });
}

function showSuccessPopup(message) {
    alert(message); // Ensure the passed message is shown
}


function calculateLateTime(selectedTime, capturedStartTime) {
	// Check for OverTimeValue selection
    if (selectedTime === "00:00:00") {
        return "0.00"; // Assume no lateness for overtime
    }
    const timeSettingParts = selectedTime.split(":");
    const startTimeParts = capturedStartTime.toTimeString().split(' ')[0].split(":");
    const timeSetting = new Date(1970, 0, 1, timeSettingParts[0], timeSettingParts[1], timeSettingParts[2]);
    const startTime = new Date(1970, 0, 1, startTimeParts[0], startTimeParts[1], startTimeParts[2]);
    if (startTime > timeSetting) {
        const difference = startTime - timeSetting;
        let hours = Math.floor(difference / (1000 * 60 * 60));
        let minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
        return hours + "." + (minutes < 10 ? "0" + minutes : minutes);
    } else {
        return "0.00";
    }
}

function handleWorkTypeChange() {
	var workTypeSelected = document.getElementById('workType').value !== "null";

    // If a work type is selected, uncheck and disable checkboxes; else enable them
    if (workTypeSelected) {
        document.getElementById('businessTrip').checked = false;
        document.getElementById('training').checked = false;
    }
    document.getElementById('businessTrip').disabled = workTypeSelected;
    document.getElementById('training').disabled = workTypeSelected;

}

function handleCheckboxChange(event) {
	 var businessTripCheckbox = document.getElementById('businessTrip');
	    var trainingCheckbox = document.getElementById('training');

	    if (event.target.id === 'businessTrip' && businessTripCheckbox.checked) {
	        trainingCheckbox.checked = false;
	    } else if (event.target.id === 'training' && trainingCheckbox.checked) {
	        businessTripCheckbox.checked = false;
	    }

	    // Disable work type select if any checkbox is checked
	    var anyCheckboxChecked = businessTripCheckbox.checked || trainingCheckbox.checked;
	    document.getElementById('workType').disabled = anyCheckboxChecked;
}

function setAccessType() {
    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
    document.getElementById("accessType").value = isMobile ? "Mobile" : "PC";
    // This console log is for debugging purposes, consider removing in production
    console.log("Detected Access Type:", document.getElementById("accessType").value);
}
function disableTimeSettingAndType() {
    document.getElementById('selectedTime').disabled = true;
    document.getElementById('workType').disabled = true;
    document.getElementById('businessTrip').disabled = true;
    document.getElementById('training').disabled = true;
}
function disableFormElements() {
    document.getElementById('selectedTime').disabled = true;
    document.getElementById('ipAddress').disabled = true;
    document.getElementById('businessTrip').disabled = true;
    document.getElementById('training').disabled = true;
    document.getElementById('workType').disabled = true;
    document.getElementById('startButton').disabled = true;
    document.getElementById('endButton').disabled = true;
}


function resetForm() {
    document.getElementById('myForm').reset();
    document.getElementById('businessTrip').disabled = false;
    document.getElementById('training').disabled = false;
    document.getElementById('selectedTime').disabled = false;
    document.getElementById('workType').disabled = false;
    document.getElementById('startButton').disabled = false;
    document.getElementById('endButton').disabled = true;
    formSubmissionStarted = false;
}
</script>
</body>

</html>