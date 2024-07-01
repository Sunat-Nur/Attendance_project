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

import syst.org.service.DesignationService;
import syst.org.vo.DesignationVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/org/dsgn")
@Controller
public class DesignationController {
	
	@Autowired
	private DesignationService designationService;

	 @GetMapping("/designationList.do")
	   public String showDesignationList(@RequestParam("deptNo") Long  deptNo, ModelMap model, HttpServletRequest request) {
			
		    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
		    
		    if (loggedInUser == null) {
		    	return "redirect:/syst/main/login.do";
		    }
		    
	    	List<DesignationVO> DesignationList = designationService.getDesignationBydeptNo(deptNo);

            model.addAttribute("designationList",DesignationList); // Use "groupList" instead of "group"
	       return "syst/org/designationList";
	   }
	 
 
	 @PostMapping("/saveDesignationChanges.do")
	 public ResponseEntity<?> saveDesignationChanges(@RequestBody List<DesignationVO> updatedDesignations) {
	     try {
	         Set<Long> designationIds = new HashSet<>();
	         for (DesignationVO designation : updatedDesignations) {
	           
	             if (!designationIds.add(designation.getDsgnNo())) {
	                 return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: Duplicate designation IDs detected.");
	             }
	         }
	         for (DesignationVO designation : updatedDesignations) {
	           
	             if (designationService.designationExists(designation.getDsgnNo())) {
	                 // Update existing designation
	                 designationService.updateDesignation(designation);
	             } else {
	                 // Insert new designation
	                 designationService.createDesignation(designation);
	             }
	         }
	         return ResponseEntity.ok("Data updated successfully");
	     } catch (Exception e) {
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
	     }
	 }
	 
	 @GetMapping("/getDesignationByDept.do")
	 public ResponseEntity<List<DesignationVO>> getDesignationByDept(@RequestParam("deptNo") Long deptNo) {
	    try {
	        List<DesignationVO> designations = designationService.getDesignationsByDeptNumber(deptNo);
	        return new ResponseEntity<>(designations, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	 }

	 @GetMapping("/getSecurityLevelByDesignation.do")
	 public ResponseEntity<List<DesignationVO>> getSecurityByDsgn(@RequestParam("dsgnNo") Long dsgnNo) {
	    try {
	        List<DesignationVO> designations = designationService.getSecurityLevelByDsgnNumber(dsgnNo);
	        return new ResponseEntity<>(designations, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	 }

	 }