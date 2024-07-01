package syst.org.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syst.org.dao.DesignationDAO;
import syst.org.service.DesignationService;
import syst.org.vo.DesignationVO;


@Service("designationService")
public class DesignationServiceImpl implements DesignationService {


	@Autowired
    private DesignationDAO designationDAO;
   
	
	public List<DesignationVO> getAllDesignation() {
	        return designationDAO.getAllDesignation();
	}
	
	@Transactional
	@Override
	public void updateDesignation(DesignationVO designation) {
		designationDAO.update("designation.updateDesignation",designation);
	}
       
	@Override
    public void createDesignation(DesignationVO designation) {
		designationDAO.insert("designation.createDesignation", designation);
	}

	@Override
	public boolean designationExists(Long designation) {
		DesignationVO existingDesignation = designationDAO.selectDesignationByDesignationNumber(designation);
		return existingDesignation != null;
	}
	
	@Override
		public List<DesignationVO> getDesignationBydeptNo(Long deptNo) {
		return designationDAO.getDesignationBydeptNo(deptNo);
	}

	@Override
	public List<DesignationVO> getDesignationsByDeptNumber(Long deptNo) {
	return designationDAO.selectDesignationsByDeptNumber(deptNo);
	}
	
	@Override
	public List<DesignationVO> getSecurityLevelByDsgnNumber(Long dsgnNo) {

	return designationDAO.selectSecurityLevelByDsgnNumber(dsgnNo);
	}

	@Override
	public DesignationVO getDesignationByDsgnNo(Long dsgnNo) {
		return designationDAO.getDesignationByDsgnNo(dsgnNo);
	}

}
