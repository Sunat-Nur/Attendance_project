package syst.menu.service;

import java.sql.SQLException;
import java.util.List;

import syst.auth.vo.MenuTree;
import syst.menu.vo.MenuVO;

public interface MenuService {

	List<MenuVO> getMenuListForMenu();

	List<MenuVO> getAllSubMenus();
	
    List<MenuVO> getMenuList();
    
    boolean menuExists(Long MenuNo);
    
    MenuTree buildMenuTree();
    
	void createMenu(MenuVO menu);

    List<MenuVO> getAllMenuList();

    public boolean updateUpperMenuNo(MenuVO menu);

	List<MenuVO> getMenuListBasedOnAuthority(String empId);

	MenuVO getMenuByUrl(String currentMenuUrl);

	List<MenuVO> getSubMenusByMenuNo(Long menuNo);

	List<Long> getAllmenuNo();

	MenuVO getMenuByMenuNo(Long menuNo);

	void updateMenu(MenuVO menu);

	MenuVO getParentMenuByUpperMenuNo(Long upperMenuNo);

	List<MenuVO> getTopMenuList(Long menuNoToMove);

	List<MenuVO> getUpperMenuListToMove(Long topMenuNo, Long menuNoToMove);

}
