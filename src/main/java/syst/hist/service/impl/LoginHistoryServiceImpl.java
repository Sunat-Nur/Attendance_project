package syst.hist.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import syst.hist.dao.LoginHistoryDAO;
import syst.hist.service.LoginHistoryService;
import syst.hist.vo.LoginHistoryVO;


@Service
public class LoginHistoryServiceImpl implements LoginHistoryService {
	
	@Autowired
    private LoginHistoryDAO loginHistoryDAO;

    @Override
    public List<LoginHistoryVO> getAllLoginHistories() {
        return loginHistoryDAO.getAllLoginHistories();
    }
   
    @Override
    public void saveLoginHistory(LoginHistoryVO loginHistory) {
        loginHistoryDAO.saveLoginHistory(loginHistory);
    }

	@Override
	public LoginHistoryVO findLastLoginForUser(String empId) {
		return loginHistoryDAO.findLastLoginForUser(empId);
	}

}
