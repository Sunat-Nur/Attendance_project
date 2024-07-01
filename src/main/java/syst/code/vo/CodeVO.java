package syst.code.vo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "NTP1_CODE_MG")
public class CodeVO implements Serializable {

    @Column(name = "CODE")
    private Long code;

    @Column(name = "UPPER_CODE")
    private Long upperCode;

    @Column(name = "CODE_NAME", nullable = false)
    private String codeName;

    @Lob
    @Column(name = "CODE_DC")
    private String codeDescription;

    @Column(name = "SORT_NUMBER")
    private Long sortNumber;

    @Column(name = "USE_YN")
    private String useYn;

    @Column(name = "REG_EMP_ID")
    private String regEmpId;

    @Column(name = "REG_DT")
    private Date regDt;

    @Column(name = "MOD_EMP_ID")
    private String modEmpId;

    @Column(name = "MOD_DT")
    private Date modDt;

	public Long getCode() {
		return code;
	}
	
	public void setCode(Long code) {
		this.code = code;
	}
	
	public Long getUpperCode() {
		return upperCode;
	}
	
	public void setUpperCode(Long upperCode) {
		this.upperCode = upperCode;
	}
	
	public String getCodeName() {
		return codeName;
	}
	
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	public String getCodeDescription() {
		return codeDescription;
	}
	
	public void setCodeDescription(String codeDescription) {
		this.codeDescription = codeDescription;
	}
	
	public Long getSortNumber() {
		return sortNumber;
	}
	
	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}
	
	public String getUseYn() {
		return useYn;
	}
	
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
