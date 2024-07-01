package syst.hist.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.hist.vo.OtherHistoryVO;

@Repository("otherHistoryDAO")
public class OtherHistoryDAO extends EgovAbstractDAO {

	public void saveOtherHistory(OtherHistoryVO history) {
	   insert("otherHistory.saveOtherHistory", history);
	}
	
	public List<OtherHistoryVO> findAllOtherHistoryList() {
		return (List<OtherHistoryVO>) list("otherHistory.findAllOtherHistoryList");
	}
}
