<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>


    <title>Login History</title>
<head> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
	<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<style>
	/* Additional styles for form elements within DataTables */
	.pageContent .loginTable input, .pageContent .loginTable select {
	    padding: 0.1em;
	    margin: 0;
	    display: inline-block;
	    border-radius: 4px;
	}
	
	.pageContent .loginTable td {
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
	 .loginTable #myLogHistDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	 }

	.loginTable #myLogHistDataTable th, .loginTable #myLogHistDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.loginTable #myLogHistDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.loginTable #myLogHistDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
        
	 /* Custom styles for table row */
	.loginTable #myLogHistDataTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	.loginTable #myLogHistDataTable tr:nth-child(even).custom-row-style td {
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
	  	<span>History Date Range:</span>
    	
    	<div class="datepicker-wrapper" style="display: inline-block; position: relative;">
    		<i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: 5px;"></i>
    		<input type="text" id="historyStartDateSearchBox" placeholder="Start Date" class="datepicker" style="padding-right: 20px;">
    	</div>
    	
    	<div class="datepicker-wrapper" style="display: inline-block; position: relative; margin-left: 10px;">
    		<i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: 5px;"></i>
    		<input type="text" id="historyEndDateSearchBox" placeholder="End Date" class="datepicker" style="padding-right: 20px;">
    	</div>
	
		<span style="margin-left: 10px;">Name:</span>
		<input type="text" id="historyNameSearchBox" placeholder="Search by Name">
		
		<span style="margin-left: 10px;">Department:</span>
		<input type="text" id="historyDepartmentSearchBox" placeholder="Search by Department">

		<span style="margin-left: 10px;">IP:</span>
		<input type="text" id="historyIpSearchBox" placeholder="Search by IP">
	</div>
	
	<div class="download-links buttons">
		<!-- Excel Download Button -->
		<button id="downloadExcel" style="text-decoration: none; color: green; background: none; border: none; cursor: pointer;">
    		<i class="fas fa-file-excel"></i> Excel
		</button>

		<!-- Pdf Download Button -->
		<button id="downloadPdf" style="text-decoration: none; margin-right: 10px; color: red; background: none; border: none; cursor: pointer;">
    		<i class="fas fa-file-pdf"></i> PDF
		</button>
	</div>

	<div class="container loginTable">
		<table id="myLogHistDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
			<thead>
				<tr>
		       		<th>No.</th>
		            <th>History Date and Time</th>
		            <th>IP</th>
		            <th>Emp ID</th>
		            <th>Name</th>
		            <th>Department</th>
        		</tr>
	        </thead>
	        <tbody>
    			<c:forEach var="history" items="${loginHistoryList}" varStatus="status">
        			<tr>
                		<td><c:out value="${history.no}"/></td>
                		<td><fmt:formatDate value='${history.histDate}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
               			<td><c:out value="${history.ip}"/></td>
		                <td><c:out value="${history.empId}"/></td>
		                <td><c:out value="${history.name}"/></td>
		                <td><c:out value="${history.deptName}"/></td>
            		</tr>
    			</c:forEach>
			</tbody>
	    </table>
	</div>
</div>

<script>
    $(document).ready(function() {
    	   var dataTableInstance;
    	    if ( $.fn.DataTable.isDataTable('#myLogHistDataTable') ) {
    	        dataTableInstance = $('#myLogHistDataTable').DataTable();
    	    } else {
    	        dataTableInstance = $('#myLogHistDataTable').DataTable({
	            "pagingType": "full_numbers",
	            "searching": true,
	            "dom": '<"top"lr>t<"bottom"ip><"clear">',
	            "createdRow": function(row, data, dataIndex) {
	                $(row).addClass('custom-row-style');
		            }
		        });
    	    }
    	    
    	    dataTableInstance.on('error.dt', function(e, settings, techNote, message) {
    	        console.log('An error occurred in DataTables: ', message);
    	    });

		// Initialize the start date datepicker
		$('#historyStartDateSearchBox').datepicker({
		    dateFormat: 'yy-mm-dd',
		    onClose: function(selectedDate) {
		        // Set the minDate of endDateSearchBox to the selected date
		        $('#historyEndDateSearchBox').datepicker("option", "minDate", selectedDate);
		        startDate = $(this).datepicker('getDate');
		        filterByDateRange(); // Call the function to filter data based on the date range
		    }
		});
		
		// Initialize the end date datepicker
		$('#historyEndDateSearchBox').datepicker({
		    dateFormat: 'yy-mm-dd',
		    onClose: function(selectedDate) {
		        // Set the maxDate of startDateSearchBox to the selected date
		        $('#historyStartDateSearchBox').datepicker("option", "maxDate", selectedDate);
		        endDate = $(this).datepicker('getDate');
		        filterByDateRange(); // Call the function to filter data based on the date range
		    }
		});
		
		// Function to filter DataTable based on date range
		function filterByDateRange() {
		    $.fn.dataTable.ext.search.push(
		        function(settings, data, dataIndex) {
		            var holidayDate = new Date(data[1]); // Assuming the holiday date is in the 5th column (index 4)
		            if ((startDate === null || isNaN(startDate.getTime())) && (endDate === null || isNaN(endDate.getTime()))) {
		                return true; // No filter applied
		            }
		            if ((startDate === null || isNaN(startDate.getTime())) && holidayDate <= endDate) {
		                return true;
		            }
		            if (startDate <= holidayDate && (endDate === null || isNaN(endDate.getTime()))) {
		                return true;
		            }
		            if (startDate <= holidayDate && holidayDate <= endDate) {
		                return true;
		            }
		            return false; // Does not meet criteria
		        }
		    );
		    dataTableInstance.draw();
		}
		
        // Handle other search fields
        $('#historyDepartmentSearchBox').on('keyup change', function() {
            dataTableInstance.columns(5).search(this.value).draw();
        });

        $('#historyIpSearchBox').on('keyup change', function() {
            dataTableInstance.columns(2).search(this.value).draw();
        });

        $('#historyNameSearchBox').on('keyup change', function() {
            dataTableInstance.columns(4).search(this.value).draw();
        });

        // Move the buttons to the top section
        $('.top').append($('.buttons'));
    });
  
</script>

<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "Login History";
    var fileName = "LoginHistory.pdf";

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
            $('#myLogHistDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#myLogHistDataTable tbody tr').each(function() {
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

    var menuName = "Login History";
    var fileName = "LoginHistory.xlsx";

    // AJAX call to save download history
    $.ajax({
        url: '/webProject/syst/hist/downloadHist/saveDownloadHistory.do',
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

            downloadExcel('myLogHistDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>

</body>

</html>