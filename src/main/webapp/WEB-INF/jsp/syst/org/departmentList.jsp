<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

    <title>Organizational managemnt</title>
  <head>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
   
<style>
    /* Additional styles for form elements within DataTables */
	.pageContent .departmentTable input, .pageContent .departmentTable select {
	    padding: 0.1em;
	    margin: 0;
	    display: inline-block;
	    border-radius: 4px;
	}
	
	.pageContent .departmentTable td {
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
	.departmentTable #deptDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	    width: 100%;
	}
	.departmentTable #deptDataTable th, .departmentTable #deptDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.departmentTable #deptDataTable tr:nth-child(even) {
    background-color: #e6e6e6;
	}
	
	.departmentTable #deptDataTable th {
	    background-color: #a6a6a6;
	    color: black;
	    
	}
       
      /* Custom styles for table row */
	.departmentTable #deptDataTable tr.custom-row-style td {
	   background-color: #e6e6e6; /* Your desired background color */
	   color: black; /* Your desired text color */
	}
	
	.departmentTable #deptDataTable tr:nth-child(even).custom-row-style td {
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
	
	.departmentTable #deptDataTable td.number {
        text-align: right;
        width: 100%;
    }
    
    /* Updated CSS class for readonly fields */
	#readonly-field {
	    background-color: #f2f2f2; /* Light grey color; adjust as needed */
	    color: #495057; /* Dark grey text color; adjust as needed */
	    border: 1px solid #ced4da; /* Light grey border; adjust thickness and style as needed */
	}
	/* Additional styles might be necessary for the positioning container */
	.edit-input-wrapper {
	    position: relative;
	    display: inline-block; /* Ensures the wrapper doesn't take more space than necessary */
	    width: 100%; /* This should match the .edit-input width if necessary */
	}
	
     .edit-input {
    width: 100%; /* Adjust this value to match your desired input width */
    box-sizing: border-box; /* Ensures padding and border are included in the width */
	}
</style>
</head>
 
<div id="pageContent">
    <div class="searchBar">
        <span>Dept Name:</span>
        <input type="text" id="dptNameSearchBox" placeholder="Search by Dept Name">
    </div>
   
    <div class="buttons">
  		<button id="editButton">Edit</button>
  		<button id="addButton" style="display:none;">Add</button>
    	<button id="saveButton" style="display:none;">Save</button>
    	<button id="cancelButton" style="display:none;">Cancel</button>  
    </div>
   
	<div class="container departmentTable">
   		<table id="deptDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
       		<thead>
        		<tr>
					<th>Dept No</th>
					<th>Dept Name</th>
					<th>Use YN</th>
					<th>Sort Number</th>
					<th>Group No</th>
					<th>Action</th>
                </tr>
            </thead>
            <tbody>
           		<c:forEach var="department" items="${departmentList}">
    					<tr>
         				<td ><c:out value="${department.deptNo}"/></td>
                        <td><c:out value="${department.deptName}"/></td>
                        <td><c:out value="${department.useYn == 'Y' ? 'Use' : 'Not Use'}"/></td>
                        <td><c:out value="${department.sortNumber}"/></td>
                        <td><c:out value="${department.groupNo}"/></td>
                    	<td>
            				<button type="button" class="viewButton" data-deptNo="${department.deptNo}">View</button>
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
    dataTableInstance = $('#deptDataTable').DataTable({
        "pagingType": "full_numbers",
        "searching": true,
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        }
    });
   
    // Move the buttons to the top section
    $('.top').append($('.buttons'));
   
   
    // Custom search functionality for "Code Name"
    $('#dptNameSearchBox').on('keyup change', function() {
        // Search in the "Dept Name" column
        dataTableInstance.columns(1).search(this.value).draw();
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

//Bind input event listener for real-time validation of sort number fields
$(document).on('input', 'input[data-fieldname="sortNumber"]', function() {
    var inputVal = $(this).val();
    var validatedInput = validateAndTrimSortNumberInput(inputVal);
    $(this).val(validatedInput); // Update the input field with the validated value
});


function toggleEditMode(enable) {
    var rows = dataTableInstance.rows().nodes();
    $(rows).each(function() {
        // Iterate over each cell in the row except the last one (presumed to be the action column)
        $('td', this).not(':last').each(function(index) {
            var cell = dataTableInstance.cell(this);
            var fieldName = ["deptNo", "deptName", "useYn", "sortNumber", "groupNo"][index % 5]; // Adjust as per your columns

            if (enable) {
                // Logic to switch to edit mode
                var cellText = cell.data();
                var inputHtml = ''; // Initialize variable to hold the input HTML string

                if (fieldName === 'deptNo') {
                    // Input box for deptNo with readonly attribute
                    inputHtml = '<input type="text" id="readonly-field" class="edit-input" data-fieldname="deptNo" value="' + cellText + '" readonly />';
                }else if(fieldName === 'groupNo') {
                    // Apply readonly only to groupNo
                    inputHtml = '<input type="text" class="edit-input" id="readonly-field"; data-fieldname="groupNo" value="' + cellText + '" readonly />';
                }else if (fieldName === 'useYn') {
                    // Use dropdown for 'useYn'
                    inputHtml = '<select data-fieldname="useYn">' +
                                '<option value="Y"' + (cellText.trim() === 'Use' ? ' selected' : '') + '>Use</option>' +
                                '<option value="N"' + (cellText.trim() === 'Not Use' ? ' selected' : '') + '>Not Use</option>' +
                                '</select>';
                } else if (fieldName === 'deptName') {
                    // Special handling for deptName to include validation message
                	 inputHtml = '<input type="text"  class="edit-input-wrapper" data-fieldname="deptName" value="' + cellText + '" />' +
                     '<div class="dept-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>';
                } else {
                    // All other fields as editable input boxes
                    inputHtml = '<input type="text" class="edit-input"  data-fieldname="' + fieldName + '" value="' + cellText + '"  />';
                }
                cell.data(inputHtml);
            } else {
                // Logic to revert from edit mode
                var cellInputValue = $(this).find('input, select').val();
                if (fieldName === 'deptNo' || fieldName === 'groupNo') { // Assuming deptNo and groupNo are your readonly fields
                    $(this).find('input, select').addClass('readonly-field');
                } else {
                    $(this).find('input, select').removeClass('readonly-field');
                }
                // Handling to display 'Use'/'Not Use' text based on selection for 'useYn' field
                if (fieldName !== 'deptNo') { // Exclude deptNo from being updated since it's readonly
                    cell.data(fieldName === 'useYn' ? (cellInputValue === 'Y' ? 'Use' : 'Not Use') : cellInputValue);
                }
            }
        });
    });

    // After toggling to edit mode and setting up inputs, including the readonly for dsgnNo, initialize validation for dsgnName
    if (enable) {
        initDeptNameValidation();
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


//Function to initialize holiday name validation
function initDeptNameValidation() {
    $('input[data-fieldname="deptName"]').off('keyup blur').on('keyup blur', function() {
        var inputLength = $(this).val().length;
        var validationMessageElement = $(this).next('.dept-name-validation-message');
        if (inputLength > 50) {
            validationMessageElement.show();
        } else {
            validationMessageElement.hide();
        }
    });
}


//Add input event listener for sort number field
$('#pageContent').on('input', 'input[data-fieldname="sortNumber"]', function() {
    var inputVal = $(this).val();
    var trimmedInput = validateAndTrimSortNumberInput(inputVal);
    $(this).val(trimmedInput); // Update input value with trimmed value
});

function addNewRow() {
    // Retrieve the groupNo from the URL
    var urlParams = new URLSearchParams(window.location.search);
    var groupNo = urlParams.get('groupNo'); // Make sure 'groupNo' matches the parameter name in your URL

    // Add the new row with groupNo included
   // Modified to include readonly-field class for deptNo and groupNo inputs
dataTableInstance.row.add([
	// For deptNo input in addNewRow function
	'<input type="text" id="readonly-field" class="edit-input-wrapper" data-fieldname="deptNo" value="" readonly />',
    '<input type="text" class="edit-input-wrapper" class="edit-input" data-fieldname="deptName" value="" /><div class="dept-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>',
    '<select data-fieldname="useYn">' +
    '<option value="Y">Use</option>' +
    '<option value="N">Not Use</option>' +
    '</select>',
    '<input type="text" class="edit-input-wrapper" data-fieldname="sortNumber" value="" />',
    '<input type="text" id="readonly-field" class="edit-input-wrapper" data-fieldname="groupNo" value="' + (groupNo ? groupNo : '') + '" readonly/>',
    '<button type="button"  class="viewButton" disabled>View</button>'
]).draw(false);


    // Initialize validation for deptName
    initDeptNameValidation();
}

function saveChanges() {
	
	 // Check if there are any error messages present
    var errorMessagesPresent = $('.dept-name-validation-message').is(':visible');

    // If error messages are present, prevent saving and display an alert
    if (errorMessagesPresent) {
        alert("Please correct the validation errors before saving.");
        return; // Exit the function without saving
    }
    
    // Check if "Group Name" or "Sort Number" input fields are empty
    var emptyFields = false;
    $('#deptDataTable input[data-fieldname="deptName"], #deptDataTable input[data-fieldname="sortNumber"]').each(function() {
        if ($(this).val().trim() === '') {
            emptyFields = true;
            return false; // Exit the loop if an empty field is found
        }
    });

    // If any of the required fields are empty, prevent saving and display an alert
    if (emptyFields) {
        alert("DepartmentName and Sort Number must not be empty.");
        return; // Exit the function without saving
    }

    // Check for uniqueness of sort numbers
    var sortNumbers = [];
    var duplicateSortNumbers = false;
    $('#deptDataTable input[data-fieldname="sortNumber"]').each(function() {
        var sortNumber = $(this).val().trim();
        if (sortNumbers.includes(sortNumber)) {
            duplicateSortNumbers = true;
            return false; // Exit the loop if a duplicate sort number is found
        }
        sortNumbers.push(sortNumber);
    });

    if (duplicateSortNumbers) {
        alert("Sort numbers must be unique.");
        return; // Exit the function to prevent saving
    }

    var updatedData = [];
    dataTableInstance.rows().every(function() {
        var rowData = {};
        $(this.node()).find('input, select').each(function() {
            var fieldName = $(this).data('fieldname');
            rowData[fieldName] = $(this).val();
        });
        updatedData.push(rowData);
    });

    console.log(updatedData); // Log data to check format

    // Perform AJAX request to save data
    $.ajax({
        url: 'saveDepartmentChanges.do', // Replace with your server endpoint
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(updatedData),
        success: function(response) {
            alert("Data saved successfully!");
            location.reload(); // Reload the page to fetch updated data
        },
    });

    toggleEditMode(false); // Exit edit mode
    $('#addButton, #saveButton, #cancelButton').hide(); // Hide edit-related buttons
    $('#editButton').show(); // Show edit button
}

function hasDuplicateGroup(data) {
    let groupNoSet = new Set();
    let isDuplicate = false;
    data.forEach(rowData => {
        if (groupNoSet.has(rowData.groupNo)) {
            isDuplicate = true;
            // Optional: Highlight the duplicate row
            rowData.element.style.backgroundColor = 'gray';
        } else {
            groupNoSet.add(rowData.groupNo);
            rowData.element.style.backgroundColor = ''; // Remove highlight if not duplicate
        }
    });
    return isDuplicate;
}

document.getElementById('saveButton').addEventListener('click', function() {
    var updatedData = [];
    var rows = document.querySelectorAll('table tbody tr');

    rows.forEach(row => {
        var rowData = { element: row, deptNo: '' };
        row.querySelectorAll('input, select').forEach(input => {
            var field = input.getAttribute('data-fieldname');
            // For a select, use the selected option's value
            rowData[field] = input.tagName === 'SELECT' ? input.value : input.value;
        });
        updatedData.push(rowData);
    });

    saveData(updatedData.map(rowData => ({
        deptNo: rowData.deptNo,
        deptName: rowData.deptName,
        useYn: rowData.useYn,
        sortNumber: rowData.sortNumber,
        groupNo: rowData.groupNo
    })));
    toggleEditMode(false);
});
</script>
<script>
	function viewGroup(deptNo) {
		var url = '/webProject/syst/org/dsgn/designationList.do?deptNo=' + encodeURIComponent(deptNo);
		window.location.href = url;
	}
	
	$(document).on('click', '.viewButton', function() {
		var deptNo = $(this).data('deptno');
		window.location.href = '/webProject/syst/org/dsgn/designationList.do?deptNo=' + deptNo;
	});
</script>

</body>
</html>