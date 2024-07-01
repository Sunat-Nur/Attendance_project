package syst.user.vo;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
@Table(name = "NTP1_USER_MG")
public class UserMgVO {

    private String empId;
    private String name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateOfJoining; // Date of Joining

    private String password;
    private Integer securityLevel;
    private String gender;
    private String group;
    private String department;
    private String designation;
    private String finalDegree;
    private Integer yearOfWorking;
    private Integer careerExperience;
    private String university;
    private String cellPhone;
    private String email;
    private String emergencyContact;
    private String address;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateOfBirth;

    private String language;
    private String religion;
    private String recruitmentRoute;
    private String recommender;
    private Long salary;
    private String maritalStatus;
    private String disability;
    private String significant;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateOfResignation;

    private String reasonForResignation;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reJoin;
   
    private String registerToken;
    private String registerStatus;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<FilesVO> contractFiles;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<FilesVO> certificateFiles;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<FilesVO> resumeFiles;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<FilesVO> kycFiles;
    
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getDateOfJoining() {
		return dateOfJoining;
	}
	public void setDateOfJoining(Date dateOfJoining) {
		this.dateOfJoining = dateOfJoining;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getSecurityLevel() {
		return securityLevel;
	}
	public void setSecurityLevel(Integer securityLevel) {
		this.securityLevel = securityLevel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getFinalDegree() {
		return finalDegree;
	}
	public void setFinalDegree(String finalDegree) {
		this.finalDegree = finalDegree;
	}
	public Integer getYearOfWorking() {
		return yearOfWorking;
	}
	public void setYearOfWorking(Integer yearOfWorking) {
		this.yearOfWorking = yearOfWorking;
	}
	public Integer getCareerExperience() {
		return careerExperience;
	}
	public void setCareerExperience(Integer careerExperience) {
		this.careerExperience = careerExperience;
	}
	public String getUniversity() {
		return university;
	}
	public void setUniversity(String university) {
		this.university = university;
	}
	public String getCellPhone() {
		return cellPhone;
	}
	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmergencyContact() {
		return emergencyContact;
	}
	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getRecruitmentRoute() {
		return recruitmentRoute;
	}
	public void setRecruitmentRoute(String recruitmentRoute) {
		this.recruitmentRoute = recruitmentRoute;
	}
	public String getRecommender() {
		return recommender;
	}
	public void setRecommender(String recommender) {
		this.recommender = recommender;
	}
	public Long getSalary() {
		return salary;
	}
	public void setSalary(Long salary) {
		this.salary = salary;
	}
	public String getMaritalStatus() {
		return maritalStatus;
	}
	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}
	public String getDisability() {
		return disability;
	}
	public void setDisability(String disability) {
		this.disability = disability;
	}
	public String getSignificant() {
		return significant;
	}
	public void setSignificant(String significant) {
		this.significant = significant;
	}
	public Date getDateOfResignation() {
		return dateOfResignation;
	}
	public void setDateOfResignation(Date dateOfResignation) {
		this.dateOfResignation = dateOfResignation;
	}
	public String getReasonForResignation() {
		return reasonForResignation;
	}
	public void setReasonForResignation(String reasonForResignation) {
		this.reasonForResignation = reasonForResignation;
	}
	public Date getReJoin() {
		return reJoin;
	}
	public void setReJoin(Date reJoin) {
		this.reJoin = reJoin;
	}
	public String getRegisterToken() {
		return registerToken;
	}
	public void setRegisterToken(String registerToken) {
		this.registerToken = registerToken;
	}
	public String getRegisterStatus() {
		return registerStatus;
	}
	public void setRegisterStatus(String registerStatus) {
		this.registerStatus = registerStatus;
	}
	public List<FilesVO> getContractFiles() {
		return contractFiles;
	}
	public void setContractFiles(List<FilesVO> contractFiles) {
		this.contractFiles = contractFiles;
	}
	public List<FilesVO> getCertificateFiles() {
		return certificateFiles;
	}
	public void setCertificateFiles(List<FilesVO> certificateFiles) {
		this.certificateFiles = certificateFiles;
	}
	public List<FilesVO> getResumeFiles() {
		return resumeFiles;
	}
	public void setResumeFiles(List<FilesVO> resumeFiles) {
		this.resumeFiles = resumeFiles;
	}
	public List<FilesVO> getKycFiles() {
		return kycFiles;
	}
	public void setKycFiles(List<FilesVO> kycFiles) {
		this.kycFiles = kycFiles;
	}
}

