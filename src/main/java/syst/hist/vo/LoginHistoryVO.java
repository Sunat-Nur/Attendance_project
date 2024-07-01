package syst.hist.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "NTP1_LOGIN_HIST_MG")
public class LoginHistoryVO {

    private Long no;
    private Date histDate;
    private String ip;
    private String empId;
    private String name;
    private String deptName;
    
	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public Date getHistDate() {
		return histDate;
	}
	
	public void setHistDate(Date histDate) {
		this.histDate = histDate;
	}
	
	public String getIp() {
		return ip;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	
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
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
   
}

