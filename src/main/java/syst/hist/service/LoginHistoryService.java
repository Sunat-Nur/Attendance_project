package syst.hist.service;

import java.util.List;

import syst.hist.vo.LoginHistoryVO;

public interface LoginHistoryService {

	List<LoginHistoryVO> getAllLoginHistories();

	void saveLoginHistory(LoginHistoryVO loginHistory);

	LoginHistoryVO findLastLoginForUser(String empId);

}
