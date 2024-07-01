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
@Table(name = "NTP1_ORG_DEPT_MG ")
public class DepartmentVO implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DEPT_NO")
    private Long deptNo;

    @Column(name = "DEPT_NAME", nullable = false)
    private String deptName;

    @Column(name = "USE_YN")
    private String useYn;

    @Column(name = "SORT_NUMBER")
    private Integer sortNumber;

    @Column(name = "GROUP_NO")
    private Long groupNo;

    @Column(name = "REG_EMP_ID")
    private String regEmpId;

    @Column(name = "REG_DT")
    private Date regDt;

    @Column(name = "MOD_EMP_ID")
    private String modEmpId;

    @Column(name = "MOD_DT")
    private Date modDt;

	public Long getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(Long deptNo) {
		this.deptNo = deptNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
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

	public Long getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Long groupNo) {
		this.groupNo = groupNo;
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
