<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/layout/subHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Emp Details</title>

<style>
       
     .user-details-table {
   margin-left: auto;
   margin-right: auto;
   width: 85%;
   border-collapse: collapse;
     	font-family: Calibri, sans-serif;
}

   .user-details-table th,
   .user-details-table td {
       border: 1px solid #ddd;
       padding: 8px;
       text-align: left;
       vertical-align: center;
   }

   .user-details-table th {
       background-color: #f2f2f2;
       text-align: right;
       width: 15%;
       font-size: 14px; /* Adjusted font size for th */
       color: #333; /* Adjusted text color for th */
   }

   .user-details-table td {
       background-color: #fff;
       font-size: 12px; /* Adjusted font size for td */
       width: 17%;
       
   }
   .container {
       width: 90%;
       margin: 0 auto;
       text-align: center;
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
		cursor: pointer;
		border-radius: 4px;
		margin-right: 10px;
 	}
 	
 	.form-buttons {
 		display: flex;
    	justify-content: flex-start;
    	margin-left: 100px;
 	}
 	
 	#deleteUserForm button {
 		background-color: #ff5c33;
 	}
 	
   .icon-input-container {
	   position: relative;
	   display: inline-block;
	}
	
	.password-field {
	   padding-right: 30px; /* Make padding to prevent text from being under the icon */
	}

	.eye-icon {
	   position: absolute;
	   right: 10px; /* Adjust as needed */
	   top: 50%;
	   transform: translateY(-50%);
	   cursor: pointer;
	   color: #065c9d; /* Adjust the color as needed */
	}

	.user-details-table input {
		font-size: 12px;
	}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div id="pageContent">
<div class="container">
<h2>Emp Details</h2>

<div class="form-buttons">
	   <form action="editEmpDetails.do" method="get" style="display: inline;">
	       <input type="hidden" name="empId" value="${userDetails.empId}" />
	       <button type="submit">Edit</button>
	   </form>
	
	  <form id="deleteUserForm" action="deleteEmployee.do" method="post" style="display: inline;">
		    <input type="hidden" name="empId" value="${userDetails.empId}">
		    <c:if test="${loggedInUser.designation == 'CEO' || loggedInUser.designation == 'Admin'}">
		        <button type="submit">Delete</button>
		    </c:if>
	  </form>
  </div>

   
<table class="user-details-table">
     <tr>
          <th>Date of Joining</th>
         <td>
            <input type="text" name="dateOfJoining" id="dateOfJoining" data-fieldname="dateOfJoining" value="<fmt:formatDate value='${userDetails.dateOfJoining}' pattern='yyyy-MM-dd' />" disabled/>
              </td>
         
          <th>Emp Id</th>
              <td>
                 <input type="text" id="empId" name="empId" data-fieldname="empId" value="${userDetails.empId}" disabled />
              </td>
             
          <th>Security</th>
         <td>
            <input type="text" id="securityLevel" name="securityLevel" data-fieldname="securityLevel" value="${userDetails.securityLevel}" disabled />
         </td>
</tr>
 <tr>
          <th>Name</th>
         <td>
            <input type="text" id="name" name="name" data-fieldname="name" value="${userDetails.name}" disabled />
              </td>
         
          <th>Password</th>
              <td>
                 <div class="password-container icon-input-container">
                 <input type="text" id="password" name="password" data-fieldname="password" value="${userDetails.password}" disabled />
                 <i class="fas fa-eye eye-icon" id="togglePassword"></i>
                 </div>
              </td>
          <th>Date of Birth</th>
         <td>
            <input type="text" name="dateOfBirth" id="dateOfBirth" data-fieldname="dateOfBirth" value="<fmt:formatDate value='${userDetails.dateOfBirth}' pattern='yyyy-MM-dd' />" disabled/>
         </td>
</tr>
 <tr>
          <th>Group</th>
         <td>
            <input type="text" id="group" name="group" data-fieldname="group" value="${userDetails.group}" disabled />
              </td>
         
          <th>Department</th>
              <td>
                 <input type="text" id="department" name="department" data-fieldname="department" value="${userDetails.department}" disabled />
              </td>
             
          <th>Designation</th>
         <td>
            <input type="text" id="designation" name="designation" data-fieldname="designation" value="${userDetails.designation}" disabled />
         </td>
</tr>
 <tr>
          <th>Gender</th>
         <td>
           <input type="text" id="gender" name="gender" data-fieldname="gender" value="${userDetails.gender}" disabled />
              </td>
         
          <th>Religion</th>
              <td>
                 <input type="text" id="religion" name="religion" data-fieldname="religion" value="${userDetails.religion}" disabled />
              </td>
             
          <th>Address</th>
         <td>
            <input type="text" id="address" name="address" data-fieldname="address" value="${userDetails.address}" disabled />
         </td>
</tr>
<tr>
          <th>Cellphone</th>
         <td>
            <input type="text" id="cellPhone" name="cellPhone" data-fieldname="cellPhone" value="${userDetails.cellPhone}" disabled />
              </td>
         
          <th>Email</th>
              <td>
                 <input type="text" id="email" name="email" data-fieldname="email" value="${userDetails.email}" disabled />
              </td>
             
          <th>Emergency contact</th>
         <td>
            <input type="text" id="emergencyContact" name="emergencyContact" data-fieldname="emergencyContact" value="${userDetails.emergencyContact}" disabled />
         </td>
</tr>
 <tr>
          <th>Final Degree</th>
         <td>
            <input type="text" id="finalDegree" name="finalDegree" data-fieldname="finalDegree" value="${userDetails.finalDegree}" disabled />
              </td>
         
          <th>University</th>
              <td>
                 <input type="text" id="university" name="university" data-fieldname="university" value="${userDetails.university}" disabled />
              </td>
             
          <th>Language</th>
         <td>
            <input type="text" id="language" name="language" data-fieldname="language" value="${userDetails.language}" disabled />
         </td>
</tr>
<tr>
          <th>Career</th>
         <td>
           <input type="text" id="careerExperience" name="careerExperience" data-fieldname="careerExperience" value="${userDetails.careerExperience}" disabled />
              </td>
         
          <th>Year</th>
              <td>
                 <input type="text" id="yearOfWorking" name="yearOfWorking" data-fieldname="yearOfWorking" value="${userDetails.yearOfWorking}" disabled />
              </td>
             
          <th>Salary</th>
         <td>
            <input type="text" id="salary" name="salary" data-fieldname="salary" value="${userDetails.salary}" disabled />
         </td>
</tr>
 <tr>
          <th>Marital Status</th>
         <td>
            <input type="text" id="maritalStatus" name="maritalStatus" data-fieldname="maritalStatus" value="${userDetails.maritalStatus}" disabled />
              </td>
         
          <th>Disablity</th>
              <td>
                 <input type="text" id="disability" name="disability" data-fieldname="disability" value="${userDetails.disability}" disabled />
              </td>
             
          <th>Significant</th>
         <td>
            <input type="text" id="significant" name="significant" data-fieldname="significant" value="${userDetails.significant}" disabled />
         </td>
</tr>
 <tr>
    <th>Contract Files</th>
    <td>
        <c:choose>
            <c:when test="${empty contractFiles}">
                <input type="text" value="No file uploaded" disabled/>
            </c:when>
            <c:otherwise>
                <c:forEach var="file" items="${contractFiles}">
                    <div style="margin-bottom: 5px;">
                        <input type="text" value="${file.fileName}" disabled/>
                        <a href="/webProject/syst/user/downloadFile.do?fileNo=${file.no}"><i class="fa-solid fa-download" style="color: #3861a8;"></i></a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </td>
    
    <th>Certificate Files</th>
    <td>
        <c:choose>
            <c:when test="${empty certificateFiles}">
                <input type="text" value="No file uploaded" disabled/>
            </c:when>
            <c:otherwise>
                <c:forEach var="file" items="${certificateFiles}">
                    <div style="margin-bottom: 5px;">
                        <input type="text" value="${file.fileName}" disabled/>
                        <a href="/webProject/syst/user/downloadFile.do?fileNo=${file.no}"><i class="fa-solid fa-download" style="color: #3861a8;"></i></a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </td>
    
    
    <th>Resume Files</th>
    <td>
        <c:choose>
            <c:when test="${empty resumeFiles}">
                <input type="text" value="No file uploaded" disabled/>
            </c:when>
            <c:otherwise>
                <c:forEach var="file" items="${resumeFiles}">
                    <div style="margin-bottom: 5px;">
                        <input type="text" value="${file.fileName}" disabled/>
                        <a href="/webProject/syst/user/downloadFile.do?fileNo=${file.no}"><i class="fa-solid fa-download" style="color: #3861a8;"></i></a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </td>
</tr>

<tr>
          <th>Date of Resignation</th>
         <td>
            <input type="text" name="dateOfResignation" id="dateOfResignation" data-fieldname="dateOfResignation" value="<fmt:formatDate value='${userDetails.dateOfResignation}' pattern='yyyy-MM-dd' />" disabled/>
              </td>
         
          <th>Reason for Resignation</th>
              <td>
                 <input type="text" id="reasonForResignation" name="reasonForResignation" data-fieldname="reasonForResignation" value="${userDetails.reasonForResignation}" disabled />
              </td>
             
          <th>Re-Join Date</th>
         <td>
            <input type="text" name="reJoin" id="reJoin" data-fieldname="reJoin" value="<fmt:formatDate value='${userDetails.reJoin}' pattern='yyyy-MM-dd' />" disabled/>
         </td>
</tr>
 <tr>
          <th>Recruitment Route</th>
         <td>
            <input type="text" id="recruitmentRoute" name="recruitmentRoute" data-fieldname="recruitmentRoute" value="${userDetails.recruitmentRoute}" disabled />
              </td>
         
          <th>Recommender</th>
              <td>
                 <input type="text" id="recommender" name="recommender" data-fieldname="recommender" value="${userDetails.recommender}" disabled />
              </td>
             
           <td colspan="2"></td>
</tr>
 </table>
 </div>
 </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
   var togglePassword = document.getElementById('togglePassword');
   var password = document.getElementById('password');

   togglePassword.addEventListener('click', function (e) {
       // toggle the type attribute
       var type = password.getAttribute('type') === 'password' ? 'text' : 'password';
       password.setAttribute('type', type);
       
       // toggle the eye / eye slash icon
       this.classList.toggle('fa-eye');
       this.classList.toggle('fa-eye-slash');
   });
});
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var formatPhoneNumber = function(phoneNumber) {
        if (phoneNumber) {
            var parts = phoneNumber.split(' ');
            var countryCode = parts[0];
            var number = parts[1];
            
            // Reverse phone number
            number = number.split('').reverse().join('');
            
            // Add dash after every group of five digits except for the last group
            number = number.replace(/(.{5})(?!$)/g, '$1-');
            
            // Reverse phone number again
            number = number.split('').reverse().join('');
            
            // Concatenate country code and formatted phone number
            var formattedNumber = countryCode + '-' + number;
            return formattedNumber;
        }
        return phoneNumber;
    };

    var cellPhoneInput = document.getElementById('cellPhone');
    var emergencyContactInput = document.getElementById('emergencyContact');

    if (cellPhoneInput) {
        cellPhoneInput.value = formatPhoneNumber(cellPhoneInput.value);
    }

    if (emergencyContactInput) {
        emergencyContactInput.value = formatPhoneNumber(emergencyContactInput.value);
    }
});
</script>


 </body>
</html>