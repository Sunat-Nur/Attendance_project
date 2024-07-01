package syst.auth.service;

import java.util.List;

import syst.auth.vo.AuthorityGrpUserMGVO;
import syst.auth.vo.AuthorityMGVO;
import syst.auth.vo.MenuTree;

public interface AuthorityMGService {

	List<AuthorityMGVO> getAllAuthorityGroups();

	AuthorityMGVO getAuthorityGroupById(Long groupNo);

	List<AuthorityGrpUserMGVO> getAuthUserList(Long groupNo);

	List<Long> getMenuIdsForGroup(Long groupNo);

	void UpdateAuthorityGroup(AuthorityMGVO authority);

	void updateUsersToAuthorityGroup(Long groupNo, List<String> selectedUserIds);

	void updateMenusToAuthorityGroup(Long groupNo, List<Long> selectedMenuIds);

	Long createAuthorityGroup(AuthorityMGVO authority);

	void createAuthorityGroupUser( List<String> selectedUserIds, Long groupNo);

	void createAuthorityGroupMenu(List<Long> selectedMenuIds, Long groupNo);

	Long getGroupNo();
	
}
