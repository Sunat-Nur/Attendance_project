package syst.holiday.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Table(name = " NTP1_HOLIDAY_MG")
public class HolidayVO {
     
	@Column(name = "HOLIDAY_DATE")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayDate;

	@Column(name = "HOLIDAY_NO")
    private Long holidayNo;

    @Column(name = "HOLIDAY_NAME")
    private String holidayName;
   
    @Lob
    @Column(name = "HOLIDAY_DC")
    private String holidayDc;
   
    @Column(name = "REG_EMP_ID")
    private String regEmpId;
   
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regDt;
   
    @Column(name = "MOD_EMP_ID")
    private String modEmpId;
   
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date modDt;

 
	public Long getHolidayNo() {
		return holidayNo;
	}
	
	
	public void setHolidayNo(Long holidayNo) {
		this.holidayNo = holidayNo;
	}
	
	
	public String getHolidayName() {
		return holidayName;
	}
	
	
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}
	
	
	public String getHolidayDc() {
		return holidayDc;
	}
	
	
	public void setHolidayDc(String holidayDc) {
		this.holidayDc = holidayDc;
	}
	
	
	public Date getHolidayDate() {
		return holidayDate;
	}
	
	
	public void setHolidayDate(Date holidayDate) {
		this.holidayDate = holidayDate;
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
	   
	public String getFormattedHolidayDate() {
	   if (holidayDate != null) {
	       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	           return sdf.format(holidayDate);
	       } else {
	           return null;
	       }
	   }
	   
	@Override
	public String toString() {
		return "HolidayVO [holidayName=" + holidayName + ", holidayDc=" + holidayDc + ", holidayDate=" + holidayDate
		+ ", regEmpId=" + regEmpId + ", regDt=" + regDt + ", modEmpId=" + modEmpId + ", modDt=" + modDt + "]";
	}

}
