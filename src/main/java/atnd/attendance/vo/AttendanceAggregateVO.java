package atnd.attendance.vo;

import java.util.Date;

import javax.persistence.Entity;

@Entity
public class AttendanceAggregateVO {

	private String empId;
    private Long wkAtndNo;
    private Long mntAtndNo;
    private Long qtrAtndNo;
    private Long yrAtndNo;
    private Long year;
    private Long quarter;
    private Long month;
    private Date startDate;
    private Date endDate;
   
   
    private String avgStartTime;
   
    private String avgEndTime;
   
    private Double ttlWorkHour;
    private Integer ttlLateness;
    private Double ttlLate;
    private Double ttlOverTime;
    private Integer ttlOutsideWork;
    private Integer ttlBusinessTrip;
    private Integer ttlTraining;
    private Long ttlAew;
    private Integer avgStatus;
    
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public Long getWkAtndNo() {
		return wkAtndNo;
	}
	public void setWkAtndNo(Long wkAtndNo) {
		this.wkAtndNo = wkAtndNo;
	}
	public Long getMntAtndNo() {
		return mntAtndNo;
	}
	public void setMntAtndNo(Long mntAtndNo) {
		this.mntAtndNo = mntAtndNo;
	}
	public Long getQtrAtndNo() {
		return qtrAtndNo;
	}
	public void setQtrAtndNo(Long qtrAtndNo) {
		this.qtrAtndNo = qtrAtndNo;
	}
	public Long getYrAtndNo() {
		return yrAtndNo;
	}
	public void setYrAtndNo(Long yrAtndNo) {
		this.yrAtndNo = yrAtndNo;
	}
	public Long getYear() {
		return year;
	}
	public void setYear(Long year) {
		this.year = year;
	}
	public Long getQuarter() {
		return quarter;
	}
	public void setQuarter(Long quarter) {
		this.quarter = quarter;
	}
	public Long getMonth() {
		return month;
	}
	public void setMonth(Long month) {
		this.month = month;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getAvgStartTime() {
		return avgStartTime;
	}
	public void setAvgStartTime(String avgStartTime) {
		this.avgStartTime = avgStartTime;
	}
	public String getAvgEndTime() {
		return avgEndTime;
	}
	public void setAvgEndTime(String avgEndTime) {
		this.avgEndTime = avgEndTime;
	}
	public Double getTtlWorkHour() {
		return ttlWorkHour;
	}
	public void setTtlWorkHour(Double ttlWorkHour) {
		this.ttlWorkHour = ttlWorkHour;
	}
	public Integer getTtlLateness() {
		return ttlLateness;
	}
	public void setTtlLateness(Integer ttlLateness) {
		this.ttlLateness = ttlLateness;
	}
	public Double getTtlLate() {
		return ttlLate;
	}
	public void setTtlLate(Double ttlLate) {
		this.ttlLate = ttlLate;
	}
	public Double getTtlOverTime() {
		return ttlOverTime;
	}
	public void setTtlOverTime(Double ttlOverTime) {
		this.ttlOverTime = ttlOverTime;
	}
	public Integer getTtlOutsideWork() {
		return ttlOutsideWork;
	}
	public void setTtlOutsideWork(Integer ttlOutsideWork) {
		this.ttlOutsideWork = ttlOutsideWork;
	}
	public Integer getTtlBusinessTrip() {
		return ttlBusinessTrip;
	}
	public void setTtlBusinessTrip(Integer ttlBusinessTrip) {
		this.ttlBusinessTrip = ttlBusinessTrip;
	}
	public Integer getTtlTraining() {
		return ttlTraining;
	}
	public void setTtlTraining(Integer ttlTraining) {
		this.ttlTraining = ttlTraining;
	}
	public Long getTtlAew() {
		return ttlAew;
	}
	public void setTtlAew(Long ttlAew) {
		this.ttlAew = ttlAew;
	}
	public Integer getAvgStatus() {
		return avgStatus;
	}
	public void setAvgStatus(Integer avgStatus) {
		this.avgStatus = avgStatus;
	}
    
}
