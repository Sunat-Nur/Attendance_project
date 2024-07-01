package syst.org.vo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "NTP1_ORG_GROUP_MG")
public class GroupVO implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "GROUP_NO")
    private Long groupNo;

    @Column(name = "GROUP_NAME", nullable = false)
    private String groupName;

    @Column(name = "USE_YN")
    private String useYn;

    @Column(name = "SORT_NUMBER")
    private Integer sortNumber;

    @Column(name = "REG_EMP_ID")
    private String regEmpId;

    @Column(name = "REG_DT")
    private Date regDt;

    @Column(name = "MOD_EMP_ID")
    private String modEmpId;

    @Column(name = "MOD_DT")
    private Date modDt;

	public Long getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Long groupNo) {
		this.groupNo = groupNo;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
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
    
}

