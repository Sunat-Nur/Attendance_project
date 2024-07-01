<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>

<head>
 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/webProject/resources/css/layout.css" type="text/css"/>
    
    <title>Group Form</title>
    <style>
    	
        /* Add your custom styles here */
        .authEdit .section {
            padding: 15px; /* Adjust the padding as necessary */
            margin-bottom: 20px; /* Space between sections */
            border: 1px solid #ddd; /* Light grey border */
            background-color: #f9f9f9; /* Light grey background */
            border-radius: 5px; /* Slightly rounded corners for the border */
        }

        /* Style for the table and its container */
        .authEdit .table-container {
            padding: 15px;
            margin-bottom: 20px; /* Same as .section for consistency */
        }


        /* Align buttons with proper spacing */
        .authEdit .button-row {
            padding: 15px;
            display: flex;
            justify-content: space-between; /* This will space out your buttons */
        }
        
     	.authEdit {
        	font-size: 12px; /* Adjust this value as needed */
     	}
        
    	.authEdit button {
            border: none;
            color: white;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 0;
            cursor: pointer;
            border-radius: 4px;
     	}
     	
     	.authEdit .saveButton, .authEdit .addButton, .authEdit .addUser {
     		background-color: #0080ff;
     	}
     	
     	.authEdit .deleteButton {
     		background-color: #ff5c33;
     	}
     	
     	.authEdit .cancelButton {
     		background-color: #8c8c8c;
     	}
     	
     	/* Make the close icon always visible */
		.authEdit .modal-header .close {
		    opacity: 1;
		}
		
		/* Change the color of the close icon to black */
		.authEdit .modal-header .close span {
		    color: black;
		    font-size: 24px; /* You can adjust the font-size as needed */
		}
    </style>
</head>

<div id="pageContent">
	<div class="authEdit">
    <form action="authEdit.do" method="post" class="mb-3">
        <div class="form-group text-right">
            <h4 align="left">Authority Group Edit</h4>
            <button type="submit" class="saveButton">Save</button>
          	<button type="button" class="cancelButton" onclick="location.href='authorityList.do'">Cancel</button>
        </div>

        <!-- Group Details Section -->
        <div class="bordered-box">
            <h6>Group Details</h6>
            <input type="hidden" id="groupNo" name="groupNo" value="${authority.groupNo}">
            <div class="form-group">
                <label for="groupName">Group Name:</label>
                <input type="text" id="groupName" name="groupName" style="font-size: 12px;" class="form-control" value="${authority.groupName}"required>
                <div class="group-name-validation-message" style="color: red; display: none;">Input cannot exceed 50 characters</div>
            </div>

            <div class="form-group">
                <label for="groupDescription">Description:</label>
                <textarea id="groupDescription" name="groupDescription" style="font-size: 12px;" class="form-control"required>${authority.groupDescription}</textarea>
            </div>

            <div class="form-group">
                <label>Used / Not Used:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="useYn" name="useYn" value="Y" ${authority.useYn == 'Y' ? 'checked' : ''} >
                    <label class="form-check-label" for="use">Use</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="useYn" name="useYn" value="N" ${authority.useYn == 'N' ? 'checked' : ''} >
                    <label class="form-check-label" for="notUse">Not Use</label>
                </div>
            </div>
        </div>

        <!-- User Details and Menu Tree Section -->
        <div class="row">
            <!-- User Permissions Table -->
            <div class="col-md-6 bordered-box">
                <h6>User Permissions</h6>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Name</th>
                                <th>Group</th>
                                <th>Designation</th>
                                <th>Department</th>
                                <th>Security Level</th>
                            </tr>
                        </thead>
                        <!-- ...existing table structure... -->
                        <tbody id="userPermissionsTableBody">
                            <c:forEach items="${authUserList}" var="userList">
                                <tr>
                                    <td><input type="checkbox" class="delete-checkbox" value="${userList.userDetails.empId}"></td>
                                    <td>${userList.userDetails.name}</td>
                                    <td>${userList.userDetails.group}</td>
                                    <td>${userList.userDetails.designation}</td>
                                    <td>${userList.userDetails.department}</td>
                                    <td>${userList.userDetails.securityLevel}</td>
                                    <td style="display: none;">
                                        <input type="hidden" name="selectedUsers" value="${userList.userDetails.empId}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <!-- ... -->
                    </table>
                    <button type="button" class="addButton" data-toggle="modal" data-target="#userModal">Add</button>
                    <button type="button" id="deleteSelectedButton" class="deleteButton">Delete</button>
                </div>
            </div>

            <!-- Menu Tree -->
            <div class="col-md-6 bordered-box">
                <h6>Menu Tree</h6>
                <div class="list-group">
                    <c:forEach items="${menuTree.root.children}" var="menuNode">
                        <c:set var="menuNode" value="${menuNode}" scope="request" />
                        <jsp:include page="recursiveMenuRenderer.jsp" />
                    </c:forEach>
                </div>
            </div>
        </div>
    </form>

    <!-- Modal -->
    <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userModalLabel">Select User</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Dropdown for Selecting Group -->
                    <div class="form-group">
                        <label for="selectGroup">Select Group:</label>
                        <select class="form-control" id="selectGroup" name="group">
                            <option value="" selected>Select Group</option>
                            <option value="group1">Technical</option>
                            <option value="group2">Support</option>
                            <!-- Add more group options as needed -->
                        </select>
                    </div>

                    <!-- Dropdown for Selecting Department -->
                    <div class="form-group">
                        <label for="selectDepartment">Select Department:</label>
                        <select class="form-control" id="selectDepartment" name="department">
                            <!-- Options will be dynamically added here -->
                        </select>
                    </div>

                    <!-- Table for Displaying Users -->
                    <table class="table" id="usersTable">
                        <thead>
                            <tr>
                                <th scope="col"></th> <!-- For checkboxes -->
                                <th scope="col">Name</th>
                                <th scope="col">EmpId</th>
                                <th scope="col">Designation</th>
                                <th scope="col">Security Level</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- User rows will be added here dynamically -->
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="addUser" id="addUserButton" disabled>Add User</button>
                </div>
            </div>
        </div>
    </div>
 </div>
</div>

<script>
$(document).ready(function() {
    // Event Handlers
    $('#selectGroup').change(function () {
        fetchDepartments($(this).val());
    });

    $('#selectDepartment').change(function () {
        fetchUsersByDepartment($(this).val());
    });

    $('#usersTable').on('change', 'input[type="checkbox"]', function() {
        var anyChecked = $('#usersTable input[type="checkbox"]:checked').length > 0;
        $('#addUserButton').prop('disabled', !anyChecked);
    });

    $('#addUserButton').click(function() {
        addSelectedUsers();
        $('#userModal').modal('hide');
    });

    document.getElementById('deleteSelectedButton').addEventListener('click', function() {
        if (confirm('Are you sure you want to delete the selected rows?')) {
            $('.delete-checkbox:checked').each(function() {
                $(this).closest('tr').remove();
            });
        }
    });

    $('#userModal').on('hidden.bs.modal', function() {
        resetModal();
    });
});

function fetchDepartments(groupValue) {
    var groupNameMap = {
        'group1': 'Technical',
        'group2': 'Support'
    };

    var groupName = groupNameMap[groupValue];
    $.ajax({
        url: 'departments.do',
        type: 'GET',
        data: { group: groupName },
        success: function(departmentData) {
            var departmentSelect = $('#selectDepartment').empty();
            departmentSelect.append(new Option("Select Department", ""));
            departmentData.forEach(function(department) {
                departmentSelect.append(new Option(department, department));
            });
        },
        error: function() {
            console.error("Error fetching departments for group " + groupName);
            $('#selectDepartment').empty().append(new Option("Failed to load departments", ""));
        }
    });
}

function fetchUsersByDepartment(departmentName) {
    $.ajax({
        url: 'departmentUsers.do',
        type: 'GET',
        data: { department: departmentName },
        success: function(userData) {
            var usersTableBody = $('#usersTable').find('tbody').empty();
            userData.forEach(function(user) {
                var row = $('<tr></tr>');
                row.append($('<td><input type="checkbox" name="userSelect" value="' + user.empId + '"></td>'));
                row.append($('<td></td>').text(user.name));
                row.append($('<td></td>').text(user.empId));
                row.append($('<td></td>').text(user.designation));
                row.append($('<td></td>').text(user.securityLevel));
                usersTableBody.append(row);
            });
        },
        error: function() {
            console.error("Error fetching users for department " + departmentName);
        }
    });
}

function addSelectedUsers() {
    var selectedGroupName = $('#selectGroup option:selected').text();
    var selectedDepartmentName = $('#selectDepartment option:selected').text();

    $('#usersTable tbody tr').each(function() {
        var row = $(this);
        var checkbox = row.find('input[type="checkbox"]:checked');
        if (checkbox.length) {
            var empId = row.find('td:nth-child(3)').text().trim();
            if (!isUserAlreadyAdded(empId)) {
                var newRow = $('<tr></tr>');
                newRow.append($('<td><input type="checkbox" class="delete-checkbox" value="' + empId + '"/></td>'));
                newRow.append($('<td>' + row.find('td:nth-child(2)').text() + '</td>'));
                newRow.append($('<td>' + selectedGroupName + '</td>'));
                newRow.append($('<td>' + row.find('td:nth-child(4)').text() + '</td>'));
                newRow.append($('<td>' + selectedDepartmentName + '</td>'));
                newRow.append($('<td>' + row.find('td:nth-child(5)').text() + '</td>'));
                newRow.append($('<td style="display: none;"><input type="hidden" name="selectedUsers" value="' + empId + '"/></td>'));
                $('#userPermissionsTableBody').append(newRow);
            }
        }
    });
}

function isUserAlreadyAdded(empId) {
    var isAdded = false;
    $('#userPermissionsTableBody').find('input[type="hidden"][name="selectedUsers"]').each(function() {
        if ($(this).val() === empId) {
            isAdded = true;
            return false;
        }
    });
    return isAdded;
}

function resetModal() {
    $('#selectGroup').val('');
    $('#selectDepartment').empty().append(new Option("Select Department", ""));
    $('#usersTable tbody').empty();
    $('#addUserButton').prop('disabled', true);
}
</script>
<script>
$(document).ready(function() {
    // Function to check if any field has an error
    function hasError() {
        var groupNameLength = $('#groupName').val().length;
        if (groupNameLength > 50) {
            $('.group-name-validation-message').show(); // Show error message for group name length
            return true;
        } else {
            return false;
        }
    }

    // Function to display warning message
    function displayWarning(message) {
        // You can customize how you want to display the warning message, such as using a modal or a toast notification
        alert(message);
    }

    // Submit event handler for the form
    $('form').submit(function(e) {
        if (hasError()) {
            e.preventDefault(); // Prevent form submission
            displayWarning("Please fix the errors before saving."); // Display warning message
        } else {
            // If no errors, proceed with form submission
            // You can also add additional validation logic here if needed
        }
    });

    // Input event handler for group name field
    $('#groupName').on('input', function() {
        var inputVal = $(this).val();
        if (inputVal.length > 50) {
            $('.group-name-validation-message').show();
        } else {
            $('.group-name-validation-message').hide();
        }
    });
});
</script>

<!-- jQuery, Popper.js, and Bootstrap JS -->