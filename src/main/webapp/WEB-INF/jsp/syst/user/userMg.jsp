<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

    <title>User List</title>
  <head>
      	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    	<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
   		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
   		<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
	/* Additional styles for form elements within DataTables */
	.pageContent .dataTable input, .pageContent .dataTable select {
	    padding: 0.1em;
	    margin: 0;
	    display: inline-block;
	    border-radius: 4px;
	}
 
	.pageContent .dataTable td {
	    vertical-align: middle; /* Align content in the middle vertically */
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
	
	/* Button Styles */
	#pageContent button {
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
     
     #pageContent .viewButton {
	    padding: 3px 6px; /* Smaller padding */
	    font-size: 10px; /* Smaller font size */
	    border-radius: 3px; /* Smaller border-radius */
	}
 
	/* Table Styles */
	.userTable #userDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	}

	.userTable #userDataTable th, .userTable #userDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

  	.userTable #userDataTable tr:nth-child(even) {
      	background-color: #e6e6e6;
  	}

  	.userTable #userDataTable th {
      	background-color: #a6a6a6;
      	color: black;
  	}
       
        /* Custom styles for table row */
 	.userTable #userDataTable tr.custom-row-style td {
		background-color: #e6e6e6; /* Your desired background color */
   		color: black; /* Your desired text color */
	}

	.userTable #userDataTable tr:nth-child(even).custom-row-style td {
   		background-color: #fff; /* Color for even rows if different */
	}

	.bottom {
   		display: flex;
   		justify-content: space-between;
   		align-items: center;
	}

	.top {
   		display: flex;
   		justify-content: space-between;
   		align-items: center;
   		margin-bottom: 10px;
	}
   
</style>
</head>
 
<div id="pageContent">
   	<div class="searchBar">
      	<span>Name:</span>
   		<input type="text" id="userNameSearchBox" placeholder="Search by Name">
 
   		<span style="margin-left: 10px;">Department:</span>
   		<input type="text" id="userDepartmentSearchBox" placeholder="Search by Department">
   
   		<span style="margin-left: 10px;">Designation:</span>
   		<input type="text" id="userDesignationSearchBox" placeholder="Search by Designation">
   	</div>
   
   
   
   	<div class="download-links buttons">
		<!-- Excel Download Button -->
		<button id="downloadExcel" style="text-decoration: none; margin-right: 10px; color: green; background: none; border: none; cursor: pointer;">
   			<i class="fas fa-file-excel"></i> Excel
		</button>
   
		<!-- Pdf Download Button -->
		<button id="downloadPdf" style="text-decoration: none; margin-right: 10px; color: red; background: none; border: none; cursor: pointer;">
			<i class="fas fa-file-pdf"></i> PDF
		</button>
			
		<button id="addButton">Add User</button>
	</div>
   
	<div class="container userTable">
   		<table id="userDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
       		<thead>
       			<tr>
            		<th>Emp ID</th>
	                <th>Name</th>
	                <th>Group</th>
	                <th>Department</th>
	                <th>Designation</th>
	                <th>Date of Joining</th>
	                <th>Cell Phone</th>
	                <th>Email</th>
	                <th>Year</th>
	                <th>Career</th>
	                <th>Gender</th>
	                <th>Final Degree</th>
	                <th>Action</th>
     			</tr>
       		</thead>
       		<tbody>
     			<c:forEach var="user" items="${users}">
                	<tr>
	                    <td>${user.empId}</td>
	                    <td>${user.name}</td>
	                    <td>${user.group}</td>
	                    <td>${user.department}</td>
	                    <td>${user.designation}</td>
	                    <td><fmt:formatDate value="${user.dateOfJoining}" pattern="yyyy-MM-dd" /></td>
	                    <td>${user.cellPhone}</td>
	                    <td>${user.email}</td>
	                    <td>${user.yearOfWorking}</td>
	                    <td>${user.careerExperience}</td>
	                    <td>${user.gender}</td>
	                    <td>${user.finalDegree}</td>
	                    <td>
                        	<button type="button" class="viewButton" onclick="viewUserDetails('${user.empId}')">View</button>
                    	</td>
                	</tr>
    			</c:forEach>
			</tbody>
   		</table>
	</div>
</div>

<script>

//Global variable for the DataTable instance
var dataTableInstance;
//Global variable to store initial data
var initialData = {};

$(document).ready(function() {
    // Initialize DataTable
    dataTableInstance = $('#userDataTable').DataTable({
        "pagingType": "full_numbers",
        "searching": true,
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        },
        "columnDefs": [{
            "targets": 6, // Assuming the Cell Phone column is the 7th column (index 6)
            "render": function(data, type, row) {
                if (type === 'display' && data) {
                    var parts = data.split(' ');
                    var countryCode = parts[0];
                    var phoneNumber = parts[1];
                    
                    // Reverse phone number
                    phoneNumber = phoneNumber.split('').reverse().join('');
                    
                 	// Add dash after every group of five digits except for the last group
                    phoneNumber = phoneNumber.replace(/(.{5})(?!$)/g, '$1-');
                    
                    // Reverse phone number again
                    phoneNumber = phoneNumber.split('').reverse().join('');
                    
                    // Concatenate country code and formatted phone number
                    var formattedNumber = countryCode + '-' + phoneNumber;
                    return formattedNumber;
                }
                return data;
            }
        }]
    });

    
    
    
    
    // Move the buttons to the top section
    $('.top').append($('.buttons'));

    // Custom search functionality for "User Name"
    $('#userNameSearchBox').on('keyup change', function() {
        // Search in the "User Name" column
        dataTableInstance.columns(1).search(this.value).draw();
    });

    $('#userDepartmentSearchBox').on('keyup change', function() {
        // Search in the "Department Name" column
        dataTableInstance.columns(3).search(this.value).draw();
    });

   
    $('#userDesignationSearchBox').on('keyup change', function() {
        // Search in the "Designation Name" column
        dataTableInstance.columns(4).search(this.value).draw();
    });

   
   
    // Add User button click event
    $('#addButton').on('click', function() {
        // Redirect to the page for adding a new user
        window.location.href = 'addUser.do'; // Adjust the URL as needed
    });

    // View button click event
    $('#userDataTable tbody').on('click', 'button.viewButton', function() {
        // Get the data associated with the clicked row
        var data = dataTableInstance.row($(this).closest('tr')).data();

        // Extract the empId from the data (assuming it's in the first column)
        var empId = data[0]; // Adjust the index if empId is in a different column

        // Redirect to the user details page with the empId parameter
        var url = 'userDetails.do?empId=' + encodeURIComponent(empId);
        window.location.href = url; // Navigate to user details page
    });
});


</script>

<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "UserList";
    var fileName = "UserList.pdf";

    // AJAX call to save download history
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do', // URL of your endpoint
        type: 'POST',
        data: {
            menuName: menuName,
            fileName: fileName
        },
        success: function(response) {
            // On success, generate and download the PDF
            var tableData = [];
            $('#userDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#userDataTable tbody tr').each(function() {
                var rowData = [];
                $(this).find('td').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });

            var docDefinition = {
                content: [{
                    table: {
                        body: tableData
                    }
                }],
                styles: {
                    tableHeader: {
                        bold: true,
                        fontSize: 13,
                        color: 'black'
                    }
                },
                defaultStyle: {
                    fontSize: 10
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

<script>
$('#downloadExcel').on('click', function(e) {
    e.preventDefault();

    var menuName = "UserList";
    var fileName = "UserList.xlsx";

    // AJAX call to save download history
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do', // URL of your endpoint
        type: 'POST',
        data: {
            menuName: menuName,
            fileName: fileName
        },
        success: function(response) {
            // On success, generate and download the Excel file
            function downloadExcel(tableId, fileName) {
                var workbook = XLSX.utils.table_to_book(document.getElementById(tableId), {sheet: "Sheet1"});
                XLSX.writeFile(workbook, fileName);
            }

            downloadExcel('userDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>