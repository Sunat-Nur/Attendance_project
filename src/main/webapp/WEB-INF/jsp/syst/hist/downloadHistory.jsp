<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>


  <title>Download History</title>
  <head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
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
	.pageContent .downloadHistoryTable input, .pageContent .downloadHistoryTable select {
	    padding: 0.1em;
	    margin: 0;
	    display: inline-block;
	    border-radius: 4px;
	}
	
	.pageContent .downloadHistoryTable td {
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
	.downloadHistoryTable #downloadDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	}

	.downloadHistoryTable #downloadDataTable th, .downloadHistoryTable #downloadDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}
	
	.downloadHistoryTable #downloadDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.downloadHistoryTable #downloadDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
     
      /* Custom styles for table row */
	.downloadHistoryTable #downloadDataTable tr.custom-row-style td {
	   background-color: #e6e6e6; /* Your desired background color */
	   color: black; /* Your desired text color */
	}
		
	.downloadHistoryTable #downloadDataTable tr:nth-child(even).custom-row-style td {
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
       
	   	<span style="margin-left: 10px;">Menu Name:</span>
	   	<input type="text" id="menuNameSearchBox" placeholder="Search by menu Name">
	 
	   	<span style="margin-left: 10px;">Name:</span>
	   	<input type="text" id="NameSearchBox" placeholder="Search by Name">
	   
	   	<span style="margin-left: 10px;">File Name:</span>
	   	<input type="text" id="FileNameSearchBox" placeholder="Search by File name">
	</div>

     <div class="download-links buttons">
            <button id="downloadExcel" style="text-decoration: none; margin-right: 10px; color: green; background: none; border: none; cursor: pointer;">
       			<i class="fas fa-file-excel"></i> Excel
   			</button>
   
		   <!-- Pdf Download Button -->
		   <button id="downloadPdf" style="text-decoration: none; color: red; background: none; border: none; cursor: pointer;">
		       <i class="fas fa-file-pdf"></i> PDF
		   </button>
   	</div>

	<div class="container downloadHistoryTable">
   		<table id="downloadDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
       		<thead>
       			<tr>
	                <th>DNL SN</th>
	                <th>History Date</th>
	                <th>Menu Name</th>
	                <th>File Name</th>
	                <th>Emp ID</th>
	                <th>Name</th>
	                <th>Dept Name</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="downloadHistory" items="${downloadHistories}">
                	<tr>
	                    <td>${downloadHistory.dnlSn}</td>
	                    <td><fmt:formatDate value="${downloadHistory.histDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                    <td>${downloadHistory.menuName}</td>
	                    <td>${downloadHistory.fileName}</td>
	                    <td>${downloadHistory.empId}</td>
	                    <td>${downloadHistory.name}</td>
	                    <td>${downloadHistory.department}</td>
                	</tr>
    			</c:forEach>
			</tbody>
   		</table>
	</div>
</div>

<script>
    $(document).ready(function() {
        // Initialize DataTable
        var dataTableInstance = $('#downloadDataTable').DataTable({
            "pagingType": "full_numbers",
            "searching": true,
            "dom": '<"top"lr>t<"bottom"ip><"clear">',
            "createdRow": function(row, data, dataIndex) {
                $(row).addClass('custom-row-style');
            }
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
        $('#menuNameSearchBox').on('keyup change', function() {
            dataTableInstance.columns(2).search(this.value).draw();
        });

        $('#NameSearchBox').on('keyup change', function() {
            dataTableInstance.columns(5).search(this.value).draw();
        });

        $('#FileNameSearchBox').on('keyup change', function() {
            dataTableInstance.columns(3).search(this.value).draw();
        });

        // Move the buttons to the top section
        $('.top').append($('.buttons'));
    });
 
</script>



<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "download History";
    var fileName = "downloadHistory.pdf";

    // AJAX call to save download history
    $.ajax({
        url: 'saveDownloadHistory.do', // URL of your endpoint
        type: 'POST',
        data: {
            menuName: menuName,
            fileName: fileName
        },
        success: function(response) {
            // On success, generate and download the PDF
            var tableData = [];
            $('#downloadDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#downloadDataTable tbody tr').each(function() {
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

    var menuName = "DownloadHistory List";
    var fileName = "DownloadHistoryList.xlsx";

    // AJAX call to save download history
    $.ajax({
        url: 'saveDownloadHistory.do', // URL of your endpoint
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

            downloadExcel('downloadDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>

</body>
</html>