package syst.auth.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "NTP1_AUTH_MENU_MAP_MG")
public class AuthorityMenuMapMGVO {
	
	@Id
    @Column(name = "GROUP_NO", nullable = false)
    private Long groupNo;

    @Column(name = "MENU_NO", nullable = false)
    private Long menuNo;

    @Column(name = "REG_EMP_ID", length = 12, nullable = false)
    private String regEmpId;

    @Temporal(TemporalType.DATE)
    @Column(name = "REG_DT", nullable = false)
    private Date regDt;

	public Long getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Long groupNo) {
		this.groupNo = groupNo;
	}

	public Long getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(Long menuNo) {
		this.menuNo = menuNo;
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

	@Override
	public String toString() {
		return "AuthorityMenuMapMG [groupNo=" + groupNo + ", menuNo=" + menuNo + ", regEmpId=" + regEmpId + ", regDt="
				+ regDt + "]";
	}

}
