<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>


<title>Menu Management</title>
<head>
  	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <link rel="stylesheet"  href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
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
		background-color: #0080ff; /* Green */
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
      
	#pageContent .moveButton {
		padding: 3px 6px; /* Smaller padding */
		font-size: 10px; /* Smaller font size */
		border-radius: 3px; /* Smaller border-radius */
	}
	
	/* Add this style for the delete button */
	#pageContent .deleteButton {
	    padding: 3px 6px; /* Same padding as moveButton */
	    font-size: 10px; /* Same font size as moveButton */
	    border-radius: 3px; /* Same border-radius as moveButton */
	    background-color: #fc1919; /* Red background color */
	}
	
       
   	/* Table Styles */
	#menuDataTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	}
	
	#menuDataTable th, #menuDataTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	.menuTable #menuDataTable tr:nth-child(even) {
		background-color: #e6e6e6;
	}
	
	.menuTable #menuDataTable th {
	   	background-color: #a6a6a6;
	   	color: black;
	}
       
     /* Custom styles for table row */
	.menuTable #menuDataTable tr.custom-row-style td {
	   	background-color: #e6e6e6; /* Your desired background color */
	   	color: black; /* Your desired text color */
	}
	
	.menuTable #menuDataTable tr:nth-child(even).custom-row-style td {
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
	
	#moveMenuModal {
	      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
	      border-radius: 5px;
	      max-width: 400px;
	  }
	   
	#moveMenuModal h2, #moveMenuModal p {
	    margin: 10px 0;
	}
	
	#moveMenuModal button {
	    margin-right: 10px;
	}
        
	.treeAndTable {
	    display: flex; /* Use flex display to align children side by side */
	    width: 100%; /* Ensure the container takes full width */
	}
	
	.menuTree {
	    flex: 1; /* Flex basis for menu tree, it will take up 1 part */
	    max-width: 19%;
	    padding: 20px; /* Add some padding around the content for better spacing */
	    box-sizing: border-box; /* Include padding in the element's total width and height */
	    border: 1px solid black;
	    margin: 45px 0;
	    overflow-y: auto;
	    height: 57.6vh;
	}
	
	.menuTableWrapper {
	    flex: 3; /* Flex basis for menu table, it will take up 3 parts */
	    max-width: 85%; /* Maximum width set to 75% of the parent container */
	    padding: 10px; /* Add some padding around the content for better spacing */
	    box-sizing: border-box; /* Include padding in the element's total width and height */
	}
    
  	.menuTable .large-input {
        width: 100%; /* Larger width for MenuName and MenuUrl */
    }
    
    .menuTable .small-input {
        width: 80%; /* Smaller width for the select dropdown */
    }
    
	.validation-message {
	    color: red;
	    display: none; /* Keeps the message hidden until it needs to be shown */
	    font-size: 0.9em; /* Optional: Adjust font size to ensure message fits nicely */
	    margin-top: 0.3em; /* Optional: Adds some space between the input and the message */
	  	max-width: 200px; /* Fixes the width of the div to 200px; adjust as needed */
    	word-wrap: break-word; /* Ensures that long words can break and wrap to the next line */
    	white-space: normal; /* Allows the text to wrap to the next line within the div */
    	text-align: left;
	}
	
/* Dialog overall styling */
.ui-dialog {
    border: 1px solid #007bff; /* Border color */
    border-radius: 8px; /* Rounded corners */
    overflow: hidden; /* Ensures the border-radius clips the content */
}

/* Dialog title bar styling */
.ui-dialog-titlebar {
    background-color: #8c8b8b; /* Title bar background color */
    color: white; /* Title bar text color */
    border: none;
}

/* Dialog title styling */
.ui-dialog-title {
    font-weight: normal;
}

/* Dialog close button styling */
.ui-dialog-titlebar-close {
    border: none;
    background-color: #8c8b8b;
}

.ui-dialog-titlebar-close:hover {
    color: red;
}

/* Custom styling for dialog buttons */
.ui-dialog-buttonpane .ui-button {
	background-color: #0080ff;
	border: none;
	color: white;
	padding: 5px 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 12px;
	margin: 0;
	cursor: pointer;
	border-radius: 4px;
}

.ui-dialog-buttonpane .ui-button:hover {
    background-color: #084f96; /* Button hover background color */
}

/* Specific style for the Cancel button */
.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset .ui-button.ui-dialog-cancel-button {
    background-color: #b5b3b3 !important; /* Different background for the cancel button */
}

.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset .ui-button.ui-dialog-cancel-button:hover {
    background-color: #8c8b8b !important; /* Hover state for cancel button */
}


/* Dialog content area styling */
.ui-dialog-content {
    padding: 20px; /* Content padding */
    font-size: 12px; /* Adjust text size as needed */
}

/* Override jQuery UI's spacing for button pane */
.ui-dialog .ui-dialog-buttonpane {
    margin-top: 0;
    padding: 1em 1em; /* Adjust padding for buttons */
    background: none; /* Optional: remove default background */
    border-width: 0 0 1px 0; /* Optional: remove default border */
}

/* Modal form styling */
#modalMoveMenu form div {
    margin-bottom: 15px; /* Adds space between form groups */
}

#modalMoveMenu label {
    display: block; /* Makes the label take the full width, pushing the input/select below */
    margin-bottom: 5px; /* Space between label and input/select */
    color: #495057; /* Dark grey for better readability */
    font-weight: bold;
}

#modalMoveMenu input, 
#modalMoveMenu select {
    width: 100%; /* Makes input and select take the full width of their parent */
    height: 38px; /* Increased height for better accessibility */
    padding: 6px 12px; /* Padding inside the input/select for text */
    background-color: #fff;
    border: 1px solid #ced4da;
    border-radius: 4px;
    box-shadow: inset 0 1px 2px rgba(0,0,0,.075);
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

#modalMoveMenu input:focus, 
#modalMoveMenu select:focus {
    border-color: #80bdff;
    outline: 0;
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
}

#modalMoveMenu input[readonly] {
    background-color: #e9ecef;
    opacity: 1; /* For iOS */
}


</style>
</head>
 
<div id="pageContent">
           
    <!--  Search Bar -->
    <div class="searchBar">
        <span>Menu Name:</span>
        <input type="text" id="menuNameSearchBox" placeholder="Search by Menu Name">
    </div>

<div class="treeAndTable">
   	<div class="menuTree">
   		<jsp:include page="menuTree.jsp" />
 	</div>
 	
	<div class="menuTableWrapper">
	    <div class="buttons">
	    	     <!-- Excel Download Button -->
			   <button id="downloadExcel" style="text-decoration: none; color: green; background: none; border: none; cursor: pointer;">
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
	    </div>
	   
		<div class="container menuTable">
		   <table id="menuDataTable" class="display table table-striped table-bordered table-sm" style="width:100%">
		
				<thead>
				    <tr>
				    	<th></th>
				        <th>UpperMenuNo</th>
				        <th>MenuNo</th>
				        <th>MenuName</th>
				        <th>Availability</th>
				        <th>MenuUrl</th>
				        <th>Sort Number</th>
				        <th>Action</th>
				    </tr>
				</thead>
				<tbody>
				    <c:forEach var="menu" items="${menuList}">
				        <tr>
				        	<td><input type="checkbox" class="row-checkbox" name="row-check" /></td>
				            <td>${menu.upperMenuNo}</td>
				            <td>${menu.menuNo}</td>
				            <td>${menu.menuName}</td>
				            
				            <td>${menu.useYn == 'Y' ? 'Use' : 'Not Use'}</td>
				            <td>${menu.menuUrl}</td>
				            <td>${menu.sortNumber}</td>
				            <td><button class="moveButton">Move</button></td>
				        </tr>
				    </c:forEach>
				</tbody>
		    </table>
		 </div>
	 </div>
 </div>
 
 
<!-- Modal: modalMoveMenu -->
<div id="modalMoveMenu" title="Move Menu Item" style="display:none;">
    <form id="moveMenuForm">
        <input type="hidden" id="modalMenuNo" name="menuNo">
        <div>
            <label for="topMenuSelect">Top Menu:</label>
            <select id="topMenuSelect" name="topMenu">
                <option value="">Select Top Menu</option>
                <!-- Dynamically populate options here -->
            </select>
        </div>
        <div>
            <label for="upperMenuSelect">Upper Menu:</label>
            <select id="upperMenuSelect" name="upperMenu">
                <option value="">Select Upper Menu</option>
                <!-- Dynamically populate options here -->
            </select>
        </div>
        <div>
            <label for="modalMenuName">Menu Name:</label>
            <input type="text" id="modalMenuName" name="menuName" readonly>
        </div>
    </form>
</div>
<!-- End of Modal: modalMoveMenu -->
 
 
 
 </div>


<script>
	
	function updateTableWithSubMenus(subMenus) {
		
		var buttons = $('.buttons').detach();
		
	    // Destroy the current DataTable instance if it exists
	    if ($.fn.dataTable.isDataTable('#menuDataTable')) {
	    	$('#menuDataTable').DataTable().clear().destroy();
	        $('#menuDataTable tbody').empty(); // Also, clear the table body to ensure no old data is left
	    }

	    // Update the table body with new subMenus data
	    subMenus.forEach(function(subMenu) {
	        var rowHtml = '<tr>' +
	        	'<td><input type="checkbox" class="row-checkbox" name="row-check" /></td>' +
	            '<td class="number">' + (subMenu.upperMenuNo !== null ? subMenu.upperMenuNo : '') + '</td>' +
	            '<td class="number">' + (subMenu.menuNo !== null ? subMenu.menuNo : '') + '</td>' +
	            '<td>' + (subMenu.menuName !== null ? subMenu.menuName : '') + '</td>' +
	            '<td>' + (subMenu.useYn === 'Y' ? 'Use' : (subMenu.useYn === 'N' ? 'Not Use' : '')) + '</td>' +
	            '<td class="sentence">' + (subMenu.menuUrl !== null ? subMenu.menuUrl : '') + '</td>' +
	            '<td class="number">' + (subMenu.sortNumber !== null ? subMenu.sortNumber : '') + '</td>' +
	            '<td><button class="moveButton">Move</button></td>' +
	            '</tr>';
	        $('#menuDataTable tbody').append(rowHtml);
	    });
	    
	 // Reinitialize the DataTable
	    initializeDataTable();
	 
	    // Re-append the buttons to the top section after reinitialization
	    $('.top').append(buttons);
	}

</script>

<script>

//Global variable for the DataTable instance
var dataTableInstance;

var loggedInEmpId = "${loggedInEmpId}"; // Assume this is set correctly from the model
var currentDate = new Date().toISOString().slice(0, 10); // Format as 'YYYY-MM-DD'

function repositionAndShowButtons() {

    // Move the buttons to the top section
    $('.top').append($('.buttons'));
    // Reset visibility for any buttons as needed
    // For instance, if certain buttons should always be visible after reinitialization:
    $('#editButton').show();
    $('#addButton, #saveButton, #cancelButton').hide();
    // Initially disable all checkboxes
    $('input[type="checkbox"].row-checkbox').prop('disabled', true);
    
    $('input[type="checkbox"].row-checkbox:checked').each(function() {
        $(this).prop('checked', false).trigger('change');
    });
};


function initializeDataTable() {
	
    // Check if dataTableInstance already exists, destroy it before reinitializing
    if ($.fn.DataTable.isDataTable('#menuDataTable')) {
        $('#menuDataTable').DataTable().destroy();
    }
    
 // Initialize DataTable with additional configurations for selection and column definitions
    var dataTableInstance = $('#menuDataTable').DataTable({
        "autoWidth": true,
        "pagingType": "full_numbers",
        "searching": true,
        "stateSave": true, // Enable state saving 
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        },
        "columnDefs": [
            // Add your initial first column definition for select-checkbox
            {
                orderable: false,
                className: 'select-checkbox',
                targets: 0
            },
	        {
	            "targets": [1, 2], // Apply the rendering function to columns 1, 13, and 15
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
	        },

	        { targets: 0, width: '5%' }, // Checkbox column
	        { targets: 1, width: '10%' }, // UpperMenuNo
	        { targets: 2, width: '10%' }, // MenuNo
	        { targets: 3, width: '20%' }, // MenuName
	        { targets: 4, width: '15%' }, // Availability
	        { targets: 5, width: '20%' }, // MenuUrl
	        { targets: 6, width: '10%' }, // Sort Number
	        { targets: 7, width: '10%' }  // Action
        ],
        // Configure select as specified
        select: {
            style: 'multi',
            selector: 'td:first-child'
        }
    });
    
    repositionAndShowButtons();

    // Make each column header resizable
    $('#menuDataTable thead th').resizable({
        handles: 'e', // Only enable resizing from the right edge of each header cell
        alsoResize: $(this).closest('th'), // Ensure the header cell being resized is also resized
        stop: function(event, ui) {
            var tableColumnIndex = ui.helper.index() + 1; // Get the index of the column
            // Adjust the width of the column in the table body
            $('#menuDataTable tbody tr').each(function() {
                $(this).find('td:nth-child(' + tableColumnIndex + ')').width(ui.size.width);
            });
        }
    });
    
    // Iterate through each row in the table
    $('#menuDataTable tbody tr').each(function() {
        // Get the value of "UpperMenuNo" column for the current row
        var upperMenuNo = $(this).find('td.number:eq(0)').text().trim();
        
        // Check if "UpperMenuNo" is 0
        if (upperMenuNo === '0') {
            // If "UpperMenuNo" is 0, find the corresponding "Move" button and disable it
            $(this).find('button.moveButton').prop('disabled', true);
        }
    });
    
    // Move the buttons to the top section
    $('.top').append($('.buttons'));
    
    
    // Custom search functionality for "Menu Name"
    $('#menuNameSearchBox').on('keyup change', function() {
        dataTableInstance.columns(3).search(this.value).draw();
    });
    
    // Event listener for the Edit button
    $('#editButton').click(function() {
        // Hide the Edit button
        $(this).hide();
        // Show the Add, Save, and Cancel buttons
        $('#addButton, #saveButton, #cancelButton').show();
        // Enable all checkboxes
        $('input[type="checkbox"].row-checkbox').prop('disabled', false);
        
    });

 // Event listener for the Cancel button
    $('#cancelButton').click(function() {
        // Hide the Add, Save, and Cancel buttons
        $('#addButton, #saveButton, #cancelButton').hide();
        // Show the Edit button
        $('#editButton').show();
        // Disable all checkboxes
        $('input[type="checkbox"].row-checkbox').prop('disabled', true);
        
        // Uncheck all checkboxes
        $('input[type="checkbox"].row-checkbox').each(function() {
            $(this).prop('checked', false).trigger('change');
        });

        // Remove new rows (marked with the 'new-row' class) from the DataTable
        var table = $('#menuDataTable').DataTable();
        table.rows('.new-row').remove().draw();

        // If there are any additional steps you take when reverting changes on existing rows,
        // include those here. For example, reverting editable fields to their original values.
    });

}

$(document).ready(function() {
    initializeDataTable(); // Call this function to initialize the DataTable when the page is ready
    
    // Initially disable all checkboxes
    $('input[type="checkbox"].row-checkbox').prop('disabled', true);
    
    // Variable to store the previously clicked row
    var previousRow = null;
    
    // Event listener for checkbox changes
    $(document).on('change', 'input[type="checkbox"].row-checkbox', function() {
        var $row = $(this).closest('tr');
        var $checkboxes = $('input[type="checkbox"].row-checkbox');

        // Uncheck all other checkboxes except the current one
        $checkboxes.not(this).prop('checked', false);

        if (this.checked) {
            // If there was a previously clicked row, revert its changes
            if (previousRow !== null && previousRow.get(0) !== $row.get(0)) {
                revertRow(previousRow);
            }
            
            // Make the row editable
            makeRowEditable($row);
            // Set the current row as the previous row
            previousRow = $row;
        } else {
            // Revert changes if checkbox is unchecked
            revertRow($row);
            // Reset the previousRow variable
            previousRow = null;
        }
    });

    // Trigger change event for checked checkboxes on page load
    $('input[type="checkbox"].row-checkbox:checked').each(function() {
        $(this).trigger('change');
    });
});
</script>

<script>

//Function to make a row editable with inline validation for menu name and menu URL
function makeRowEditable($row) {
    $row.find('td').each(function(index) {
        var html = $(this).html();
        $(this).data('original-content', html); // Store the original content

        // Add editable fields based on column index
        if (index === 3) { // MenuName column
            var inputHtml = '<input type="text" class="form-control large-input" value="' + html.trim().replace(/\s+/g, ' ') + '">';
            var messageHtml = '<div class="validation-message">Please enter a valid menu name (max 50 characters)</div>';
            $(this).html(inputHtml).append(messageHtml);
            setupValidation($(this).find('input'), 50, ".validation-message");
        } else if (index === 5) { // MenuUrl column
            var inputHtml = '<input type="text" class="form-control large-input" value="' + html.trim().replace(/\s+/g, ' ') + '">';
            var messageHtml = '<div class="validation-message">Please enter a valid menu URL (max 200 characters)</div>';
            $(this).html(inputHtml).append(messageHtml);
            setupValidation($(this).find('input'), 200, ".validation-message");
        } else if (index === 4) { // Availability column (Use/Not Use)
            var selectHtml = '<select class="form-control small-input">' +
                             '<option value="Y"' + (html === 'Use' ? ' selected' : '') + '>Use</option>' +
                             '<option value="N"' + (html === 'Not Use' ? ' selected' : '') + '>Not Use</option>' +
                             '</select>';
            $(this).html(selectHtml);
        } else if (index === 6) { // Sort Number column
            // Added input field with validation for Sort Number
            var inputHtml = '<input type="text" class="form-control small-input sort-number" value="' + html.trim() + '">';
            $(this).html(inputHtml);
            // Add numeric validation similar to adding new row
            setupValidationForSortNumber($(this).find('.sort-number'));
        }
    });
}

// Setup validation specifically for the Sort Number to ensure it's numeric
function setupValidationForSortNumber($input) {
    $input.on('input', function() {
        var value = this.value.replace(/[^0-9]+/g, '');
        value = parseInt(value, 10);
        if (isNaN(value)) value = '';
        else value = Math.max(1, Math.min(1000, value)); // Enforce range between 1 and 1000
        this.value = value.toString().substring(0, 4); // Max 4 digits
    });
    
    $input.on('keydown', function(e) {
        // Allow backspace, delete, tab, escape, enter, and numbers only
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) || 
            (e.keyCode >= 35 && e.keyCode <= 40)) {
             return; // Let it happen
        }
        // Ensure that it's a number and stop the keypress if not
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
}


// Setup validation for input with a maximum length constraint
function setupValidation($input, maxLength, messageSelector) {
    var validateInput = function() {
        var value = $input.val().trim().replace(/\s+/g, ' ');
        if(value.length > maxLength) {
            $input.next(messageSelector).show();
        } else {
            $input.next(messageSelector).hide();
        }
        // Update the input value with trimmed version
        $input.val(value);
    };

    // Attach keyup and blur event listeners for validation
    $input.on('keyup blur', validateInput);
}




function revertRow($row) {
    $row.find('td').each(function(index) {
        // Skip columns that should not be editable
        if ([3, 4, 5, 6].includes(index)) {
            // Check if the original content is stored
            if ($(this).data('original-content') !== undefined) {
                // Restore the original content
                var originalContent = $(this).data('original-content');
                $(this).html(originalContent);
            }
        }
    });
}
</script>

<script>
$(document).ready(function() {
	
    // Initialize the dialog
    $("#modalMoveMenu").dialog({
        autoOpen: false,
        width: 400,
        modal: true,
        buttons: {
            "Save": function() {
                // Check if both topMenu and upperMenu are selected
                var topMenuNo = $('#topMenuSelect').val();
                var upperMenuNo = $('#upperMenuSelect').val();
                if (!topMenuNo || !upperMenuNo) {
                    alert('Please select both Top Menu and Upper Menu.');
                    return;
                }
                
                // Create the menu object to send to the server
                var menuToMove = {
                    menuNo: $('#modalMenuNo').val(),
                    upperMenuNo: upperMenuNo
                };
                
                // Send the menu object to the server
                updateMenuUpperNo(menuToMove);
                
                $(this).dialog("close");
            },
            "Cancel": function() {
                $(this).dialog("close");
            }
        }
    });


    // Event handler for topMenuSelect change
    $('#topMenuSelect').change(function() {
        var topMenuNo = $(this).val();
        var menuNo = $("#modalMenuNo").val(); // Retrieve menuNo from the hidden field

        if(topMenuNo) {
            // Fetch and populate upperMenuSelect based on selectedTopMenu and menuNoToMove
            fetchUpperMenuListToMove(topMenuNo, menuNo);
        } else {
            $('#upperMenuSelect').html('<option value="">Select Upper Menu</option>').prop('disabled', true); // Reset and disable upperMenuSelect
        }
    });

    // Event handler for move button clicks
    $(document).on('click', '.moveButton', function() {
        var $row = $(this).closest("tr");
        var menuNo = $row.find("td.number:nth-child(3)").text().trim().replace(/,/g, ''); // Extract menu number and remove commas
        var menuName = $row.find("td").eq(3).text().trim(); // Extract menu name

        // Populate modal fields
        $("#modalMenuNo").val(menuNo);
        $("#modalMenuName").val(menuName);

        // Open the modal
        $("#modalMoveMenu").dialog('open');
        
        $('#upperMenuSelect').html('<option value="">Select Upper Menu</option>').prop('disabled', true);

        // Capture the selected menuNo and send it to fetchTopMenu function
        fetchTopMenu(menuNo);
    });
});

function fetchTopMenu(menuNo) {
    $.ajax({
        url: "getTopMenuList.do",
        type: "GET",
        data: {
            menuNoToMove: menuNo  // Pass the selected menuNo as menuNoToMove parameter
        },
        success: function(data) {
            var topMenuSelect = $('#topMenuSelect');
            topMenuSelect.empty().append('<option value="">Select Top Menu</option>');
            $.each(data, function(index, menu) {
                topMenuSelect.append($('<option>', { 
                    value: menu.menuNo,
                    text : menu.menuName 
                }));
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('Error fetching top menu: ', textStatus, errorThrown);
        }
    });
}



function fetchUpperMenuListToMove(topMenuNo, menuNo) { // Change parameter name to menuNo
    // Adjust menuNo format if necessary
    
    $.ajax({
        url: "getUpperMenuListToMove.do",
        type: "GET",
        data: {
            topMenuNo: topMenuNo,
            menuNoToMove: menuNo // Use the adjusted menu number
        },
        success: function(upperMenuList) {
            console.log('Upper Menu List:', upperMenuList); // Log the received menu list
            var upperMenuSelect = $('#upperMenuSelect');
            upperMenuSelect.empty().append('<option value="">Select Upper Menu</option>');
            $.each(upperMenuList, function(index, menu) {
                console.log('Menu:', menu.menuNo, menu.menuName); // Log each menu object
                upperMenuSelect.append($('<option>', { 
                    value: menu.menuNo,
                    text : menu.menuName 
                }));
            });
            upperMenuSelect.prop('disabled', false);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('Error fetching upper menus: ', textStatus, errorThrown);
            $('#upperMenuSelect').html('<option value="">Select Upper Menu</option>').prop('disabled', true);
        }
    });
}

function updateMenuUpperNo(menuToMove) {
    $.ajax({
        url: "updateUpperMenuNo.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(menuToMove),
        success: function(response) {
            // Handle success response
            console.log(response);
            alert("Menu moved successfully");
            window.location.reload();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle error response
            console.error('Error updating menu: ', textStatus, errorThrown);
        }
    });
}

</script>

<script>
function setMenuNumber(clickedMenu) {
    selectedMenuNo = clickedMenu.menuNo; // Update the global variable with the provided menu number
    console.log("Selected menu number1: " + selectedMenuNo);
    // Optionally, you can trigger a click event on the corresponding menu folder element to mimic user selection
    // For example:
    // $('.menu-folder[data-menuNo="' + menuNo + '"]').trigger('click');
}

$(document).ready(function() {
    $('#addButton').click(function() {
        if (typeof selectedMenuNo === 'undefined' || selectedMenuNo === null) {
            alert("Please select a menu first.");
            return;
        }
        
        $('input[type="checkbox"].row-checkbox').prop('disabled', true);
        
        // Uncheck all checkboxes
        $('input[type="checkbox"].row-checkbox').each(function() {
            $(this).prop('checked', false).trigger('change');
        });
        
        var table = $('#menuDataTable').DataTable();

        // Add a new row at the end of the table
        var newRow = table.row.add([
            '<input type="checkbox" class="row-checkbox" name="row-check" disabled>',
            selectedMenuNo, // UpperMenuNo
            '<input type="text" class="form-control small-input" value="" readonly>', // MenuNo
            '<input type="text" class="form-control large-input">', // MenuName
            '<select class="form-control small-input"><option value="Y">Use</option><option value="N">Not Use</option></select>', // Availability
            '<input type="text" class="form-control large-input">', // MenuUrl
            '<input type="text" class="form-control small-input sort-number" placeholder="Sort Number">', // Sort Number
            '<button class="deleteButton">Delete</button>' // Delete button
        ]).draw(false).node();

        $(newRow).addClass('new-row');

        // Add validation message placeholders for new inputs
        var menuNameValidationHtml = '<div class="validation-message" style="display: none;">Please enter a valid menu name (max 50 characters)</div>';
        var menuUrlValidationHtml = '<div class="validation-message" style="display: none;">Please enter a valid menu URL (max 200 characters)</div>';

        // Append validation messages to the MenuName and MenuUrl columns
        $(newRow).find('td').eq(3).append(menuNameValidationHtml);
        $(newRow).find('td').eq(5).append(menuUrlValidationHtml);

        // Setup validation for newly added row
        setupValidation($(newRow).find('.large-input').eq(0), 50, $(newRow).find('.validation-message').eq(0));
        setupValidation($(newRow).find('.large-input').eq(1), 200, $(newRow).find('.validation-message').eq(1));

        // Focus on the first input element for MenuName
        $(newRow).find('input[type="text"]').not('[readonly]').first().focus();
        
        $(newRow).find('.sort-number').on('input', function() {
            var value = this.value.replace(/[^0-9]+/g, ''); // Remove non-numeric characters
            value = parseInt(value, 10);
            if (isNaN(value)) {
                value = '';
            } else {
                value = Math.max(1, Math.min(1000, value)); // Enforce 1-1000 range
            }
            this.value = value.toString().substring(0, 4); // Enforce max 4 digits
        });
        
        // Add event listener to newly added sort number input to prevent invalid characters
        $(newRow).find('.sort-number').on('keydown', function (e) {
            // Allow: backspace, delete, tab, escape, and enter
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                 // Allow: Ctrl+A, Command+A
                (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
                 // Allow: home, end, left, right, down, up
                (e.keyCode >= 35 && e.keyCode <= 40)) {
                     // let it happen, don't do anything
                     return;
            }
            // Ensure that it is a number and stop the keypress for other keys
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });
    });

    // Code for setupValidation function...
    function setupValidation($input, maxLength, $message) {
        var validateInput = function() {
            var value = $input.val();
            if (value.length > maxLength) {
                $message.show();
            } else {
                $message.hide();
            }
        };

        $input.on('keyup blur', validateInput);
    }
    
    // Event listener for the delete button
    $(document).on('click', '.deleteButton', function() {
        var table = $('#menuDataTable').DataTable();
        var row = $(this).closest('tr');
        table.row(row).remove().draw(false);
    });
});

</script>

<script>
$(document).ready(function() {
    $('#saveButton').click(function() {
        // Check for visible validation messages
        var validationErrorsExist = $('.validation-message:visible').length > 0;
        
        // If there are visible validation messages, alert the user and halt the operation
        if (validationErrorsExist) {
            alert('Please correct the validation errors before saving.');
            return; // Exit the function to prevent further execution
        }
    
        var newRows = [];
        var allSortNumbers = []; // Array to store all sort numbers including existing ones
        var isAllFieldsValid = true;

        // Collect and validate existing sort numbers
        $('#menuDataTable tbody tr').each(function() {
            var existingSortNumber = $(this).find('td:nth-child(7)').text().trim();
            if (existingSortNumber) {
                allSortNumbers.push(existingSortNumber);
            }
        });

        // Handle new rows
        $('#menuDataTable tbody tr.new-row').each(function() {
            var rowData = collectRowData($(this));
            if (!validateRowData(rowData)) {
                isAllFieldsValid = false;
                return false; // Stop if invalid
            }
            newRows.push(rowData);
            allSortNumbers.push(rowData.sortNumber); // Add new sort number for validation
        });

        if (!isAllFieldsValid) {
            return; // Stop if any field is invalid
        }

        var sortNumbers = {}; // Object to hold sort numbers for uniqueness check
        var hasDuplicate = false; // Flag to track duplicates

        // Iterate through each row to collect sort numbers
        $('#menuDataTable tbody tr').each(function() {
        	var sortNumber = $(this).find('td:nth-child(7) input').val() || $(this).find('td:nth-child(7)').text();
        	if (sortNumber) { // Check if sortNumber exists before trimming
        	    sortNumber = sortNumber.trim();
                if (sortNumbers[sortNumber]) {
                    hasDuplicate = true; // Mark as duplicate found
                    return false; // Exit loop
                } else {
                    sortNumbers[sortNumber] = true; // Mark this sort number as seen
                }
            }
        });

        if (hasDuplicate) {
            alert("Please enter unique Sort Number");
            return; // Stop execution if duplicate sort number found
        }
        // Handle update if only one checkbox is selected
        var $checkedRow = $('input[type="checkbox"]:checked').closest('tr');
        if ($checkedRow.length === 1) {
            var updateData = collectRowData($checkedRow);
            if (!validateRowData(updateData)) {
                return; // Stop if the row to update is invalid
            }
            updateMenu(updateData, 'updateMenu.do', 'Menu updated successfully');
        }

        // Create new menus if any
        if (newRows.length > 0) {
            createMenu(newRows, 'createMenu.do', 'Menu added successfully');
        }
    });
});



function collectRowData($row) {
    // Extract and return data from a row, removing commas from numeric values
    return {
        upperMenuNo: removeCommas($row.find('td:nth-child(2)').text().trim()),
        menuNo: $row.hasClass('new-row') ? null : removeCommas($row.find('td:nth-child(3)').text().trim()),
        menuName: $row.find('td:nth-child(4) input').val().trim(),
        useYn: $row.find('td:nth-child(5) select').val(),
        menuUrl: $row.find('td:nth-child(6) input').val().trim(),
        sortNumber: removeCommas($row.find('td:nth-child(7) input').val().trim())
    };
}

function removeCommas(value) {
    // Remove commas from the string and return it
    return value.replace(/,/g, '');
}

function validateRowData(rowData) {
    // Implement validation logic for rowData
    if (!rowData.menuName || !rowData.sortNumber) {
        alert("Menu Name and Sort Number must not be empty.");
        return false;
    }
    return true;
}

function createMenu(newMenus, url, successMessage) {
    $.ajax({
        url: url,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(newMenus),
        success: function(response) {
            alert(successMessage);
            // Refresh the page or data table here to reflect new menu items
            window.location.reload();
        },
        error: function(error) {
            alert('Error creating menu: ' + error.responseText);
        }
    });
}

function updateMenu(updateData, url, successMessage) {
    $.ajax({
        url: url,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(updateData),
        success: function(response) {
            alert(successMessage);
            // Refresh the page or data table here to reflect updated menu items
            window.location.reload();
        },
        error: function(error) {
            alert('Error updating menu: ' + error.responseText);
        }
    });
}


</script>




<script>
$('#downloadPdf').on('click', function(e) {
    e.preventDefault();

    var menuName = "MenuList";
    var fileName = "MenuList.pdf";

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
            $('#menuDataTable thead tr').each(function() {
                var rowData = [];
                $(this).find('th').each(function() {
                    rowData.push($(this).text());
                });
                tableData.push(rowData);
            });
            $('#menuDataTable tbody tr').each(function() {
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

    var menuName = "MenuList";
    var fileName = "MenuList.xlsx";

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

            downloadExcel('menuDataTable', fileName);
        },
        error: function(xhr, status, error) {
            alert("Error: " + xhr.responseText);
        }
    });
});
</script>