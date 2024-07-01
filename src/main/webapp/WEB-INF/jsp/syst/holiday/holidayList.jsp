<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<html>
<head>
    <title>Holiday Management</title>
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
	    <link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
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
	
	#pageContent #editButton, #pageContent #addButton, #pageContent #saveButton {
		background-color: #0080ff;
	}
       
	#pageContent #deleteButton {
		background-color: #ff5c33;
	}
	
	#pageContent #cancelButton {
		background-color: #8c8c8c;
	}
	
	#pageContent #downloadPdfButton {
		background-color: #b32400;
	}

     /* Table Styles */
	.holidayTable #holidayDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	}
	
	.holidayTable #holidayDataTable th, .holidayTable #holidayDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.holidayTable #holidayDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}
	
	.holidayTable #holidayDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
	
	/* Custom styles for table row */
	.holidayTable #holidayDataTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}

	.holidayTable #holidayDataTable tr:nth-child(even).custom-row-style td {
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
	
     /* Hide the select column initially */
	.dataTables th:first-child,
	.dataTables td:first-child {
	   display: none;
	}
    .edit-input {
    width: 100%; /* Adjust this value to match your desired input width */
    box-sizing: border-box; /* Ensures padding and border are included in the width */
	}
	
	/* Additional styles might be necessary for the positioning container */
	.edit-input-wrapper {
	    position: relative;
	    display: inline-block; /* Ensures the wrapper doesn't take more space than necessary */
	    width: 100%; /* This should match the .edit-input width if necessary */
	}
	
	.fa-calendar-days {
	    position: absolute;
	    right: 10px;
	    top: 5px;
	    cursor: pointer;
	}
	 .readonly-field {
        background-color: #f2f2f2; /* Light grey color; adjust as needed */
        color: #495057; /* Dark grey text color; adjust as needed */
        border: 1px solid #ced4da; /* Light grey border; adjust thickness and style as needed */
    }
    
     
</style>
</head>
<body>

<div id="pageContent">
    <div class="searchBar">
    	<span>Holiday Name:</span>
    	<input type="text" id="holidayNameSearchBox" placeholder="Search by Holiday Name">
   
    	<span style="margin-left: 10px;">Holiday Date Range:</span>
    	
    	<div class="datepicker-wrapper" style="display: inline-block; position: relative;">
    		<i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: 5px;"></i>
    		<input type="text" id="holidayStartDateSearchBox" placeholder="Start Date" class="datepicker" style="padding-right: 30px;" readonly>
    	</div>
    	
    	<div class="datepicker-wrapper" style="display: inline-block; position: relative; margin-left: 10px;">
    		<i class="fa-solid fa-calendar-days" style="position: absolute; right: 10px; top: 5px;"></i>
    		<input type="text" id="holidayEndDateSearchBox" placeholder="End Date" class="datepicker" style="padding-right: 30px;" readonly>
    	</div>
    	
	</div>


    <div class="buttons">
	   	<button id="downloadExcel" style="text-decoration: none; margin-right: 10px; color: green; background: none; border: none; cursor: pointer;">
	       <i class="fas fa-file-excel"></i> Excel
	   	</button>
	   
	   <!-- Pdf Download Button -->
	   <button id="downloadPdf" style="text-decoration: none; margin-right: 10px; color: red; background: none; border: none; cursor: pointer;">
	       <i class="fas fa-file-pdf"></i> PDF
	   </button>
	   
        <button id="editButton">Edit</button>
        <button id="addButton" style="display:none;">Add</button>
        <button id="saveButton" style="display:none;">Save</button>
        <button id="cancelButton" style="display:none;">Cancel</button>
        <button id="deleteButton" style="display:none;">Delete</button>
    </div>

    <div class="container holidayTable">
        <table id="holidayDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
            <thead>
    			<tr>
        			<th></th> <!-- Empty header for checkboxes -->
			        <th>Holiday Number</th>
			        <th>Holiday Name</th>
			        <th>Holiday Description</th>
			        <th>Holiday Date</th>
			        <th>Registered Employee ID</th>
			        <th>Registration Date</th>
			        <th>Modified Employee ID</th>
			        <th>Modification Date</th>
    			</tr>
			</thead>
			<tbody>
    			<c:forEach var="holiday" items="${holidayList}">
        			<tr>
			            <td></td> <!-- Empty cell for checkbox -->
			            <td>${holiday.holidayNo}</td>
			            <td>${holiday.holidayName}</td>
			            <td >${holiday.holidayDc}</td>
			           <td class="editable-date"><fmt:formatDate value='${holiday.holidayDate}' pattern='yyyy-MM-dd' /></td>
			            <td>${holiday.regEmpId}</td>
			            <td><fmt:formatDate value='${holiday.regDt}' pattern='yyyy-MM-dd' /></td>
			            <td>${holiday.modEmpId}</td>
			            <td><fmt:formatDate value='${holiday.modDt}' pattern='yyyy-MM-dd' /></td>
        			</tr>
    			</c:forEach>
			</tbody>
        </table>
    </div>
</div>

<script>
    // Global variable for the DataTable instance
    var dataTableInstance;
    
    var startDate, endDate; // Declare startDate and endDate variables outside the scope of any function

    var loggedInEmpId = "${loggedInEmpId}"; // Assume this is set correctly from the model
    var currentDate = new Date().toISOString().slice(0, 10); // Format as 'YYYY-MM-DD'

    $(document).ready(function() {
        // Initialize DataTable
        dataTableInstance = $('#holidayDataTable').DataTable({
            "pagingType": "full_numbers",
            "autoWidth": true,
            "searching": true,
            "dom": '<"top"lr>t<"bottom"ip><"clear">',
            "createdRow": function(row, data, dataIndex) {
                $(row).addClass('custom-row-style');
            },
            "columnDefs": [{
                "targets": 0, // Target the first column (checkboxes)
                "orderable": false, // Disable ordering
                "searchable": false, // Disable searching
                "className": "dt-body-center dt-checkbox-column", // Add 'dt-checkbox-column' class
                "render": function(data, type, full, meta) {
                    var holidayNo = full[1]; // Assuming holiday number is in the second column
                    return '<input type="checkbox" class="edit-checkbox" data-holiday-no="' + holidayNo + '">';
                },
                "width": "40px" // Adjust this value as needed to prevent width reduction
            }]

        });

        // Hide the select column initially
        $('.dataTable th:first-child, .dataTable td:first-child').hide();

        // Move the buttons to the top section
        $('.top').append($('.buttons'));

        // Custom search functionality for "Holiday Name"
        $('#holidayNameSearchBox').on('keyup change', function() {
            dataTableInstance.columns(2).search(this.value).draw();
        });
       
     // Initialize the start date datepicker
        $('#holidayStartDateSearchBox').datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true, // Enable month dropdown
            changeYear: true, // Enable year dropdown
            onClose: function(selectedDate) {
                // Set the minDate of endDateSearchBox to the selected date
                $('#holidayEndDateSearchBox').datepicker("option", "minDate", selectedDate);
                startDate = $(this).datepicker('getDate');
                filterByDateRange(); // Call the function to filter data based on the date range
            }
        });

        // Initialize the end date datepicker
        $('#holidayEndDateSearchBox').datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true, // Enable month dropdown
            changeYear: true, // Enable year dropdown
            onClose: function(selectedDate) {
                // Set the maxDate of startDateSearchBox to the selected date
                $('#holidayStartDateSearchBox').datepicker("option", "maxDate", selectedDate);
                endDate = $(this).datepicker('getDate');
                filterByDateRange(); // Call the function to filter data based on the date range
            }
        });

        // Function to filter DataTable based on date range
        function filterByDateRange() {
            $.fn.dataTable.ext.search.push(
                function(settings, data, dataIndex) {
                    var holidayDate = new Date(data[4]); // Assuming the holiday date is in the 5th column (index 4)
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
   
        $('#hideColumnButton').on('click', function() {
            // Code to hide the column
            dataTableInstance.columns.adjust().draw(); // Adjust column sizing
        });

        
        // Edit button event listener
        $('#editButton').on('click', function() {
            toggleEditMode(true);
            $('#addButton, #saveButton, #cancelButton, #deleteButton').show();
            $('#editButton').hide();
        });

        // Add button event listener
        $('#addButton').on('click', function() {
            addNewRow();
        });

        // Save button event listener
        $('#saveButton').on('click', function() {
            saveChanges();
        });

        // Cancel button event listener
        $('#cancelButton').on('click', function() {
            toggleEditMode(false);
            location.reload();
        });
        
        // Event listener for checkboxes
        $('.edit-checkbox').on('change', function() {
            // Uncheck all other checkboxes except the current one
            $('.edit-checkbox').not(this).prop('checked', false);
        });
       

        $('#deleteButton').on('click', function() {
            var selectedCheckboxes = $('.edit-checkbox:checked');
            if (selectedCheckboxes.length > 0) {
                var confirmation = confirm('Do you really want to delete the selected rows?');
                if (confirmation) {
                    var deletedHolidayNos = [];

                    selectedCheckboxes.each(function() {
                        var holidayNo = $(this).data('holiday-no');
                        console.log('Selected Holiday No:', holidayNo);
                        if (holidayNo) {
                            deletedHolidayNos.push(holidayNo);
                        }
                    });

                    console.log('Deleted Holiday Numbers:', deletedHolidayNos);

                    if (deletedHolidayNos.length > 0) {
                        // Perform AJAX request to delete data
                        $.ajax({
                            url: 'deleteHoliday.do',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(deletedHolidayNos[0]), // Send the first selected holiday number as a single Long
                            success: function(response) {
                                alert("Data deleted successfully!");
                                dataTableInstance.rows('.selected').remove().draw(false);
                                location.reload(); // Refresh the page after deleting
                            },
                            error: function(xhr, status, error) {
                                alert('Error deleting holidays: ' + xhr.responseText);
                            }
                        });

                    } else {
                        alert('No holiday numbers found for deletion.');
                    }
                }
            } else {
                alert('Please select at least one row to delete.');
            }
        });

    });
    
    $('input[data-fieldname="groupName"]').on('keyup blur', function() {
        var inputLength = $(this).val().length;
        var validationMessageElement = $(this).next('.group-name-validation-message');
        if (inputLength > 50) {
            validationMessageElement.show();
        } else {
            validationMessageElement.hide();
        }
    });


    function toggleEditMode(enable) {
        var rows = dataTableInstance.rows().nodes();
        $(rows).each(function() {
            var $row = $(this);
            if (enable) {
                if ($row.find('td:first-child input[type="checkbox"]').length === 0) {
                    $row.find('td:first-child').prepend('<input type="checkbox" class="edit-checkbox" style="margin-right: 10px;">');
                }
                $('.dataTable th:first-child, .dataTable td:first-child').show();
            } else {
                $row.find('td:first-child .edit-checkbox').remove();
                $('.dataTable th:first-child, .dataTable td:first-child').hide();
            }

            $row.find('td:not(:first-child)').each(function(index) {
                var cell = dataTableInstance.cell(this);
                var fieldName = ["holidayNo", "holidayName", "holidayDc", "holidayDate", "regEmpId", "regDt", "modEmpId", "modDt"][index % 8];
                var cellText = cell.data();
                if (enable) {
                    var inputHtml = '';
                    if (fieldName === 'holidayDate') {
                        inputHtml = '<div style="position: relative;">' +
                                    '<input type="text" class="edit-input datepicker" data-fieldname="' + fieldName + '" value="' + cellText + '" readonly >' + // Add readonly attribute here
                                    '<i class="fa-solid fa-calendar-days"></i>' +
                                    '</div>';
                    } else if (fieldName === 'holidayNo') { // Add conditions for modEmpId and regEmpId
                        inputHtml = '<input type="text" class="edit-input readonly-field" data-fieldname="' + fieldName + '" value="' + cellText + '" readonly >';               
                    } else if (fieldName === 'holidayName') {
                        inputHtml = '<input type="text" class="edit-input" data-fieldname="' + fieldName + '" value="' + cellText + '" />' +
                                    '<div class="holiday-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>';
                    } else if (fieldName === 'regDt' || fieldName === 'modDt') {
                    	inputHtml = '<input type="text" class="edit-input" data-fieldname="' + fieldName + '" value="' + cellText + '" readonly style="background-color: #f2f2f2; color: #495057; border: 1px solid #ced4da;">';
                    } else if (fieldName === 'modEmpId' || fieldName === 'regEmpId') { // Add conditions for modEmpId and regEmpId
                        inputHtml = '<input type="text" class="edit-input readonly-field" data-fieldname="' + fieldName + '" value="' + cellText + '" readonly >'; 
                    } else {
                        inputHtml = '<input type="text" class="edit-input" data-fieldname="' + fieldName + '" value="' + cellText + '" />';
                    }
                    cell.data(inputHtml);
                }else {
                    var cellInput = $(this).find('.edit-input').val();
                    cell.data(cellInput);
                }
            });
        });


        if (enable) {
            // Apply jQuery UI datepicker to all date inputs after adding them to the DOM
            $("input.datepicker").not('[data-fieldname="regDt"], [data-fieldname="modDt"]').datepicker({
               dateFormat: 'yy-mm-dd',
               changeYear: true,
               changeMonth: true,
               yearRange: "-30:+30"
             });

            $('#addButton, #saveButton, #cancelButton, #deleteButton').show();
            $('#editButton').hide();
            initHolidayNameValidation(); // Make sure this function is properly defined to handle validation
        } else {
            $('#addButton, #saveButton, #cancelButton, #deleteButton').hide();
            $('#editButton').show();
        }

        // Adjust column widths and redraw the table
        dataTableInstance.columns.adjust().draw();
    }


 
    function validateAndTrimSortNumberInput(inputVal) {
        var trimmedInput = inputVal.trim(); // Trim whitespace

        // Ensure input contains only digits (0-9)
        if (!/^\d+$/.test(trimmedInput)) {
            return ''; // Return an empty string or any other fallback value
        }

        // Convert input to a number and check conditions
        var numericInput = parseInt(trimmedInput, 10);
        
        // Set to 1 if input is 0 (e.g., '0000')
        if (numericInput === 0) {
            return '1';
        }

        // Check if input length exceeds 4 digits, also serves to check if numericInput > 9999
        if (trimmedInput.length > 4 || numericInput > 9999) {
            trimmedInput = trimmedInput.substring(0, 4); // Trim to first 4 digits
            numericInput = parseInt(trimmedInput, 10); // Parse again in case we trimmed leading zeros
        }

        // Limit the maximum value to 1000
        if (numericInput > 1000) {
            return '1000';
        }

        // Return string representation of numericInput
        return numericInput.toString();
    }

    
    // Check if sort numbers are unique
    var sortNumbers = [];
    var duplicateSortNumbers = false;
    $('#myDataTable input[data-fieldname="sortNumber"]').each(function() {
        var sortNumber = $(this).val().trim();
        if (sortNumbers.includes(sortNumber)) {
            duplicateSortNumbers = true;
            return false; // Exit the loop if a duplicate sort number is found
        }
        sortNumbers.push(sortNumber);
    });
   

    // Add input event listener for sort number field
    $('#pageContent').on('input', 'input[data-fieldname="sortNumber"]', function() {
        var inputVal = $(this).val();
        var trimmedInput = validateAndTrimSortNumberInput(inputVal);
        $(this).val(trimmedInput); // Update input value with trimmed value
    });
    

    // Add input event listener for upper code and code fields
    $('#myDataTable').on('input', 'input[data-fieldname="upperCode"], input[data-fieldname="code"]', function() {
        var fieldName = $(this).data('fieldname');
        var inputVal = $(this).val();

        // Trim value if it exceeds 6 numbers
        if (inputVal.length > 6) {
            $(this).val(inputVal.slice(0, 6));
        }

        // Validate for special characters and alphabets
        var regex = /^[0-9]*$/; // Only allow numbers
        if (!regex.test(inputVal)) {
            $(this).val(inputVal.replace(/[^0-9]/g, '')); // Remove any non-numeric characters
        }
    });
    

    function clearErrorMessages() {
        $('.input-error-message').each(function() {
            $(this).hide(); // or $(this).empty();
        });
    }

    
    // Function to initialize holiday name validation
    function initHolidayNameValidation() {
        $('input[data-fieldname="holidayName"]').off('keyup blur').on('keyup blur', function() {
            var inputLength = $(this).val().length;
            var validationMessageElement = $(this).next('.holiday-name-validation-message');
            if (inputLength > 50) {
                validationMessageElement.show();
            } else {
                validationMessageElement.hide();
            }
        });
    }

    function addNewRow() {
        var newHolidayDateId = 'newHolidayDate-' + new Date().getTime();
        var newRegDateId = 'newRegDate-' + new Date().getTime();
        var newModDateId = 'newModDate-' + new Date().getTime();
        var loggedInEmpId = ''; // Define loggedInEmpId as needed

        dataTableInstance.row.add([
        	'',
            '',
            '<input type="text" class="edit-input" data-fieldname="holidayName" value="" /><div class="holiday-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>',
            '<input type="text" class="edit-input" data-fieldname="holidayDc" value="" />',
            '<div style="position: relative;"><input type="text" id="' + newHolidayDateId + '" class="edit-input" data-fieldname="holidayDate" value=""><i class="fa-solid fa-calendar-days"></i></div>',
            '<input type="text" class="edit-input readonly-field" data-fieldname="regEmpId" value="' + loggedInEmpId + '" readonly />',
            '<input type="text" class="edit-input readonly-field" data-fieldname="regDt" value="" readonly >', // Removed datepicker class and icon
            '<input type="text" class="edit-input readonly-field" data-fieldname="modEmpId" value="" readonly />',
            '<input type="text" class="edit-input readonly-field" data-fieldname="modDt" value="" readonly >' // Removed datepicker class and icon
        ]).draw(false);

        // Initialize the datepicker only for the holidayDate input of the new row
        $("#" + newHolidayDateId).datepicker({
            dateFormat: 'yy-mm-dd'
        });
        initHolidayNameValidation(); // Re-validate holiday names if necessary
    }



    function saveChanges() {
        // Validate if any holiday name is null
        var isHolidayNameNull = false;
        var errorCount = 0; // Track the number of errors
        $('#holidayDataTable tbody tr').each(function() {
            var holidayName = $(this).find('input[data-fieldname="holidayName"]').val();
            if (!holidayName || holidayName.trim() === '') {
                isHolidayNameNull = true;
                errorCount++; // Increment error count
                return false; // Exit loop early if a null holiday name is found
            }
        });

        // If error messages are present, prevent saving and display an alert
        if ($('.holiday-name-validation-message:visible').length > 0) {
            alert("Please correct the validation errors before saving.");
            return; // Exit the function without saving
        }

        if (isHolidayNameNull) {
            alert('Holiday Name must not be empty.');
            return; // Exit function early if any holiday name is null
        }

        // Proceed with saving changes if all holiday names are valid
        var updatedData = [];
        dataTableInstance.rows().every(function() {
            var rowData = {};
            $(this.node()).find('input, select').each(function() {
                var fieldName = $(this).data('fieldname');
                var value = $(this).val();
                rowData[fieldName] = value;
            });
            updatedData.push(rowData);
        });

        console.log("Updated Data:", updatedData);
        console.log(updatedData);
        $.ajax({
            url: 'saveHolidayChanges.do',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(updatedData),
            success: function(response) {
                alert("Data saved successfully!");
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert("Error saving data: " + xhr.responseText);
            }
        });
        toggleEditMode(false);
        $('#addButton, #saveButton, #cancelButton').hide();
        $('#editButton').show();
    }


</script>


<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "HolidayList";
    var fileName = "HolidayList.pdf";

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
            $('#holidayDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#holidayDataTable tbody tr').each(function() {
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

    var menuName = "HolidayList";
    var fileName = "HolidayList.xlsx";

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

            downloadExcel('holidayDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>
</body>
</html>