package syst.org.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syst.org.dao.DepartmentDAO;
import syst.org.service.DepartmentService;
import syst.org.vo.DepartmentVO;


@Service("departmentService")
public class DepartmentServiceImpl  implements DepartmentService{
	
	@Autowired
    private DepartmentDAO departmentDAO;
   
	@Override
	public List<DepartmentVO> getAllDepartment() {
        return departmentDAO.getAllDepartment();
    }
 
	@Override
	@Transactional
    public void createDepartment(DepartmentVO department) {
		departmentDAO.insert("department.createDepartment",department);  
	}
	
	@Override
	public boolean departmentExists(Long department) {
		DepartmentVO existingDepartment = departmentDAO.selectDepartmentByDepartmentNumber(department);
		return existingDepartment != null;
	}
	
	@Override
	@Transactional
	public void updateDepartment(DepartmentVO department) {
		departmentDAO.update("department.updateDepartment",department);
	}
	
	@Override
		public List<DepartmentVO> getDepartmentByGroupNo(Long groupNo) {
		return departmentDAO.getDepartmentByGroupNo(groupNo);
	}

	@Override
	public List<DepartmentVO> getDepartmentsByGroupNumber(Long groupNo) {
	return departmentDAO.selectDepartmentsByGroupNumber(groupNo);
	}

	@Override
	public DepartmentVO getDepartmentByDeptNo(Long deptNo) {
		return departmentDAO.getDepartmentByDeptNo(deptNo);
	}
	
	@Override
	public DepartmentVO findDeptByName(String deptName) {
		return departmentDAO.findDeptByName(deptName);
	}	
	

}
