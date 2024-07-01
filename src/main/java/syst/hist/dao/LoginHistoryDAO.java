package syst.hist.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.hist.vo.LoginHistoryVO;

@Repository
public class LoginHistoryDAO extends EgovAbstractDAO{

    public List<LoginHistoryVO> getAllLoginHistories() {
        return (List<LoginHistoryVO>) list("loginHist.getAllLoginHistories");
    }

	public void saveLoginHistory(LoginHistoryVO loginHistory) {
		insert("loginHist.insertLoginHistory", loginHistory);
	}

	public LoginHistoryVO findLastLoginForUser(String empId) {
		return (LoginHistoryVO) select("loginHist.findLastLoginForUser", empId);
	}

}
