package syst.auth.vo;

import java.util.ArrayList;
import java.util.List;

public class MenuNode {
    private Long id;
    private Long upperMenuNo;
    private String name;
    private List<MenuNode> children;

    public MenuNode(Long id, Long upperMenuNo, String name) {
        this.id = id;
        this.upperMenuNo = upperMenuNo;
        this.name = name;
        this.children = new ArrayList<>();
    }

    public void addChild(MenuNode child) {
        this.children.add(child);
    }

    // Getters and setters as needed
    public Long getId() {
        return id;
    }

    public Long getUpperMenuNo() {
        return upperMenuNo;
    }

    public String getName() {
        return name;
    }

    public List<MenuNode> getChildren() {
        return children;
    }
}
