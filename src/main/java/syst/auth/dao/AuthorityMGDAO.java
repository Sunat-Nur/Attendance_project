package syst.auth.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.auth.vo.AuthorityGrpUserMGVO;
import syst.auth.vo.AuthorityMGVO;
import syst.auth.vo.AuthorityMenuMapMGVO;

@Repository("authorityMGDAO")
public class AuthorityMGDAO extends EgovAbstractDAO{
	
	public List<AuthorityMGVO> getAllAuthorityGroups() {
		return (List<AuthorityMGVO>) list("authorityMG.getAllAuthorityGroups");
		}

	public AuthorityMGVO getAuthorityGroupsById(Long groupNo) {
	    return (AuthorityMGVO) select("authorityMG.getAuthorityGroupsById", groupNo);
	}

	public List<AuthorityGrpUserMGVO> getUsersByGroupNo(Long groupNo) {
	    List<AuthorityGrpUserMGVO> userList = (List<AuthorityGrpUserMGVO>) list("AuthorityGrpUser.getUsersByGroupNo", groupNo);

	    return userList; 
	}

	public List<Long> getMenuIdsForGroup(Long groupNo) {
		List<Long> menuID = (List<Long>) list("authMenuMap.getMenuIdsForGroup", groupNo);
		return menuID;
	}
	
	public void updateAuthorityGroup(AuthorityMGVO authority) {
        update("authorityMG.updateAuthorityGroup", authority);
    }

    public void clearUsersFromAuthorityGroup(Long groupNo) {
        delete("AuthorityGrpUser.clearUsersFromAuthorityGroup", groupNo);
    }

    public void addUserToAuthorityGroup(Long groupNo, String empId) {
        // Create an object to pass groupNo and empId
        AuthorityGrpUserMGVO user = new AuthorityGrpUserMGVO();
        user.setGroupNo(groupNo);
        user.setEmpId(empId);
        insert("AuthorityGrpUser.addUserToAuthorityGroup", user);
    }

    public void clearMenusFromAuthorityGroup(Long groupNo) {
        delete("authMenuMap.clearMenusFromAuthorityGroup", groupNo);
    }

    public void addMenuToAuthorityGroup(Long groupNo, Long menuNO) {
    	
    	AuthorityMenuMapMGVO menu = new AuthorityMenuMapMGVO();
    	menu.setGroupNo(groupNo);
        menu.setMenuNo(menuNO);
        insert("authMenuMap.addMenuToAuthorityGroup", menu);
    }

    public Long createAuthorityGroup(AuthorityMGVO authority) {       
        Long generatedGroupNo = (Long) insert("authorityMG.createAuthorityGroup", authority);       
        return generatedGroupNo;
    }

	   
    public void createAuthorityGroupUser(List<String> selectedUserIds, Long groupNo) {
        for (String empId : selectedUserIds) {
            Map<String, Object> params = new HashMap<>();
            params.put("empId", empId);
            params.put("groupNo", groupNo);
            insert("AuthorityGrpUser.createAuthorityGroupUser", params);
        }
    }
  
    public void createAuthorityGroupMenu(List<Long> selectedMenuIds, Long groupNo) {
        for (Long menuNo : selectedMenuIds) {
            Map<String, Object> params = new HashMap<>();
            params.put("menuNo", menuNo);
            params.put("groupNo", groupNo);
            insert("authMenuMap.createAuthorityGroupMenu", params);
        }
    }

    public Long getGroupNo() {
	    return (Long) select("authorityMG.getMaxGroupNo");
	}
}
