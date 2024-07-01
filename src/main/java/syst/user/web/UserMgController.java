package syst.user.web;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import syst.hist.service.OtherHistoryService;
import syst.org.service.GroupService;
import syst.org.vo.GroupVO;
import syst.user.service.UserService;
import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;

 
@RequestMapping("/syst/user")
@Controller
public class UserMgController{
   
	@Autowired
	private UserService userService;
	
	@Autowired
	private OtherHistoryService otherHistoryService;
	
	@Autowired
	private GroupService groupService;
	
	@GetMapping("/allUsersList.do")
	public String showAllUserList(ModelMap model, HttpServletRequest request) {
		
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
		List<UserMgVO> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "syst/user/userMg";
	}

	@GetMapping("/addUser.do")
	public String showAddUserForm(ModelMap model, HttpServletRequest request) {
		
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
		List<GroupVO> allGroup = groupService.getAllGroup();
		model.addAttribute("newUser", new UserMgVO());
		model.addAttribute("allGroup", allGroup);
		return "syst/user/userAdd";
	}
   
	@PostMapping("/addUser.do")
	public String addUser(@ModelAttribute("newUser") UserMgVO newUser, ModelMap model) {
		// Print or log values to debug
		System.out.println("Group: " + newUser.getGroup());
		System.out.println("Department: " + newUser.getDepartment());

		// Save the new user
		userService.addUser(newUser);

		// Redirect to the user list view after adding the user
		return "redirect:allUsersList.do";
	}
	

	@GetMapping("/userDetails.do")
	public String getUserDetails(@RequestParam("empId") String empId, ModelMap model, HttpServletRequest request) {
	    
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	        return "redirect:/syst/main/login.do";
	    }
	    
	    UserMgVO userDetails = userService.getUserByEmpId(empId);
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

	    List<GroupVO> allGroup = groupService.getAllGroup();
	    model.addAttribute("allGroup", allGroup);

	    model.addAttribute("userDetails", userDetails);
	    model.addAttribute("resumeFiles", resumeFiles);
	    model.addAttribute("contractFiles", contractFiles);
	    model.addAttribute("certificateFiles", certificateFiles);
	    model.addAttribute("loggedInUser", loggedInUser);
	    return "syst/user/userView";
	}
	
	
	
	@GetMapping("/editUserDetails.do")
	public String getUserDetailsEdit(@RequestParam("empId") String empId, ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	        return "redirect:/syst/main/login.do";
	    }
	    
	    UserMgVO userDetails = userService.getUserByEmpId(empId);
	    List<FilesVO> files = userService.getFilesForUser(empId);

	    // Filter files by category
	    List<FilesVO> resumeFiles = files.stream().filter(file -> "Resume".equals(file.getFileCategory())).collect(Collectors.toList());
	    List<FilesVO> contractFiles = files.stream().filter(file -> "Contract".equals(file.getFileCategory())).collect(Collectors.toList());
	    List<FilesVO> certificateFiles = files.stream().filter(file -> "Certificate".equals(file.getFileCategory())).collect(Collectors.toList());

	    // Printing file IDs for each category
	    System.out.println("Resume File IDs:");
	    resumeFiles.forEach(file -> System.out.println(file.getNo()));

	    System.out.println("Contract File IDs:");
	    contractFiles.forEach(file -> System.out.println(file.getNo()));

	    System.out.println("Certificate File IDs:");
	    certificateFiles.forEach(file -> System.out.println(file.getNo()));

	    List<GroupVO> allGroup = groupService.getAllGroup();
	    model.addAttribute("allGroup", allGroup);

	    model.addAttribute("userDetails", userDetails);
	    model.addAttribute("resumeFiles", resumeFiles);
	    model.addAttribute("contractFiles", contractFiles);
	    model.addAttribute("certificateFiles", certificateFiles);
	    model.addAttribute("loggedInUser", loggedInUser);
	    return "syst/user/userEdit";
	}

	

	@PostMapping("/updateUserDetails.do")
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
	        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Edit", "User Management", existingUser);

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
	
	
	@PostMapping("/deleteFiles.do")
	public ResponseEntity<?> deleteFiles(@RequestBody List<Long> fileNos, HttpServletRequest request) {
	    try {
	        HttpSession session = request.getSession();
	        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");

	        if (loggedInUser == null) {
	            return new ResponseEntity<>("No logged-in user found", HttpStatus.UNAUTHORIZED);
	        }

	        if (fileNos == null || fileNos.isEmpty()) {
	            return ResponseEntity.badRequest().body("No file numbers provided for deletion.");
	        }

	        List<FilesVO> filesToDelete = new ArrayList<>();
	        for (Long no : fileNos) {
	            FilesVO file = userService.getFileByNo(no);
	            filesToDelete.add(file);
	            userService.deleteFile(no);
	        }

	        String referrerUrl = request.getHeader("Referer");
	        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Delete Files", "User Management", filesToDelete);

	        return ResponseEntity.ok("Files deleted successfully");
	    } catch (Exception e) {
	        // Consider using a logger instead of printing stack trace
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while deleting files.");
	    }
	}



	
	@GetMapping("/downloadFile.do")
	public void downloadFile(@RequestParam("fileNo") Long fileNo, HttpServletResponse response) {
	    try {
	        // Fetch the file's metadata and data using the file number
	        FilesVO file = userService.getFileByNo(fileNo); // Implement this method in your service layer

	        if (file != null && file.getFileData() != null) {
	            // Set the content type and the header for file download
	            response.setContentType(file.getFileType());
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getFileName() + "\"");

	            // Write the file's byte array to the response's output stream
	            response.getOutputStream().write(file.getFileData());
	            response.getOutputStream().flush();
	        } else {
	            // Handle the case where the file is not found or there's no data
	            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found or no data available.");
	        }
	    } catch (IOException e) {
	        // Handle exceptions related to input/output operations
	        e.printStackTrace();
	        // Consider logging this exception and sending a server error response
	    }
	}


	@PostMapping("/deleteUser.do")
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
	            return "redirect:allUsersList.do";
	        }
	        
	        // Save the old field values to other history
	        String referrerUrl = request.getHeader("Referer");
	        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Delete", "User Management", existingUser);

	        // Delete the user with the given empId
	        userService.deleteUser(empId);

	        // Add a flash attribute to indicate successful deletion
	        redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully");

	        // Redirect to the user list page
	        return "redirect:allUsersList.do";
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the stack trace for debugging

	        // Add a flash attribute to indicate the error
	        redirectAttributes.addFlashAttribute("errorMessage", "Error deleting the user: " + e.getMessage());

	        // Redirect to the user list page with the error message
	        return "redirect:allUsersList.do";
	    }
	}
	
	@GetMapping("/checkEmailForOtherEmpId.do")
	public ResponseEntity<Map<String, String>> checkEmailForOtherEmpId(@RequestParam String empId, @RequestParam String email) {
	Map<String, String> response = new HashMap<>();
	   
	   try {
	       boolean exists = userService.emailExistsForOtherEmpId(empId, email);
	       response.put("exists", String.valueOf(exists));
	       return new ResponseEntity<>(response, HttpStatus.OK);
	   } catch (Exception e) {
	       response.put("error", e.getMessage());
	       return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	}
	
}
