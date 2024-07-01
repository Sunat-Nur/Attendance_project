package syst.auth.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import syst.auth.dao.AuthorityMGDAO;
import syst.auth.service.AuthorityMGService;
import syst.auth.vo.AuthorityGrpUserMGVO;
import syst.auth.vo.AuthorityMGVO;
import syst.auth.vo.MenuTree;

@Service("authorityMGService")
public class AuthorityMGServiceImpl implements AuthorityMGService{
	
	@Autowired
	private AuthorityMGDAO authorityMGDAO;
	
	@Override
    public List<AuthorityMGVO> getAllAuthorityGroups() {
        return authorityMGDAO.getAllAuthorityGroups();
    }

	@Override
	public AuthorityMGVO getAuthorityGroupById(Long groupNo) {
		AuthorityMGVO authorityGroup = authorityMGDAO.getAuthorityGroupsById(groupNo);

        // Fetch the associated users for this group
        List<AuthorityGrpUserMGVO> authUsers = authorityMGDAO.getUsersByGroupNo(groupNo);

        // Set the users in the authority group object
        authorityGroup.setAuthGrpUserMg(authUsers);

        return authorityGroup;
	}

	@Override
	public List<AuthorityGrpUserMGVO> getAuthUserList(Long groupNo) {
		return authorityMGDAO.getUsersByGroupNo(groupNo);
	}

	@Override
	public List<Long> getMenuIdsForGroup(Long groupNo) {
		// TODO Auto-generated method stub
		return authorityMGDAO.getMenuIdsForGroup(groupNo);
	}

	@Override
    public void UpdateAuthorityGroup(AuthorityMGVO authority) {
        authorityMGDAO.updateAuthorityGroup(authority);
    }

    @Override
    public void updateUsersToAuthorityGroup(Long groupNo, List<String> selectedUserIds) {
        // Clear existing users for this group
        authorityMGDAO.clearUsersFromAuthorityGroup(groupNo);
        
        // Add new users to this group
        for(String empId : selectedUserIds) {
            authorityMGDAO.addUserToAuthorityGroup(groupNo, empId);
        }
    }

    @Override
    public void updateMenusToAuthorityGroup(Long groupNo, List<Long> selectedMenuIds) {
        // Clear existing menus for this group
        authorityMGDAO.clearMenusFromAuthorityGroup(groupNo);
        
        // Add new menus to this group
        for(Long menuId : selectedMenuIds) {
            authorityMGDAO.addMenuToAuthorityGroup(groupNo, menuId);
        }
    }

    @Override
    public Long createAuthorityGroup(AuthorityMGVO authority) {
        Long generatedGroupNo = authorityMGDAO.createAuthorityGroup(authority);
        return generatedGroupNo;
    }

	@Override
	public void createAuthorityGroupUser(List<String> selectedUserIds, Long groupNo) {
		authorityMGDAO.createAuthorityGroupUser(selectedUserIds, groupNo);
		
	}

	@Override
	public void createAuthorityGroupMenu(List<Long> selectedMenuIds, Long groupNo) {
		authorityMGDAO.createAuthorityGroupMenu(selectedMenuIds, groupNo);
		
	}

	@Override
	public Long getGroupNo() {
		return authorityMGDAO.getGroupNo();
	}


//	@Override
//	public Long createAuthorityGroup(AuthorityMGVO authority) {
//		authorityMGDAO.createAuthorityGroup(authority);
//		
//	}
//
//	@Override
//	public void createAuthorityGroupUser(List<String> selectedUserIds) {
//		authorityMGDAO.createAuthorityGroupUser(selectedUserIds);
//		
//	}
//
//	@Override
//	public void createAuthorityGroupMenu(List<Long> selectedMenuIds) {
//		authorityMGDAO.createAuthorityGroupMenu(selectedMenuIds);
//		
//	}

}
