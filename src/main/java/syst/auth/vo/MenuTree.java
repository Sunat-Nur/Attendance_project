package syst.auth.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import syst.menu.vo.MenuVO;

public class MenuTree {
    private MenuNode root;
    private List<MenuNode> orphanNodes;

    public MenuTree() {
        this.root = new MenuNode(0L, null, "Root");
        this.orphanNodes = new ArrayList<>();
    }

    public void buildTree(List<MenuVO> menus) {
        Map<Long, MenuNode> menuMap = new HashMap<>();

        for (MenuVO menu : menus) {
            Long upperMenuNo = (menu.getUpperMenuNo() != null && menu.getUpperMenuNo() == 0) ? null : menu.getUpperMenuNo();
            MenuNode node = new MenuNode(menu.getMenuNo(), upperMenuNo, menu.getMenuName());
            menuMap.put(menu.getMenuNo(), node);
        }

        for (MenuNode node : menuMap.values()) {
            if (node.getUpperMenuNo() == null) {
                root.addChild(node);
            } else {
                MenuNode parent = menuMap.get(node.getUpperMenuNo());
                if (parent != null) {
                    parent.addChild(node);
                } else {
                    orphanNodes.add(node); // Handle orphan nodes
                }
            }
        }
    }

    public MenuNode getRoot() {
        return root;
    }

    // Getter for orphan nodes
    public List<MenuNode> getOrphanNodes() {
        return orphanNodes;
    }
}
