package syst.menu.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.enterprise.inject.Model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.glass.ui.Menu;

import syst.hist.service.OtherHistoryService;
import syst.menu.service.MenuService;
import syst.menu.vo.MenuTreeBuilder;
import syst.menu.vo.MenuVO;
import syst.user.vo.UserMgVO;

@Controller
@RequestMapping("/syst/menu")
public class MenuController {

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private OtherHistoryService otherHistoryService;
	
	@GetMapping(value = "/menuListForMenu.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MenuVO>> getMenuListForMenu(HttpServletRequest request) {
	    
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	    
	    List<MenuVO> menuListForMenu = menuService.getMenuListBasedOnAuthority(loggedInUser.getEmpId());
	    System.out.println("bbbbbbbbbbbbbb" + menuListForMenu);
	    
	    return new ResponseEntity<>(menuListForMenu, HttpStatus.OK);
	}

    
    
	@GetMapping(value = "/subMenusForList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MenuVO>> getSubMenus(@RequestParam("MenuNo") Long MenuNo) {
	    try {
	        List<MenuVO> subMenus = menuService.getSubMenusByMenuNo(MenuNo);
	        return new ResponseEntity<>(subMenus, HttpStatus.OK);
	    } catch (Exception e) {
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

    
    
    @GetMapping(value = "/menuListForUser.do", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<MenuVO>> getMenuListBasedOnAuthority(HttpServletRequest request) {
    	UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
    	List<MenuVO> menuList = menuService.getMenuListBasedOnAuthority(loggedInUser.getEmpId());
    	
        return new ResponseEntity<>(menuList, HttpStatus.OK);  	
    }
    
    


    
    @GetMapping("/menuList.do")
    public String menuManagement(ModelMap model, HttpServletRequest request) {
	    UserMgVO user = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (user == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
        return "syst/menu/menuList"; // Return the name of the JSP page that displays the menus
    }

    
    
    @PostMapping("/createMenu.do")
    public ResponseEntity<?> createMenu(@RequestBody List<MenuVO> menus, HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
            
            if (loggedInUser == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            
            // Fetch existing menu numbers
            List<Long> existingMenuNos = menuService.getAllmenuNo();
            System.out.println("Existing menuNo: " + existingMenuNos);
            
            // Convert List to Set for faster lookup
            Set<Long> existingMenuNosSet = new HashSet<>(existingMenuNos);
            
            Random rand = new Random();
            
            for (MenuVO menu : menus) {
                long newMenuNo;
                
                do {
                    // Generate a new unique 6-digit menuNo
                    newMenuNo = 100000 + rand.nextInt(900000); // This generates numbers in the range [100000, 999999]
                } while (existingMenuNosSet.contains(newMenuNo)); // Ensure it's unique
                
                // Set the new unique menuNo
                menu.setMenuNo(newMenuNo);
                // Add the new menuNo to the set to keep it up to date
                existingMenuNosSet.add(newMenuNo);
                
                menu.setRegEmpId(loggedInUser.getEmpId());
                menu.setRegDt(new Date());
                
                menuService.createMenu(menu);
            }

            // Assuming your saving logic is here and it's successful
            return ResponseEntity.ok("Menu Created Successfully");
        } catch (Exception e) {
            e.printStackTrace(); // It's a good practice to log the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
        }
    }
    
    @PostMapping("/updateMenu.do")
    public ResponseEntity<?> updateMenu(@RequestBody MenuVO menu, HttpServletRequest request) {
    	try {
    		HttpSession session = request.getSession();
    		
    		UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
    		
            if (loggedInUser == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            
            MenuVO existingMenu = null;
            
            if (menu.getMenuNo() != null) {
                existingMenu = menuService.getMenuByMenuNo(menu.getMenuNo());
            }

            // If the holiday already exists, prepare it for an update
            if (existingMenu != null) {
                // Save the existing holiday state into another history table before updating
                String referrerUrl = request.getHeader("Referer");
                otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Edit", "Menu Management", existingMenu);
            }
            
            menu.setModEmpId(loggedInUser.getEmpId());
            menu.setModDt(new Date());
    		
            menuService.updateMenu(menu);
    		
    		return ResponseEntity.ok("Menu updated successfully");
    	} catch (Exception e) {
    		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
    	}
    }
    
    

    @PostMapping("/updateUpperMenuNo.do")
    public ResponseEntity<?> updateMenuUpperNo(@RequestBody MenuVO menuToMove, HttpServletRequest request) {
    	try {
    		HttpSession session = request.getSession();
    		
    		UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
    		
            if (loggedInUser == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            
            
           // Log the received menuNo and upperMenuNo
           System.out.println("Received menuNo: " + menuToMove.getMenuNo());
           System.out.println("Received upperMenuNo: " + menuToMove.getUpperMenuNo());
           
           MenuVO existingMenu = null;
           
           if (menuToMove.getMenuNo() != null) {
               existingMenu = menuService.getMenuByMenuNo(menuToMove.getMenuNo());
           }

           // If the holiday already exists, prepare it for an update
           if (existingMenu != null) {
               // Save the existing holiday state into another history table before updating
               String referrerUrl = request.getHeader("Referer");
               otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Move", "Menu Management", existingMenu);
           }

           boolean updateResult = menuService.updateUpperMenuNo(menuToMove);

           if(updateResult) {
               return ResponseEntity.ok("Menu updated successfully");
           } else {
               return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Menu not found or update failed");
           }
       } catch (Exception e) {
           e.printStackTrace();
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating menu: " + e.getMessage());
       }
    }
    
    
	@GetMapping("/menuTree.do")
	public String showMenuStructure(ModelMap model, HttpServletRequest request) {
		
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
    
	    return "syst/menu/menuTree";
	}
	
	
    @GetMapping(value = "/getMenusForMenuTree.do", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<MenuVO>> getMenusForMenuTree(HttpServletRequest request) {
        UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        
        List<MenuVO> menus = menuService.getMenuList();
        Logger logger = LoggerFactory.getLogger(MenuController.class);
        logger.info("Fetched " + menus.size() + " menus.");

        List<MenuVO> rootMenus = MenuTreeBuilder.buildTree(menus);
        
        // Logging for debugging; consider removing or adjusting log level for production
        for (MenuVO menuVO : rootMenus) {
            System.out.println("Menu Name: " + menuVO.getMenuName());
            System.out.println("Sub Menus: " + menuVO.getSubMenus());
        }

        return new ResponseEntity<>(rootMenus, HttpStatus.OK);
    }
    
    
    @GetMapping(value = "/parentMenusHierarchy.do", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getParentMenusHierarchy(HttpServletRequest request) {
        String currentMenuUrl = request.getParameter("menuUrl"); // Get the menu URL from request
        if (currentMenuUrl == null) {
            return ResponseEntity.badRequest().body("Menu URL is required");
        }
        
        try {
            // Fetch the menu by URL
            MenuVO currentMenu = menuService.getMenuByUrl(currentMenuUrl);
            if (currentMenu == null) {
                return ResponseEntity.notFound().build(); // Menu not found
            }
            
            List<MenuVO> hierarchy = new ArrayList<>();
            MenuVO tempMenu = currentMenu;
            // Build hierarchy list
            while (tempMenu != null && tempMenu.getUpperMenuNo() != 0) {
                hierarchy.add(0, tempMenu); // Add to the beginning of the list to maintain order
                tempMenu = menuService.getParentMenuByUpperMenuNo(tempMenu.getUpperMenuNo());
            }
            
            // Optionally, add the main menu (root) if not included and needed
            if (tempMenu != null && tempMenu.getUpperMenuNo() == 0) {
                hierarchy.add(0, tempMenu); // Add main menu at the beginning
            }
            System.out.println("abcdabd" + hierarchy);
            
            return new ResponseEntity<>(hierarchy, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching menu hierarchy: " + e.getMessage());
        }
    }
    
    @GetMapping(value = "/getTopMenuList.do", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<MenuVO>> getTopMenuList(@RequestParam("menuNoToMove") Long menuNoToMove, HttpServletRequest request) {
	    
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }
	    
	    System.out.println("mmmmmmmm" + menuNoToMove);
	    
	    List<MenuVO> topMenuList = menuService.getTopMenuList(menuNoToMove);
	    
	    return new ResponseEntity<>(topMenuList, HttpStatus.OK);
	}
	
	@GetMapping(value = "/getUpperMenuListToMove.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MenuVO>> getUpperMenuListToMove(@RequestParam("topMenuNo") Long topMenuNo, @RequestParam("menuNoToMove") Long menuNoToMove, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");

	    if (loggedInUser == null) {
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }

	    System.out.println("topmenuno: " + topMenuNo);
	    System.out.println("menutomove: " + menuNoToMove);

	    List<MenuVO> upperMenuList = menuService.getUpperMenuListToMove(topMenuNo, menuNoToMove);
	    System.out.println("Upper Menu List: " + upperMenuList); // Log the received menu list from the service

	    return new ResponseEntity<>(upperMenuList, HttpStatus.OK);
	}

    
}
