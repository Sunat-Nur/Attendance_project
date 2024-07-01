package syst.menu.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuTreeBuilder {
    public static List<MenuVO> buildTree(List<MenuVO> menus) {
        Map<Long, MenuVO> menuMap = new HashMap<>();
        List<MenuVO> rootMenus = new ArrayList<>();

        // Populate the map for quick access to menus by menuNo
        for (MenuVO menu : menus) {
            menuMap.put(menu.getMenuNo(), menu);
        }

        for (MenuVO menu : menus) {
            if (menu.getUpperMenuNo() == null) { // Root menu identified by upperMenuNo being null
                rootMenus.add(menu);
            } else {
                // Non-root menus - Find and assign to their parent menu's subMenu list
                MenuVO parentMenu = menuMap.get(menu.getUpperMenuNo());
                if (parentMenu != null) { // Check if the parent menu exists to avoid NullPointerException
                    parentMenu.addSubMenu(menu);
                }
            }
        }

        return rootMenus;
    }
}
