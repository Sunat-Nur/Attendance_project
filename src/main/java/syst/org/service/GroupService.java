package syst.org.service;

import java.util.List;

import syst.org.vo.GroupVO;

public interface GroupService {
	
	public List<GroupVO>getAllGroup();

	void updateGroup(GroupVO group);

	void createGroup(GroupVO group);

	boolean groupExists(Long group);

	public GroupVO findGroupByName(String groupName);

	public GroupVO getGroupByGroupNo(Long groupNo);

}
