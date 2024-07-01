package syst.org.service;

import java.util.List;

import syst.org.vo.DepartmentVO;

public interface DepartmentService {
	
	public List<DepartmentVO> getAllDepartment();
	   
	void updateDepartment(DepartmentVO department);

	void createDepartment(DepartmentVO department);

	boolean departmentExists(Long departmentId);

	List<DepartmentVO> getDepartmentByGroupNo(Long groupNo);

	public List<DepartmentVO> getDepartmentsByGroupNumber(Long groupNo);

	public DepartmentVO getDepartmentByDeptNo(Long deptNo);

	public DepartmentVO findDeptByName(String deptName);



}
