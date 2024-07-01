<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

    <title>Personal Attendance</title>
 <head>
 <link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link href="/webProject/resources/js/MDTimePicker/mdtimepicker.css" rel="stylesheet">
<script src="/webProject/resources/js/MDTimePicker/mdtimepicker.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> -->
   
<style>


<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> -->
   
<style>



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

	
	
	.personalAtndDataTable th, .personalAtndDataTable td {
	    text-align: center;
	    padding: 0;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    font-size: 12px;
	   
	}
	
	.personalAtndDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.personalAtndDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	    width: 100%;
	}
      
      /* Custom styles for table row */
	.personalAtndDataTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	.personalAtndDataTable tr:nth-child(even).custom-row-style td {
	    background-color: #fff; /* Color for even rows if different */
	}
	
	.download-links {
    	text-align: right; /* Align the buttons to the right side */
	}
	
	.top {
		margin-bottom: 10px;
	}
	
	.personalAtndDataTable td.number {
	       text-align: right;
	} 
	#select, #cancel {
	margin-right: 10px;
	 background-color:  #0080ff;
	 border: none;
	 padding: 5px;
	  border-radius: 2px;
     color: white;
      font-size: 11px;
	     
	}
	.small-button {
    padding: 5px 5px;
    font-size: 5px;
    border:none;
    border-radius: 5px; /* Optional: for rounded corners */
    cursor: pointer; /* To indicate it's clickable */
 

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
        }
        .md-timepicker:focus {
            /* Styles for when the input is focused */
            border-color: #0056b3; /* Darker blue border */
            outline: none; /* Remove default focus outline */
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); /* Bootstrap-like focus glow */
        }
        
        .overtimeDetailsButton
        {
         background-color: #0080ff;
         border: none;
         padding:5px;
         font-size: 12px;
         color: white;
         border-radius: 3px;
         }
     

.display-table th, .display-table td {
         border: 0.5px solid #c9c7c8; /* You can adjust the color and width of the border here */
        white-space: nowrap;
        font-size: 12px;
        text-align: center;
        max-width:170px;
        }
        .display-table th{
border: 0.5px solid #c9c7c8;
background-color: #e6f0ff;
width:100%;
}  
 
 .download-links {
  display: flex; /* This line will make all child elements align horizontally */
  align-items: center; /* Align the items vertically in the center */
  justify-content: flex-end; /* Align the items to the end of the container */
  margin-right: 10px; /* Adjust as needed to fit the container */
}
.buttons {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.edit-btn, .save-btn, .cancel-btn {
  border: none;
  background-color: transparent;
  cursor: pointer;
}

.edit-btn i  {
  color: blue; /* Change icon color here */
  font-size: 12px; /* Adjust icon size here */
}
.save-btn i{
  color: green; /* Change icon color here */
  font-size: 12px; /* Adjust icon size here */
}
.cancel-btn i{
  color: gray; /* Change icon color here */
  font-size: 12px;
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
     }
     .md-timepicker:focus {
         /* Styles for when the input is focused */
         border-color: #0056b3; /* Darker blue border */
         outline: none; /* Remove default focus outline */
         box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); /* Bootstrap-like focus glow */
     }
       
.dataTables_wrapper .dataTables_length{
  color: #333;
  margin-top: 18px;
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
  border: 0.5px solid #c9c7c8;
  font-size: 12px;
  style: 'Calibri';
}
</style>
</head>
<div id="pageContent">
<div class="searchBar" style="display: flex; justify-content: space-between; align-items: center;">
        <div>
            <span style="margin-right: 10px;">Date Range:</span>
            <div style="position: relative; display: inline-block; margin-right: 10px; ">
			    <input type="text" id="startDatePicker" placeholder="Select Start Date" style="padding-right: 30px; cursor: pointer;" readonly>
			    <i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: calc(50% - 7.5px); pointer-events: none;"></i>
			</div>
			<div style="position: relative; display: inline-block;">
			    <input type="text" id="endDatePicker" placeholder="Select End Date" style="padding-right: 30px;cursor: pointer;" readonly>
			    <i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: calc(50% - 7.5px); pointer-events: none;"></i>
			</div>
  
   			<span style="margin-left: 10px; margin-right: 10px;">Work Type:</span>
		    <input type="text" id="workTypeSearchBox" placeholder="Search by Work Type">
		    <span style="margin-left: 10px; margin-right: 10px;">Access Type:</span>
		    <input type="text" id="accessTypeSearchBox" placeholder="Search by Access Type">
		    
		    
		 </div>
   <button class="overtimeDetailsButton" data-empid="${empId}">Over Time Details</button>
</div>
	   <div class="download-links buttons">
	        <!-- Excel Download Button -->
	        <button id="downloadAttendanceExcel" style="text-decoration: none; margin-right: 10px; color: green; background: none; border: none; cursor: pointer;">
	            <i class="fas fa-file-excel"></i> Excel
	        </button>
	        
	        <!-- PDF Download Button -->
	        <button id="downloadAttendancePdf" style="text-decoration: none; color: red; background: none; border: none; cursor: pointer;">
	            <i class="fas fa-file-pdf"></i> PDF
	        </button>
	    </div>
	    
     <center><h4>PERSONAL ATTENDANCE</h4></center>
            	<table class="personalAtndDataTable" id="personalAtndDataTable"  >
         <thead class="thead-dark" style= "text-align: center;">
            <tr>
               <th>Emp ID</th>
               <th>Name</th>
               <th>Group</th>
               <th>Department</th>
               <th>Designation</th>
               <th>Year of Work</th>
               <th>Career</th>
               <th>Time Setting</th>
               <th>GPS Information</th>
               <th>Start Time</th>
               <th>End Time</th>
               <th>Work Type</th>
               <th>Access Type</th>
               <th>Late</th>
               <th>Lateness</th>
               <th>IP Address</th>
               <th>Outside Work</th>
               <th>Business Trip</th>
               <th>Training</th>
               <th>Overtime</th>
               <th>Status</th>
               <th>Work Hour</th>
               <th>AEW</th>
               <th>Attendance No</th>
               <th>Actions</th>
                             
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${attendanceList}" var="attendance" >
  <tr>
<td data-fieldname="empId">${attendance.empId}</td>
        <td data-fieldname="name">${attendance.name}</td>
        <td data-fieldname="group">${attendance.group}</td>
        <td data-fieldname="department">${attendance.department}</td>
        <td data-fieldname="designation">${attendance.designation}</td>
        <td data-fieldname="yearOfWork">${attendance.yearOfWork}</td>
        <td data-fieldname="career">${attendance.career}</td>
        <td data-fieldname="timeSetting">
            <fmt:formatDate value="${attendance.timeSetting}" pattern="yyyy-MM-dd HH:mm:ss" />
        </td>
        <td data-fieldname="gpsInformation"><a href="https://www.google.com/maps/search/?api=1&query=${attendance.gpsInformation}" target="_blank">${attendance.gpsInformation}</a></td>
        <td data-fieldname="startTime">
   <span class="time-display">
       <fmt:formatDate value="${attendance.startTime}" pattern="HH:mm" />
   </span>
   <input type="text" class="start-time-picker" value="<fmt:formatDate value='${attendance.startTime}' pattern='HH:mm' />" style="display: none;">
</td>
<td data-fieldname="endTime">
   <span class="time-display">
       <fmt:formatDate value="${attendance.endTime}" pattern="HH:mm" />
   </span>
   <input type="text" class="end-time-picker" value="<fmt:formatDate value='${attendance.endTime}' pattern='HH:mm' />" style="display: none;">
</td>

<td data-fieldname="workType">${attendance.workType}</td>
        <td data-fieldname="accessType">${attendance.accessType}</td>
        <td data-fieldname="late">${attendance.late}</td>
        <td data-fieldname="lateness">${attendance.lateness}</td>
        <td data-fieldname="ipAddress">${attendance.ipAddress}</td>
        <td data-fieldname="outsideWork">${attendance.outsideWork}</td>
        <td data-fieldname="businessTrip">${attendance.businessTrip}</td>
        <td data-fieldname="training">${attendance.training}</td>
        <td data-fieldname="overTime">${attendance.overTime}</td>
        <td data-fieldname="status">${attendance.status}</td>
        <td data-fieldname="workHour">${attendance.workHour}</td>
        <td data-fieldname="aew">${attendance.aew}</td>
        <td data-fieldname="atndNo">
            <input type="hidden"  value="${attendance.atndNo}">
            ${attendance.atndNo} <!-- Displayed to the user -->
        </td>
        <td>
            <button class="edit-btn"><i class="fas fa-edit"></i></button>
            <button class="save-btn" style="display:none;"><i class="fas fa-save"></i></button>
            <button class="cancel-btn" style="display:none;"><i class="fas fa-times"></i></button>
        </td>

</tr>

</c:forEach>
</tbody>
   </table>

</div>

<script>
$(document).ready(function() {
var userSecurityLevel = ${userSecurityLevel};

if (userSecurityLevel > 5) {
        $('.edit-btn').prop('disabled', true).css('opacity', '0.5').css('cursor', 'not-allowed');
    }
$('#personalAtndDataTable').on('click', '.edit-btn', function() {
        if (userSecurityLevel <= 5) { // Only allow edit operations if security level is 4 or lower
            var row = $(this).closest('tr');
            row.find('td').each(function(index) {
                if (index === 9 || index === 10) { // Target "Start Time" and "End Time"
                    var initialContent = $(this).text();
                    // Convert 24-hour time to 12-hour format with AM/PM before initializing the input
                    var formattedTime = moment(initialContent, 'HH:mm').format('hh:mm A');
                    $(this).html('<input type="text" class="md-timepicker" value="' + formattedTime + '" data-initial-content="' + initialContent + '">');
                }
            });

            row.find('.edit-btn').hide();
            row.find('.save-btn, .cancel-btn').show();

            // Initialize MDTimePicker for new input fields
            $('.md-timepicker').mdtimepicker({
                timeFormat: 'hh:mm:ss.000',
                format: 'h:mm tt', // This is correct for showing AM/PM
                theme: 'blue',
                readOnly: true,
                hourPadding: false
            });
        }
    });
   
// Cancel button click handler
   $('#personalAtndDataTable').on('click', '.cancel-btn', function() {
       var row = $(this).closest('tr');
       row.find('.md-timepicker').each(function() {
           var initialContent = $(this).data('initial-content'); // Get the initial content from data attribute
           var td = $(this).closest('td');
           td.text(initialContent); // Revert the edited content back to the original text
       });

       row.find('.edit-btn').show();
       row.find('.save-btn, .cancel-btn').hide();
   });


   $('td[data-fieldname="overTime"]').each(function() {
       var overtimeDouble = $(this).text();
       var overtimeColon = convertToColonFormatForDisplay(overtimeDouble);
       $(this).text(overtimeColon);
   });
   
   
 

   // Save button click handler
// Save button click handler
   $('#personalAtndDataTable').on('click', '.save-btn', function() {
   var row = $(this).closest('tr');
   var startTimeInput = row.find('td:nth-child(10) .md-timepicker');
   var endTimeInput = row.find('td:nth-child(11) .md-timepicker');
   
   // Assuming the input from the time picker is in 12-hour format with AM/PM
   // Parse the time correctly using 'hh:mm A' format
   var startTime = moment(startTimeInput.val(), 'hh:mm A');
   var endTime = moment(endTimeInput.val(), 'hh:mm A');
   
   var overtimeColon = row.find('td[data-fieldname="overTime"]').text(); // Get the displayed value
   var overtimeDouble = convertToServerFormat(overtimeColon); // Convert back to server format

   
   
    // append converted value

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
           
      formData.append('empId', row.find('td:nth-child(1)').text());      
      formData.append('startTime', startTime);
      formData.append('endTime', endTime);
      formData.append('atndNo', row.find('td:nth-child(24)').text().trim());      
      var timeSettingText = row.find('td:nth-child(8)').text().trim();
      formData.append('timeSetting', timeSettingText);
      formData.append('overTime', overtimeDouble);
           // Add more properties as needed
     
         formData.forEach(function(value, key) {
   console.log(key + ', ' + value);
});
           // Send AJAX request to your server
           $.ajax({
               url: 'updatePersonalAttendanceData.do',
               type: 'POST',
               processData: false, // Important for FormData
               contentType: false, // Important for FormData
               data: formData,
               
               success: function(response) {
                alert("Attendance details updated successfully");
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
   
   function convertToColonFormatForDisplay(overtimeDouble) {
       // Format overtimeDouble as per your requirement
       var formattedData = parseFloat(overtimeDouble).toFixed(2).replace('.', ':');
       return formattedData;
   }

   function convertToServerFormat(overtimeColon) {
       var parts = overtimeColon.split(':');
       var hours = parseInt(parts[0], 10);
       var minutes = parseInt(parts[1], 10);
       return hours + '.' + (minutes < 10 ? '0' : '') + minutes;
   }
   
});
</script>

<script>

//Global variable for the DataTable instance
var dataTableInstance;
//Global variable to store initial data
var initialData = {};

$(document).ready(function() {
   // Initialize DataTable
   var dataTableInstance = $('#personalAtndDataTable').DataTable({
  "pagingType": "full_numbers",
       "searching": true,
       "scrollX": true,
       
       dom: '<"top"Blr>t<"bottom"ip><"clear">',
       "columnDefs": [{
           "targets": [21,13], // Adjust the index for the Over Time column if needed
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
   });
   
   $('.overtimeDetailsButton').on('click', function() {
       var empId = $(this).data('empid'); // Fetches the empId from the button
       window.location.href = "overTime.do?empId=" + empId; // Redirects to the over time details page for this empId
   });
   
   window.onpageshow = function(event) {
       if (event.persisted) {
           window.location.reload();
       }
   };
 
  // Move the buttons to the top section
  $('.top').append($('.buttons'));
 
 
    // Initialize the date pickers with restrictions and auto-filter functionality
    $('#startDatePicker').datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(selectedDate) {
            // Set the minDate of endDatePicker when a date is selected in startDatePicker
            $('#endDatePicker').datepicker('option', 'minDate', selectedDate);
        },
        onClose: function() {
            // Check if the startDatePicker field is cleared
            if (!$(this).val()) {
                // Remove the minDate restriction from endDatePicker
                $('#endDatePicker').datepicker('option', 'minDate', null);
                dataTableInstance.draw(); // Redraw the DataTable if the start date is cleared
            }
        }
    });

    $('#endDatePicker').datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(selectedDate) {
            // Set the maxDate of startDatePicker when a date is selected in endDatePicker
            $('#startDatePicker').datepicker('option', 'maxDate', selectedDate);
            dataTableInstance.draw(); // Auto-filter the table upon selecting the end date
        },
        onClose: function() {
            // Check if the endDatePicker field is cleared
            if (!$(this).val()) {
                // Remove the maxDate restriction from startDatePicker
                $('#startDatePicker').datepicker('option', 'maxDate', null);
                dataTableInstance.draw(); // Redraw the DataTable if the end date is cleared
            }
        }
    });
   
 // Event handlers for Work Type and Access Type search boxes
    $('#workTypeSearchBox, #accessTypeSearchBox').on('keyup change', function() {
        dataTableInstance.draw(); // Redraw the table upon typing or changing values in the input fields
    });

    // Custom filter for Time Setting, Work Type, and Access Type
    $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
        var startDate = $('#startDatePicker').datepicker("getDate");
        var endDate = $('#endDatePicker').datepicker("getDate");
        var workType = $('#workTypeSearchBox').val().toLowerCase();
        var accessType = $('#accessTypeSearchBox').val().toLowerCase();
        var timeSettingStr = data[7];
        var timeSetting = parseDate(timeSettingStr);
        var dataWorkType = data[11].toLowerCase();
        var dataAccessType = data[12].toLowerCase();

        if (((startDate === null && endDate === null) ||
             (startDate === null && timeSetting <= endDate) ||
             (endDate === null && timeSetting >= startDate) ||
             (timeSetting >= startDate && timeSetting <= endDate)) &&
            (!workType || dataWorkType.includes(workType)) &&
            (!accessType || dataAccessType.includes(accessType))) {
            return true;
        }
        return false;
    });


    function parseDate(dateStr) {
        if (!dateStr) return null;
        var parts = dateStr.split(" ");
        var dateParts = parts[0].split("-");
        var timeParts = parts[1].split(":");
     // For yyyy-mm-dd HH:mm:ss
        return new Date(dateParts[0], dateParts[1] - 1, dateParts[2], timeParts[0], timeParts[1], timeParts[2]);
    }


   
});




</script>

<script>
$('#downloadAttendanceExcel').on('click', function(e) {
    e.preventDefault();

    var menuName = "Personal Attendance";
    var fileName = "PersonalAttendanceList.xlsx";

    // AJAX call to save download history (optional)
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do',
        type: 'POST',
        data: { menuName: menuName, fileName: fileName },
        success: function(response) {
            // On success, generate and download the Excel file
            var workbook = XLSX.utils.table_to_book(document.getElementById('personalAtndDataTable'), {sheet: "Sheet1"});
            XLSX.writeFile(workbook, fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});



$('#downloadAttendancePdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "Personal Attendance";
    var fileName = "PersonalAttendanceList.pdf";

    // AJAX call to save download history (optional)
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do',
        type: 'POST',
        data: { menuName: menuName, fileName: fileName },
        success: function(response) {
            // On success, generate and download the PDF
            var tableData = [];
            $('#personalAtndDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#personalAtndDataTable tbody tr').each(function() {
                var rowData = [];
                $(this).find('td').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });

            var docDefinition = {
            pageOrientation: 'landscape',
                content: [{
                    table: {
                        body: tableData
                    }
                }],
                styles: {
                    tableHeader: {
                        bold: true,
                        fontSize: 7,
                        color: 'black'
                    }
                },
                defaultStyle: {
                    fontSize: 5
                }
            };

            pdfMake.createPdf(docDefinition).download(fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});

</script>