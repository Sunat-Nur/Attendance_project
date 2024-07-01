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
@Table(name = "NTP1_ORG_DSGN_MG") // Replace "YourTableName" with the actual table name
public class DesignationVO implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DEPT_NO")
    private Long deptNo;

    @Column(name = "DSGN_NO")
    private Long dsgnNo;

    @Column(name = "DSGN_NAME", nullable = false)
    private String dsgnName;

    @Column(name = "USE_YN")
    private String useYn;

    @Column(name = "SORT_NUMBER")
    private Integer sortNumber;

    @Column(name = "SECURITY_LEVEL")
    private String securityLevel;

    @Column(name = "REG_EMP_ID")
    private String regEmpId;

    @Column(name = "REDesignationVOG_DT")
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

	public Long getDsgnNo() {
		return dsgnNo;
	}

	public void setDsgnNo(Long dsgnNo) {
		this.dsgnNo = dsgnNo;
	}

	public String getDsgnName() {
		return dsgnName;
	}

	public void setDsgnName(String dsgnName) {
		this.dsgnName = dsgnName;
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

	public String getSecurityLevel() {
		return securityLevel;
	}

	public void setSecurityLevel(String securityLevel) {
		this.securityLevel = securityLevel;
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
