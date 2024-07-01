package syst.user.service;

import java.util.List;

import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;

public interface UserService {

	UserMgVO findByEmpIdAndPassword(String empId, String password);
	
	UserMgVO getUserByEmpId(String empId);

	List<String> getUniqueDepartmentsByGroup(String group);

	List<UserMgVO> getUsersByDepartment(String department);
	
	List<UserMgVO> getAllUser();

	void addUser(UserMgVO user);

	void updateUser(UserMgVO user);

	void deleteUser(String empId);

	String getLastEmpId(String empIdPrefixForQuery);

	boolean emailExists(String email);
	
	void createUser(UserMgVO newUser);

	boolean isValidToken(String token);

	void saveFile(FilesVO file);

	void resetPassword(String token, String password);

	void updateRegisterTokenForUser(String email, String token);

	boolean emailExistsForOtherEmpId(String empId, String email);

	boolean passwordExists(String token, String password);

	List<FilesVO> getFilesForUser(String empId);

	FilesVO getFileByNo(Long fileNo);

	void deleteFile(Long no);

	List<UserMgVO> getUsersDetailsByEmpIds(List<String> empIds);
}
