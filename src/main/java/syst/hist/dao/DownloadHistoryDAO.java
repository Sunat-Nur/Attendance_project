package syst.hist.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.hist.vo.DownloadHistoryVO;

@Repository
public class DownloadHistoryDAO extends EgovAbstractDAO {
	
    public void insertDownloadHistory(DownloadHistoryVO downloadHistory) {
        insert("downloadHistory.insertDownloadHistory", downloadHistory);
    }
    public DownloadHistoryVO findDownloadHistoryById(Long dnlSn) {
        return (DownloadHistoryVO) select("downloadHistory.findDownloadHistoryById", dnlSn);
    }
    public List<DownloadHistoryVO> findAllDownloadHistories() {
        return (List<DownloadHistoryVO>) list("downloadHistory.findAllDownloadHistories");
    } 
}
