package syst.auth.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import syst.user.vo.UserMgVO;

@Entity
@Table(name = "NTP1_AUTH_GRP_USER_MG")
public class AuthorityGrpUserMGVO {

	@Id
    @Column(name = "GROUP_NO", nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long groupNo;

    @Column(name = "EMP_ID", length = 12, nullable = false)
    private String empId;

    @Column(name = "REG_EMP_ID", length = 12, nullable = false)
    private String regEmpId;

    @Temporal(TemporalType.DATE)
    @Column(name = "REG_DT", nullable = false)
    private Date regDt;
    
    @ManyToOne
    @JoinColumn(name = "GROUP_NO", referencedColumnName = "GROUP_NO")
    private AuthorityMGVO authorityMg;  
    
    private UserMgVO userDetails;  

    public UserMgVO getUserDetails() {
		return userDetails;
	}

	public void setUserDetails(UserMgVO userDetails) {
		this.userDetails = userDetails;
	}

	public AuthorityMGVO getAuthorityMg() {
		return authorityMg;
	}

	public void setAuthorityMg(AuthorityMGVO authorityMg) {
		this.authorityMg = authorityMg;
	}

	public Long getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Long groupNo) {
		this.groupNo = groupNo;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
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
		return "AuthorityGrpUserMGVO [groupNo=" + groupNo + ", empId=" + empId + ", regEmpId=" + regEmpId + ", regDt="
				+ regDt + ", authorityMg=" + authorityMg + ", userDetails=" + userDetails + "]";
	}

}
