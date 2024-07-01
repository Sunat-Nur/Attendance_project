package syst.org.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import syst.org.service.GroupService;
import syst.org.vo.GroupVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/org")
@Controller
public class GroupController {


	@Autowired
	private GroupService groupService;
	
	@GetMapping("/groupList.do")
	public String showGroupList(ModelMap model, HttpServletRequest request) {
		
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
	    List<GroupVO> groupList = groupService.getAllGroup();
	    model.addAttribute("groupList", groupList);
	    return "syst/org/groupList";
	}
 
	@PostMapping("/saveGroupChanges.do")
	public ResponseEntity<?> saveGroupChanges(@RequestBody List<GroupVO> updatedGroups) {
	   try {
	       Set<Long> groupNos = new HashSet<>();
	       for (GroupVO group : updatedGroups) {
	           if (!groupNos.add(group.getGroupNo())) {
	               return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: Duplicate group numbers detected.");
	           }
	       }
	
	       for (GroupVO group : updatedGroups) {
	           if (groupService.groupExists(group.getGroupNo())) {
	               // Update existing group
	               groupService.updateGroup(group);
	           } else {
	               // Insert new group
	               groupService.createGroup(group);
	           }
	       }
	       return ResponseEntity.ok("Data updated successfully");
	   } catch (Exception e) {
	       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
	   }
	}
	
    @GetMapping("/getGroupNoByName.do")
    @ResponseBody
    public ResponseEntity<?> getGroupNoByName(@RequestParam("groupName") String groupName) {
        try {
            GroupVO group = groupService.findGroupByName(groupName);
            if (group != null) {
                return ResponseEntity.ok(group.getGroupNo());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Group not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching group number: " + e.getMessage());
        }
    }

}