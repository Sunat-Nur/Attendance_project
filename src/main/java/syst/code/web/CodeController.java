package syst.code.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import syst.code.service.CodeService;
import syst.code.vo.CodeVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/code")
@Controller
public class CodeController {

	@Autowired
	private CodeService codeService;
	
	
	@GetMapping("/codeList.do")
	public String showCodeList(ModelMap model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
	    
	    UserMgVO user = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
		    if (user == null) {
		    	return "redirect:/syst/main/login.do";
		    }

	    if (user != null && "admin".equals(user.getEmpId())) {
	        List<CodeVO> codeList = codeService.getAllCodeList();
	        model.addAttribute("code", codeList);
	        return "syst/code/codeList";
	    } else {
	        redirectAttributes.addFlashAttribute("alertMessage", "Access restricted, only admin can access this.");
	        return "redirect:/syst/main/subHeader.do"; // Redirect to a different page where the alert will be shown
	    }
	}
	
	@PostMapping("/saveCodeChanges.do")
	public ResponseEntity<?> saveCodeChanges(@RequestBody List<CodeVO> updatedCodes) {
	    try {
	        Set<Long> codes = new HashSet<>();
	        for (CodeVO code : updatedCodes) {
	            if (!codes.add(code.getCode())) {
	                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: Duplicate codes detected.");
	            }
	        }

	        List<CodeVO> codesToUpdate = new ArrayList<>();
	        List<CodeVO> codesToCreate = new ArrayList<>();

	        for (CodeVO code : updatedCodes) {
	            if (codeService.codeExists(code.getCode())) {
	                codesToUpdate.add(code);
	            } else {
	                codesToCreate.add(code);
	            }
	        }

	        if (!codesToUpdate.isEmpty()) {
	            codeService.updateCodes(codesToUpdate);
	        }
	        if (!codesToCreate.isEmpty()) {
	            codeService.createCodes(codesToCreate); // You'll need to implement a similar batch create method
	        }

	        return ResponseEntity.ok("Data updated successfully");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
	    }
	}

	

}
