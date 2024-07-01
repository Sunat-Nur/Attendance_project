package syst.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syst.user.dao.UserDAO;
import syst.user.service.UserService;
import syst.user.vo.FilesVO;
import syst.user.vo.UserMgVO;


@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDAO userDAO;

	@Override
	public UserMgVO findByEmpIdAndPassword(String empId, String password) {
		return userDAO.findByEmpIdAndPassword(empId, password);
	}
	
	@Override
    public UserMgVO getUserByEmpId(String empId) {
        return userDAO.getUserByEmpId(empId);
    }
	
	@Override
	public List<UserMgVO> getUsersDetailsByEmpIds(List<String> empIds) {
	    return userDAO.getUsersDetailsByEmpIds(empIds);
	}

	@Override
	public List<String> getUniqueDepartmentsByGroup(String group) {
	   return userDAO.getUniqueDepartmentsByGroup(group);
	}

	@Override
	public List<UserMgVO> getUsersByDepartment(String department) {
	return userDAO.getUsersByDepartment(department);
	}
	
	@Override
	public List<UserMgVO> getAllUser() {
	return userDAO.getAllUser();
	}

	@Override
	public void addUser(UserMgVO user) {
	userDAO.addUser(user);
	}

	@Override
    public void updateUser(UserMgVO user) {
        userDAO.updateUser(user);
    }

	@Override
	@Transactional
	public void deleteUser(String empId) {
		userDAO.deleteUser(empId);
	}

	@Override
	public String getLastEmpId(String empIdPrefix) {
		return userDAO.getLastEmpId(empIdPrefix);
	}

	@Override
	public boolean emailExists(String email) {
        boolean result = userDAO.emailExists(email);
        return result;
    }

	@Override
	public void createUser(UserMgVO newUser) {
		userDAO.createUser(newUser);
	}

	@Override
	public boolean isValidToken(String token) {
		UserMgVO employee = userDAO.findEmployeeByToken(token);
		return employee != null && employee.getRegisterToken() != null;
	}

	@Override
	@Transactional
	public void saveFile(FilesVO file) {
		userDAO.saveFile(file);
	}
	
	@Override
	@Transactional
	public void updateRegisterTokenForUser(String email, String token) {
		userDAO.updateRegisterTokenForUser(email, token);
	}

	@Override
	@Transactional
	public void resetPassword(String token, String password) {
		System.out.println(password);
		System.out.println(token);
	    userDAO.resetPassword(token, password);
	}
	
	@Override
	public boolean emailExistsForOtherEmpId(String empId, String email) {
       return userDAO.emailExistsForOtherEmpId(empId, email);
	}
	
	@Override
	public boolean passwordExists(String token, String password) {
		return userDAO.passwordExists(token, password);
	}
	
	@Override
	public List<FilesVO> getFilesForUser(String empId) {
		return userDAO.getFilesForUser(empId);
	}
	
	@Override
	public FilesVO getFileByNo(Long fileNo) {
		return userDAO.getFileByNo(fileNo);
	}

	@Override
	public void deleteFile(Long fileNo) {
		userDAO.deleteFile(fileNo);
	}
	
}
