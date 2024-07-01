<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="/webProject/resources/js/MDTimePicker/mdtimepicker.css" rel="stylesheet">
<script src="/webProject/resources/js/MDTimePicker/mdtimepicker.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>



    <meta charset="UTF-8">
    <title>Overtime Details</title>
    <style>
       
    .overTimeData th, .overTimeData td {
	    text-align: center;
	    padding: 0;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    font-size: 12px;
	   
	}
	
	.overTimeData tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.overTimeData th {
	    background-color: #a6a6a6;
	    color: black;
	}
      
      /* Custom styles for table row */
	.overTimeData tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	.overTimeData tr:nth-child(even).custom-row-style td {
	    background-color: #fff; /* Color for even rows if different */
	}
     
       
    .overTimeData input[type="text"] {
    width: 100%; /* Make input fields take up 100% of the cell's width */
    box-sizing: border-box; /* Include padding and border in the element's width */
    margin: 0; /* Remove any default margin */
    border: 1px solid #ccc; /* Optional: style the border of the input field */
    font-size: 12px; /* Match the font size of the table */
	}    
    .md-timepicker {
     /* Example styles */
     border: 2px solid #007bff; /* Blue border */
     width: 61px; /* Adjust width as needed */
     height: 18px; /* Adjust height as needed */
     padding: 0px 0px; /* Adjust padding as needed */
     font-size: 12px; /* Adjust font size as needed */
     border-radius: 5px; /* Rounded corners */          
     color: #333; /* Dark text color */
     background-color: #f8f9fa; /* Light background */
     align-content: center;
     }
     .md-timepicker:focus {
         /* Styles for when the input is focused */
         border-color: #0056b3; /* Darker blue border */
         outline: none; /* Remove default focus outline */
         box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); /* Bootstrap-like focus glow */
     }
       
     .top {
	 margin-bottom: 10px;
	 }
      .dataTables_wrapper .dataTables_length{
	   color: #333;
	   margin-top: -20px;
	   font-size: 12px;
	}

	.dataTables_length select {
	       width: 36px; /* Set the width as you desire */
	       height: 18px; /* Set the height as you desire */      
	       margin: 0 5px; /* Optional: Adjust margin around the select box */
	       font-size: 10px;
	       background-color: #f7f7f7; /* Optional: Change background color */
	       border: 1px solid #ddd; /* Optional: Add a border */
	   }
		.dataTables_wrapper .dataTables_info{
		font-size: 12px;
		}

		.dataTables_wrapper .dataTables_paginate {
		   font-size: 12px;
		}
		.searchBar {
		    display: flex;
		    align-items: center;
		    padding: 0.6em;
		    margin-bottom: 1em;
		    box-sizing: border-box;
		    width: 100%;
		    border: 1px solid black;
		    font-size: 12px;
		}
     
		.searchBar span {
		    margin-right: 10px; /* Space between label and input */
		}

		.searchBar input[type="text"] {
			width: auto; /* Adjust based on your preference */
			padding: 0.2em;
			box-sizing: border-box;
			font-size: 12px;
		}

	
       
    </style>
</head>
<body>
<div id="pageContent">
 <div class="searchBar">
    <span style="margin-right: 10px;">Date Range:</span>
<div style="position: relative; display: inline-block; margin-right: 10px;">
   <input type="text" id="startDatePicker" placeholder="Select Start Date" style="padding-right: 30px; font-size: 12px;">
   <i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: calc(50% - 7.5px); pointer-events: none;"></i>
</div>
<div style="position: relative; display: inline-block;">
   <input type="text" id="endDatePicker" placeholder="Select End Date" style="padding-right: 30px; font-size: 12px;">
   <i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: calc(50% - 7.5px); pointer-events: none;"></i>
</div>
 </div>
	<center><h4 style="margin-bottom: 40px;">OVERTIME DETAILS</h4></center>
            	<table class="overTimeData" id="overTimeData"  >
                	<thead class="thead-dark"  >
                    <tr>
                <th style="display:none;">No</th>
                <th>Emp ID</th>              
                <th>Date</th>              
                <th>GPS Information</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Over Time</th>
                <th>Work Type</th>                
                <th>Access Type</th>
                <th>IP Address</th>
                <th>Actions</th>
                <th style="display:none;">TimeSetting</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${overTimeList}" var="overTime">
                <tr>
                    <td style="display:none;">${overTime.no}</td>
                    <td>${overTime.empId}</td>
                    <td><fmt:formatDate value="${overTime.startTime}" pattern="yyyy-MM-dd"/></td>
                   
                    <td><a href="https://www.google.com/maps/search/?api=1&query=${attendance.gpsInformation}" target="_blank">${attendance.gpsInformation}</a></td>
                    <td><fmt:formatDate value="${overTime.startTime}" pattern="HH:mm"/></td>
                    <td><fmt:formatDate value="${overTime.endTime}" pattern="HH:mm"/></td>
                   
                    <td>${overTime.overTime}</td>
                    <td>${overTime.workType}</td>
                   
                    <td>${overTime.accessType}</td>
                    <td>${overTime.ipAddress}</td>
                    <td>
                      <button class="edit-btn"><i class="fas fa-edit"></i></button>
          <button class="save-btn" style="display:none;"><i class="fas fa-save"></i></button>
          <button class="cancel-btn" style="display:none;"><i class="fas fa-times"></i></button>
                    </td>
                    <td style="display:none;">${overTime.timeSetting}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
   </div>
   
   
<script>
$(document).ready(function() {
    // Initialize DataTable
    dataTableInstance = $('#overTimeData').DataTable({
    "pagingType": "full_numbers",
        "searching": true,
       
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
       
        "columnDefs": [{
            "targets": [6], // Adjust the index for the Over Time column if needed
            "render": function(data, type, row) {
                if(type === 'display') {
                    // Assuming 'data' is your decimal number for over time
                    var formattedData = parseFloat(data).toFixed(2).replace('.', ':');
                    return formattedData;
                }
                return data; // Return unmodified data for other types
            }
        }
       
    ],
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        }
    });

    var userSecurityLevel = ${loggedInUser.securityLevel}; // Ensure this variable is defined appropriately

    // Disable edit buttons based on user security level
    if (userSecurityLevel > 5) {
        $('#overTimeData .edit-btn').prop('disabled', true).css({'opacity': '0.5', 'cursor': 'not-allowed'});
    }

    // Event listener for edit button in Over Time Data Table
    $('#overTimeData').on('click', '.edit-btn', function() {
        if (userSecurityLevel <= 5) { // Check security level before allowing edits
            var row = $(this).closest('tr');
            row.find('td').each(function(index) {
                if (index === 4 || index === 5) { // Target "Start Time" and "End Time"
                    var initialContent = $(this).text();
                    // Convert 24-hour time to 12-hour format with AM/PM
                    var formattedTime = moment(initialContent, 'HH:mm').format('hh:mm A');
                    $(this).html('<input type="text" class="md-timepicker" value="' + formattedTime + '" data-initial-content="' + initialContent + '">');
                }
            });

            row.find('.edit-btn').hide();
            row.find('.save-btn, .cancel-btn').show();
           
       

        // Initialize MDTimePicker for new input fields
        $('.md-timepicker').mdtimepicker({
            timeFormat: 'hh:mm:ss.000',
            format: 'h:mm tt', // Ensure this is set to 'h:mm tt' for 12-hour format
            theme: 'blue',
            readOnly: true,
            hourPadding: false
        });
        }

    });
    // Cancel button click handler
    $('#overTimeData').on('click', '.cancel-btn', function() {
        var row = $(this).closest('tr');
        row.find('.md-timepicker').each(function() {
            var initialContent = $(this).data('initial-content'); // Get the initial content from data attribute
            var td = $(this).closest('td');
            td.text(initialContent); // Revert the edited content back to the original text
        });

        row.find('.edit-btn').show();
        row.find('.save-btn, .cancel-btn').hide();
    });

    // Save button click handler
// Save button click handler
   $('#overTimeData').on('click', '.save-btn', function() {
   var row = $(this).closest('tr');
   var startTimeInput = row.find('td:nth-child(5) .md-timepicker');
   var endTimeInput = row.find('td:nth-child(6) .md-timepicker');
   
   // Assuming the input from the time picker is in 12-hour format with AM/PM
   // Parse the time correctly using 'hh:mm A' format
   var startTime = moment(startTimeInput.val(), 'hh:mm A');
   var endTime = moment(endTimeInput.val(), 'hh:mm A');

   // After parsing, convert to 24-hour format for comparison and further operations
   // Note: The comparison can work directly with moment objects without explicit format conversion
   if (startTime.isBefore(endTime)) {
       row.find('.md-timepicker').each(function() {
           var newValue = $(this).val(); // This value is still in 12-hour format with AM/PM
           
           // Convert newValue to 24-hour format before setting it as the new value
           var newTimeValue = moment(newValue, 'hh:mm A').format('HH:mm'); // Convert to 24-hour format
           
           var td = $(this).closest('td');
           td.text(newTimeValue).attr('data-initial-content', newTimeValue); // Update the cell in 24-hour format
       });

            row.find('.edit-btn').show();
            row.find('.save-btn, .cancel-btn').hide();

            // Extract data from the row
            var formData = new FormData();
              formData.append('no', row.find('td:nth-child(1)').text());
      formData.append('empId', row.find('td:nth-child(2)').text());
      formData.append('gpsInformation', row.find('td:nth-child(3)').text());
      formData.append('startTime', startTime);
      formData.append('endTime', endTime);
     
      formData.append('workType', row.find('td:nth-child(8)').text());
      formData.append('accessType', row.find('td:nth-child(9)').text());
      formData.append('ipAddress', row.find('td:nth-child(10)').text());
      formData.append('timeSetting', row.find('td:nth-child(12)').text());
            // Add more properties as needed
       
           

            // Send AJAX request to your server
            $.ajax({
                url: 'updateOvertimeDeatails.do',
                type: 'POST',
                processData: false, // Important for FormData
                contentType: false, // Important for FormData
                data: formData,
               
                success: function(response) {
                alert("Overtime details updated successfully");
           // Refresh the current page
           window.location.reload();
                },
                error: function(xhr, status, error) {
                    // Handle error (e.g., show an error message)
                }
            });
        } else {
            // Show an error message or handle the error as needed
            alert('Start Time must be less than End Time.');
        }
    });
   $("#startDatePicker").datepicker({
       dateFormat: "yy-mm-dd",
       onClose: function(selectedDate) {
           // When a start date is selected, set the end date's minDate to the selected date
           $("#endDatePicker").datepicker("option", "minDate", selectedDate);
           dataTableInstance.draw(); // Redraw the DataTable to apply the new filter
       }
   });

   // Initialize the end date picker
   $("#endDatePicker").datepicker({
       dateFormat: "yy-mm-dd",
       onClose: function(selectedDate) {
           // When an end date is selected, set the start date's maxDate to the selected date
           $("#startDatePicker").datepicker("option", "maxDate", selectedDate);
           dataTableInstance.draw(); // Redraw the DataTable to apply the new filter
       }
   });

   // Custom search function for DataTable
   $.fn.dataTable.ext.search.push(
       function(settings, data, dataIndex) {
           var startDate = $('#startDatePicker').datepicker("getDate");
           var endDate = $('#endDatePicker').datepicker("getDate");
           var dateColumn = data[2]; // Assuming date is in the 3rd column (index 2), adjust if necessary
           
           // Convert date from the table into a comparable format
           var date = moment(dateColumn, "YYYY-MM-DD").toDate();

           if (!startDate && !endDate) {
               return true;
           }
           if (startDate && !endDate) {
               return date >= startDate;
           }
           if (!startDate && endDate) {
               return date <= endDate;
           }
           if (startDate && endDate) {
               return date >= startDate && date <= endDate;
           }
       }
   );
});
</script>


 
</body>
</html>