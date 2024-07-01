package syst.main.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import syst.org.service.DepartmentService;
import syst.org.service.GroupService;
import syst.org.vo.GroupVO;
import syst.user.service.UserService;
import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;


@RequestMapping("/syst/reg")
@Controller
public class RegisterController {


@Autowired
private UserService userService;

    @Autowired
    private JavaMailSender mailSender;
   
    @Autowired
    private GroupService groupService;
   
    @Autowired
    private DepartmentService departmentService;


    @GetMapping("/registerEmployeeByLink.do")
    public String registerEmployeeByCEO(ModelMap model, HttpServletRequest request) {
        UserMgVO user = (UserMgVO) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            // No user is logged in, redirect to login page
            return "redirect:/syst/main/login.do";
        }

            UserMgVO loggedInUser = userService.getUserByEmpId(user.getEmpId());

                List<GroupVO> groupList = groupService.getAllGroup();
                model.addAttribute("loggedInUser", loggedInUser);
                model.addAttribute("groupList", groupList);
                return "atnd/employee/registerEmpByLink";
    }


@PostMapping("/sendRegistrationEmail.do")
public ResponseEntity<Map<String, String>> sendRegistrationEmail(@RequestBody Map<String, String> requestData) {
  Map<String, String> response = new HashMap<>();

  try {
      String email = requestData.get("email");
      String empId = requestData.get("empId");
      String dateOfJoiningStr = requestData.get("dateOfJoining");
      String groupName = requestData.get("groupName");
      String groupNo = requestData.get("groupNo");
      String uniqueCode = UUID.randomUUID().toString();
      String yearOfWorkingStr = requestData.get("year");
      Integer yearOfWorking = Integer.parseInt(yearOfWorkingStr);

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Date dateOfJoining = sdf.parse(dateOfJoiningStr);

      SimpleMailMessage message = new SimpleMailMessage();
      message.setFrom("teamfuturesquad6@gmail.com");
      message.setTo(email);
      message.setSubject("Employee Registration Link");

      // Include the groupName as a query parameter in the registration link
      String registrationLink = "http://india-intra.grcworks.kr/webProject/syst/reg/register.do?token=" + uniqueCode + "&empId=" + empId + "&groupName=" + groupName + "&groupNo=" + groupNo;
      message.setText("Click the link to register: " + registrationLink);

      mailSender.send(message);

      UserMgVO newEmployee = new UserMgVO();

      newEmployee.setEmail(email);
      newEmployee.setEmpId(empId);
      newEmployee.setDateOfJoining(dateOfJoining);
      newEmployee.setRegisterToken(uniqueCode);
      newEmployee.setRegisterStatus("Pending");
      newEmployee.setGroup(groupName); // Associate the group with the employee
      newEmployee.setYearOfWorking(yearOfWorking);

      userService.createUser(newEmployee);

      response.put("status", "success");
      return new ResponseEntity<>(response, HttpStatus.OK);
  } catch (Exception e) {
      response.put("status", "error");
      response.put("error", e.getMessage());
      return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
  }
}


    @GetMapping("/registrationSucess.do")
    public String showRegisterSuccess() {
    	return "syst/main/registerSuccess";
    }


	@GetMapping("/register.do")
	public String showRegisterPage(@RequestParam String token, @RequestParam String empId, ModelMap model, HttpServletRequest request) {
	  if (!userService.isValidToken(token)) {
	      model.addAttribute("error", "Invalid or expired token");
	      return "error/invalidToken";
	  }
	  model.addAttribute("empId", empId);
	 
	  // Pass the groupName as a read-only attribute to the registration page
	  String groupName = request.getParameter("groupName"); // Get groupName from the request
	  model.addAttribute("groupName", groupName);
	 
	  return "syst/main/register";
	}


	@PostMapping("/register.do")
	public ResponseEntity<String> submitRegistrationOrUpdate(
			@ModelAttribute UserMgVO employee,
			MultipartHttpServletRequest request) {
		try {
			String empId = employee.getEmpId();
	
			// Check and retrieve employee record from the database
			UserMgVO existingEmployee = userService.getUserByEmpId(empId);
			if (existingEmployee == null) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Employee record not found.");
			}
   
		if (existingEmployee.getRegisterToken()== null) { // Check if token is null
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid token.");
		}
   
		// Update the employee object with new data from the form
		existingEmployee.setName(employee.getName());
		existingEmployee.setPassword(employee.getPassword());
		existingEmployee.setGroup(employee.getGroup());
		existingEmployee.setDepartment(employee.getDepartment());
		existingEmployee.setDesignation(employee.getDesignation());
		existingEmployee.setUniversity(employee.getUniversity());
		existingEmployee.setSecurityLevel(employee.getSecurityLevel());
		existingEmployee.setFinalDegree(employee.getFinalDegree());

	  // Extract and concatenate address components
	  String addressLine1 = request.getParameter("addressLine1");
	  String addressLine2 = request.getParameter("addressLine2");
	  String city = request.getParameter("city");
	  String state = request.getParameter("state");
	  String country = request.getParameter("country");
	  String zipCode = request.getParameter("postalCode");

           // Construct the full address string with names
           String fullAddress = String.join(", ", addressLine1, addressLine2, city, state, country, zipCode);
           existingEmployee.setAddress(fullAddress);

           existingEmployee.setCellPhone(employee.getCellPhone());
//           existingEmployee.setRegisterToken(null);

           // Parse and set career experience
           String careerExperienceStr = request.getParameter("careerExperience");
           if (careerExperienceStr != null && !careerExperienceStr.isEmpty()) {
          try {
          int careerExperience = Integer.parseInt(careerExperienceStr);
          existingEmployee.setCareerExperience(careerExperience);
          } catch (NumberFormatException e) {
          System.out.println("Invalid format for career experience: " + careerExperienceStr);
          }
           }
           
           System.out.println("Starting file upload processing.");

        // Initialize lists to hold processed files
        List<FilesVO> kycFilesList = new ArrayList<>();
        List<FilesVO> resumeFilesList = new ArrayList<>();

     // Process file uploads from the request
        Iterator<String> fileNames = request.getFileNames();
        while (fileNames.hasNext()) {
            String inputName = fileNames.next();
            List<MultipartFile> files = request.getFiles(inputName);

            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    FilesVO filesVO = new FilesVO();
                    filesVO.setUser(existingEmployee);
                    String originalFileName = file.getOriginalFilename();
                    filesVO.setFileData(file.getBytes());
                    filesVO.setFileSize(file.getSize());
                    filesVO.setFileType(file.getContentType());
                    String[] parts = originalFileName.split("\\|");
                    if(parts.length == 2) {
                        filesVO.setFileName(parts[0]); // Set the actual file name without the category
                        String category = parts[1];
                        filesVO.setFileCategory(category.equals("KYC") ? "KYC" : "Resume");
                        // Debugging line to confirm category
                        System.out.println("File category set to " + category + " for file: " + parts[0]);
                       
                       if(category.equals("KYC")) {
                        kycFilesList.add(filesVO);
                       } else {
                        resumeFilesList.add(filesVO);
                       }
                       
                    } else {
                        // Handle case where file name does not follow expected convention
                        System.out.println("Unexpected file naming convention: " + originalFileName);
                        continue; // Skip this file or handle appropriately
                    }
                   
                    userService.saveFile(filesVO);
                   
                }
            }
        }


        existingEmployee.setResumeFiles(resumeFilesList);
        existingEmployee.setKycFiles(kycFilesList);
           
           // Persist changes to the database
           userService.updateUser(existingEmployee);
           
           // Send email to CEO with resume attachment
           String subject = "New Employee Registration Details";
           String htmlContent = buildHtmlContentForCeo(existingEmployee);

           // Send email to CEO with resume and KYC file attachments
           sendEmailToCeo("hyunsu.na@miraegisul.com", subject, htmlContent, resumeFilesList, kycFilesList);
           
           return ResponseEntity.ok("Registration details updated successfully.");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
		}
	}
	
	private String buildHtmlContentForCeo(UserMgVO employee) {
		String approveLink = "http://india-intra.grcworks.kr/webProject/syst/reg/approveRegistration.do?empId=" + employee.getEmpId();
		String rejectLink = "http://india-intra.grcworks.kr/webProject/syst/reg/rejectRegistration.do?empId=" + employee.getEmpId();

	   StringBuilder builder = new StringBuilder();
	   builder.append("<h1>Employee Registration Details</h1>")
	          .append("<p><strong>Name:</strong> ").append(employee.getName()).append("</p>")
	          .append("<p><strong>Email:</strong> ").append(employee.getEmail()).append("</p>")
	          .append("<p><strong>Cellphone:</strong> ").append(employee.getCellPhone()).append("</p>")
	          .append("<p><strong>Employee ID:</strong> ").append(employee.getEmpId()).append("</p>")
	          .append("<p><strong>Group:</strong> ").append(employee.getGroup()).append("</p>")
	          .append("<p><strong>Department:</strong> ").append(employee.getDepartment()).append("</p>")
	          .append("<p><strong>Designation:</strong> ").append(employee.getDesignation()).append("</p>")
	          .append("<p><strong>University:</strong> ").append(employee.getUniversity()).append("</p>")
	          .append("<p><strong>Final Degree:</strong> ").append(employee.getFinalDegree()).append("</p>")
	          .append("<p><strong>Security Level:</strong> ").append(employee.getSecurityLevel()).append("</p>")
	          .append("<p><strong>Career Experience:</strong> ").append(employee.getCareerExperience()).append(" years</p>")
	          .append("<p><strong>Address:</strong> ").append(employee.getAddress()).append("</p>")
	         
	         
	          // Adding approval and rejection buttons side by side with CSS styling
	          .append("<div style='display: inline-block; margin-right: 10px;'>")
	          .append("<form method='post' action='").append(approveLink).append("'>")
	          .append("<button type='submit' style='background-color: green; color: white; border: none; padding: 10px; margin-right: 5px; border-radius: 5px; cursor: pointer;'>Approve</button>")
	          .append("</form>")
	          .append("</div>")
	          .append("<div style='display: inline-block;'>")
	          .append("<form method='post' action='").append(rejectLink).append("'>")
	          .append("<button type='submit' style='background-color: red; color: white; border: none; padding: 10px; border-radius: 5px; cursor: pointer;'>Reject</button>")
	          .append("</form>")
	          .append("</div>");
	
	   return builder.toString();
	}






	private void sendEmailToCeo(String ceoEmail, String subject, String htmlContent, List<FilesVO> resumeFiles, List<FilesVO> kycFiles) {
	  try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper helper = new MimeMessageHelper(message, true);
	
	      helper.setFrom("teamfuturesquad6@gmail.com");
	      helper.setTo(ceoEmail);
	      helper.setSubject(subject);
	      helper.setText(htmlContent, true);
	
	      // Attach resume files to the email
	      for (FilesVO resumeFile : resumeFiles) {
	          helper.addAttachment(resumeFile.getFileName(), new ByteArrayResource(resumeFile.getFileData()));
	      }
	
	      // Attach KYC files to the email
	      for (FilesVO kycFile : kycFiles) {
	          helper.addAttachment(kycFile.getFileName(), new ByteArrayResource(kycFile.getFileData()));
	      }
	
	      mailSender.send(message);
	  } catch (Exception e) {
	      e.printStackTrace();
	  }
	}
	
	@RequestMapping(value = "/approveRegistration.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String approveRegistration(@RequestParam("empId") String empId, Model model) {
	   try {
	       UserMgVO employee = userService.getUserByEmpId(empId); // Retrieve employee details
	       if (employee == null) {
	           model.addAttribute("message", "Employee record not found.");
	           return "errorPage"; // Redirect to an error page
	       }
	
	       // Update employee status in the database
	       employee.setRegisterStatus("Approved");
	       userService.updateUser(employee);
	
	    // Send approval email to the employee
	       String successMessage = "Registration Approved. You can now log in using the following link: <a href='http://india-intra.grcworks.kr/webProject/syst/main/login.do'>"
	        + "Login</a>";
	       sendApprovalOrRejectionEmail(employee.getEmail(), "Registration Approved", successMessage);
	
	
	       model.addAttribute("message", successMessage);
	       return "syst/main/approvePage"; // Redirect to a JSP page with the approval message
	   } catch (Exception e) {
	       e.printStackTrace();
	       model.addAttribute("message", "An error occurred during the approval process.");
	       return "errorPage"; // Redirect to an error page
	   }
	}
	
	@RequestMapping(value = "/rejectRegistration.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String rejectRegistration(@RequestParam("empId") String empId, Model model) {
	   try {
	       UserMgVO employee = userService.getUserByEmpId(empId); // Retrieve employee details
	       if (employee == null) {
	           model.addAttribute("message", "Employee record not found.");
	           return "errorPage"; // Redirect to an error page
	       }
	
	       // Update employee status in the database
	       employee.setRegisterStatus("Rejected");
	       userService.updateUser(employee);
	
	       // Send rejection email to the employee
	       String successMessage = "Registration Rejected.";
	       sendApprovalOrRejectionEmail(employee.getEmail(), "Registration Rejected", successMessage);
	
	       model.addAttribute("message", successMessage);
	       return "syst/main/rejectPage"; // Redirect to a JSP page with the rejection message
	   } catch (Exception e) {
	       e.printStackTrace();
	       model.addAttribute("message", "An error occurred during the rejection process.");
	       return "errorPage"; // Redirect to an error page
	   }
	}




	private void sendApprovalOrRejectionEmail(String toEmail, String subject, String messageContent) {
	   try {
	       MimeMessage message = mailSender.createMimeMessage();
	       MimeMessageHelper helper = new MimeMessageHelper(message, true);
	
	       helper.setFrom("teamfuturesquad6@gmail.com"); // CEO's email address
	       helper.setTo(toEmail);
	       helper.setSubject(subject);
	       helper.setText(messageContent, true);
	       mailSender.send(message);
	   } catch (MessagingException e) {
	       e.printStackTrace();
	   }
	}



	@GetMapping("/generateEmpId.do")
	public ResponseEntity<Map<String, String>> generateEmpId(@RequestParam String dateOfJoining, @RequestParam String group) {
	   Map<String, String> response = new HashMap<>();
	
	   try {
	       String year = dateOfJoining.substring(0, 4);
	       String month = dateOfJoining.substring(5, 7);
	       String empIdPrefix = (group.equals("Support") ? "MS" : "MT") + year + month;
	       String empIdPrefixForQuery = empIdPrefix + "%";
	
	       // Replace userService.getLastEmpId with your method to get the last used empId
	       String lastEmpId = userService.getLastEmpId(empIdPrefixForQuery);  
	
	       String newEmpId;
	       if (lastEmpId == null) {
	           newEmpId = empIdPrefix + "01";
	       } else {
	           int lastNumber = Integer.parseInt(lastEmpId.substring(lastEmpId.length() - 2));
	           newEmpId = empIdPrefix + String.format("%02d", lastNumber + 1);
	       }
	
	       response.put("empId", newEmpId);
	       return new ResponseEntity<>(response, HttpStatus.OK);
	   } catch (Exception e) {
	       response.put("error", e.getMessage());
	       return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	}


	@GetMapping("/checkEmailExists.do")
	public ResponseEntity<Map<String, String>> checkEmailExists(@RequestParam String email) {
	  Map<String, String> response = new HashMap<>();
	 
	  try {
	      boolean exists = userService.emailExists(email);
	      response.put("exists", String.valueOf(exists));
	      return new ResponseEntity<>(response, HttpStatus.OK);
	  } catch (Exception e) {
	      response.put("error", e.getMessage());
	      return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	  }
	}



}
