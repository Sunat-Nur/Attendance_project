package syst.user.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;

@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO{

	public UserMgVO findByEmpIdAndPassword(String empId, String password) {
		Map<String, String> params = new HashMap<>();
		params.put("empId", empId);
		params.put("password", password);
		return (UserMgVO) select("user.selectByEmpIdAndPassword", params);
	}
	
	public List<String> getUniqueDepartmentsByGroup(String group) {
		return (List<String>) list("user.getUniqueDepartmentsByGroup", group) ;
	}

	public List<UserMgVO> getUsersByDepartment(String department) {
		return (List<UserMgVO>) list("user.getUsersByDepartment", department) ;
	}
	
	public UserMgVO getUserByEmpId(String empId) {
		return (UserMgVO) select("user.getUserByEmpId", empId);
	}
	
	public List<UserMgVO> getUsersDetailsByEmpIds(List<String> empIds) {
		return (List<UserMgVO>) list("user.getUsersDetailsByEmpIds", empIds);
	}
	
	public List<UserMgVO> getAllUser() {
		return (List<UserMgVO>) list("user.getAllUser") ;
	}

	public void addUser(UserMgVO user) {
		insert("user.addUser", user);
	}

	public void updateUser(UserMgVO user) {
        update("user.updateUser", user);
    }

	public void deleteUser(String empId) {
		delete ("user.deleteUser", empId);
	}

	public String getLastEmpId(String empIdPrefix) {
		return (String) select("user.getLastEmpId", empIdPrefix);
	}

	public boolean emailExists(String email) {
       Integer count = (Integer) select("user.emailExistOrNot", email);
       return count != null && count > 0;
   }
	
	public void createUser(UserMgVO newUser) {
	    insert("user.createUser", newUser);
	}

	public UserMgVO findEmployeeByToken(String token) {
		return (UserMgVO) select("user.findEmployeeByToken", token);
	}
	
	public void updateRegisterTokenForUser(String email, String token) {
	   Map<String, String> params = new HashMap<>();
	   params.put("email", email);
	   params.put("token", token);
	   update("user.updateRegisterTokenForUser", params);
	}

	public void resetPassword(String token, String password) {
	   Map<String, String> params = new HashMap<>();
	   params.put("token", token);
	   params.put("password", password);
	   update("user.resetPassword", params);
	}
	
	 public boolean emailExistsForOtherEmpId(String empId, String email) {
       Map<String, Object> params = new HashMap<>();
       params.put("empId", empId);
       params.put("email", email);
       Integer count = (Integer) select("user.emailExistsForOtherEmpId", params);
       return count != null && count > 0;
   }

	 public boolean passwordExists(String token, String password) {
	   Map<String, String> params = new HashMap<>();
	   params.put("token", token);
	   params.put("password", password);
	   Integer count = (Integer) select("user.passwordExists", params);
	   return count != null && count > 0;
	}
	 
	 

	public void saveFile(FilesVO file) {
	    System.out.println("Saving file: " + file.getFileName() + " for user: " + file.getUser().getEmpId());
	    insert("files.saveFile", file);
	}
	
	public List<FilesVO> getFilesForUser(String empId) {
		return (List<FilesVO>) list("files.getFilesByUserId", empId);
	}
	
	public FilesVO getFileByNo(Long fileNo) {
		return (FilesVO) select("files.getFileByNo", fileNo);
	}

	public void deleteFile(Long no) {
		delete ("files.deleteFile", no);
	}

}
