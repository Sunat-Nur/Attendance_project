package atnd.calendar.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import atnd.calendar.dao.CalendarDAO;
import atnd.calendar.service.CalendarService;
import atnd.calendar.vo.CalendarVO;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService {

	@Autowired
    private CalendarDAO calendarDao;

    @Override
    public List<CalendarVO> getEventsByDivision(String division) {
        return calendarDao.getEventsByDivision(division);
    }
   
    @Override
    public List<CalendarVO> getEventsForCriteria(String division, int year, int month) {
        return calendarDao.getEventsForCriteria(division, year, month);
    }
   
    @Override
    public List<CalendarVO> getUpcomingEvents(String startDate, String endDate) {
        return calendarDao.getUpcomingEvents(startDate, endDate);
    }

	@Override
	public boolean deleteEventByEventNo(Long eventNo) {
		return calendarDao.deleteEventByEventNo(eventNo) ;
	}

	@Override
	@Transactional
	public void updateByEventNo(CalendarVO calendarVO) {
		calendarDao.updateByeventNo(calendarVO);
	}

	@Override
	public void insert(CalendarVO calendarEvent) {
		calendarDao.insert(calendarEvent);
   }
}