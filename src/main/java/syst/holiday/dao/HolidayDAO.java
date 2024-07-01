package syst.holiday.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.holiday.vo.HolidayVO;

@Repository("holidayDAO")
public class HolidayDAO extends EgovAbstractDAO {

	public List<HolidayVO> getAllHolidayList() {
		return (List<HolidayVO>) list("holiday.getAllHolidayList");
	}

	// Update a single code or multiple codes
	public void updateHoliday(HolidayVO updatedHoliday) {
		update("holiday.updateHoliday", updatedHoliday);
	}

	// Insert a new code
	public void insertHoliday(HolidayVO newHoliday) {
		insert("holiday.createHoliday", newHoliday);
	}

	public HolidayVO selectGroupByGroupNumber(Long holiday) {
		return (HolidayVO) select("holiday.selectGroupByGroupNumber", holiday);
	}

	public void deleteHolidays(List<Long> holidayNos) {
		for (Long holidayNo : holidayNos) {
			delete("holiday.deleteHoliday", holidayNo);
		 }
	}

	public List<HolidayVO> getHolidaysForMonth(int year, int month) {
		Map<String, Object> params = new HashMap<>();
		params.put("year", year);
		params.put("month", month);
		return (List<HolidayVO>) list("holiday.getHolidaysForMonth", params);
	}

	public List<HolidayVO> getHolidaysForCriteria(int year, int month) {
		Map<String, Object> params = new HashMap<>();
		 	params.put("year", year);
		 	params.put("month", month);
		 	return (List<HolidayVO>) list("holiday.getHolidaysForCriteria", params);
	}
		   
	public List<HolidayVO> getHolidaysInRange(String startDate, String endDate) {
		Map<String, Object> params = new HashMap<>();
			params.put("startDate", startDate);
			params.put("endDate", endDate);
			return (List<HolidayVO>) list("holiday.getHolidaysInRange", params);
	}

	public HolidayVO getHolidayByNo(Long holidayNo) {
		return (HolidayVO) select("holiday.getHolidayByNo", holidayNo);
	}
	public void deleteHoliday(Long holidayNo) {
		delete("holiday.deleteHoliday", holidayNo);
	 }
}