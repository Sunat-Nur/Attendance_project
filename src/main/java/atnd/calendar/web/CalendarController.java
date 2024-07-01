package atnd.calendar.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import atnd.calendar.service.CalendarService;
import atnd.calendar.vo.CalendarVO;
import syst.holiday.service.HolidayService;
import syst.holiday.vo.HolidayVO;
import syst.user.vo.UserMgVO;

@Controller
public class CalendarController {

	@Autowired
	private HolidayService holidayService;
	
	@Autowired
	private CalendarService calendarService;
	
	@GetMapping("/calendar.do")
	public String calendarPage(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
	    model.remove("lastAccess");
	    return "atnd/calendar/calendarPage";
	}
	

	@GetMapping("/getEventsByDivision.do")
	@ResponseBody
	public ResponseEntity<?> getEventsByDivision(@RequestParam String division, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");

	    if (loggedInUser == null) {
	        return new ResponseEntity<>("User not logged in", HttpStatus.UNAUTHORIZED);
	    }

	    try {
	        List<Map<String, Object>> fullCalendarEvents = new ArrayList<>();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	        if ("holiday".equals(division)) {
	            // Fetch holidays
	            List<HolidayVO> holidays = holidayService.getAllHolidayList();
	            for (HolidayVO holiday : holidays) {
	                Map<String, Object> fullCalendarEvent = new HashMap<>();
	                fullCalendarEvent.put("title", holiday.getHolidayName());
	                fullCalendarEvent.put("start", dateFormat.format(holiday.getHolidayDate()));
	                fullCalendarEvent.put("end", dateFormat.format(holiday.getHolidayDate())); // Same as start date if it's a single day holiday
	                fullCalendarEvent.put("color", "red"); // Example color for holidays
	                fullCalendarEvents.add(fullCalendarEvent);
	            }
	        } else {
	            // Fetch events based on division
	            List<CalendarVO> events = calendarService.getEventsByDivision(division);
	            for (CalendarVO event : events) {
	                if ("personal".equals(division)) {
	                    // Check if the division is personal and the loggedInUser's employeeId matches regEmpId
	                    if (!event.getRegEmpId().equals(loggedInUser.getEmpId())) {
	                        continue; // Skip this event if not associated with the logged-in user
	                    }
	                }
	                // Format the event and add it to the list
	                Map<String, Object> fullCalendarEvent = new HashMap<>();
	                fullCalendarEvent.put("title", event.getTitle());
	                fullCalendarEvent.put("start", dateFormat.format(event.getStartDt()));
	                fullCalendarEvent.put("end", dateFormat.format(event.getEndDt()));
	                fullCalendarEvent.put("details", event.getDetails());
	                fullCalendarEvents.add(fullCalendarEvent);
	            }
	        }

	        return new ResponseEntity<>(fullCalendarEvents, HttpStatus.OK);
	    } catch (Exception e) {
	        // Log the exception and return an appropriate error response
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}



	@GetMapping("/getEvents.do")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getEvents(
	    @RequestParam("division") String division,
	    @RequestParam("year") int year,
	    @RequestParam("month") int month,
	    HttpServletRequest request) {

	    // Fetch the logged-in user
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");

	    // Check if the user is logged in
	    if (loggedInUser == null) {
	        // Return unauthorized status
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }

	    try {
	        // Initialize the list to hold formatted events
	        List<Map<String, Object>> formattedEvents = new ArrayList<>();

	        // Fetch regular events based on division, year, and month
	        List<CalendarVO> events = calendarService.getEventsForCriteria(division, year, month);

	        // Filter events based on division and personal events condition
	        for (CalendarVO event : events) {
	            // For "personal" division, only include events where regEmpId matches the logged-in user's employee ID
	            if ("personal".equals(division) && !event.getRegEmpId().equals(loggedInUser.getEmpId())) {
	                continue; // Skip this event if it's not associated with the logged-in user
	            }
	            
	            // Format the event for FullCalendar
	            Map<String, Object> eventMap = formatEventForFullCalendar(event);
	            formattedEvents.add(eventMap);
	        }

	        // Fetch and format holiday events if the division is 'holiday' or for all divisions
	        if ("holiday".equals(division) || "all".equals(division)) {
	            List<HolidayVO> holidays = holidayService.getHolidaysForCriteria(year, month);
	            formattedEvents.addAll(formatHolidaysForFullCalendar(holidays));
	        }

	        // Return the formatted events
	        return new ResponseEntity<>(formattedEvents, HttpStatus.OK);
	    } catch (Exception e) {
	        // Log the exception and return an appropriate error response
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	private Map<String, Object> formatEventForFullCalendar(CalendarVO event) {
	    Map<String, Object> eventMap = new HashMap<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	    eventMap.put("title", event.getTitle());
	    eventMap.put("eventNo", event.getEventNo());
	    eventMap.put("start", dateFormat.format(event.getStartDt()));

	    // FullCalendar by default uses the same "start" date as "end" date for one-day events.
	    // If your event spans multiple days, ensure "end" is the actual end date without modification.
	    if (event.getEndDt() != null) {
	        eventMap.put("end", dateFormat.format(event.getEndDt()));
	    }
	    
	    eventMap.put("details", event.getDetails());
	    eventMap.put("division", event.getDivision());

	    return eventMap;
	}


	private List<Map<String, Object>> formatHolidaysForFullCalendar(List<HolidayVO> holidays) {
	   List<Map<String, Object>> formattedHolidays = new ArrayList<>();
	   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	   for (HolidayVO holiday : holidays) {
	       Map<String, Object> holidayMap = new HashMap<>();
	       holidayMap.put("title", holiday.getHolidayName());
	       holidayMap.put("start", dateFormat.format(holiday.getHolidayDate()));
	       holidayMap.put("end", dateFormat.format(holiday.getHolidayDate())); // Assuming holidays are single-day
	       holidayMap.put("color", "red"); // Assigning a distinct color for holidays
	       formattedHolidays.add(holidayMap);
	   }

	   return formattedHolidays;
	}


	@GetMapping("/getUpcomingEvents.do")
	public ResponseEntity<List<Map<String, Object>>> getUpcomingEvents(
	       @RequestParam("startDate") String startDate,
	       @RequestParam("endDate") String endDate,
	       HttpServletRequest request) {

	   // Fetch the logged-in user
	   UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");

	   // Check if the user is logged in
	   if (loggedInUser == null) {
	       // Return unauthorized status
	       return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	   }

	   try {
	       List<CalendarVO> events = calendarService.getUpcomingEvents(startDate, endDate);

	       // Filter events based on the logged-in user's employee ID
	       List<Map<String, Object>> formattedEvents = formatEventsForFrontend(events, loggedInUser.getEmpId());

	       // Fetch and format holiday events
	       List<HolidayVO> holidays = holidayService.getHolidaysInRange(startDate, endDate);
	       List<Map<String, Object>> formattedHolidays = formatHolidaysForFrontend(holidays);

	       // Combine formatted events and holidays
	       formattedEvents.addAll(formattedHolidays);

	       return new ResponseEntity<>(formattedEvents, HttpStatus.OK);
	   } catch (Exception e) {
	       // Log the exception and return an appropriate error response
	       e.printStackTrace();
	       return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	}


	// This method formats events for the frontend and filters based on the logged-in user's employee ID
	private List<Map<String, Object>> formatEventsForFrontend(List<CalendarVO> events, String loggedInEmployeeId) {
	    List<Map<String, Object>> formattedEvents = new ArrayList<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	    for (CalendarVO event : events) {
	        // Check if the event's division is "personal" and regEmpId matches the logged-in user's employee ID
	        if ("personal".equals(event.getDivision()) && !event.getRegEmpId().equals(loggedInEmployeeId)) {
	            continue; // Skip this event if it's not associated with the logged-in user
	        }

	        Map<String, Object> eventMap = new HashMap<>();
	        eventMap.put("title", event.getTitle());
	        eventMap.put("start", dateFormat.format(event.getStartDt()));
	        eventMap.put("end", dateFormat.format(event.getEndDt())); // Use the end date as it is
	        eventMap.put("division", event.getDivision());
	        formattedEvents.add(eventMap);
	    }

	    return formattedEvents;
	}

	
	
	// This method formats holiday events for the frontend
	private List<Map<String, Object>> formatHolidaysForFrontend(List<HolidayVO> holidays) {
	   List<Map<String, Object>> formattedHolidays = new ArrayList<>();
	   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	   for (HolidayVO holiday : holidays) {
	       Map<String, Object> holidayMap = new HashMap<>();
	       holidayMap.put("title", holiday.getHolidayName());
	       String formattedDate = holiday.getFormattedHolidayDate();
	       holidayMap.put("start", formattedDate);
	       holidayMap.put("end", formattedDate); // For a single-day event, start and end dates are the same
	       holidayMap.put("division", "holiday"); // Assign 'holiday' division for coloring in frontend
	       formattedHolidays.add(holidayMap);
	   }

	   return formattedHolidays;
	}
	

	@PostMapping("/deleteEvent.do")
	@ResponseBody
	public ResponseEntity<String> deleteEvent(@RequestParam("eventNo") Long eventNo) {
	   try {
	       // Call the service layer to delete the event by eventNo
	       boolean deleted = calendarService.deleteEventByEventNo(eventNo);
	       
	       if (deleted) {
	           return new ResponseEntity<>("Event deleted successfully", HttpStatus.OK);
	       } else {
	           return new ResponseEntity<>("Failed to delete event", HttpStatus.NOT_FOUND);
	       }
	   } catch (Exception e) {
	       // Log the exception and return an internal server error response
	       e.printStackTrace();
	       return new ResponseEntity<>("Internal server error", HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	}

	@PostMapping("/updateEvent.do")
	@ResponseBody
	public ResponseEntity<?> updateEvent(@RequestBody CalendarVO calendarVO) {
	  try {
	      System.out.println("Updating event: " + calendarVO);
	      calendarService.updateByEventNo(calendarVO);
	      return ResponseEntity.ok("Event updated successfully");
	  } catch (Exception e) {
	      e.printStackTrace(); // Log the exception
	      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating event: " + e.getMessage());
	  }
	}

	@GetMapping("/addEvent.do")
	public String addEvent(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
	  return "atnd/calendar/addEvent";
	}
	
	
	@PostMapping("/addEvent.do")
	public String addEvent(
	   @RequestParam("title") String title,
	   @RequestParam("startDt") String startDtStr,
	   @RequestParam("endDt") String endDtStr,
	   @RequestParam("details") String details,
	   @RequestParam("division") String division,
	   RedirectAttributes redirectAttrs,
	   ModelMap model,
	   HttpServletRequest request) throws java.text.ParseException {

	   UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	   
	   if (loggedInUser == null) {
	       return "redirect:/syst/main/login.do";
	   }

	   CalendarVO calendarEvent = new CalendarVO();

	   calendarEvent.setTitle(title);
	   calendarEvent.setDetails(details);
	   calendarEvent.setDivision(division);

	   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	   dateFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // Set timezone to UTC

	   Date startDt = dateFormat.parse(startDtStr);
	   Date endDt = dateFormat.parse(endDtStr);
	   
	   System.out.println("end date is: " + endDt);

	   calendarEvent.setStartDt(startDt);
	   calendarEvent.setEndDt(endDt);

	   calendarEvent.setRegEmpId(loggedInUser.getEmpId());
	   calendarEvent.setRegDt(new Date()); // Current date

	   calendarService.insert(calendarEvent); // Use service to save the event
	   redirectAttrs.addFlashAttribute("successMessage", "Event added successfully!");
	   return "redirect:/syst/main/home.do"; // Make sure this is the correct mapping to your calendar view
	}
}