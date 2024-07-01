package syst.hist.service;

import java.util.List;

import syst.hist.vo.DownloadHistoryVO;

public interface DownloadHistoryService {
	
    void insertDownloadHistory(DownloadHistoryVO downloadHistory);
    
    List<DownloadHistoryVO> getAllDownloadHistories();

}
