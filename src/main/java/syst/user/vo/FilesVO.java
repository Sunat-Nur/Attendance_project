package syst.user.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "NTP1_KYC_FILES")
public class FilesVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "NO")
    private Long no;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "EMP_ID", nullable = false)
    private UserMgVO user;

    @Column(name = "FILE_NAME")
    private String fileName;

    @Lob
    @Column(name = "FILE_DATA")
    private byte[] fileData;

    @Column(name = "FILE_SIZE")
    private Long fileSize;

    @Column(name = "FILE_TYPE")
    private String fileType;
    
    @Column(name = "FILE_CATEGORY")
    private String fileCategory;

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public UserMgVO getUser() {
    return user;
	}
	
	public void setUser(UserMgVO user) {
	this.user = user;
	}

	public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public byte[] getFileData() {
        return fileData;
    }

    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

	public String getFileCategory() {
		return fileCategory;
	}

	public void setFileCategory(String fileCategory) {
		this.fileCategory = fileCategory;
	}
    
}
