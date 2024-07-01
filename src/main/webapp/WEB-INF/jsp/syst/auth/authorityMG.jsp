<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
	<title>Authority Management</title> 
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">

<style>        
	.edit-btn {
	    color: #007bff; 
	    text-decoration: none;
	}
	      
	.edit-btn:hover {
	    text-decoration: underline;
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
	#authorityTable {
	    border-collapse: collapse;
	    font-size: 13px;
	    table-layout: fixed;
	}

	#authorityTable th, #authorityTable td {
	    text-align: center;
	    padding: 5px;
	    border: 1px solid grey; /* Add border to th and td */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}

	#authorityTable tr:nth-child(even) {
	    background-color: #e6e6e6;
	}
	
	#authorityTable th {
	    background-color: #a6a6a6;
	    color: black;
	}
      
      /* Custom styles for table row */
	#authorityTable tr.custom-row-style td {
	    background-color: #e6e6e6; /* Your desired background color */
	    color: black; /* Your desired text color */
	}
	
	#authorityTable tr:nth-child(even).custom-row-style td {
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
		    <span>Group Name:</span>
		    <input type="text" id="groupNameSearchBox" placeholder="Search by Group Name">
		</div><br>
		<div class="addButton">
		    <button onclick="location.href='authorityAdd.do'">Add</button>
		</div>
                
		<table id="authorityTable" class="display table table-striped table-bordered table-sm">
		    <thead>
		        <tr>
		            <th>Group Name</th>
		            <th>Description</th>
		            <th>Used / Not Used</th>
		            <th>Action</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="authority" items="${authorityList}">
		            <tr>
		                <td>${authority.groupName}</td>
		                <td>${authority.groupDescription}</td>
		                <td>${authority.useYn == 'Y' ? 'Use' : 'Not Use'}</td>
		                <td>
		                    <a href="/webProject/syst/auth/editAuthority.do?id=${authority.groupNo}" class="edit-btn">Edit</a>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>

    </div>

<script>
var dataTableInstance;

$(document).ready(function() {
	dataTableInstance = $('#authorityTable').DataTable({
        "pagingType": "full_numbers",
        "searching": true,
        "dom": '<"top"lr>t<"bottom"ip><"clear">',
        "createdRow": function(row, data, dataIndex) {
            $(row).addClass('custom-row-style');
        }
    });

    $('.top').append($('.addButton'));

    // Custom search functionality for "Code Name"
    $('#groupNameSearchBox').on('keyup change', function() {
        dataTableInstance.columns(0).search(this.value).draw();
    });
});
</script>