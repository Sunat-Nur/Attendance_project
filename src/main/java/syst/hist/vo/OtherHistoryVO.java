package syst.hist.vo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "NTP1_OTHER_HIST_MG")
public class OtherHistoryVO implements Serializable {
   
    private Long histSn;
   
    @Temporal(TemporalType.DATE)
    @Column(name = "HIST_DATE")
    private Date histDate;
   
    private String ip;
    private String empId;
    private String name;
    private String deptName;
    private String menuName;
    private String historyCfn;
    private String url;
    private String parameter;

    // Getters and setters for each field

    public Long getHistSn() {
        return histSn;
    }

    public void setHistSn(Long histSn) {
        this.histSn = histSn;
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

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getHistoryCfn() {
        return historyCfn;
    }

    public void setHistoryCfn(String historyCfn) {
        this.historyCfn = historyCfn;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getParameter() {
        return parameter;
    }

    public void setParameter(String parameter) {
        this.parameter = parameter;
    }

	@Override
	public String toString() {
		return "OtherHistory [histSn=" + histSn + ", histDate=" + histDate + ", ip=" + ip + ", empId=" + empId
		+ ", name=" + name + ", deptName=" + deptName + ", menuName=" + menuName + ", historyCfn=" + historyCfn
		+ ", url=" + url + ", parameter=" + parameter + "]";
	}

}
