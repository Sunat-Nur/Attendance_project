package syst.menu.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;

@Entity
public class MenuVO {
	
	private Long menuNo;
	private Long upperMenuNo;
	private String menuName;
	private Integer sortNumber;
	private String useYn;
	private String menuUrl;
	private String regEmpId;
	private Date regDt;
	private String modEmpId;
	private Date modDt;
	private List<MenuVO> subMenus = new ArrayList<>();
	
	public Long getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(Long menuNo) {
		this.menuNo = menuNo;
	}
	public Long getUpperMenuNo() {
		return upperMenuNo;
	}
	public void setUpperMenuNo(Long upperMenuNo) {
		this.upperMenuNo = upperMenuNo;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public Integer getSortNumber() {
		return sortNumber;
	}
	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public String getRegEmpId() {
		return regEmpId;
	}
	public void setRegEmpId(String regEmpId) {
		this.regEmpId = regEmpId;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getModEmpId() {
		return modEmpId;
	}
	public void setModEmpId(String modEmpId) {
		this.modEmpId = modEmpId;
	}
	public Date getModDt() {
		return modDt;
	}
	public void setModDt(Date modDt) {
		this.modDt = modDt;
	}
	public List<MenuVO> getSubMenus() {
		return subMenus;
	}
	public void setSubMenus(List<MenuVO> subMenus) {
		this.subMenus = subMenus;
	}
	
    public void addSubMenu(MenuVO subMenu) {
        this.subMenus.add(subMenu);
    }

}
