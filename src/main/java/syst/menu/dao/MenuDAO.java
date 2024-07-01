package syst.menu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.menu.vo.MenuVO;

@Repository("menuDAO")
public class MenuDAO extends EgovAbstractDAO{
	
	public MenuVO getMenuByMenuNo(Long menuNo) {
		return (MenuVO) select("menu.getMenuByMenuNo", menuNo);
	}

	public List<MenuVO> getMenuListForMenu() {
		return (List<MenuVO>) list("menu.getMenuListForMenu");
	}

	public List<MenuVO> getAllSubMenus() {
		return (List<MenuVO>) list("menu.getAllSubMenus");
	}
	
	public List<MenuVO> getMenuList() {
		return (List<MenuVO>) list("menu.getMenuList");
	}
	
	public List<MenuVO> getMenuListBasedOnAuthority(String empId) {
		return (List<MenuVO>) list("menu.getMenuListBasedOnAuthority", empId);
	}

    public void updateMenu(MenuVO updatedMenu) {
        update("menu.updateMenu", updatedMenu);
    }

    // Insert a new code
    public void createMenu(MenuVO newMenu) {
        insert("menu.createMenu", newMenu);
    }

    public void updateUpperMenuNo(Long menuNo, Long upperMenuNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("menuNo", menuNo);
        paramMap.put("upperMenuNo", upperMenuNo);
       
        update("menu.updateMenuUpperNo", paramMap);
    }

	public MenuVO getMenuByUrl(String currentMenuUrl) {
		return (MenuVO) select("menu.getMenuByUrl",currentMenuUrl);
	}

	public List<MenuVO> getSubMenusByMenuNo(Long menuNo) {
		return (List<MenuVO>) list("menu.getSubMenusByMenuNo", menuNo);
	}

	public List<Long> getAllmenuNo() {
		return (List<Long>) list("menu.getAllmenuNo");
	}

	public MenuVO getParentMenuByUpperMenuNo(Long upperMenuNo) {
		return (MenuVO) select("menu.getMenuByMenuNo", upperMenuNo);
	}

	public List<MenuVO> getTopMenuList(Long menuNoToMove) {
		return (List<MenuVO>) list("menu.getTopMenuList", menuNoToMove);
	}

	public List<MenuVO> getMenuHierarchy(Long menuNo) {
		return (List<MenuVO>) list("menu.getMenuHierarchy", menuNo);
	}

}
