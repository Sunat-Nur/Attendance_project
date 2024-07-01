package syst.holiday.service.impl;

import java.sql.SQLException;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.SqlMapClient;

import syst.holiday.dao.HolidayDAO;
import syst.holiday.service.HolidayService;
import syst.holiday.vo.HolidayVO;

@Service("holidayService")
public class HolidayServiceImpl implements HolidayService{

    @Autowired
    private HolidayDAO holidayDAO;
   

	@Autowired
	private SqlMapClient sqlMapClient;

	
	@Override
	public List<HolidayVO> getAllHolidayList() {
		return holidayDAO.getAllHolidayList();
	}
		   
	@Override
	public boolean holidayExists(Long holiday) {
		HolidayVO existingGroup = holidayDAO.selectGroupByGroupNumber(holiday);
		return existingGroup != null;
	}
	
	@Override
	public void updateHolidays(List<HolidayVO> holidays) throws SQLException {
	      try {
	          sqlMapClient.startTransaction();
	          sqlMapClient.startBatch();
	
	          for (HolidayVO holiday : holidays) {
	           holidayDAO.updateHoliday(holiday);
	          }
	
	          sqlMapClient.executeBatch();
	          sqlMapClient.commitTransaction();
	      } catch (Exception e) {
	          e.printStackTrace();
	      } finally {
	          sqlMapClient.endTransaction();
	      }
	}
		       
	
	@Override
	public void createHolidays(List<HolidayVO> holidaysToCreate) throws SQLException {
		try {
			sqlMapClient.startTransaction();
			sqlMapClient.startBatch();
	
			for (HolidayVO holiday : holidaysToCreate) {
				holidayDAO.insertHoliday(holiday);
			}
	
			sqlMapClient.executeBatch();
			sqlMapClient.commitTransaction();
			} catch (Exception e) {
				e.printStackTrace();
		    } finally {
		        sqlMapClient.endTransaction();
		    }
	}
	
	@Override
	public List<HolidayVO> getHolidaysForMonth(int year, int month) {
		return holidayDAO.getHolidaysForMonth(year, month);
	}
	
	@Override
	public List<HolidayVO> getHolidaysForCriteria(int year, int month) {
		return holidayDAO.getHolidaysForCriteria(year, month);
	}
		 
	
	@Override
	public List<HolidayVO> getHolidaysInRange(String startDate, String endDate) {
		return holidayDAO.getHolidaysInRange(startDate, endDate);
	}
	@Override
    public HolidayVO getHolidayByNo(Long holidayNo) {
        return holidayDAO.getHolidayByNo(holidayNo);
    }
	
	@Override
	public void deleteHoliday(Long holidayNo) {
		holidayDAO.deleteHoliday(holidayNo);
	}
}
