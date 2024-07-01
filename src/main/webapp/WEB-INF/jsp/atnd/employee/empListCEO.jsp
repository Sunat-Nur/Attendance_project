<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

    <title>Employee List For CEO</title>
 <head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
 	<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>

<style>
	/* Additional styles for form elements within DataTables */
	.pageContent .employeeTable input, .pageContent .employeeTable select {
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
       
	 /* Table Styles */
	.employeeTable #employeeDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	}
	
	.employeeTable #employeeDataTable th, .employeeTable #employeeDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.employeeTable #employeeDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}
	
	.employeeTable #employeeDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
       
	 /* Custom styles for table row */
	.employeeTable #employeeDataTable tr.custom-row-style td {
	   background-color: #e6e6e6; /* Your desired background color */
	   color: black; /* Your desired text color */
	}
	
	.employeeTable #employeeDataTable tr:nth-child(even).custom-row-style td {
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
    
    <center><h4>EMPLOYEE LIST</h4></center>
   
    <div class="download-links buttons">
       
   		<!-- Excel Download Button -->
   		<button id="downloadExcel" style="text-decoration: none; margin-right: 10px; color: green; background: none; border: none; cursor: pointer;">
       		<i class="fas fa-file-excel"></i> Excel
   		</button>
   
   		<!-- Pdf Download Button -->
   		<button id="downloadPdf" style="text-decoration: none; color: red; background: none; border: none; cursor: pointer;">
       		<i class="fas fa-file-pdf"></i> PDF
   		</button>
   	</div>
   
	<div class="container employeeTable">
   		<table id="employeeDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
       		<thead>
       			<tr>
	                <th>Emp ID</th>
	                <th>Date of Joining</th>
	                <th>Security Level</th>
	                <th>Name</th>
	                <th>Group</th>
	                <th>Department</th>
	                <th>Designation</th>
	                <th>Year</th>
	                <th>Career</th>
	                <th>Gender</th>
	                <th>Final Degree</th>
	                <th>Address</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="user" items="${users}">
            		<c:if test="${user.securityLevel >= loggedInUser.securityLevel}">
	                	<tr>
		                    <td>${user.empId}</td>
		                    <td><fmt:formatDate value="${user.dateOfJoining}" pattern="yyyy-MM-dd" /></td>
		                    <td>${user.securityLevel}</td>
		                    <td><a href="employeeDetails.do?empId=${user.empId}" style="color: blue;">${user.name}</a></td>
		                    <td>${user.group}</td>
		                    <td>${user.department}</td>
		                    <td>${user.designation}</td>
	                        <td>${user.yearOfWorking}</td>
		                    <td>${user.careerExperience}</td>
		                    <td>${user.gender}</td>
		                    <td>${user.finalDegree}</td>
		                    <td>${user.address}</td>
	                	</tr>
                	</c:if>
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
    dataTableInstance = $('#employeeDataTable').DataTable({
        "pagingType": "full_numbers",
        "searching": true,
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        }
    });

    // Move the buttons to the top section
    $('.top').append($('.buttons'));

    // Custom search functionality for "User Name"
    $('#userNameSearchBox').on('keyup change', function() {
        // Search in the "User Name" column
        dataTableInstance.columns(3).search(this.value).draw();
    });

    $('#userDepartmentSearchBox').on('keyup change', function() {
        // Search in the "Department Name" column
        dataTableInstance.columns(5).search(this.value).draw();
    });

   
    $('#userDesignationSearchBox').on('keyup change', function() {
        // Search in the "Designation Name" column
        dataTableInstance.columns(6).search(this.value).draw();
    });
   

});

</script>
<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "EmployeeListForCEO";
    var fileName = "EmployeeListForCEO.pdf";

    // AJAX call to save download history
    $.ajax({
        url:  '/webProject/syst/hist/downloadHist/saveDownloadHistory.do', // URL of your endpoint
        type: 'POST',
        data: {
            menuName: menuName,
            fileName: fileName
        },
        success: function(response) {
            // On success, generate and download the PDF
            var tableData = [];
            $('#employeeDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#employeeDataTable tbody tr').each(function() {
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

    var menuName = "EmployeeListForCEO";
    var fileName = "EmployeeListForCEO.xlsx";

    // AJAX call to save download history
    $.ajax({
        url:  '/webProject/syst/hist/downloadHist/saveDownloadHistory.do', // URL of your endpoint
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

            downloadExcel('employeeDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>