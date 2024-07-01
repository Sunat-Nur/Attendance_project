package syst.menu.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.SqlMapClient;

import syst.auth.vo.MenuNode;
import syst.auth.vo.MenuTree;
import syst.menu.dao.MenuDAO;
import syst.menu.service.MenuService;
import syst.menu.vo.MenuTreeBuilder;
import syst.menu.vo.MenuVO;

@Service("menuService")
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuDAO menuDAO;
	
	@Override
	public List<MenuVO> getMenuListForMenu() {
		return menuDAO.getMenuListForMenu();
	}

	@Override
	public List<MenuVO> getAllSubMenus() {
		return  menuDAO.getAllSubMenus();
	}
	
    @Override
    public List<MenuVO> getMenuList() {
        return menuDAO.getMenuList();
    }
    
    @Override
    public MenuVO getMenuByMenuNo(Long menuNo) {
		return menuDAO.getMenuByMenuNo(menuNo);
    }

    @Override
    public void updateMenu(MenuVO menu) {
        menuDAO.updateMenu(menu);
    }

    @Override
    public List<MenuVO> getMenuListBasedOnAuthority(String empId) {
        return menuDAO.getMenuListBasedOnAuthority(empId);
    }
    
    @Override
    public MenuTree buildMenuTree() {
    	   
    	   List<MenuVO> menuDetails = menuDAO.getMenuList();
    	   MenuTree menuTree = new MenuTree();
    	   
    	   Map<Long, MenuNode> menuMap = new HashMap<>();
    	   
    	   for (MenuVO menu : menuDetails) {
    	       MenuNode node = new MenuNode(menu.getMenuNo(), menu.getUpperMenuNo(), menu.getMenuName());
    	       menuMap.put(menu.getMenuNo(), node);
    	   }

    	   for (MenuNode node : menuMap.values()) {
    	       if (node.getUpperMenuNo() == null) {
    	           
    	           menuTree.getRoot().addChild(node);
    	       } else {
    	           
    	           MenuNode parent = menuMap.get(node.getUpperMenuNo());
    	           if (parent != null) {
    	               parent.addChild(node);
    	           } else {
    	               
    	               menuTree.getOrphanNodes().add(node);
    	           }
    	       }
    	   }
    	   return menuTree;
    	}
    
    @Override
    public List<MenuVO> getAllMenuList() {
    	return  menuDAO.getMenuList();
    }


    @Override
    public boolean menuExists(Long menuNo) {
      // Assuming you have a method in your DAO to fetch a code by its identifier
    	MenuVO existingMenu = menuDAO.getMenuByMenuNo(menuNo);
    	return existingMenu != null; // Returns true if the code exists, false otherwise
    }

    @Override
    public void createMenu(MenuVO menu) {
    	menuDAO.createMenu(menu);
    }
    
    @Override
    public boolean updateUpperMenuNo(MenuVO menu) {
       try {
           menuDAO.updateUpperMenuNo(menu.getMenuNo(), menu.getUpperMenuNo());
           return true;
       } catch (Exception e) {
           e.printStackTrace();
           return false;
       }
    }

	@Override
	public MenuVO getMenuByUrl(String currentMenuUrl) {
		return menuDAO.getMenuByUrl(currentMenuUrl);
	}

	@Override
	public List<MenuVO> getSubMenusByMenuNo(Long menuNo) {
		return menuDAO.getSubMenusByMenuNo(menuNo);
	}

	@Override
	public List<Long> getAllmenuNo() {
		return menuDAO.getAllmenuNo();
	}

	@Override
	public MenuVO getParentMenuByUpperMenuNo(Long upperMenuNo) {
		return menuDAO.getParentMenuByUpperMenuNo(upperMenuNo);
	}

	@Override
	public List<MenuVO> getTopMenuList(Long menuNoToMove) {
	    return menuDAO.getTopMenuList(menuNoToMove);
	}

	@Override
	public List<MenuVO> getUpperMenuListToMove(Long topMenuNo, Long menuNoToMove) {
	    List<MenuVO> menuList = menuDAO.getMenuList(); // Assuming getMenuList fetches all menus
	    Map<Long, MenuVO> menuMap = new HashMap<>();
	    List<MenuVO> upperMenuList = new ArrayList<>();

	    // Populate menu map for easy lookup
	    for (MenuVO menu : menuList) {
	        menuMap.put(menu.getMenuNo(), menu);
	    }

	    MenuVO topMenu = menuMap.get(topMenuNo);
	    if (topMenu != null) { // Check if the parent menu exists to avoid NullPointerException
	        // Add child menus of topMenu until the last level
	        addChildMenus(topMenu, menuMap, upperMenuList, menuNoToMove);
	    }

	    return upperMenuList;
	}

	// Helper method to add child menus until the last level
	private void addChildMenus(MenuVO menu, Map<Long, MenuVO> menuMap, List<MenuVO> upperMenuList, Long menuNoToMove) {
	    // Add current menu to the list
	    upperMenuList.add(menu);
	    // Add child menus recursively until the last level
	    for (MenuVO childMenu : fetchSubMenus(menu, menuMap, menuNoToMove)) {
	        addChildMenus(childMenu, menuMap, upperMenuList, menuNoToMove);
	    }
	}

	// Private method to fetch submenus excluding the menu to move and its hierarchy
	private List<MenuVO> fetchSubMenus(MenuVO menu, Map<Long, MenuVO> menuMap, Long menuNoToMove) {
	    List<MenuVO> subMenus = new ArrayList<>();
	    for (Long subMenuNo : menuMap.keySet()) {
	        MenuVO subMenu = menuMap.get(subMenuNo);
	        if (subMenu.getUpperMenuNo() != null && subMenu.getUpperMenuNo().equals(menu.getMenuNo()) && !subMenu.getMenuNo().equals(menuNoToMove)) {
	            subMenus.add(subMenu);
	            
                if(menuMap.get(menuNoToMove).getUpperMenuNo() != null) {
                	subMenus.remove(menuMap.get(menuMap.get(menuNoToMove).getUpperMenuNo()));
                }
                
	            // Recursively exclude the menu to move and its hierarchy
	            if (subMenu.getMenuNo().equals(menuNoToMove)) {
	                subMenus.remove(subMenu);
	                subMenus.removeAll(fetchSubMenus(subMenu, menuMap, menuNoToMove));
	            } 
	        }
	    }
	    return subMenus;
	}

        
}
