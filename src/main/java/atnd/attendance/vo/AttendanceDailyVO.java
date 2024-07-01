package atnd.attendance.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
public class AttendanceDailyVO {
	
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "NO")
   private Long no;
   
   @Column(name = "EMP_ID")
   private String empId;

   @Column(name = "ATND_NO")
   private Long atndNo;

   @Column(name = "NAME")
   private String name;

   @Column(name = "GROUP")
   private String group;

   @Column(name = "DEPARTMENT")
   private String department;

   @Column(name = "DESIGNATION")
   private String designation;

   @Column(name = "YEAR_OF_WORK")
   private Integer yearOfWork;

   @Column(name = "CAREER")
   private Integer career;
 
   @JsonFormat
   private Date timeSetting;
 
   @Column(name = "GPS_INFORMATION")
   private String gpsInformation;
 
   @JsonFormat(pattern = "dd-MM-yyyy HH:mm:ss")
   private Date startTime;
 
   @JsonFormat(pattern = "dd-MM-yyyy HH:mm:ss")
   private Date endTime;

   @Column(name = "LATENESS")
   private Integer lateness;

   @Column(name = "LATE")
   private Double late;

   @Column(name = "OVER_TIME")
   private Double overTime;

   @Column(name = "WORK_TYPE")
   private String workType;

   @Column(name = "WORK_HOUR")
   private Double workHour;

   @Column(name = "OUTSIDE_WORK")
   private Integer outsideWork;

   @Column(name = "BUSINESS_TRIP")
   private Integer businessTrip;

   @Column(name = "TRAINING")
   private Integer training;
 
   @Column(name = "ACCESS_TYPE")
   private String accessType;

   @Column(name = "IP_ADDRESS")
   private String ipAddress;

   @Column(name = "AEW")
   private Integer aew;

   @Column(name = "STATUS")
   private Integer status;

	public Long getNo() {
		return no;
	}
	
	public void setNo(Long no) {
		this.no = no;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public Long getAtndNo() {
		return atndNo;
	}

	public void setAtndNo(Long atndNo) {
		this.atndNo = atndNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Integer getYearOfWork() {
		return yearOfWork;
	}
	
	public void setYearOfWork(Integer yearOfWork) {
		this.yearOfWork = yearOfWork;
	}

	public Integer getCareer() {
		return career;
	}

	public void setCareer(Integer career) {
		this.career = career;
	}

	public Date getTimeSetting() {
		return timeSetting;
	}

	public void setTimeSetting(Date timeSetting) {
		this.timeSetting = timeSetting;
	}

	public String getGpsInformation() {
		return gpsInformation;
	}

	public void setGpsInformation(String gpsInformation) {
		this.gpsInformation = gpsInformation;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getLateness() {
		return lateness;
	}

	public void setLateness(Integer lateness) {
		this.lateness = lateness;
	}

	public Double getLate() {
		return late;
	}

	public void setLate(Double late) {
		this.late = late;
	}

	public Double getOverTime() {
		return overTime;
	}

	public void setOverTime(Double overTime) {
		this.overTime = overTime;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public Double getWorkHour() {
		return workHour;
	}

	public void setWorkHour(Double workHour) {
		this.workHour = workHour;
	}

	public Integer getOutsideWork() {
		return outsideWork;
	}

	public void setOutsideWork(Integer outsideWork) {
		this.outsideWork = outsideWork;
	}

	public Integer getBusinessTrip() {
		return businessTrip;
	}

	public void setBusinessTrip(Integer businessTrip) {
		this.businessTrip = businessTrip;
	}

	public Integer getTraining() {
		return training;
	}

	public void setTraining(Integer training) {
		this.training = training;
	}

	public String getAccessType() {
		return accessType;
	}

	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public Integer getAew() {
		return aew;
	}

	public void setAew(Integer aew) {
		this.aew = aew;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "AttendanceVO [no=" + no + ", empId=" + empId + ", atndNo=" + atndNo + ", name=" + name + ", group="
		+ group + ", department=" + department + ", designation=" + designation + ", yearOfWork=" + yearOfWork
		+ ", career=" + career + ", timeSetting=" + timeSetting + ", gpsInformation=" + gpsInformation
		+ ", startTime=" + startTime + ", endTime=" + endTime + ", lateness=" + lateness + ", late=" + late
		+ ", overTime=" + overTime + ", workType=" + workType + ", workHour=" + workHour + ", outsideWork="
		+ outsideWork + ", businessTrip=" + businessTrip + ", training=" + training + ", accessType="
		+ accessType + ", ipAddress=" + ipAddress + ", aew=" + aew + ", status=" + status + "]";
	}
}
