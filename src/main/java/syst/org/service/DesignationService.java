package syst.org.service;

import java.util.List;

import syst.org.vo.DesignationVO;

public interface DesignationService {
	
		public List<DesignationVO> getAllDesignation();

		void updateDesignation(DesignationVO designation);

		void createDesignation(DesignationVO designation);

		boolean designationExists(Long designation);

		List<DesignationVO> getDesignationBydeptNo(Long deptNo);

		public List<DesignationVO> getSecurityLevelByDsgnNumber(Long dsgnNo);

		public List<DesignationVO> getDesignationsByDeptNumber(Long deptNo);

		public DesignationVO getDesignationByDsgnNo(Long deptNo);

}
