package atnd.attendance.web;

import java.beans.PropertyEditorSupport;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import atnd.attendance.service.AttendanceService;
import atnd.attendance.vo.AttendanceAggregateVO;
import atnd.attendance.vo.AttendanceDailyVO;
import atnd.attendance.vo.AttendanceVO;
import syst.user.service.UserService;
import syst.user.vo.UserMgVO;

@RequestMapping("/atnd/attendance")
@Controller
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private UserService userService;

    @GetMapping("/dailyLogin.do")
    public String showLoginPage(ModelMap model, HttpServletRequest request) {
        UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/syst/main/login.do";
        }
        
        // Check if the logged-in user is admin
        if ("admin".equals(loggedInUser.getEmpId())) {
            model.addAttribute("isAdmin", true); // Flag to indicate admin user
        } else {
            model.addAttribute("isAdmin", false);
        }
        
        model.addAttribute("loggedInUser", loggedInUser);
        return "atnd/attendance/dailyLogin";
    }

    
    
    @GetMapping("/getLatestAttendance.do")
    @ResponseBody
    public ResponseEntity<?> getLatestAttendance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
        }

        AttendanceVO latestAttendance = attendanceService.getLatestAttendance(loggedInUser.getEmpId());
        boolean hasOngoingSession = latestAttendance != null && latestAttendance.getEndTime() == null;

        // Additionally, send the state to the frontend to directly manipulate the button states
        Map<String, Object> response = new HashMap<>();
        response.put("hasOngoingSession", hasOngoingSession);
        response.put("enableStart", latestAttendance == null || latestAttendance.getEndTime() != null);
        response.put("enableEnd", hasOngoingSession);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/personalAtnd.do")
    public String showAttendanceList(@RequestParam(name = "empId", required = false) String empIdParameter,
                                     ModelMap model, HttpServletRequest request) {
        UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/syst/main/login.do";
        }

        String empId = (empIdParameter != null) ? empIdParameter : loggedInUser.getEmpId();
        List<AttendanceDailyVO> attendanceList = attendanceService.getAllAttendances(empId);

        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("empId", empId);
        // Add loggedInUser's security level to the model
        model.addAttribute("userSecurityLevel", loggedInUser.getSecurityLevel());
        

        return "atnd/attendance/personalAtnd";
    }
    
    
    @PostMapping(value = "/saveAttendance.do", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ResponseEntity<?> saveAttendance(@ModelAttribute AttendanceVO attendance, HttpServletRequest request) {
       HttpSession session = request.getSession();
       UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
       if (loggedInUser == null) {
           return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
       }
       attendance.setEmpId(loggedInUser.getEmpId());
       attendance.setIpAddress(getClientIPAddress(request));
       Double lateTime = attendance.getLate();
       if (lateTime != null) {
           DecimalFormat df = new DecimalFormat("#.00");
           lateTime = Double.valueOf(df.format(lateTime));
           attendance.setLate(lateTime);
       }
       if (attendance.getAew() == null) {
           attendance.setAew(0); // Set to 0 if null
       }
       if (attendance.getOverTime() == null) {
           attendance.setOverTime(0.0); // Set overtime to 0 if not provided
       }
       // Set lateness based on late time
       Integer lateness = (lateTime != null && lateTime > 0) ? 1 : 0;
       attendance.setLateness(lateness);
       try {
           boolean attendanceUpdated = false;
           if (attendance.getEndTime() == null) {
               // Insert operation
               attendanceService.insertAttendance(attendance);
               attendanceUpdated = true;
           } else {
               // Update operation - Fetch the latest record with endTime null and update it
               AttendanceVO latestAttendance = attendanceService.getLatestAttendance(loggedInUser.getEmpId());
               if (latestAttendance != null) {
                   attendance.setNo(latestAttendance.getNo());
                   attendanceService.updateAttendance(attendance);
                   attendanceUpdated = true;
               } else {
                   return new ResponseEntity<>("No open attendance record to update.", HttpStatus.BAD_REQUEST);
               }
           }
         
           return new ResponseEntity<>(Collections.singletonMap("message", "Attendance processed successfully!"), HttpStatus.OK);
       } catch (Exception e) {
           e.printStackTrace();
           return new ResponseEntity<>(Collections.singletonMap("message", "Failed to process attendance."), HttpStatus.INTERNAL_SERVER_ERROR);
       }
    }

    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
       // For 'startTime' and 'endTime' fields
       SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateTimeFormat, true));

       // For 'timeSetting' field, if it's just a time without a date
       SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
       binder.registerCustomEditor(Date.class, "timeSetting", new CustomDateEditor(timeFormat, true) {
           @Override
           public void setAsText(String text) throws IllegalArgumentException {
               try {
                   // Combine with the current date if needed
                   Date time = timeFormat.parse(text);
                   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                   Date currentDate = new Date();
                   String currentDateString = dateFormat.format(currentDate);
                   Date combinedDateTime = dateTimeFormat.parse(currentDateString + " " + text);
                   setValue(combinedDateTime);
               } catch (ParseException e) {
                   throw new IllegalArgumentException("Could not parse time: " + text, e);
               }
           }
       });
    }
    

    @GetMapping("/getIPAddress.do")
    public ResponseEntity<String> getIPAddress(HttpServletRequest request) {
        String clientIP = getClientIPAddress(request);
        return new ResponseEntity<>(clientIP, HttpStatus.OK);
    }

    // Add the getClientIPAddress method here
    private String getClientIPAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_FORWARDED");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_FORWARDED_FOR");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_FORWARDED");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_VIA");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("REMOTE_ADDR");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
        }

        // In case of multiple IPs, extract the first one
        if (ipAddress != null && ipAddress.contains(",")) {
            ipAddress = ipAddress.split(",")[0].trim();
        }

        // Check for IPv6 loopback address and return IPv4 loopback address instead
        if ("0:0:0:0:0:0:0:1".equals(ipAddress)) {
            ipAddress = "127.0.0.1";
        }

        return ipAddress;
    }



    @PostMapping("/saveAttendanceChanges.do")
    public ResponseEntity<?> saveAttendanceChanges(@RequestBody AttendanceDailyVO data) {
        try {
            System.out.println(data);
            // Process the single attendance record
            attendanceService.updateDailyAttendance(data);
           
            System.out.println("controller");
            return ResponseEntity.ok("Data updated successfully");
        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();
            // Return an appropriate error response
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
        }
    }
    
    @PostMapping("/updatePersonalAttendanceData.do")
    public ResponseEntity<?> updatePersonalAttendanceData(@RequestParam("empId") String empId,
            @RequestParam("startTime") String startTimeStr,
            @RequestParam("endTime") String endTimeStr,
            @RequestParam("overTime") String overTime,
            @RequestParam("timeSetting") String timeSetting,
            @RequestParam("atndNo") String atndNo) {
    	try {
    		System.out.println("Employee ID: " + empId);
            System.out.println("Start Time: " + startTimeStr);
            System.out.println("End Time: " + endTimeStr);
            System.out.println("Overtime: " + overTime);
            System.out.println("TimeSettings: " + timeSetting);
            
            attendanceService.updatePersonalAttendanceData(empId,startTimeStr,endTimeStr,overTime,timeSetting, atndNo);
    		
    		return ResponseEntity.ok("Data updated successfully");
    	} catch (Exception e) {
    		// Log the exception for debugging purposes
    		e.printStackTrace();
    		// Return an appropriate error response
    		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
    	}
    }


    @PostMapping("/deletePersonalAttendance.do")
    public ResponseEntity <String> deletePersonalAttendance(@RequestParam("no") Long no) {
        try {
            attendanceService.deletePersonalAttendance(no);
            return new ResponseEntity <> ("Data deleted successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity <> ("There was an error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/latestAtndlistEmp.do")
    public String getAllLatestAttendancesForEmp(ModelMap model, HttpServletRequest request) {
        try {
            UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
            if (loggedInUser == null || loggedInUser.getSecurityLevel() == null) {
                return "redirect:/syst/main/login.do"; // Redirect to login page
            }

            Integer loggedInUserSecurityLevel = loggedInUser.getSecurityLevel();
            String loggedInUserDesignation = loggedInUser.getDesignation();
            String loggedInUserGroup = loggedInUser.getGroup();
            String loggedInUserDepartment = loggedInUser.getDepartment();

            List < AttendanceDailyVO > allAttendances = attendanceService.getAllLatestAttendances();
            System.out.println(allAttendances);
            List < AttendanceDailyVO > filteredAttendance = new ArrayList < > ();

            for (AttendanceDailyVO attendance: allAttendances) {
                UserMgVO user = userService.getUserByEmpId(attendance.getEmpId());
                System.out.println(user);
                if (user != null) {
                    Integer userSecurityLevel = user.getSecurityLevel();
                    String userGroup = user.getGroup();
                    String userDepartment = user.getDepartment();

                    boolean isSameGroup = loggedInUserGroup.equals(userGroup);
                    boolean isSameOrLowerSecurity = userSecurityLevel != null && userSecurityLevel >= loggedInUserSecurityLevel;
                    boolean isSameDepartment = loggedInUserDepartment.equals(userDepartment);

                    if ("CXO".equals(loggedInUserDesignation) || "VP".equals(loggedInUserDesignation)) {
                        if (isSameGroup && isSameOrLowerSecurity) {
                            filteredAttendance.add(attendance);
                        }

                    } else {
                        if (isSameGroup && isSameDepartment && isSameOrLowerSecurity) {
                            filteredAttendance.add(attendance);
                        }
                    }
                }
                model.addAttribute("user", user);
            }
            
            model.addAttribute("attendances", filteredAttendance);
            return "atnd/attendance/atndListEmp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "An error occurred: " + e.getMessage());
            return "board/error";
        }
    }


    @GetMapping("/latestAtndlistCEO.do")
    public String getAllLatestAttendancesForCEO(ModelMap model, HttpServletRequest request) {
        try {
            UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
            if (loggedInUser == null) {
                // Store the current URL in the session
                request.getSession().setAttribute("previousURL", request.getRequestURI());
                return "redirect:/syst/main/login.do";
            }

            String loggedInUserDesignation = loggedInUser.getDesignation();

            if (!"CEO".equals(loggedInUserDesignation) && !"Admin".equals(loggedInUserDesignation)) {
                model.addAttribute("errorMessage", "Access denied: Insufficient privileges");
                return "redirect:" + request.getHeader("Referer");
            }

            List <AttendanceDailyVO> allAttendances = attendanceService.getAllLatestAttendances();
            model.addAttribute("attendances", allAttendances);
            return "atnd/attendance/atndListCEO";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "An error occurred: " + e.getMessage());
            return "board/error";
        }
    }



    @GetMapping("/filterData.do")
    public ResponseEntity <List <AttendanceAggregateVO>> getFilteredData(@RequestParam String column, @RequestParam String value) {
        try {
            List <AttendanceAggregateVO> filteredData = attendanceService.getFilteredData(column, value);


            return new ResponseEntity<> (filteredData, HttpStatus.OK);
        } catch (Exception e) {

            e.printStackTrace();
            return new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    
    @GetMapping("/overTime.do")
    public String getOverTimeDetails(@RequestParam(name = "empId", required = true) String empId, ModelMap model, HttpServletRequest request) {

    	UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
    	
        if (loggedInUser == null) {
            // Store the current URL in the session
            request.getSession().setAttribute("previousURL", request.getRequestURI());
            return "redirect:/syst/main/login.do";
        }
        
        List<AttendanceVO> overTimeList = attendanceService.getOvertimeDetailsByEmpId(empId);

        // Filter out today's data
        LocalDate today = LocalDate.now(); // You might need to specify a time zone: LocalDate.now(ZoneId.systemDefault());
        List<AttendanceVO> filteredOverTimeList = overTimeList.stream()
                .filter(ot -> !ot.getStartTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        // Add the filtered list to the model
        model.addAttribute("overTimeList", filteredOverTimeList);
        model.addAttribute("empId", empId);

        return "atnd/attendance/overTimeDetails";
    }
    
    
    @PostMapping("/updateOvertimeDeatails.do")
    public ResponseEntity<?> updateOvertimeDeatails(@RequestParam("empId") String empId,
            @RequestParam("gpsInformation") String gpsInformation,
            @RequestParam("startTime") String startTimeString,
            @RequestParam("endTime") String endTimeString,

            @RequestParam("workType") String workType,
            @RequestParam("accessType") String accessType,
            @RequestParam("ipAddress") String ipAddress,
            @RequestParam("timeSetting") String timeSettingString,
            @RequestParam("no") String no) {
        try {
                 
            attendanceService.updateOvertimeDeatails(empId, gpsInformation, startTimeString, endTimeString,
                    workType, accessType, ipAddress, timeSettingString, no);
                                 
            return ResponseEntity.ok("Data updated successfully");
        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();
            // Return an appropriate error response
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating data: " + e.getMessage());
        }
    }
    
    @GetMapping("/todayAttendanceList.do")
    public String getTodayAttendanceList( ModelMap model, HttpServletRequest request) {
   
    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
    
    if (loggedInUser == null) {
        // Store the current URL in the session
        request.getSession().setAttribute("previousURL", request.getRequestURI());
        return "redirect:/syst/main/login.do";
    }
       
    String empId =  loggedInUser.getEmpId();
   
   
        List<AttendanceVO> todayAttendanceList = attendanceService.getTodayAttendanceList(empId);

       
        model.addAttribute("loggedInUser", loggedInUser);
        model.addAttribute("todayAttendanceList", todayAttendanceList);
       

        return "atnd/attendance/today";
    }
   
   
   
   
    @GetMapping("/todayAllAttendanceList.do")
    public String getTodayAllAttendanceList(ModelMap model, HttpServletRequest request) {

        UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            // Store the current URL in the session
            request.getSession().setAttribute("previousURL", request.getRequestURI());
            return "redirect:/syst/main/login.do";
        }
       
        // Fetch today's attendance list
        List<AttendanceVO> todayAllAttendanceList = attendanceService.getTodayAllAttendanceList();
        
        // Extract employee IDs from the attendance list
        List<String> empIds = todayAllAttendanceList.stream()
                                                    .map(AttendanceVO::getEmpId)
                                                    .collect(Collectors.toList());
        
        List<UserMgVO> userDetailsList = new ArrayList<>();
        
        // Fetch user details only if empIds is not empty
        if (!empIds.isEmpty()) {
            userDetailsList = userService.getUsersDetailsByEmpIds(empIds);
        }

        // Add attendance list and user details to the model attribute
        model.addAttribute("todayAllAttendanceList", todayAllAttendanceList);
        model.addAttribute("userDetailsList", userDetailsList);

        return "atnd/attendance/todayAll";
    }

}