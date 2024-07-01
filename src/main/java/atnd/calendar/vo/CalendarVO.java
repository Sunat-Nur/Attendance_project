package atnd.calendar.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "NTP1_CALENDAR")
public class CalendarVO implements Serializable {

   @Column(name = "TITLE")
   private String title;

   @Column(name = "REG_EMP_ID")
   private String regEmpId;

   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private Date regDt;
 
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private Date startDt;

   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private Date endDt;

   @Lob
   @Column(name = "DETAILS")
   private String details;

   @Column(name = "DIVISION")
   private String division;
   
   @Column(name = "YEAR")
   private Integer year;
   
   @Column(name = "MONTH")
   private Integer month;

   @Column(name = "EVENT_NO")
   private Long eventNo;

	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
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
	
	public Date getStartDt() {
		return startDt;
	}
	
	public void setStartDt(Date startDt) {
		this.startDt = startDt;
	}
	
	public Date getEndDt() {
		return endDt;
	}
	
	public void setEndDt(Date endDt) {
		this.endDt = endDt;
	}
	
	public String getDetails() {
		return details;
	}
	
	public void setDetails(String details) {
		this.details = details;
	}
	
	public String getDivision() {
		return division;
	}
	
	public void setDivision(String division) {
		this.division = division;
	}
	
	public Integer getYear() {
		return year;
	}
	
	public void setYear(Integer year) {
		this.year = year;
	}
	
	public Integer getMonth() {
		return month;
	}
	
	public void setMonth(Integer month) {
		this.month = month;
	}
	
	public Long getEventNo() {
		return eventNo;
	}
	
	public void setEventNo(Long eventNo) {
		this.eventNo = eventNo;
	}
	
	@Override
	public String toString() {
		return "CalendarVO [title=" + title + ", regEmpId=" + regEmpId + ", regDt=" + regDt + ", startDt=" + startDt
		+ ", endDt=" + endDt + ", details=" + details + ", division=" + division + ", year=" + year + ", month="
		+ month + ", eventNo=" + eventNo + "]";
	}
	   
	   
}