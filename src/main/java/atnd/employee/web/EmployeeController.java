package atnd.employee.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import syst.hist.service.OtherHistoryService;
import syst.org.service.DepartmentService;
import syst.org.service.GroupService;
import syst.org.vo.DepartmentVO;
import syst.org.vo.GroupVO;
import syst.user.service.UserService;
import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/atnd/employee")
@Controller
public class EmployeeController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private OtherHistoryService otherHistoryService;

	@Autowired
	private GroupService groupService;

	@Autowired
	private DepartmentService departmentService;


	@PostMapping("/deleteEmployee.do")
	public String deleteUser(@RequestParam String empId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
	    try {
	        // Fetch the logged-in user details
	        HttpSession session = request.getSession();
	        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");

	        if (loggedInUser == null) {
	            // Handle case where no user is logged in
	            return "redirect:syst/main/login.do"; // Redirect to the login page or any appropriate page
	        }

	        UserMgVO existingUser = userService.getUserByEmpId(empId);
	        if (existingUser == null) {
	            redirectAttributes.addFlashAttribute("errorMessage", "User not found.");
	            return "redirect:employeeListForCEO.do";
	        }
	        
	        // Save the old field values to other history
	        String referrerUrl = request.getHeader("Referer");
	        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Delete", "User Management", existingUser);

	        // Delete the user with the given empId
	        userService.deleteUser(empId);

	        // Add a flash attribute to indicate successful deletion
	        redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully");

	        // Redirect to the user list page
	        return "redirect:employeeListForCEO.do";
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the stack trace for debugging

	        // Add a flash attribute to indicate the error
	        redirectAttributes.addFlashAttribute("errorMessage", "Error deleting the user: " + e.getMessage());

	        // Redirect to the user list page with the error message
	        return "redirect:employeeListForCEO.do";
	    }
	}

	  @GetMapping("/allEmployeeStatus.do")
	     public String allEmployeeStatusPage(ModelMap model, HttpServletRequest request) {
	 
	      try {
		  	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
			    
			    if (loggedInUser == null) {
			    	return "redirect:/syst/main/login.do";
			    }
	    	  
	          List<GroupVO> groupList = groupService.getAllGroup();
	          model.addAttribute("groupList", groupList);

	 
	          // Assuming you want to load departments for the first group as an example
	          if (!groupList.isEmpty()) {
	              List<DepartmentVO> departments = departmentService.getAllDepartment();
	              model.addAttribute("departmentList", departments);
	          }

	          return "atnd/employee/allEmployeeStatus"; // Name of your JSP page
	      } catch (Exception e) {
	          e.printStackTrace(); // Log the exception for debugging
	          return "errorPage"; // Redirect to an error page
	      }
	  }
	 
	  @GetMapping("/employeeListForCEO.do")
	  public String employeeListForCEOPage(ModelMap model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
	      UserMgVO user = (UserMgVO) request.getSession().getAttribute("loggedInUser");

	      if (user == null) {
	          // No user is logged in, redirect to login page
	          return "redirect:/syst/main/login.do";
	      }

	      try {
	          UserMgVO loggedInUser = userService.getUserByEmpId(user.getEmpId());
	          
	          if ("CEO".equals(loggedInUser.getDesignation()) || "Admin".equals(loggedInUser.getDesignation())) {
	              // User is the CEO, proceed to show employee list
	              List<UserMgVO> users = userService.getAllUser();
	              model.addAttribute("loggedInUser", loggedInUser);
	              model.addAttribute("users", users);
	              return "atnd/employee/empListCEO";
	          } else {
	              // User is not the CEO, show alert message
	              redirectAttributes.addFlashAttribute("alertMessage", "Access restricted to CEO only.");
	              return "redirect:" + request.getHeader("Referer");
	          }
	      } catch (Exception e) {
	          e.printStackTrace(); // Consider using a logger
	          model.addAttribute("errorMessage", "An error occurred: " + e.getMessage());
	          return "board/error"; // Replace with your error view page
	      }
	  }

	 
	  @GetMapping("/employeeListForEmployee.do")
	  public String employeeListForEmployeePage(ModelMap model, HttpServletRequest request) {
	      try {
	          UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	          
	          if (loggedInUser == null || loggedInUser.getSecurityLevel() == null) {
	              return "redirect:/syst/main/login.do"; // Redirect to login page
	          }

	          Integer loggedInUserSecurityLevel = loggedInUser.getSecurityLevel();
	          String loggedInUserDesignation = loggedInUser.getDesignation();
	          String loggedInUserGroup = loggedInUser.getGroup();
	          String loggedInUserDepartment = loggedInUser.getDepartment();

	          List<UserMgVO> filteredUsers = new ArrayList<>();
	          List<UserMgVO> users = userService.getAllUser();

	          for (UserMgVO user : users) {
	              Integer userSecurityLevel = user.getSecurityLevel();
	              String userGroup = user.getGroup();
	              String userDepartment = user.getDepartment();

	              boolean isSameGroup = loggedInUserGroup.equals(userGroup);
	              boolean isSameOrLowerSecurity = userSecurityLevel != null && userSecurityLevel >= loggedInUserSecurityLevel;
	              boolean isSameDepartment = loggedInUserDepartment.equals(userDepartment);

	              if ("CXO".equals(loggedInUserDesignation) || "VP".equals(loggedInUserDesignation)) {
	                  if (isSameGroup && isSameOrLowerSecurity) {
	                      filteredUsers.add(user);
	                  }
	              } else if ("General Manager".equals(loggedInUserDesignation)) {
	                  if (isSameGroup && isSameDepartment && isSameOrLowerSecurity) {
	                      filteredUsers.add(user);
	                  }
	              } else {
	                  if (isSameGroup && isSameDepartment && isSameOrLowerSecurity) {
	                      filteredUsers.add(user);
	                  }
	              }
	          }
	          model.addAttribute("loggedInUser", loggedInUser);
	          model.addAttribute("users", filteredUsers);
	          return "atnd/employee/empListEmployee";
	      } catch (Exception e) {
	          e.printStackTrace(); // Consider using a logger
	          model.addAttribute("errorMessage", "An error occurred: " + e.getMessage());
	          return "board/error"; // Redirect to an error page
	      }
	  }
	 
	  @GetMapping("/employeeDetails.do")
	  public String getEmployeeDetails(@RequestParam("empId") String empId, ModelMap model, HttpServletRequest request) {
	      UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	      UserMgVO user = userService.getUserByEmpId(empId);
	      
	      if (loggedInUser == null) {
	          return "redirect:/syst/main/login.do";
	      }
	      
	      List<FilesVO> files = userService.getFilesForUser(empId);

		    // Initialize empty lists to avoid NullPointerException
		    List<FilesVO> resumeFiles = Collections.emptyList();
		    List<FilesVO> contractFiles = Collections.emptyList();
		    List<FilesVO> certificateFiles = Collections.emptyList();

		    // Check if files is not null before filtering
		    if (files != null) {
		        resumeFiles = files.stream().filter(file -> "Resume".equals(file.getFileCategory())).collect(Collectors.toList());
		        contractFiles = files.stream().filter(file -> "Contract".equals(file.getFileCategory())).collect(Collectors.toList());
		        certificateFiles = files.stream().filter(file -> "Certificate".equals(file.getFileCategory())).collect(Collectors.toList());
		    }
	      
	      

	      boolean isAdminOrHigher = loggedInUser.getDesignation().equals("CEO") ||
	                                 loggedInUser.getDesignation().equals("Admin") ||
	                                 Arrays.asList("CXO", "VP", "General Manager").contains(loggedInUser.getDesignation());

	      if (user != null && (isAdminOrHigher || loggedInUser.getEmpId().equals(empId))) {
	          model.addAttribute("loggedInUser", loggedInUser);
	          model.addAttribute("userDetails", user);
			  model.addAttribute("resumeFiles", resumeFiles);
			  model.addAttribute("contractFiles", contractFiles);
			  model.addAttribute("certificateFiles", certificateFiles);
	          model.addAttribute("canEdit", true); // Enable edit for authorized roles including Admin
	          return "atnd/employee/empPersonal";
	      } else if (user != null) {
	          model.addAttribute("userDetails", user);
	          model.addAttribute("canEdit", false); // View only for other roles
	          model.addAttribute("loggedInUser", loggedInUser);
	          model.addAttribute("resumeFiles", resumeFiles);
			  model.addAttribute("contractFiles", contractFiles);
			  model.addAttribute("certificateFiles", certificateFiles);
	          return "atnd/employee/empPersonal";
	      } else {
	          model.addAttribute("errorMessage", "User not found.");
	          return "board/error";
	      }
	  }
	  		
		
		@GetMapping("/editEmpDetails.do")
		public String getUserDetailsEdit(@RequestParam("empId") String empId, ModelMap model, HttpServletRequest request) {

		   UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
		   
		   if (loggedInUser == null) {
		    return "redirect:/syst/main/login.do";
		   }
		   
		   UserMgVO userDetails = userService.getUserByEmpId(empId);
		    List<FilesVO> files = userService.getFilesForUser(empId);

		    // Similar logic to separate files by category as in userDetails.do
		    List<FilesVO> resumeFiles = files.stream().filter(file -> "Resume".equals(file.getFileCategory())).collect(Collectors.toList());
		    List<FilesVO> contractFiles = files.stream().filter(file -> "Contract".equals(file.getFileCategory())).collect(Collectors.toList());
		    List<FilesVO> certificateFiles = files.stream().filter(file -> "Certificate".equals(file.getFileCategory())).collect(Collectors.toList());

		    List<GroupVO> allGroup = groupService.getAllGroup();
		    model.addAttribute("allGroup", allGroup);

		    model.addAttribute("userDetails", userDetails);
		    model.addAttribute("resumeFiles", resumeFiles);
		    model.addAttribute("contractFiles", contractFiles);
		    model.addAttribute("certificateFiles", certificateFiles);
		    model.addAttribute("loggedInUser", loggedInUser);
		    return "atnd/employee/empPersonalEdit";
		}
		

		@PostMapping("/updateEmpDetails.do")
		public ResponseEntity<String> updateUserDetails(
		    @ModelAttribute UserMgVO user,
		    MultipartHttpServletRequest request) {
		    try {
		        HttpSession session = request.getSession();
		        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");

		        if (loggedInUser == null) {
		            return new ResponseEntity<>("No logged-in user found", HttpStatus.UNAUTHORIZED);
		        }

		        UserMgVO existingUser = userService.getUserByEmpId(user.getEmpId());
		        if (existingUser == null) {
		            return new ResponseEntity<>("User not found.", HttpStatus.NOT_FOUND);
		        }

		        // Save in other history
		        String referrerUrl = request.getHeader("Referer");
		        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Edit", "Emp Personal", existingUser);

		        System.out.println("User details received: " + user);

		        user.setRegisterStatus(existingUser.getRegisterStatus());
		        user.setRegisterToken(existingUser.getRegisterToken());

		        // Initialize lists to hold processed files
		        List<FilesVO> certificateFilesList = new ArrayList<>();
		        List<FilesVO> contractFilesList = new ArrayList<>();
		        List<FilesVO> resumeFilesList = new ArrayList<>();

		        // Process file uploads from the request
		        Iterator<String> fileNames = request.getFileNames();
		        while (fileNames.hasNext()) {
		            String inputName = fileNames.next();
		            List<MultipartFile> files = request.getFiles(inputName);

		            for (MultipartFile file : files) {
		                if (file != null && !file.isEmpty()) {
		                    FilesVO filesVO = new FilesVO();
		                    filesVO.setUser(existingUser);
		                    String originalFileName = file.getOriginalFilename();
		                    filesVO.setFileData(file.getBytes());
		                    filesVO.setFileSize(file.getSize());
		                    filesVO.setFileType(file.getContentType());
		                    String[] parts = originalFileName.split("\\|");
		                    if(parts.length == 2) {
		                        filesVO.setFileName(parts[0]); // Set the actual file name without the category
		                        String category = parts[1];
		                        switch (category) {
		                            case "Certificate":
		                                filesVO.setFileCategory("Certificate");
		                                certificateFilesList.add(filesVO);
		                                break;
		                            case "Contract":
		                                filesVO.setFileCategory("Contract");
		                                contractFilesList.add(filesVO);
		                                break;
		                            case "Resume":
		                                filesVO.setFileCategory("Resume");
		                                resumeFilesList.add(filesVO);
		                                break;
		                            default:
		                                // Handle unknown file category
		                                break;
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

		        // Set uploaded files to the user
		        existingUser.setCertificateFiles(certificateFilesList);
		        existingUser.setContractFiles(contractFilesList);
		        existingUser.setResumeFiles(resumeFilesList);

		        userService.updateUser(user);
		        
		        System.out.println("User details updated successfully");

		        return new ResponseEntity<>("User details updated successfully", HttpStatus.OK);
		    } catch (Exception e) {
		        // Improved error handling with logging
		        // Log the error (consider using a logger)
		        return new ResponseEntity<>("There was an error updating the user details: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		    }
		}
		
	}
	
		
		

