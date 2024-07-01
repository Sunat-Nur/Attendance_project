<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance List</title>
   
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">  
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/vfs_fonts.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">	
   
   
<style>


.dropbtn {
 background-color: #0080ff;
 color: white;
 padding: 5px;
 font-size: 10px;
 border: thick;
 cursor: pointer;
 justify-content: flex-end;
 border-radius: 2px;
 
}

/* The container <div> - needed to position the dropdown content */
.dropdown {

 display: inline-block;
 text-align: center;
  margin-left: 10px; /* Adjust margin as needed */
 
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
 display: none;
 position: absolute;
 background-color: #f9f9f9;
 max-width: 350px;
 box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
 z-index: 1;
  margin-left: -200px;
 
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
display: flex;
width: 420px;
flex-wrap: wrap;
text-align: center;
 width: 33%;
}

/* Checkbox labels */
.dropdown-content label {
display: flex;
margin: 10px;
cursor: pointer;
width: 33%;

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
    justify-content: space-between; /* Align items with equal space between them */
    }
    
    .searchBar > div {
    display: flex;
    align-items: center;
}
      
	.searchBar span {
	    margin-right: 10px; /* Space between label and input */
	}
	
	.searchBar input[type="text"] {
		width: auto; /* Adjust based on your preference */
		padding: 0.2em;
		box-sizing: border-box;
		font-size: 12px;
		 margin-right: 10px; /* Add margin between input boxes */
	}

	
	
	.attendanceTable th, .attendanceTable td {
	    text-align: center;
	    padding: 0;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    font-size: 12px;
	   
	}
	
	.attendanceTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.attendanceTable th {
	    background-color: #a6a6a6;
	    color: black;
	    width: 100%;
	}
      
      /* Custom styles for table row */
	.attendanceTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	.attendanceTable tr:nth-child(even).custom-row-style td {
	    background-color: #fff; /* Color for even rows if different */
	}
	
	.download-links {
    	text-align: right; /* Align the buttons to the right side */
	}
	
	.top {
		margin-bottom: 10px;
	}
	
	.attendanceTable td.number {
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

	
</style>

</head>
<body>
<div id="pageContent">
    <div class="searchBar" style="display: flex; justify-content: space-between; align-items: center;">
        <div>
            <span style="margin-right: 10px;">Date Range:</span>
            <div style="position: relative; display: inline-block; margin-right: 10px;">
			    <input type="text" id="startDatePicker" placeholder="Select Start Date" style="padding-right: 30px;" readonly>
			    <i class="fa-solid fa-calendar-days" style="position: absolute; right: 15px; top: calc(50% - 7.5px); pointer-events: none;"></i>
			</div>
			<div style="position: relative; display: inline-block;">
			    <input type="text" id="endDatePicker" placeholder="Select End Date" style="padding-right: 30px;" readonly>
			    <i class="fa-solid fa-calendar-days" style="position: absolute; right: 15px; top: calc(50% - 7.5px); pointer-events: none;"></i>
			</div>
  
   			<span style="margin-left: 10px; margin-right: 10px;">Work Type:</span>
		    <input type="text" id="workTypeSearchBox" placeholder="Search by Work Type">
		    <span style="margin-left: 10px; margin-right: 10px;">Access Type:</span>
		    <input type="text" id="accessTypeSearchBox" placeholder="Search by Access Type">
        </div>

        <div class="button-wrapper" style="margin-left: auto;">
            <!-- Column Visibility Button -->
            <div class="dropdown">
                <button onclick="myFunction()" class="dropbtn">Column Visibility</button>
                <div id="myDropdown" class="dropdown-content">
				    <c:if test="${loggedInUser.securityLevel <= 10}">
				        <label><input type="checkbox" onchange="toggleColumn('column-emp-id')"> Emp ID</label>
				    </c:if>
				    
				    <label><input type="checkbox" onchange="toggleColumn('column-name')"> Name</label>
				    <c:if test="${loggedInUser.securityLevel <= 11}">
				        <label><input type="checkbox" onchange="toggleColumn('column-group')"> Group</label>
				    </c:if>
				    
				    <c:if test="${loggedInUser.securityLevel <= 10}">
				        <label><input type="checkbox" onchange="toggleColumn('column-department')"> Department</label>
				    </c:if>
				    
				    <label><input type="checkbox" onchange="toggleColumn('column-designation')"> Designation</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-year-of-work')"> Year of Work</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-career')"> Career</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-time-setting')"> Time Setting</label>
				    
				    <c:if test="${loggedInUser.securityLevel <= 6}">
				        <label><input type="checkbox" onchange="toggleColumn('column-gps-information')"> GPS Info</label>
				    </c:if>
				    
				    <label><input type="checkbox" onchange="toggleColumn('column-start-time')"> Start Time</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-end-time')"> End Time</label>
				    <c:if test="${loggedInUser.securityLevel <= 6}">
				    
			        <label><input type="checkbox" onchange="toggleColumn('column-work-type')"> Work Type</label>
			        <label><input type="checkbox" onchange="toggleColumn('column-access-type')"> Access Type</label>
       
       			    <label><input type="checkbox" onchange="toggleColumn('column-ip-address')"> IP Address</label>
				    </c:if>
				    <label>
				    <input type="checkbox" onchange="toggleColumn('column-late')"> Late</label>
				        <label><input type="checkbox" onchange="toggleColumn('column-lateness')"> Lateness</label>
				    <c:if test="${loggedInUser.securityLevel <= 11}">
				        <label><input type="checkbox" onchange="toggleColumn('column-outside-work')"> Outside Work</label>
				        <label><input type="checkbox" onchange="toggleColumn('column-business-trip')"> Business Trip</label>
				        <label><input type="checkbox" onchange="toggleColumn('column-training')"> Training</label>
				    </c:if>
				    <label><input type="checkbox" onchange="toggleColumn('column-overtime')"> Overtime</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-status')"> Status</label>
				    <label><input type="checkbox" onchange="toggleColumn('column-work-hour')"> Work Hour</label>
				    <c:if test="${loggedInUser.securityLevel <= 6}">
				        <label><input type="checkbox" onchange="toggleColumn('column-aew')"> AEW</label>
				    </c:if>
				    <div class="small-button">
				   		<button onclick="selectAllColumns()" id="select" >Select All</button>
						<button onclick="clearAllColumns()" id="cancel" >Clear All</button>
					</div>
				    
    			</div>
        	</div>
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
	</div>
      
  	<center><h4>ATTENDANCE LIST</h4></center>
            	<table class="attendanceTable" id="attendance-table"  >
                	<thead class="thead-dark"  >
            <tr>
               <c:if test="${loggedInUser.securityLevel <= 11}"><th class="column-emp-id">Emp ID</th></c:if>
               <th class="column-name">Name</th>
               <c:if test="${loggedInUser.securityLevel <= 11}"><th class="column-group">Group</th></c:if>
               <c:if test="${loggedInUser.securityLevel <= 10}"><th class="column-department">Department</th></c:if>
               <th class="column-designation">Designation</th>
               <th class="column-year-of-work">Year of Work</th>
               <th class="column-career">Career</th>
               <th class="column-time-setting">Time Setting</th>
               <c:if test="${loggedInUser.securityLevel <= 6}"><th class="column-gps-information">GPS Information</th></c:if>              
                    <th class="column-start-time">Start Time
                        <select class="form-control" onchange="filterTable(this, 'start-time', 'avgStartTime')">
                           <option disabled selected>Select Option</option>
                           <option value="Last 5 days AVG">Last 5 days AVG</option>
                           <option value="Weekly AVG">Weekly AVG</option>
                           <option value="Monthly AVG">Monthly AVG</option>
                           <option value="Quarterly AVG">Quarterly AVG</option>
                           <option value="Yearly AVG">Yearly AVG</option>
                        </select>
                    </th>                              
                    <th class="column-end-time">End Time
                        <select class="form-control" onchange="filterTable(this, 'end-time','avgEndTime')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days AVG">Last 5 days AVG</option>
                           <option value="Weekly AVG">Weekly AVG</option>
                           <option value="Monthly AVG">Monthly AVG</option>
                           <option value="Quarterly AVG">Quarterly AVG</option>
                           <option value="Yearly AVG">Yearly AVG</option>
                      </select>
                  </th>
               <c:if test="${loggedInUser.securityLevel <= 6}"><th class="column-work-type">Work Type</th></c:if>
               <c:if test="${loggedInUser.securityLevel <= 6}"><th class="column-access-type">Access Type</th></c:if>              
                   <th class="column-late">Late
                       <select class="form-control" onchange="filterTable(this, 'late', 'ttlLate')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                       </select>
                   </th>
                   <th class="column-lateness">Lateness
                      <select class="form-control" onchange="filterTable(this, 'lateness','ttlLateness')">
                        <option disabled selected>Select Option</option>
   <option value="Last 5 days Total">Last 5 days Total</option>
   <option value="Weekly Total">Weekly Total</option>
   <option value="Monthly Total">Monthly Total</option>
   <option value="Quarterly Total">Quarterly Total</option>
   <option value="Yearly Total">Yearly Total</option>
</select>
</th>
               <c:if test="${loggedInUser.securityLevel <= 6}"><th class="column-ip-address">IP Address</th></c:if>
               <c:if test="${loggedInUser.securityLevel <= 11}">
                   <th class="column-outside-work">Outside Work
                    <select class="form-control" onchange="filterTable(this, 'outside-work','ttlOutsideWork')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                       </select>
                   </th>
                </c:if>
                <c:if test="${loggedInUser.securityLevel <= 11}">
                    <th class="column-business-trip">Business Trip
                        <select class="form-control" onchange="filterTable(this, 'business-trip','ttlBusinessTrip')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                        </select>
                    </th>
               </c:if>
               <c:if test="${loggedInUser.securityLevel <= 11}">
                    <th class="column-training">Training
                        <select class="form-control" onchange="filterTable(this, 'training','ttlTraining')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                        </select>
                    </th>
                </c:if>              
                    <th class="column-overtime">Overtime
                        <select class="form-control" onchange="filterTable(this, 'overtime','ttlOverTime')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                        </select>
                    </th>                
                    <th class="column-status">Status
                       <select class="form-control" onchange="filterTable(this, 'status','avgStatus')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days AVG">Last 5 days AVG</option>
                           <option value="Weekly AVG">Weekly AVG</option>
                           <option value="Monthly AVG">Monthly AVG</option>
                           <option value="Quarterly AVG">Quarterly AVG</option>
                           <option value="Yearly AVG">Yearly AVG</option>
                       </select>
                   </th>                
                   <th class="column-work-hour">Work Hour
                       <select class="form-control" onchange="filterTable(this, 'work-hour','ttlWorkHour')">
                           <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                       </select>
                   </th>                
                <c:if test="${loggedInUser.securityLevel <= 6}">
                   <th class="column-aew">AEW
                       <select class="form-control" onchange="filterTable(this, 'aew','ttlAew')">
                        <option disabled selected>Select Option</option>
                           <option value="Last 5 days Total">Last 5 days Total</option>
                           <option value="Weekly Total">Weekly Total</option>
                           <option value="Monthly Total">Monthly Total</option>
                           <option value="Quarterly Total">Quarterly Total</option>
                           <option value="Yearly Total">Yearly Total</option>
                       </select>
                   </th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${attendances}" var="attendance">
        <tr>
            <td >${attendance.empId}</td>
            <td >
                <c:choose>
                 
                    <c:when test="${loggedInUser.securityLevel <= 2}">
                        <a href="personalAtnd.do?empId=${attendance.empId}">${attendance.name}</a>
                    </c:when>
                 
                    <c:when test="${loggedInUser.securityLevel <= 4}">
                        <c:choose>
                            <c:when test="${loggedInUser.group == attendance.group or loggedInUser.empId == attendance.empId}">
                                <a href="personalAtnd.do?empId=${attendance.empId}">${attendance.name}</a>
                            </c:when>
                            <c:otherwise>
                                ${attendance.name}
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                   
                    <c:when test="${loggedInUser.securityLevel == 5}">
                        <c:choose>
                            <c:when test="${loggedInUser.group == attendance.group and loggedInUser.department == attendance.department or loggedInUser.empId == attendance.empId}">
                                <a href="personalAtnd.do?empId=${attendance.empId}">${attendance.name}</a>
                            </c:when>
                            <c:otherwise>
                                ${attendance.name}
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                 
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${loggedInUser.empId == attendance.empId}">
                                <a href="personalAtnd.do?empId=${attendance.empId}">${attendance.name}</a>
                            </c:when>
                            <c:otherwise>
                                ${attendance.name}
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </td>
                   <c:if test="${loggedInUser.securityLevel <= 11}"><td>${attendance.group}</td></c:if>
                   <c:if test="${loggedInUser.securityLevel <= 10}"><td>${attendance.department}</td></c:if>
                   <td>${attendance.designation}</td>
                   <td >${attendance.yearOfWork}</td>
                   <td >${attendance.career}</td>
                   <td><fmt:formatDate value='${attendance.timeSetting}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
                   <c:if test="${loggedInUser.securityLevel <= 6}"><td><a href="https://www.google.com/maps/search/?api=1&query=${attendance.gpsInformation}" target="_blank">${attendance.gpsInformation}</a></td></c:if>
                   <td id="start-time-${attendance.empId}" >${fn:substring(attendance.startTime, 11, 16)}</td>
                   <td id="end-time-${attendance.empId}"  >${fn:substring(attendance.endTime, 11, 16)}</td>
                   <c:if test="${loggedInUser.securityLevel <= 6}"><td>${attendance.workType}</td></c:if>
                   <c:if test="${loggedInUser.securityLevel <= 6}"><td>${attendance.accessType}</td></c:if>
                   <td id="late-${attendance.empId}"  >${attendance.late}</td>
                   <td id="lateness-${attendance.empId}"  >${attendance.lateness}</td>
                   <c:if test="${loggedInUser.securityLevel <= 6}"><td ">${attendance.ipAddress}</td></c:if>
                   <c:if test="${loggedInUser.securityLevel <= 11}"><td id="outside-work-${attendance.empId}" >${attendance.outsideWork}</td></c:if>
                   <c:if test="${loggedInUser.securityLevel <= 11}"><td id="business-trip-${attendance.empId}" >${attendance.businessTrip}</td></c:if>
                   <c:if test="${loggedInUser.securityLevel <= 11}"><td id="training-${attendance.empId}" >${attendance.training}</td></c:if>
                   <td id="overtime-${attendance.empId}" >${attendance.overTime}</td>
                   <td id="status-${attendance.empId}" >${attendance.status}</td>
                   <td id="work-hour-${attendance.empId}" ">${attendance.workHour}</td>
                   <c:if test="${loggedInUser.securityLevel <= 6}"><td id="aew-${attendance.empId}" >${attendance.aew}</td></c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</div>



<script>

$(document).ready(function() {
    // Initialize the date pickers with restrictions
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
           table.draw(); // Redraw the DataTable if the start date is cleared
       }
   }
});

$('#endDatePicker').datepicker({
   dateFormat: 'yy-mm-dd',
   onSelect: function(selectedDate) {
       // Set the maxDate of startDatePicker when a date is selected in endDatePicker
       $('#startDatePicker').datepicker('option', 'maxDate', selectedDate);
       table.draw(); // Auto-filter the table upon selecting the end date
   },
   onClose: function() {
       // Check if the endDatePicker field is cleared
       if (!$(this).val()) {
           // Remove the maxDate restriction from startDatePicker
           $('#startDatePicker').datepicker('option', 'maxDate', null);
           table.draw(); // Redraw the DataTable if the end date is cleared
       }
   }
});


    // Initialize the DataTable
   var table = $('#attendance-table').DataTable({
    pagingType: "full_numbers",
    searching: true,
    scrollX: true,
   
    dom: '<"top"Blr>t<"bottom"ip><"clear">',
   
   
   

});
   
   
   columnDefs1: [
   { targets: [2,3,4,5,6,8,15,16,17], visible: false },
       { orderable: false, targets: [8,9,10,11,12,13,14,15,16,17, 18, 19, 20, 21, 22] },
       {
           "targets": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22], // Adjust the index for the Over Time column if needed
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

   $('input[type="checkbox"][onchange*="column-group"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-department"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-designation"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-year-of-work"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-career"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-gps-information"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-ip-address"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-outside-work"]').prop('checked', false);
   $('input[type="checkbox"][onchange*="column-business-trip"]').prop('checked', false);
   
   $(window).resize(function() {
   table.columns.adjust().draw(); // Adjust column sizing and redraw the table
});
   
   updateCheckboxStates();
   function updateCheckboxStates() {
       $('input[type="checkbox"][onchange*="toggleColumn"]').each(function() {
           // Extract the column class from the checkbox's onchange attribute
           var columnClass = $(this).attr('onchange').match(/'([^']+)'/)[1];
           // Check if the column is currently visible
           var isVisible = table.column('.' + columnClass).visible();
           // Set the checkbox state to match the column visibility
           $(this).prop('checked', isVisible);
       });
   }

   // Event listener to update checkboxes when columns are shown/hidden
   $('input[type="checkbox"][onchange*="toggleColumn"]').on('change', function() {
       // Wait for the column visibility toggle to complete
       setTimeout(updateCheckboxStates, 0);
   });
    // Move the buttons to the top section
    $('.top').append($('.buttons'));

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

    // Filter button click event for date range
    $('#dateFilterBtn').click(function() {
        var startDate = $('#startDatePicker').val();
        var endDate = $('#endDatePicker').val();
       
        if (startDate && endDate) {
            table.draw();
        } else {
            alert('Please select both start and end dates.');
        }
    });

    // Event handlers for Work Type and Access Type search boxes
    $('#workTypeSearchBox, #accessTypeSearchBox').on('keyup change', function() {
        table.draw();
    });


    // Filter button click event for date range
    $('#dateFilterBtn').click(function() {
        var startDate = $('#startDatePicker').val();
        var endDate = $('#endDatePicker').val();
       
        if (startDate && endDate) {
            table.draw();
        } else {
            alert('Please select both start and end dates.');
        }
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

function filterTable(dropdown, column, dataField) {
    var value = dropdown.value;
    console.log("Filtering table for column:", column, "with value:", value);

    $.ajax({
        url: 'filterData.do',
        type: 'GET',
        data: { column: column, value: value },
        success: function(response) {
            console.log("Response received:", response);
           
           
            resetColumn(column);
           
           
            updateColumn(column, response, dataField);
           
            if (column === 'start-time') {
                updateStartTimeColumn(response);
            }
            if (column === 'end-time') {
                updateEndTimeColumn(response);
            }            
           
            if (column === 'late') {
                updateLateColumn(response);
            }
         
            if (column === 'work-hour') {
                updateWorkHourColumn(response);
            }
         
            if (column === 'lateness') {
                updateLatenessColumn(response);
            }
           
            if (column === 'outside-work') {
                updateOutsideWorkColumn(response);
            }
           
            if (column === 'business-trip') {
                updateBusinessTripColumn(response);
            }
           
            if (column === 'training') {
                updateTrainingColumn(response);
            }
           
            if (column === 'overtime') {
                updateOvertimeColumn(response);
            }
           
            if (column === 'status') {
                updateStatusColumn(response);
            }
           
            if (column === 'aew') {
                updateAEWColumn(response);
            }
           

        },
        error: function(xhr, status, error) {
            console.error("An error occurred:", error);
        }
    });
}

function resetColumn(column) {
    var columnId = column.replace(/([A-Z])/g, '-$1').toLowerCase();
    $('td[id^="' + columnId + '-"]').text('N/A');
}


function updateColumn(column, response, dataField) {
    console.log('Updating column:', column, 'with data:', response);

   
    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#' + column + '-' + empId;
        var fieldValue = row[dataField];

        console.log('Updating selector:', selector, 'with field value:', fieldValue);

       
        if (typeof fieldValue !== 'undefined') {
            updateTableCell(selector, fieldValue);
        } else {
            console.error('Field value is undefined for selector:', selector);
        }
    });
}

function updateTableCell(selector, fieldValue) {
 
    if ($(selector).length > 0) {
     
        $(selector).text(fieldValue);
    } else {
        console.error('Element not found for selector:', selector);
    }
}

function updateStartTimeColumn(response) {
    console.log('Updating Start Time column with data:', response);


    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#start-time-' + empId;
        var fieldValue = row.startTime;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        updateTableCell(selector, fieldValue);
    });
}

function updateEndTimeColumn(response) {
    console.log('Updating End Time column with data:', response);

 
    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#end-time-' + empId;
        var fieldValue = row.endTime;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        updateTableCell(selector, fieldValue);
    });
}

function updateWorkHourColumn(response) {
    console.log('Updating Work Hour column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#work-hour-' + empId;
        var fieldValue = row.ttlWorkHour;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null) {
            // Format fieldValue as per your requirement
            var formattedData = parseFloat(fieldValue).toFixed(2).replace('.', ':');
            updateTableCell(selector, formattedData);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}

function updateLateColumn(response) {
    console.log('Updating Late column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#late-' + empId;
        var fieldValue = row.ttlLate;

        console.log('Updating selector:', selector, 'with empId:', empId, 'and field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null) {
            // Format fieldValue as per your requirement
            var formattedData = parseFloat(fieldValue).toFixed(2).replace('.', ':');
            updateTableCell(selector, formattedData);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}


function updateLatenessColumn(response) {
    console.log('Updating Lateness column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#lateness-' + empId;
        var fieldValue = row.ttlLateness;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
    } else {
        updateTableCell(selector, 'N/A');
    }
    });
}

function updateOutsideWorkColumn(response) {
    console.log('Updating Outside Work column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#outside-work-' + empId;
        var fieldValue = row.ttlOutsideWork;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}

function updateBusinessTripColumn(response) {
    console.log('Updating Business Trip column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#business-trip-' + empId;
        var fieldValue = row.ttlBusinessTrip;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}

function updateTrainingColumn(response) {
    console.log('Updating Training column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#training-' + empId;
        var fieldValue = row.ttlTraining;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
    } else {
        updateTableCell(selector, 'N/A');
    }
    });
}

function updateOvertimeColumn(response) {
    console.log('Updating Overtime column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#overtime-' + empId;
        var fieldValue = row.ttlOverTime;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0) {
            // Format fieldValue as per your requirement
            var formattedData = parseFloat(fieldValue).toFixed(2).replace('.', ':');
            updateTableCell(selector, formattedData);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}


function updateStatusColumn(response) {
    console.log('Updating Status column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#status-' + empId;
        var fieldValue = row.avgStatus;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
    } else {
        updateTableCell(selector, 'N/A');
    }
    });
}

function updateAEWColumn(response) {
    console.log('Updating AEW column with data:', response);

    $.each(response, function(i, row) {
        var empId = row.empId;
        var selector = '#aew-' + empId;
        var fieldValue = row.ttlAew;

        console.log('Updating selector:', selector, 'with field value:', fieldValue);
        if (typeof fieldValue !== 'undefined' && fieldValue !== null && fieldValue !== 0){
        updateTableCell(selector, fieldValue);
        } else {
            updateTableCell(selector, 'N/A');
        }
    });
}
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
  }

  window.onclick = function(event) {
    if (!event.target.matches('.dropbtn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      for (var i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }

  function toggleColumn(columnClass) {
   var table = $('#attendance-table').DataTable();
   // Directly use the class selector without :visible to get the column.
   var column = table.column('.' + columnClass);

   if (column) {
       // Toggle the visibility
       column.visible(!column.visible());
   } else {
       console.error('Column with class ' + columnClass + ' not found');
   }
}

  function selectAllColumns() {
   var table = $('#attendance-table').DataTable();
   table.columns().visible(true);
   // Select all checkboxes
   $('input[type="checkbox"][onchange*="toggleColumn"]').prop('checked', true);
}

function clearAllColumns() {
   var table = $('#attendance-table').DataTable();
   table.columns().visible(false);
   // Unselect all checkboxes
   $('input[type="checkbox"][onchange*="toggleColumn"]').prop('checked', false);
}


</script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<script>
$('#downloadAttendanceExcel').on('click', function(e) {
    e.preventDefault();

    var menuName = "AttendanceList";
    var fileName = "AttendanceList.xlsx";

    // AJAX call to save download history (optional)
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do',
        type: 'POST',
        data: { menuName: menuName, fileName: fileName },
        success: function(response) {
            // On success, generate and download the Excel file
            var workbook = XLSX.utils.table_to_book(document.getElementById('attendance-table'), {sheet: "Sheet1"});
            XLSX.writeFile(workbook, fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});



$('#downloadAttendancePdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "AttendanceList";
    var fileName = "AttendanceList.pdf";

    // AJAX call to save download history (optional)
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do',
        type: 'POST',
        data: { menuName: menuName, fileName: fileName },
        success: function(response) {
            // On success, generate and download the PDF
            var tableData = [];
            $('#attendance-table thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#attendance-table tbody tr').each(function() {
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
                        fontSize: 8,
                        color: 'black'
                    }
                },
                defaultStyle: {
                    fontSize: 6
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

</body>
</html>