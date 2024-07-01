package syst.org.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.org.vo.DepartmentVO;

@Repository("departmentDAO")
public class DepartmentDAO extends EgovAbstractDAO  {

	public List<DepartmentVO> getAllDepartment() {
		return (List<DepartmentVO>) list("department.getAllDepartment");
	}
	
	public void update(DepartmentVO updatedDepartment) {
		update("department.updateDepartment",updatedDepartment);
	}
	public void insert(DepartmentVO newDepartment) {
		insert("department.createDepartment", newDepartment);
	}
	
	public DepartmentVO selectDepartmentByDepartmentNumber(Long departmentNo) {
		return (DepartmentVO) select("department.selectDepartmentByDepartmentNumber", departmentNo);
	}
	
	public List<DepartmentVO> getDepartmentByGroupNo(Long groupNo) {
		return (List<DepartmentVO>) list("department.getDepartmentByGroupNo", groupNo);
	}

	public List<DepartmentVO> selectDepartmentsByGroupNumber(Long groupNo) {
	       return (List<DepartmentVO>) list("department.selectDepartmentsByGroupNumber", groupNo);
	   }

	public DepartmentVO getDepartmentByDeptNo(Long deptNo) {
	return (DepartmentVO) select("department.getDepartmentByDeptNo", deptNo);
	}
	
	public DepartmentVO findDeptByName(String deptName) {
		return (DepartmentVO) select("department.findDeptByName", deptName);
	}
	
	
}
