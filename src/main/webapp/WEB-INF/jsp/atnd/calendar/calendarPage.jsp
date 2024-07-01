<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calendar page </title>
   	<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css' rel='stylesheet' />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   
<style>
    /* General Calendar Styles */
    .calendar {
        font-size: 0.9em;
    }

    .calendar .fc-header {
        font-size: 1em;
    }

    .calendar .fc-day-number {
        cursor: pointer;
    }

    .calendar .past-day {
        color: #999;
    }

    /* Calendar Layout and Container Styles */
    .calendar .container {
        display: flex;
        flex-wrap: wrap;
        flex-direction: row;
        justify-content: space-between;
        align-items: flex-start;
        padding-left: 150px;
    }

    .calendar .calendar-container {
        flex: 1;
        width: 100%;
    }

    .calendar #project-scheduler {
        width: 91%;
        align: center;
    }

    /* Event Titles and Upcoming Events Container */
    .calendar .event-titles-container,
    .calendar #upcoming-events-container {
	   width: 100%;
	   display: flex; /* Using Flexbox */
	   flex-direction: column; /* Stack children vertically */
	   align-items: center; /* Center children horizontally */
	   margin-top: 20px;
	}

    .calendar #event-titles-list li {
        margin-bottom: 10px;
        font-weight: bold;
        cursor: pointer;
    }

    /* Legends Container Styles */
    .calendar .legends-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
    }

    .calendar .legend-box {
        display: inline-block;
        width: 15px;
        height: 15px;
        margin-right: 5px;
        border-radius: 3px;
        cursor: pointer;
    }

    .calendar .legend-text {
		font-size: 12px;
      	margin-right: 20px;
      	cursor: pointer;
    }
   
   

    /* Header and Event Box Styles */
    .calendar .header,
    .calendar .add-event-container {
        padding: 10px 20px;
        display: flex;
        justify-content: flex-end;
        background-color: #fff;
        border-bottom: 1px solid #ddd;
        margin-bottom: 10px;
    }

    .calendar .header-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 100px;
    }

    .calendar .event-box {
        padding: 15px;
        text-align: center;
        border-radius: 5px;
        position: relative;
    }

    /* Button and Link Styles */
    .calendar .button {
		background-color: #0080ff;
		border: none;
		color: white;
		padding: 5px 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 11px;
		margin: 0;
		cursor: pointer;
		border-radius: 4px;
    }

    .calendar .button:hover {
        background-color: #0056b3;
    }

    .calendar a {
        font-size: 12px;
        color: black;
        text-decoration: none;
    }

    /* Event Details and Sidebar Styles */
    .calendar #event-details,
    .calendar .events-sidebar {
        background-color: #f9f9f9;
        border-radius: 4px;
        padding: 20px;
        margin-top: 20px;
        max-height: 300px;
        overflow-y: auto;
    }

    .calendar .events-list {
        list-style: none;
        padding: 0;
    }

    .calendar .event-item {
        background-color: #eee;
        padding: 10px;
        margin-bottom: 5px;
        border-radius: 3px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .calendar .event-item:hover {
        background-color: #d9d9d9;
    }

    .calendar #event-details-container {
        margin-top: 20px;
        padding: 10px;
        border: 1px solid #ddd;
        background-color: #f9f9f9;
    }

    .calendar #event-details-list li {
        padding: 5px;
        border-bottom: 1px solid #eee;
    }

    /* Additional Styles */
    .calendar .upcoming-event-item {
        display: flex;
        align-items: Left;
        margin-bottom: 10px;
    }

    .calendar .upcoming-event-item .legend-box {
        width: 10px;
        height: 10px;
        margin-right: 10px;
        flex-shrink: 0;
    }

    .calendar .upcoming-event-item .event-title {
        font-weight: bold;
        margin-left: 5px;
    }

    .calendar .upcoming-event-item .event-date-range {
        margin-left: 10px;
    }

    .calendar #upcoming-events {
        font-size: 12px;
    }
   
    /* Calendar and Legends Container */
	.calendar .calendar-container, .calendar .events-container {
	   width: 48%; /* Slightly less than half to account for padding/margins */
	   margin-right: 2%; /* Space between two main containers */
	}
	
	.edit-icon, .delete-icon {
	    margin-left: 10px;
	    cursor: pointer;
	    color: #007bff; /* Example color */
	}
	
	.edit-icon:hover, .delete-icon:hover {
	    color: #0056b3; /* Darker shade for hover effect */
	}
	
	/* for get events list box */
	.event-details {
	    flex: 1;
	    min-width: 0;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	}
	
	.edit-delete-icons {
	    flex-shrink: 0;
	    display: flex;
	    align-items: center;
	    justify-content: flex-end;
	    width: 100px;
	}
	
	.edit-icon, .delete-icon {
	    cursor: pointer;
	    margin-left: 10px;
	}
	
	.year-month-selectors {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.year-month-selectors select {
	    padding: 3px 5px;
	    margin-right: 5px;
	    border: none; /* Removes the border */
	    border-radius: 6px;
	    background-color: #cccccc; /* Light grey background */
	    color: #333; /* Dark grey text for good contrast */
	    cursor: pointer;
	}
	
	.year-month-selectors select:hover {
		background-color: #f2f2f2;
	}

	#yearDropdown, #monthDropdown {
	    width: auto; /* Adjust the width as needed, or set it to auto */
	    text-align-last: center; /* Centers the text within the select box for some browsers */
	}
	
	#event-titles-list {
	    list-style-type: none; /* Removes bullet points */
	    padding-left: 0; /* Removes indentation */
	}
	
	.event-list-item {
	    display: flex;
	    align-items: center; /* Center items vertically */
	    padding: 5px; /* Add some padding */
	    background-color: #e6faff;
	    width: 450px; /* Adjust the width as needed */
	}
	
	.event-title {
	    width: 150px; /* Fixed width for title */
	    margin-right: 10px; /* Space between title and date */
	    overflow: hidden;
	}
	
	.event-date {
	    flex-grow: 1; /* Allows the date to fill the available space */
	    text-align: right; /* Aligns the date text to the left */
	    margin-right: 30px;
	}
	
	.event-actions {
	    margin-left: auto; /* Pushes the actions to the end of the container */
	    display: flex; /* Ensures icons are aligned in a row */
	}
	
	#editEventModal {
		align-items: center;
	    display: none;
	    position: fixed;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background-color: #ffffff;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    padding: 20px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	    z-index: 1000;
	    width: 450px; /* Adjust width as needed */
	    max-width: 90%; /* Limit maximum width */
	    height: auto; /* Allow height to adjust based on content */
	    max-height: 90%; /* Limit maximum height */
	    overflow-y: auto; /* Enable vertical scrolling if content exceeds height */
	    box-sizing: border-box;
	    grid-template-columns: 1fr 1fr;
	    grid-gap: 20px;
	    animation: fadeIn 0.3s ease-out; /* Smooth fade-in effect when modal opens */  
	}
	
	/* Animation for the modal to fade in */
	@keyframes fadeIn {
	    from {
	        opacity: 0;
	    }
	    to {
	        opacity: 1;
	    }
	}
	
	#editEventModal label {
	    display: block;
	    margin-bottom: 5px;
	  	grid-column: 1 / -1; /* Make label span full width */
	}
	
	#editEventModal input[type="text"],
	#editEventModal input[type="date"],
	#editEventModal textarea,
	#editEventModal select {
	    width: 100%;
	    padding: 5px;
	    margin-bottom: 10px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	}
	
	#editEventModal textarea {
	    height: 100px;
	}
	
	#editEventModal button {
		background-color: #0080ff;
		border: none;
		color: white;
		padding: 5px 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 14px;
		margin: 0;
		cursor: pointer;
		border-radius: 4px;
	}
	
	#editEventModal button:last-child {
	  	background-color: #8c8c8c;
	  	margin-right: 0;
	}
	
	/* Background overlay */
	#editEventModalOverlay {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
	    backdrop-filter: blur(10px); /* Apply blur effect to the background */
	    z-index: 999; /* Ensure the overlay is above the modal */
	}
	
	#editEventModal .form-row {
	    display: contents; /* Make .form-row children participate in the grid layout */
	}
	
	#editEventModal .full-width {
	    grid-column: 1 / -1; /* Make element span full width */
	}
	
	#editEventModal .input-wrapper {
	    position: relative;
	    display: block; /* Use block to ensure the wrapper fills the parent's width */
	    width: 100%; /* Ensure the wrapper takes up the full width */
	}
	
	#editEventModal .input-wrapper input {
	    width: 100%; /* Input should fill the wrapper */
	    padding-right: 30px; /* Make padding on the right to prevent text from overlapping the icon */
	    padding-left: 5px; /* Adjusted for consistency */
	    padding-top: 5px;
	    padding-bottom: 5px;
	    margin-bottom: 10px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	    cursor: pointer;
	}
	
	#editEventModal .input-wrapper i {
	    position: absolute;
	    right: 10px; /* Adjust as needed to place the icon inside the input at the end */
	    top: 38%;
	    transform: translateY(-50%);
	    pointer-events: none; /* Prevent the icon from interfering with input field clicks */
	}
	
	#editEventModal .is-invalid {
	    border-color: #dc3545 !important; /* Add !important to override other styles */
	}
	
	#editEventModal .invalid-feedback {
	    display: none;
	    width: 100%;
	    color: #dc3545;
	    font-size: 12px;
	}
	
	#editEventModal .is-invalid ~ .invalid-feedback {
	    display: block;
	}
	
	#editEventModal h3 {
		text-align: center;
	}
.no-titlebar .ui-dialog-titlebar {
    display: none;
}

.no-close-button .ui-dialog-titlebar-close {
    display: none;
}

.cancel-symbol {
    position: absolute;
    top: 3px;
    left: 5px; /* Adjusted left position */
    font-size: 16px;
    cursor: pointer;
    color: #808080;
}

.cancel-symbol:hover {
    color: #606060;
}

#modalContent {
    padding-top: 30px;
    
}


	
</style>

</head>
<div id="pageContent">
    <div class="calendar">
        <div class="add-event-container">
            <a href="/webProject/addEvent.do" id="addEventButton" class="button">Add Event</a>
        </div>

		<div class="container">
		    <!-- Calendar and Legends Container -->
		    <div class="calendar-container">
		        <div id="project-scheduler"></div>
		          <div class="legends-container">
			          <div class="legend-box" style="background-color: #99e600;" data-event-type="notice"></div>
					  <div class="legend-text">Notice</div>
					  <div class="legend-box" style="background-color: skyblue;" data-event-type="personal"></div>
					  <div class="legend-text">Personal</div>
					  <div class="legend-box" style="background-color: #ffcc80;" data-event-type="project"></div>
					  <div class="legend-text">Project</div>
					  <div class="legend-box" style="background-color: #ff8c66;" data-event-type="holiday"></div>
			          <span class="legend-text holiday">Holiday</span>
		        </div>
		    </div>
    		
			<ul id="holiday-list"></ul>
			
            <div class="events-container">
				<!-- Events Header with Year and Month Dropdowns -->
	         	<div class="events-header">
   					<div class="year-month-selectors">
						<!-- Year Dropdown -->
						<select id="yearDropdown"></select>
						<select id="monthDropdown"></select>
						<select id="divisionDropdown">
							<option value="personal">Personal</option>
							<option value="project">Project</option>
							<option value="notice">Notice</option>
							<option value="holiday">Holiday</option>
						</select>
					</div>

    				<div class="event-titles-container">
						<ul id="event-titles-list">
						    <!-- Event items here -->
						</ul>
					</div>
				</div>
				
                <!-- Upcoming Events Title and Container -->
                <div id="upcoming-events-container">
   					<h2>Upcoming Events</h2>
					<div id="upcoming-events"></div>
        		</div>
            </div>
        </div>
    </div>
</div>








<!-- Edit Event Modal -->
<div id="editEventModal" style="display:none;">
	<form id="editEventForm">
		<h3><i class="fa-solid fa-pen-to-square" style="margin-right: 10px;"></i>Edit Event</h3>
	
		<div class="form-row">
			<label for="editeventNO"></label>
			<input type="hidden" id="editeventNO" readonly>
        </div>
        
        <div class="form-row">
            <label for="editTitle">Title:</label>
            <input type="text" id="editTitle" name="title">
  			<div class="invalid-feedback" id="titleError"></div>
        </div><br>
        
		<div class="form-row">
		    <label for="editStartDt">Start Date:</label>
		    <div class="input-wrapper">
		        <input type="text" id="editStartDt" name="startDt" readonly>
		        <i class="fa fa-calendar-days" id="startDtIcon"></i>
		    </div>
		    <div class="invalid-feedback" id="startDtError"></div>
		</div>
		
		<div class="form-row">
		    <label for="editEndDt">End Date:</label>
		    <div class="input-wrapper">
		        <input type="text" id="editEndDt" name="endDt" readonly>
		        <i class="fa fa-calendar-days" id="endDtIcon"></i>
		    </div>
		    <div class="invalid-feedback" id="endDtError"></div>
		</div>
        
        <div class="form-row full-width">
            <label for="editDetails">Details:</label>
            <textarea id="editDetails" name="details"></textarea>
            <div class="invalid-feedback" id="detailsError"></div>
        </div><br>
        
        <div class="form-row">
            <label for="editDivision">Division:</label>
            <select id="editDivision" name="division" class="full-width">
                <option value="personal">Personal</option>
                <option value="project">Project</option>
                <option value="notice">Notice</option>
            </select>
        </div><br><br>
        
        <div class="form-row">
            <button type="button" onclick="submitEditEventForm()">Save</button>
            <button type="button" onclick="closeEditModal()">Cancel</button>
        </div>
    </form>
</div>

<div id="eventDetailsModal" title="Event Details" style="display:none;">
    <div id="modalContent" style="max-height: 300px; overflow-y: auto; padding-top: 10px; padding-left: 20px; position: relative;">
        <!-- Added padding-left property for gap -->
        <span class="cancel-symbol">&#10006;</span>
        <p id="modalDetails" style="font-size: 12px; color: #666;">Modal Content</p>
    </div>
</div>





<!-- <script>
$(document).ready(function() {
    $('#project-scheduler').fullCalendar({
        defaultView: 'month',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        // Here you can add your events or fetch them from a server
        events: [
            {
                title: 'Event1',
                start: 'YYYY-MM-DD',
                end: 'YYYY-MM-DD'
            }
        ],
        dayClick: function(date, jsEvent, view) {
            $('#project-scheduler').fullCalendar('changeView', 'agendaDay', date);
        }
    });
});
</script> -->



<script>
$(document).ready(function() {
    $('#project-scheduler').fullCalendar({
        defaultView: 'month',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        events: [
            {
                title: 'Event1',
                start: 'YYYY-MM-DD',
                end: 'YYYY-MM-DD',
                details: 'This is a sample event.'
            }
        ],
        dayClick: function(date, jsEvent, view) {
            $('#project-scheduler').fullCalendar('changeView', 'agendaDay', date);
        },

        eventClick: function(event, jsEvent, view) {
            // Populate modal with event title and details
            $('#modalDetails').text(event.title + ": " + (event.details || "No additional details provided."));

            // Open the modal
            var dialog = $("#eventDetailsModal").dialog({
                modal: true,
                width: 400, // Adjust as per your requirement
                closeText: "&#10006;", // Close mark to close the dialog
                closeOnEscape: true,
                dialogClass: 'no-titlebar no-close-button', // Remove titlebar and close button
                buttons: [] // No buttons
            });

            // Add click event listener to the cancel symbol to close the dialog
            dialog.find('.cancel-symbol').click(function() {
                dialog.dialog('close');
            });
        },

        
        // Existing eventRender function
        eventRender: function(event, element) {
            element.find('.fc-event-title').css('color', 'white');

            // Bind click event to the event title to open modal
            element.find('.fc-title').on('click', function() {
                // Populate the modal with event information
                $('#eventTitle').text(event.title);
                $('#eventDetails').text(event.details);
                $('#eventDetailsModal').modal('show');
            });
        },

    });

    // Click event for legend boxes and texts
    $('.legend-box, .legend-text').on('click', function() {
        // Get the division type and color
        var division = $(this).data('event-type');
        var color = $(this).css('background-color');

        // Handle the case where the text is clicked instead of the box
        if (!division && $(this).hasClass('legend-text')) {
            division = $(this).prev('.legend-box').data('event-type');
            color = $(this).prev('.legend-box').css('background-color');
        }

        // AJAX call to fetch events based on division
        $.ajax({
            url: '/webProject/getEventsByDivision.do', // Adjust to your server endpoint
            type: 'GET',
            data: { division: division },
            dataType: 'json', // Expecting JSON response
            success: function(events) {
                events.forEach(function(event) {
                    event.color = color; // Apply the color

                    // Check if end date is greater than start date
                    var startDate = moment(event.start);
                    var endDate = moment(event.end);
                    if (endDate.isAfter(startDate)) {
                        // Add 1 day to the end date
                        endDate.add(1, 'day');
                        event.end = endDate.format();
                    }
                });

                $('#project-scheduler').fullCalendar('removeEvents');
                $('#project-scheduler').fullCalendar('addEventSource', events);
            },
            error: function(xhr, status, error) {
                console.log("Error fetching events for division " + division + ": " + error);
            }
        });
    });

    // Set text color inside color boxes to white using CSS
    $('.legend-box').find('span').css('color', 'white');
    
    // Simulate click on Notice legend to load notice events by default
    $('.legend-text').filter(function() {
        return $(this).text() === 'Notice';
    }).trigger('click');
});

</script>


<script>
$(document).ready(function() {
    // Populate the year and month dropdowns when the page loads
    populateYearDropdown();
    populateMonthDropdown();

    // Fetch and display events based on the current selections
    fetchAndDisplayEvents();
   
    // Call function to set up delete event handlers after events are displayed
    setupDeleteEventHandlers();

    // Set up event listeners for when the dropdown values change
    $('#yearDropdown, #monthDropdown, #divisionDropdown').on('change', function() {
        fetchAndDisplayEvents(); // Re-fetch and display events for the new selections
    });
});

// Populates the year dropdown dynamically
function populateYearDropdown() {
    var currentYear = moment().year();
    for (var year = currentYear - 5; year <= currentYear + 5; year++) {
        $('#yearDropdown').append($('<option>', { value: year, text: year }));
    }
    $('#yearDropdown').val(currentYear); // Set the current year as the default selection
}

// Populates the month dropdown dynamically
function populateMonthDropdown() {
    moment.months().forEach(function(month, index) {
        $('#monthDropdown').append($('<option>', { value: index + 1, text: month }));
    });
    $('#monthDropdown').val(moment().month() + 1); // Set the current month as the default selection
}

// Fetches and displays events based on the selected year, month, and division
function fetchAndDisplayEvents() {
    var year = $('#yearDropdown').val();
    var month = $('#monthDropdown').val();
    var division = $('#divisionDropdown').val();

    $.ajax({
        url: '/webProject/getEvents.do', // The URL to your event fetching endpoint
        type: 'GET',
        data: { year: year, month: month, division: division },
        dataType: 'json',
        success: function(events) {
            $('#event-titles-list').empty(); // Clear the list before adding new events

            if (events.length === 0) {
                $('#event-titles-list').append($('<li>').text("No events found."));
            } else {
            	events.forEach(function(event) {
            	    var colorBox = $('<div>').css({
            	        'display': 'inline-block',
            	        'width': '10px',
            	        'height': '10px',
            	        'background-color': getColorForDivision(division),
            	        'margin-right': '10px'
            	    });

            	    var titleDiv = $('<div class="event-title">').text(event.title);
            	    var dateDiv = $('<div class="event-date">').text(event.start + " to " + event.end);
            	    var actionContainer = $('<div class="event-actions">');

                    if (division !== "holiday") {
                        var editIcon = $('<i class="fas fa-edit" style="cursor: pointer; color: blue; margin-right: 7px;"></i>').click(function() {
                            openAndPopulateEditModal(event);
                        });

                        var deleteIcon = $('<i class="fas fa-trash" style="cursor: pointer; color: red;"></i>')
                            .data('eventNo', event.eventNo)
                            .data('eventTitle', event.title);

                        actionContainer.append(editIcon).append(deleteIcon);
                    }

                    var listItem = $('<li class="event-list-item">').append(colorBox).append(titleDiv).append(dateDiv).append(actionContainer);

                    $('#event-titles-list').append(listItem);
                });

                // Call function to set up delete event handlers after events are displayed
                setupDeleteEventHandlers();
            }
        },

        error: function(xhr, status, error) {
            console.error("Error fetching events:", error);
            $('#event-titles-list').empty().append($('<li>').text("Failed to load events. Error: " + error));
        }
    });
}


function getColorForDivision(division) {
    var colors = {
   		'personal': 'skyblue',
        'project': '#ffcc80',
        'notice': '#99e600',
        'holiday': '#ff8c66'
    };
    // Ensure division is a string before attempting to trim and convert to lowercase
    var divisionKey = (typeof division === 'string') ? division.trim().toLowerCase() : '';
    var color = colors[divisionKey] || 'grey'; // Use a default color if division is not recognized
    return color;
}

//Function to set up event handlers for delete icons
function setupDeleteEventHandlers(events) {
    $('.fa-trash').click(function() {
        var eventNo = $(this).data('eventNo');
        var eventTitle = $(this).data('eventTitle');
        var confirmDelete = confirm('Are you sure you want to delete the event "' + eventTitle + '"?');
        if (confirmDelete) {
            deleteEvent(eventNo);
        }
    });
}



//Function to delete the event via AJAX
function deleteEvent(eventNo) {
    $.ajax({
        url: '/webProject/deleteEvent.do',
        type: 'POST',
        data: { eventNo: eventNo },
        dataType: 'text', // Expecting text response
        success: function(response) {
            console.log(response); // Log the response for debugging
            // Optionally, you can update the UI or reload the events list after successful deletion
           	alert("Event deleted successfully!");
            fetchAndDisplayEvents(); // Reload events after deletion
            fetchAndDisplayUpcomingEvents();
        },
        error: function(xhr, status, error) {
            console.error("Error deleting event:", error);
            alert('Failed to delete event. Error: ' + error); // Notify user of error
        }
    });
 
}

</script>

<script>
$(document).ready(function() {
    // Fetch and display upcoming events based on the current month
    fetchAndDisplayUpcomingEvents();
});

// Fetches and displays upcoming events based on the current month
function fetchAndDisplayUpcomingEvents() {
    // Get current date
    var currentDate = moment();

    // Get the last day of the current month
    var lastDayOfMonth = moment().endOf('month');

    // Prepare the date range for the query
    var startDate = currentDate.format('YYYY-MM-DD');
    var endDate = lastDayOfMonth.format('YYYY-MM-DD');


    // Send AJAX request to fetch upcoming events
    $.ajax({
        url: '/webProject/getUpcomingEvents.do', // The URL to your upcoming events fetching endpoint
        type: 'GET',
        data: { startDate: startDate, endDate: endDate },
        dataType: 'json',
        success: function(events) {
            if (!events || events.length === 0) {
                console.log("No events or error in events format.");
                return; // Exit if no events or malformed data
            }
            displayUpcomingEvents(events); // Proceed if data is correct
        },

        error: function(xhr, status, error) {
            console.error("Error fetching upcoming events:", error);
            $('#upcoming-events').empty().append($('<p>').text("Failed to load upcoming events. Error: " + error));
        }
    });
}

function displayUpcomingEvents(events) {
    $('#upcoming-events').empty();
    if (events.length === 0) {
        $('#upcoming-events').append($('<p>').text("No upcoming events for the current month."));
        return;
    }

    // Iterate over each fetched event and append it to the container
    events.forEach(function(event) {
        // Format start and end dates
        var formattedStartDate = moment(event.start).format('YYYY-MM-DD');
        var formattedEndDate = moment(event.end).format('YYYY-MM-DD');
        var dateRange = formattedStartDate + ' to ' + formattedEndDate; // Combine them in the desired format

        var divisionColor = getDivisionColor(event.division); // Get color based on division

        var eventContainer = $('<div>').css({
            'display': 'flex',
            'align-items': 'center', // Align items vertically
            'justify-content': 'space-between', // Space between name and date
            'margin-bottom': '10px', // Space between events
            'font-size': '14px', // Set font size to 15px
            'font-family': 'Calibri', // Set font family to Calibri
            'font-weight': 'bold', // Make the font bold
            'background-color': '#e6faff',
            'width': '450px',
            'padding': '5px'
        });

        // Colored box to indicate division
        var coloredBox = $('<div>').css({
            'display': 'inline-block',
            'width': '10px',
            'height': '10px',
            'background-color': divisionColor,
            'margin-right': '10px'
        });

        // Container for event name and colored box
        var nameContainer = $('<div>').css({
            'flex-grow': 1,
            'display': 'flex',
            'align-items': 'center',
            'margin-right': '10px'
        }).append(coloredBox).append($('<div>').text(event.title));

        // Container for event date range
        var dateContainer = $('<div>').text(dateRange);

        // Append the name and date containers to the event container
        eventContainer.append(nameContainer).append(dateContainer);

        // Append the event container to the upcoming events list
        $('#upcoming-events').append(eventContainer);
    });
}

// Function to get color based on division
function getDivisionColor(division) {
    var colors = {
   		'personal': 'skyblue',
        'project': '#ffcc80',
        'notice': '#99e600',
        'holiday': '#ff8c66'
    };
    // Ensure division is a string before attempting to trim and convert to lowercase
    var divisionKey = (typeof division === 'string') ? division.trim().toLowerCase() : '';
    var color = colors[divisionKey] || 'grey'; // Use a default color if division is not recognized
    return color;
}
</script>

<!-- Edit Event Modal -->
<script>
$(document).ready(function() {
    // Event listeners for date inputs
    $('#editStartDt').on('change', function() {
        updateEndDateMin(); // Update minimum end date when start date changes
    });

    $('#editEndDt').on('change', function() {
        updateStartDateMax(); // Update maximum start date when end date changes
    });
    
    // DatePicker for start date
    $('#editStartDt').datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,      // Enable the month drop-down
        changeYear: true,        // Enable the year drop-down
        onSelect: function(dateText, inst) {
            // Automatically close the datepicker after selecting a date
            $(this).datepicker('hide');
            
            // Set the minDate of end date to the selected start date
            $('#editEndDt').datepicker('option', 'minDate', dateText);
        }
    });

    // DatePicker for end date
    $('#editEndDt').datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,      // Enable the month drop-down
        changeYear: true,        // Enable the year drop-down
        onSelect: function(dateText, inst) {
            // Automatically close the datepicker after selecting a date
            $(this).datepicker('hide');
            
            // Set the maxDate of start date to the selected end date
            $('#editStartDt').datepicker('option', 'maxDate', dateText);
        }
    });

    // Trigger DatePicker on icon click
    $('#startDtIcon').click(function() {
        $('#editStartDt').datepicker('show');
    });

    $('#endDtIcon').click(function() {
        $('#editEndDt').datepicker('show');
    });
});


function closeEditModal() {
    // Hide the modal
    $('#editEventModal').hide();
    clearValidation();
    
    // Reset the datepicker options for start and end dates to remove minDate and maxDate restrictions
    $('#editStartDt').datepicker('option', 'minDate', null);
    $('#editStartDt').datepicker('option', 'maxDate', null);
    $('#editEndDt').datepicker('option', 'minDate', null);
    $('#editEndDt').datepicker('option', 'maxDate', null);

    // Optionally, clear the input values if you want a clean slate each time the modal opens
    $('#editEventForm').find('input[type="text"], textarea').val('');
    $('#editEventForm').find('select').prop('selectedIndex', 0); 
}


function openAndPopulateEditModal(event) {
    $('#editeventNO').val(event.eventNo).attr('readonly', true); // Set the event number and make it read-only
    $('#editTitle').val(event.title);
    $('#editStartDt').val(moment(event.start).format('YYYY-MM-DD'));
    $('#editEndDt').val(moment(event.end).format('YYYY-MM-DD'));
    $('#editDetails').val(event.details);
    
    clearValidation();
    
    // Reset the datepicker options for start and end dates to remove minDate and maxDate restrictions
    $('#editStartDt').datepicker('option', 'minDate', null);
    $('#editStartDt').datepicker('option', 'maxDate', null);
    $('#editEndDt').datepicker('option', 'minDate', null);
    $('#editEndDt').datepicker('option', 'maxDate', null);

    // Preselect the division
    var divisionValue = event.division; // The value you want to preselect

    var $editDivision = $('#editDivision');
    $editDivision.val(divisionValue).trigger('change');

    // Explicitly mark the matching option as selected only if the direct method fails
    if ($editDivision.val() !== divisionValue) {
        $editDivision.find('option').each(function() {
            if ($(this).val() === divisionValue) {
                $(this).prop('selected', true);
            }
        });
    }

    $('#editEventModal').show();
}



function submitEditEventForm() {
    event.preventDefault();

    // Perform validation checks for required fields only
    var isTitleValid = validateTitle();
    var isStartDateValid = validateStartDate();
    var isEndDateValid = validateEndDate();
    
    // Check if the details input is visibly marked as invalid
    var isDetailsValid = !$("#editDetails").hasClass("is-invalid");

    // If all required validations pass, submit the form data via AJAX
    if (isTitleValid && isStartDateValid && isEndDateValid && isDetailsValid) {
        var eventData = {
            eventNo: $('#editeventNO').val(),
            title: $('#editTitle').val(),
            startDt: $('#editStartDt').val(),
            endDt: $('#editEndDt').val(),
            details: $('#editDetails').val(),
            division: $('#editDivision').val()
        };

        $.ajax({
            type: "POST",
            url: "/webProject/updateEvent.do",
            data: JSON.stringify(eventData),
            contentType: 'application/json; charset=utf-8',
            dataType: 'text', // Expecting plain text response from server
            success: function(response) {
                alert("Event modified successfully!");
                fetchAndDisplayEvents();
                fetchAndDisplayUpcomingEvents();
                closeEditModal();
            },
            error: function(xhr, status, error) {
                console.error("Error submitting event:", error);
                alert('Failed to submit event. Error: ' + error);
            }
        });
    } else {
        alert("Please fill all the fields properly!");
    }
}


//Make sure to bind the submitEditEventForm function to the actual submission event of your form
$('#editEventForm').on('submit', function(e) {
    e.preventDefault(); // Prevent the default form submission
    submitEditEventForm();
});
</script>

<script>
$(document).ready(function() {
    // Title Validation
     $("#editTitle").on("input", function() {
        var inputElement = $(this);
        var inputValue = inputElement.val();
        var correctedValue = inputValue.replace(/\s\s+/g, ' '); // Replace consecutive spaces with a single space
        
        if (correctedValue.length > 50) {
            $("#titleError").text("Please enter a valid title (Max 50 characters)").show();
        } else {
            $("#titleError").hide();
        }
    });
    
    
     $("#editTitle").on("blur", function() {
         var inputElement = $(this);
         var trimmedValue = inputElement.val().trim(); // Trim leading and trailing spaces
         inputElement.val(trimmedValue);
         validateTitle(); // Re-validate title after trimming
     });


    // Start Date Validation
    $('#editStartDt').on('change', function() {
        validateStartDate(); // Validate start date
        updateEndDateMin(); // Update minimum end date when start date changes
    });

    // End Date Validation
    $('#editEndDt').on('change', function() {
        validateEndDate(); // Validate end date
        updateStartDateMax(); // Update maximum start date when end date changes
    });
});

//Define the validateTitle function outside of $(document).ready()
function validateTitle() {
    var titleInput = $("#editTitle");
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


function validateStartDate() {
    var startDateInput = $("#editStartDt");
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
    var endDateInput = $("#editEndDt");
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




function clearValidation() {
    // Clear validation messages
    $("#titleError").hide();
    $("#startDtError").hide();
    $("#endDtError").hide();

    // Remove 'is-invalid' class from input fields
    $("#editTitle").removeClass("is-invalid");
    $("#editStartDt").removeClass("is-invalid");
    $("#editEndDt").removeClass("is-invalid");
}
</script>

</body>
</html>