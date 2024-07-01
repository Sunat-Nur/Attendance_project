package syst.auth.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import syst.auth.service.AuthorityMGService;
import syst.auth.vo.AuthorityGrpUserMGVO;
import syst.auth.vo.AuthorityMGVO;
import syst.auth.vo.MenuTree;
import syst.menu.service.MenuService;
import syst.user.service.UserService;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/auth")
@Controller
public class AuthorityMGController {

    @Autowired
    private AuthorityMGService authorityMGService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private MenuService menuService;

    @GetMapping("/authorityList.do")
    public String getAllAuthorityGroups(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
    	
        List<AuthorityMGVO> list = authorityMGService.getAllAuthorityGroups();        
        model.addAttribute("authorityList", list);
        return "syst/auth/authorityMG"; 
    }
    
    
    @GetMapping("/authorityAdd.do")
    public String authorityAdd(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
    	MenuTree menuTree = menuService.buildMenuTree();
    	model.addAttribute("menuTree", menuTree);
        return "syst/auth/authorityAdd"; 
    }
    
    @PostMapping("/authSave.do")
    public ModelAndView saveAuthorityGroup(
            @ModelAttribute AuthorityMGVO authority,
            @RequestParam(value = "selectedUsers", required = false) List<String> selectedUserIds,
            @RequestParam(value = "selectedMenus", required = false) List<Long> selectedMenuIds
    ) {
        authorityMGService.createAuthorityGroup(authority);
        Long groupNo = authorityMGService.getGroupNo();

        
        if (selectedUserIds != null && !selectedUserIds.isEmpty()) {
            authorityMGService.createAuthorityGroupUser(selectedUserIds, groupNo);
            System.out.println("Selected User IDs: " + selectedUserIds);
        }

        if (selectedMenuIds != null && !selectedMenuIds.isEmpty()) {
            authorityMGService.createAuthorityGroupMenu(selectedMenuIds, groupNo);
            System.out.println("Selected Menu IDs: " + selectedMenuIds);
        }
        return new ModelAndView("redirect:authorityList.do");
    }
    
    
    @GetMapping("/editAuthority.do")
    public String editAuthority(@RequestParam("id") Long groupNo, ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
        AuthorityMGVO authority = authorityMGService.getAuthorityGroupById(groupNo);
        List<AuthorityGrpUserMGVO> authUserList = authorityMGService.getAuthUserList(groupNo);
        System.out.println("Size of authUserList: " + authUserList.size());

        for (AuthorityGrpUserMGVO authUser : authUserList) {
            authUser.setUserDetails(userService.getUserByEmpId(authUser.getEmpId()));
        }                     
        authority.setAuthGrpUserMg(authUserList);

        List<Long> menuIds = authorityMGService.getMenuIdsForGroup(groupNo);
        
        MenuTree menuTree = menuService.buildMenuTree();
        model.addAttribute("menuTree", menuTree);

        model.addAttribute("authority", authority);
        model.addAttribute("authUserList", authUserList);
        model.addAttribute("menuTree", menuTree); 
        model.addAttribute("selectedMenuIds", menuIds);
        return "syst/auth/authorityEdit"; 
    }
    
    
    @GetMapping("/departments.do")
    public ResponseEntity<List<String>> getDepartmentsByGroup(@RequestParam String group) {
        try {
            List<String> departments = userService.getUniqueDepartmentsByGroup(group);
            return new ResponseEntity<>(departments, HttpStatus.OK);
        } catch (Exception e) {

            e.printStackTrace();

            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    @GetMapping("/departmentUsers.do")
    public ResponseEntity<List<UserMgVO>> getUsersByDepartment(@RequestParam String department) {
        try {
            List<UserMgVO> users = userService.getUsersByDepartment(department);         
            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    
    @PostMapping("/authEdit.do")
    public ModelAndView saveAuthorityDetails(
        @ModelAttribute AuthorityMGVO authority,
        @RequestParam(value = "selectedUsers", required = false) List<String> selectedUserIds,
        @RequestParam(value = "selectedMenus", required = false) List<Long> selectedMenuIds
    ) {    	
        // First, save the authority group details
        authorityMGService.UpdateAuthorityGroup(authority);
        // If users are selected, add them to the authority group
        if (selectedUserIds != null) {
            authorityMGService.updateUsersToAuthorityGroup(authority.getGroupNo(), selectedUserIds);
        }
        // If menus are selected, add them to the authority group
        if (selectedMenuIds != null) {
            authorityMGService.updateMenusToAuthorityGroup(authority.getGroupNo(), selectedMenuIds);
        }
        // Redirect to a confirmation page or back to the list
        ModelAndView modelAndView = new ModelAndView("redirect:authorityList.do");
        modelAndView.addObject("message", "Authority details saved successfully.");
        return modelAndView;
    }

    
}
