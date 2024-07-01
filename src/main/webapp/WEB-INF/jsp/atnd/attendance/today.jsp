<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <title>Today's Attendance List</title>
    <style>
    div#todayAttendanceTable_wrapper {
   margin-top: 25px;
}
 
      /* Apply border to table headers and cells */
       .todayAttendanceTableList th, .todayAttendanceTableList td {
           text-align: center;
    padding: 0;
    border: 1px solid grey; /* Add border to th and td */
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 12px;
   }
      
       .todayAttendanceTableList th{
       background-color: #a6a6a6;
    color: black;
    width: 100%;
      
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
     
	
	
	
	input[type="time"] {
	       border-radius: 4px; /* Rounded borders */
	       padding: 2px 5px; /* Padding inside the inputs */
	       margin: 0 10px 0 0; /* Margin for spacing */
	       background-color:; /* Light background color */
	       font-size: 14px; /* Increased font size for better readability */
	   }
	
	   input[type="time"]:hover {
	       background-color: #e9ecef; /* Slightly darker background on hover */
	   }
	
	   input[type="time"]:focus {
	       outline: none; /* Remove the default focus outline */
	       box-shadow: 0 0 0 0.1rem rgba(0,123,255,.25); /* Custom focus shadow to match the border color */
	   }
         
    </style>
</head>
<body>

<div id="pageContent">
<div class="searchBar">
    <span style="margin-right: 10px;">Start Time Range:</span>
    <div style="position: relative; display: inline-block; margin-right: 10px;">
        <input type="time" id="startTimePicker" class="timePickerInputFielstyle" style="padding-right: 30px; font-size: 12px;">
    </div>
    <div style="position: relative; display: inline-block;">
        <input type="time" id="endTimePicker"  class="timePickerInputFielstyle" style="padding-right: 30px; font-size: 12px;">
    </div>
</div>
<center><h4>TODAY ATTENDANCE LIST</h4></center>
<table id="todayAttendanceTable"  class="todayAttendanceTableList">
<thead>
    <tr>
        <th>Emp ID</th>      
        <th>Name</th>      
        <th>Group</th>      
        <th>Department</th>      
        <th>Time Setting</th>
        <th>GPS Information</th>
        <th>Start Time</th>
        <th>End Time</th>
        <th>Lateness</th>
        <th>Late</th>
        <th>Over Time</th>
        <th>Work Type</th>
        <th>Work Hour</th>
        <th>Outside Work</th>
        <th>Business Trip</th>
        <th>Training</th>
        <th>Access Type</th>
        <th>IP Address</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="attendance" items="${todayAttendanceList}">
        <tr>
            <td>${attendance.empId}</td>
            <td>${loggedInUser.name}</td>
            <td>${loggedInUser.group}</td>
            <td>${loggedInUser.department}</td>
            <td><fmt:formatDate value="${attendance.timeSetting}" pattern="HH:mm"/></td>
            <td><a href="https://www.google.com/maps/search/?api=1&query=${attendance.gpsInformation}" target="_blank">${attendance.gpsInformation}</a></td>
            <td><fmt:formatDate value="${attendance.startTime}" pattern="HH:mm"/></td>
            <td><fmt:formatDate value="${attendance.endTime}" pattern="HH:mm"/></td>
            <td>${attendance.lateness}</td>
           
            <td>${attendance.late}</td>
           
            <td>${attendance.overTime}</td>
            <td>${attendance.workType}</td>
           
            <td>${attendance.workHour}</td>
            <td>${attendance.outsideWork}</td>
            <td>${attendance.businessTrip}</td>
            <td>${attendance.training}</td>
            <td>${attendance.accessType}</td>
            <td>${attendance.ipAddress}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

<script>

var datatable

$(document).ready(function() {
    var datatable = $('#todayAttendanceTable').DataTable({
    pagingType: "full_numbers",
        searching: true,
        scrollX : true,
        autoWidth: true,
       
        // Enables the search box
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "columnDefs": [{
                "targets": [9, 10, 12], // Adjust the index for the Over Time column if needed
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
   
    $(window).resize(function() {
        datatable.columns.adjust().draw(); // Adjust column sizing and redraw the table
    });

   
    $('#startTimePicker, #endTimePicker').on('change', function() {
        datatable.draw();
    });

    $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
        var startTimeInput = $('#startTimePicker').val();
        var endTimeInput = $('#endTimePicker').val();
        var rowStartTime = moment(data[3], "yyyy-MM-dd HH:mm:ss").format("HH:mm");
        var startTime = startTimeInput ? moment(startTimeInput, "HH:mm") : null;
        var endTime = endTimeInput ? moment(endTimeInput, "HH:mm") : null;
        var rowTime = moment(rowStartTime, "HH:mm");

        if (!startTime && !endTime) {
            return true;
        } else if (startTime && !endTime && rowTime.isSameOrAfter(startTime)) {
            return true;
        } else if (!startTime && endTime && rowTime.isSameOrBefore(endTime)) {
            return true;
        } else if (startTime && endTime && rowTime.isBetween(startTime, endTime, null, '[]')) {
            return true;
        }
        return false;
    });

    // Enforcing time constraints
    function adjustTimePickers() {
        var startTime = $('#startTimePicker').val();
        var endTime = $('#endTimePicker').val();

        if (startTime && endTime) {
            if (moment(startTime, "HH:mm").isAfter(moment(endTime, "HH:mm"))) {
                // Automatically adjust the end time to match the start time if it's before the start time
                $('#endTimePicker').val(startTime);
            }
        }
    }

    $('#startTimePicker').change(function() {
        adjustTimePickers();
    });

    $('#endTimePicker').change(function() {
        adjustTimePickers();
    });
});
</script>



</body>
</html>