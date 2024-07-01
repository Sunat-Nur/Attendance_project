package syst.org.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.org.vo.DepartmentVO;
import syst.org.vo.GroupVO;

@Repository("groupDAO")
public class GroupDAO extends EgovAbstractDAO  {

	public List<GroupVO> getAllGroup() {
		return (List<GroupVO>) list("group.getAllGroup");
	}
	
	public void update(GroupVO updatedGroup) {
		update("group.updateGroup",updatedGroup);
	}

	public void insert(GroupVO newGroup) {
       insert("group.createGroup", newGroup);
	}
 
	public GroupVO selectGroupByGroupNumber(Long groupNo) {
       return (GroupVO) select("group.selectGroupByGroupNumber", groupNo);
	}
	
	public GroupVO findGroupByName(String groupName) {
		return (GroupVO) select("group.findGroupByName", groupName);
	}

	public GroupVO getGroupByGroupNo(Long groupNo) {
		return (GroupVO) select("group.getGroupByGroupNo", groupNo);
	}
}
