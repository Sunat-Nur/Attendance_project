package syst.org.web;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import syst.org.service.DepartmentService;
import syst.org.vo.DepartmentVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/org/dept")
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	 @GetMapping("/departmentList.do")
	   public String showDepartmentList(@RequestParam("groupNo") Long  groupNo, ModelMap model, HttpServletRequest request) {
			
		    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
		    
		    if (loggedInUser == null) {
		    	return "redirect:/syst/main/login.do";
		    }
       
		    List<DepartmentVO> DepartmentList = departmentService.getDepartmentByGroupNo(groupNo);
		    model.addAttribute("departmentList", DepartmentList); // Use "groupList" instead of "group"
		 return "syst/org/departmentList";
	 }
 
	 @PostMapping("/saveDepartmentChanges.do")
	 public ResponseEntity<?> saveDepartmentChanges(@RequestBody List<DepartmentVO> updatedDepartment) {
	     try {
	         Set<Long> departmentIds = new HashSet<>();
	         for (DepartmentVO department : updatedDepartment) {
	             
	             if (!departmentIds.add(department.getDeptNo()))  {
	                 return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: Duplicate department IDs detected.");
	             }
	         }
	         for (DepartmentVO department : updatedDepartment) {
	           
	             if (departmentService.departmentExists(department.getDeptNo())) {
	                 // Update existing department
	                 departmentService.updateDepartment(department);
	             } else {
	                 // Insert new department
	                 departmentService.createDepartment(department);
	             }
	         }
	         return ResponseEntity.ok("Data updated successfully");
	     } catch (Exception e) {
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
	     }
	 }
	 
	 @GetMapping("/getDepartmentsByGroup.do")
	 public ResponseEntity<List<DepartmentVO>> getDepartmentsByGroupNumber(@RequestParam("groupNo") Long groupNo) {
	    try {
	        List<DepartmentVO> departments = departmentService.getDepartmentsByGroupNumber(groupNo);
	        return new ResponseEntity<>(departments, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	 }
	 
	 @GetMapping("/getDeptNoByName.do")
	 @ResponseBody
	 public ResponseEntity<?> getDeptNoByName(@RequestParam("deptName") String deptName) {
	     System.out.println("Received request for deptName: " + deptName); // Add detailed logging
	     try {
	         DepartmentVO department = departmentService.findDeptByName(deptName);
	         if (department != null) {
	             return ResponseEntity.ok(department.getDeptNo());
	         } else {
	             return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Department not found.");
	         }
	     } catch (Exception e) {
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching department number: " + e.getMessage());
	     }
	 }
}