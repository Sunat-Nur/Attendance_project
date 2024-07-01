package atnd.calendar.service;

import java.util.List;

import atnd.calendar.vo.CalendarVO;

public interface CalendarService {

	void updateByEventNo(CalendarVO calendarVO);

	void insert(CalendarVO calendarEvent);

	boolean deleteEventByEventNo(Long eventNo);

	List<CalendarVO> getUpcomingEvents(String startDate, String endDate);

	List<CalendarVO> getEventsForCriteria(String division, int year, int month);

	List<CalendarVO> getEventsByDivision(String division);
}
