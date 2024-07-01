package syst.hist.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import syst.hist.dao.DownloadHistoryDAO;
import syst.hist.service.DownloadHistoryService;
import syst.hist.vo.DownloadHistoryVO;

@Service
public class DownloadHistoryServiceImpl implements DownloadHistoryService {

    @Autowired
    private DownloadHistoryDAO downloadHistoryDAO;
    
    @Override
    public void insertDownloadHistory(DownloadHistoryVO downloadHistory) {
        if (downloadHistory == null) {
            throw new IllegalArgumentException("DownloadHistory object is null");
        }
        downloadHistoryDAO.insertDownloadHistory(downloadHistory);
    }
    
    @Override
    public List<DownloadHistoryVO> getAllDownloadHistories() {
        return downloadHistoryDAO.findAllDownloadHistories();
    }
}