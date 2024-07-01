package syst.holiday.service;

import java.sql.SQLException;
import java.util.List;

import syst.holiday.vo.HolidayVO;

public interface HolidayService {

	boolean holidayExists(Long holidayNo);

	List<HolidayVO> getAllHolidayList();

	void updateHolidays(List<HolidayVO> holidays) throws SQLException;

	void createHolidays(List<HolidayVO> holidaysToCreate) throws SQLException;

	List<HolidayVO> getHolidaysForMonth(int year, int month);

	List<HolidayVO> getHolidaysInRange(String startDate, String endDate);

	List<HolidayVO> getHolidaysForCriteria(int year, int month);

	void deleteHoliday(Long holidayNo);

	HolidayVO getHolidayByNo(Long holidayNo);

	

}
