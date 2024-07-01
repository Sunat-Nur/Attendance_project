package syst.auth.vo;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "NTP1_AUTHORITY_MG")
public class AuthorityMGVO {

	    @Id 
	    @Column(name = "GROUP_NO")
	    private Long groupNo;

	    @Column(name = "GROUP_NAME", length = 30, nullable = false)
	    private String groupName;

	    @Lob
	    @Column(name = "GROUP_DC")
	    private String groupDescription;

	    @Column(name = "USE_YN", length = 1, nullable = false)
	    private String useYn;

	    @Column(name = "REG_EMP_ID", length = 12, nullable = false)
	    private String registeredEmployeeId;

	    @Temporal(TemporalType.DATE)
	    @Column(name = "REG_DT", nullable = false)
	    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	    private Date registrationDate;

	    @Column(name = "MOD_EMP_ID", length = 12, nullable = false)
	    private String modifiedEmployeeId;

	    @Temporal(TemporalType.DATE)
	    @Column(name = "MOD_DT", nullable = false)
	    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	    private Date modificationDate;
	    
	    
	    @OneToMany(mappedBy = "authorityMg", cascade = CascadeType.ALL)
	    private List<AuthorityGrpUserMGVO> authGrpUserMg;


		public List<AuthorityGrpUserMGVO> getAuthGrpUserMg() {
			return authGrpUserMg;
		}

		public void setAuthGrpUserMg(List<AuthorityGrpUserMGVO> authGrpUserMg) {
			this.authGrpUserMg = authGrpUserMg;
		}

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

		public String getGroupDescription() {
			return groupDescription;
		}

		public void setGroupDescription(String groupDescription) {
			this.groupDescription = groupDescription;
		}

		public String getUseYn() {
			return useYn;
		}

		public void setUseYn(String useYn) {
			this.useYn = useYn;
		}

		public String getRegisteredEmployeeId() {
			return registeredEmployeeId;
		}

		public void setRegisteredEmployeeId(String registeredEmployeeId) {
			this.registeredEmployeeId = registeredEmployeeId;
		}

		public Date getRegistrationDate() {
			return registrationDate;
		}

		public void setRegistrationDate(Date registrationDate) {
			this.registrationDate = registrationDate;
		}

		public String getModifiedEmployeeId() {
			return modifiedEmployeeId;
		}

		public void setModifiedEmployeeId(String modifiedEmployeeId) {
			this.modifiedEmployeeId = modifiedEmployeeId;
		}

		public Date getModificationDate() {
			return modificationDate;
		}

		public void setModificationDate(Date modificationDate) {
			this.modificationDate = modificationDate;
		}

		@Override
		public String toString() {
			return "AuthorityMGVO [groupNo=" + groupNo + ", groupName=" + groupName + ", groupDescription="
					+ groupDescription + ", useYn=" + useYn + ", registeredEmployeeId=" + registeredEmployeeId
					+ ", registrationDate=" + registrationDate + ", modifiedEmployeeId=" + modifiedEmployeeId
					+ ", modificationDate=" + modificationDate + "]";
		}
}
