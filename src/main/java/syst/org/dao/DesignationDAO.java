package syst.org.dao;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.org.vo.DepartmentVO;
import syst.org.vo.DesignationVO;

@Repository("designationDAO")
public class DesignationDAO extends EgovAbstractDAO {

	public List<DesignationVO> getAllDesignation() {
		return (List<DesignationVO>) list("designation.getAllDesignation");
	}
	
	public void update(DesignationVO updatedDesignation) {
		update("designation.updateDesignation",updatedDesignation);
	}
	
	public void insert(DesignationVO newDesignation) {
		insert("designation.createDesignation", newDesignation);
	}
	
	public DesignationVO selectDesignationByDesignationNumber(Long designation) {
		return (DesignationVO) select("designation.selectDesignationByDesignationNumber", designation);
	}
	
	 public List<DesignationVO> getDesignationBydeptNo(Long deptNo) {
		 return (List<DesignationVO>) list("designation.getDesignationBydeptNo", deptNo);
	 }

	 public List<DesignationVO> selectDesignationsByDeptNumber(Long deptNo) {
		 return (List<DesignationVO>) list("designation.selectDesignationsByDeptNumber", deptNo);


		}
		public List<DesignationVO> selectSecurityLevelByDsgnNumber(Long dsgnNo) {
		return (List<DesignationVO>) list("designation.selectSecurityLevelByDsgnNumber", dsgnNo);

		}
		
		
		public DesignationVO getDesignationByDsgnNo(Long dsgnNo) {
			return (DesignationVO) select("designation.getDesignationByDsgnNo", dsgnNo);
		}

		

}
