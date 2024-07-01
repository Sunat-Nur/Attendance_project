<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

    <title>Common Code Management</title>
 <head> 
      	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
   		<link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" >
   		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
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
	.codeTable #myDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	}	

	.codeTable #myDataTable th, .codeTable #myDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.codeTable #myDataTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}

	.codeTable #myDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
      
      /* Custom styles for table row */
	.codeTable #myDataTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	.codeTable #myDataTable tr:nth-child(even).custom-row-style td {
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

   /* Updated CSS class for readonly fields */
    .readonly-field {
        background-color: #f2f2f2; /* Light grey color; adjust as needed */
        color: #495057; /* Dark grey text color; adjust as needed */
        border: 1px solid #ced4da; /* Light grey border; adjust thickness and style as needed */
    }
		
</style>
</head> 
 
<div id="pageContent">
    <div class="searchBar">
        <span>Code Name:</span>
        <input type="text" id="codeNameSearchBox" placeholder="Search by Code Name">
    </div>
    <div class="buttons">
	 	<button id="editButton">Edit</button>
	 	<button id="addButton" style="display:none;">Add</button>
	    <button id="saveButton" style="display:none;">Save</button>
	    <button id="cancelButton" style="display:none;">Cancel</button>  
    </div><br>
    
	<div class="container codeTable">
	    <table id="myDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
	        <thead>
	        	<tr>
					<th>Upper Code</th>
					<th>Code</th>
					<th>Code Name</th>
					<th>Description</th>
					<th>Availability</th>
					<th>Sort Number</th>
	      		</tr>
	        </thead>
	        <tbody>
    			<c:forEach var="codeList" items="${code}">
        			<tr>
			            <td>${codeList.upperCode}</td>
			            <td>${codeList.code}</td>
			            <td>${codeList.codeName}</td>
			            <td>${codeList.codeDescription}</td>
			            <td>${codeList.useYn == 'Y' ? 'Use' : 'Not Use'}</td>
			            <td>${codeList.sortNumber}</td>
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
    dataTableInstance = $('#myDataTable').DataTable({
        "pagingType": "full_numbers",
        "searching": true,
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        },
        "columnDefs": [
            {
                "targets": [0, 1], // Apply the rendering function to columns 1, 13, and 15
                "render": function(data, type, row) {
                    if (type === 'display') {
                        // Reverse the string, format it with commas, and reverse it back
                        var reversed = data.toString().split('').reverse().join('');
                        var formatted = reversed.replace(/(\d{3})(?=\d)/g, '$1,');
                        var result = formatted.split('').reverse().join('');
                        return result;
                    }
                    return data; // Return unmodified data for other types
                }
            }
        ]
    });

    
    
    // Move the buttons to the top section
    $('.top').append($('.buttons'));
    
    
    // Custom search functionality for "Code Name"
    $('#codeNameSearchBox').on('keyup change', function() {
        // Search in the "Code Name" column
        // Ensure the column index is correct. Here, it's assumed that "Code Name" is the third column (index 2)
        dataTableInstance.columns(2).search(this.value).draw();
    });

    // Edit button event listener
    $('#editButton').on('click', function() {
        toggleEditMode(true);
        $('#addButton, #saveButton, #cancelButton').show(); // Show edit-related buttons
        $('#editButton').hide(); // Hide edit button
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
        location.reload(); // Reload the page to restore the original table state
    });
});

function toggleEditMode(enable) {
    var rows = dataTableInstance.rows().nodes();
    $(rows).find('td').each(function(index) {
        var cell = dataTableInstance.cell(this);
        var columnIdx = index % 6; // Adjust based on the number of columns
        var fieldName = ["upperCode", "code", "codeName", "codeDescription", "useYn", "sortNumber"][columnIdx];

        if (enable) {
            var cellText = cell.data();
            // Check if the field is 'upperCode' or 'code' to make them readonly
            if (fieldName === 'upperCode' || fieldName === 'code') {
    			cell.data('<input type="text" data-fieldname="' + fieldName + '" value="' + cellText + '" readonly class="readonly-field" />');
				} else if (fieldName === 'codeName') {
                // Code name with validation logic
                var inputHtml = '<input type="text" class="edit-input" data-fieldname="' + fieldName + '" value="' + cellText + '" />';
                var validationMessageHtml = '<div class="code-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>';
                cell.data(inputHtml + validationMessageHtml);

                // Add event listeners for validation
                var inputElement = $(cell.node()).find('input');
                validateCodeNameInput(inputElement); // Initial validation in case the existing value exceeds the limit
                inputElement.on('input', function() { validateCodeNameInput($(this)); });
            } else if (fieldName === 'useYn') {
                // Use dropdown for 'useYn'
                cell.data('<select data-fieldname="useYn">' +
                          '<option value="Y"' + (cellText === 'Use' ? ' selected' : '') + '>Use</option>' +
                          '<option value="N"' + (cellText === 'Not Use' ? ' selected' : '') + '>Not Use</option>' +
                          '</select>');
            } else if (fieldName === 'sortNumber') {
                // Sort number input with validation
                cell.data('<input type="text" data-fieldname="' + fieldName + '" value="' + cellText + '" />');
                var inputElement = $(cell.node()).find('input');
                inputElement.on('input', function() {
                    var inputVal = $(this).val();
                    var trimmedInput = validateAndTrimSortNumberInput(inputVal);
                    $(this).val(trimmedInput); // Update input value with trimmed value
                });
            } else {
                cell.data('<input type="text" data-fieldname="' + fieldName + '" value="' + cellText + '" />');
            }
        } else {
            if (fieldName === 'useYn') {
                var selectedValue = $(this).find('select').val();
                cell.data(selectedValue === 'Y' ? 'Use' : 'Not Use');
            } else {
                var cellInput = $(this).find('input').val();
                cell.data(cellInput);
            }
        }
    });
}


function validateCodeNameInput(inputElement) {
    var maxLength = 50;
    var validationMessageElement = inputElement.next('.code-name-validation-message');
    if (inputElement.val().length > maxLength) {
        validationMessageElement.show();
    } else {
        validationMessageElement.hide();
    }
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




function addNewRow() {
    // Add the new row
    var newNode = dataTableInstance.row.add([
        '<input type="text" data-fieldname="upperCode" value="" />',
        '<input type="text" data-fieldname="code" value="" />',
        '<input type="text" class="edit-input" data-fieldname="codeName" value="" /><div class="code-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>',
        '<input type="text" data-fieldname="codeDescription" value="" />',
        '<select data-fieldname="useYn">' +
        '<option value="Y">Use</option>' +
        '<option value="N">Not Use</option>' +
        '</select>',
        '<input type="text" data-fieldname="sortNumber" value="" />'
    ]).draw(false).node();

    // Attach validation logic to the codeName input in the new row
    var codeNameInput = $(newNode).find('input[data-fieldname="codeName"]');
    validateCodeNameInput(codeNameInput); // Validate immediately in case of predefined values
    codeNameInput.on('input', function() {
        validateCodeNameInput($(this));
    });
}




function removeCommasFromNumbers(data) {
    // Iterate through the data
    for (var i = 0; i < data.length; i++) {
        // Iterate through each object's properties
        for (var key in data[i]) {
            if (typeof data[i][key] === 'string' && !isNaN(parseFloat(data[i][key].replace(/,/g, '')))) {
                // If the property is a string and represents a number, remove commas
                data[i][key] = data[i][key].replace(/,/g, '');
            }
        }
    }
    return data;
}
function saveChanges() {
    // Check if there are any error messages present
    var errorMessagesPresent = $('.code-name-validation-message').is(':visible');

    // If error messages are present, prevent saving and display an alert
    if (errorMessagesPresent) {
        alert("Please correct the validation errors before saving.");
        return; // Exit the function without saving
    }

    // Check if "Code Name" or "Sort Number" input fields are empty
    var emptyFields = false;
    $('#myDataTable input[data-fieldname="codeName"], #myDataTable input[data-fieldname="sortNumber"]').each(function() {
        if ($(this).val().trim() === '') {
            emptyFields = true;
            return false; // Exit the loop if an empty field is found
        }
    });

    // If any of the required fields are empty, prevent saving and display an alert
    if (emptyFields) {
        alert("Code Name and Sort Number must not be empty.");
        return; // Exit the function without saving
    }
    
    // Check for duplicate sort numbers
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

    // If duplicate sort numbers are found, prevent saving and display an alert
    if (duplicateSortNumbers) {
        alert("Sort numbers must be unique.");
        return; // Exit the function without saving
    }

    // Proceed with saving the changes if no error messages, no empty fields, and no duplicate sort numbers are found
    var updatedData = [];
    dataTableInstance.rows().every(function() {
        var rowData = {};
        $(this.node()).find('input, select').each(function() {
            var fieldName = $(this).data('fieldname');
            var value = $(this).val();
            if (fieldName === 'useYn') {
                rowData[fieldName] = value;
            } else {
                rowData[fieldName] = value;
            }
        });
        updatedData.push(rowData);
    });

    // Remove commas from numerical values
    updatedData = removeCommasFromNumbers(updatedData);

    console.log(updatedData); // Log data to check format

    // Perform AJAX request to save data
    $.ajax({
        url: 'saveCodeChanges.do', // Replace with your server endpoint
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(updatedData),
        success: function(response) {
            alert("Data saved successfully!");
            location.reload(); // Reload the page to fetch updated data
        },
        error: function(xhr, status, error) {
            console.log(xhr.responseText); // Log the response text
            alert("Error saving data: " + xhr.responseText);
        }
    });

    toggleEditMode(false); // Exit edit mode
    $('#addButton, #saveButton, #cancelButton').hide(); // Hide edit-related buttons
    $('#editButton').show(); // Show edit button
}

</script>