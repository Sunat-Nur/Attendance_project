package syst.holiday.web;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import syst.hist.service.OtherHistoryService;
import syst.holiday.service.HolidayService;
import syst.holiday.vo.HolidayVO;
import syst.user.vo.UserMgVO;

import java.util.ArrayList;
import java.util.Date;

@RequestMapping("/syst/holiday")
@Controller
public class HolidayController {

	@Autowired
	private HolidayService holidayService;
	
	@Autowired
	private OtherHistoryService otherHistoryService;

	@GetMapping("/holidayList.do")
	public String showHolidayList(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
    
		List<HolidayVO> holidayList = holidayService.getAllHolidayList();
		model.addAttribute("holidayList", holidayList);
		return "syst/holiday/holidayList";
	}

	@PostMapping("/saveHolidayChanges.do")
	public ResponseEntity<?> saveHolidayChanges(@RequestBody List<HolidayVO> updatedHolidays, HttpSession session, HttpServletRequest request) {
	    try {
	        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");

	        if (loggedInUser != null && loggedInUser.getEmpId() != null) {
	            Date currentDate = new Date();

	            Set<Long> uniqueHolidayNos = new HashSet<>();
	            List<Long> duplicateHolidayNos = new ArrayList<>();

	            for (HolidayVO holiday : updatedHolidays) {
	                if (holiday.getHolidayNo() != null && !uniqueHolidayNos.add(holiday.getHolidayNo())) {
	                    duplicateHolidayNos.add(holiday.getHolidayNo());
	                }
	            }

	            if (!duplicateHolidayNos.isEmpty()) {
	                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: Duplicate holiday numbers detected - " + duplicateHolidayNos);
	            }

	            List<HolidayVO> holidaysToUpdate = new ArrayList<>();
	            List<HolidayVO> holidaysToCreate = new ArrayList<>();

	            for (HolidayVO updatedHoliday : updatedHolidays) {
	                // Fetch the existing holiday data before it is updated
	                HolidayVO existingHoliday = null;
	                if (updatedHoliday.getHolidayNo() != null) {
	                    existingHoliday = holidayService.getHolidayByNo(updatedHoliday.getHolidayNo());
	                }

	                // If the holiday already exists, prepare it for an update
	                if (existingHoliday != null) {
	                    // Save the existing holiday state into another history table before updating
	                    String referrerUrl = request.getHeader("Referer");
	                    otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Edit", "Holiday Management", existingHoliday);

	                    updatedHoliday.setModEmpId(loggedInUser.getEmpId());
	                    updatedHoliday.setModDt(currentDate);
	                    holidaysToUpdate.add(updatedHoliday);
	                } else {
	                    // For new holidays
	                    updatedHoliday.setRegEmpId(loggedInUser.getEmpId());
	                    updatedHoliday.setRegDt(currentDate);
	                    holidaysToCreate.add(updatedHoliday);
	                }
	            }

	            // Process updates and creates
	            if (!holidaysToUpdate.isEmpty()) {
	                holidayService.updateHolidays(holidaysToUpdate);
	            }
	            if (!holidaysToCreate.isEmpty()) {
	                holidayService.createHolidays(holidaysToCreate);
	            }

	            return ResponseEntity.ok("Data updated successfully");
	        } else {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized access");
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
	    }
	}


    @PostMapping("/deleteHoliday.do")
    public ResponseEntity<?> deleteHolidays(@RequestBody Long holidayNo, HttpServletRequest request, RedirectAttributes redirectAttributes){
    	
    	
    	  // Fetch the logged-in user details
        HttpSession session = request.getSession();
        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
        
      

       HolidayVO existingHoliday = holidayService.getHolidayByNo(holidayNo);
        if (existingHoliday == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Holiday not found.");
        }
        
        
        // Save the old field values to other history
        String referrerUrl = request.getHeader("Referer");
        otherHistoryService.createOtherHistoryRecord(loggedInUser, referrerUrl, "Delete", "Holiday Management", existingHoliday);
        
        holidayService.deleteHoliday(holidayNo);
        return ResponseEntity.ok().body("Deleted successfully");
    }
}