package syst.hist.service;

import java.util.List;

import syst.hist.vo.OtherHistoryVO;
import syst.user.vo.UserMgVO;

public interface OtherHistoryService {
	
	List<OtherHistoryVO> getAllOtherHistoryList();

//	void createOtherHistoryRecord(UserMgVO loggedInUser, String referrerUrl, String actionType, String parameter);

	void createOtherHistoryRecord(UserMgVO loggedInUser, String referrerUrl, String actionType, String menuName, Object objOrList);

}
