package atnd.calendar.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import atnd.calendar.vo.CalendarVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository
public class CalendarDAO extends EgovAbstractDAO{

	public List<CalendarVO> getEventsByDivision(String division) {
	       return (List<CalendarVO>) list("calendar.getEventsByDivision", division);
	   }


	public List<CalendarVO> getEventsForCriteria(String division, int year, int month) {
	   Map<String, Object> params = new HashMap<>();
	   params.put("division", division);
	   params.put("year", year);
	   params.put("month", month);
	   return (List<CalendarVO>) list("calendar.getEventsForCriteria", params);
	}


	   public List<CalendarVO> getUpcomingEvents(String startDate, String endDate) {
	       Map<String, String> params = new HashMap<>();
	       params.put("startDate", startDate);
	       params.put("endDate", endDate);
	   return (List<CalendarVO>) list("calendar.getUpcomingEvents", params);
	   }
	
	   public boolean deleteEventByEventNo(Long eventNo) {
	       int deletedCount = delete("calendar.deleteEventByEventNo", eventNo);
	       return deletedCount > 0;
	   }
	   
	   public void updateByeventNo(CalendarVO calendarVO) {
		   update("calendar.updateEventByeventNo", calendarVO);
	   }
	   
	   
	   public void insert(CalendarVO calendarEvent) {
		   insert("calendar.insertCalendar", calendarEvent);
	   }
}
