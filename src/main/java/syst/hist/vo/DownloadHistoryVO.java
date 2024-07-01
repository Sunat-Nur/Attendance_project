package syst.hist.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "NTP1_DNL_HIST_MG")
public class DownloadHistoryVO {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DNL_SN")
    private Long dnlSn;

    @Column(name = "HIST_DATE")
    private Date histDate;

    @Column(name = "MENU_NAME", nullable = false)
    private String menuName;

    @Column(name = "FILE_NAME")
    private String fileName;

    @Column(name = "EMP_ID")
    private String empId;

    @Column(name = "NAME")
    private String name;

    @Column(name = "DEPARTMENT")
    private String department;

	public Long getDnlSn() {
		return dnlSn;
	}

	public void setDnlSn(Long dnlSn) {
		this.dnlSn = dnlSn;
	}

	public Date getHistDate() {
		return histDate;
	}

	public void setHistDate(Date histDate) {
		this.histDate = histDate;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
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

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

}
