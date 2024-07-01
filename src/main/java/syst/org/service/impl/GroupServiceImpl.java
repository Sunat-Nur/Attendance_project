package syst.org.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syst.org.dao.GroupDAO;
import syst.org.service.GroupService;
import syst.org.vo.GroupVO;

@Service("groupService")
public class GroupServiceImpl implements GroupService{

	@Autowired
    private GroupDAO groupDAO;
	
	@Override
	public List<GroupVO> getAllGroup() {
		return groupDAO.getAllGroup();
	}

    @Override
    @Transactional
    public void createGroup(GroupVO group) {
    	groupDAO.insert("group.createGroup", group);
    }
    
    @Override
    public boolean groupExists(Long group) {
    	GroupVO existingGroup = groupDAO.selectGroupByGroupNumber(group);
    	return existingGroup != null;
    }
    
    @Override
    @Transactional
    public void updateGroup(GroupVO group) {
    	groupDAO.update("group.updateGroup",group);
    }
    
    @Override
    public GroupVO findGroupByName(String groupName) {
    	return groupDAO.findGroupByName(groupName);
    }

	@Override
	public GroupVO getGroupByGroupNo(Long groupNo) {
		return groupDAO.getGroupByGroupNo(groupNo);
	}
}
