package atnd.attendance.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import atnd.attendance.dao.AttendanceDAO;
import atnd.attendance.service.AttendanceService;
import atnd.attendance.vo.AttendanceAggregateVO;
import atnd.attendance.vo.AttendanceDailyVO;
import atnd.attendance.vo.AttendanceVO;
import syst.user.service.UserService;
import syst.user.vo.UserMgVO;

@EnableScheduling
@Service("attendanceService")
public class AttendanceServiceImpl implements AttendanceService {

	@Autowired
	private AttendanceDAO attendanceDAO;
	
	@Autowired
	private UserService userService;
	
	@Override
	public void insertAttendance(AttendanceVO attendance) {
	     attendanceDAO.insertRecord(attendance);
	 }
	
	@Override
	public void deletePersonalAttendance(Long no) {
		attendanceDAO.deleteById(no);
	}
	
	@Override
	public List<AttendanceDailyVO> getAllAttendances(String empId) {
		return attendanceDAO.getAllAttendanceList(empId);
	}


	@Override
	public void updateDailyAttendance(AttendanceDailyVO attendance) {
		attendanceDAO.updateDailyAttendance(attendance);
	}


	@Override
	public List<AttendanceDailyVO> getAllLatestAttendances() {
		return attendanceDAO.getAllLatestAttendances();
	}

	@Override
	public List<AttendanceAggregateVO> getFilteredData(String column, String value) {
	        List<AttendanceAggregateVO> results = null;

	       
	        if ("start-time".equals(column)) {
	            results = attendanceDAO.getFilteredDataByStartTime(value);
	        } else if ("end-time".equals(column)) {
	            results = attendanceDAO.getFilteredDataByEndTime(value);
	        } else if ("work-hour".equals(column)) {
	            results = attendanceDAO.getFilteredDataByWorkHour(value);
	        }else if ("late".equals(column)) {
	            results = attendanceDAO.getFilteredDataByLate(value);
	        } else if ("lateness".equals(column)) {
	            results = attendanceDAO.getFilteredDataByLateness(value);
	        } else if ("outside-work".equals(column)) {
	            results = attendanceDAO.getFilteredDataByOutsideWork(value);
	        } else if ("business-trip".equals(column)) {
	            results = attendanceDAO.getFilteredDataByBusinessTrip(value);
	        } else if ("training".equals(column)) {
	            results = attendanceDAO.getFilteredDataByTraining(value);
	        } else if ("overtime".equals(column)) {
	            results = attendanceDAO.getFilteredDataByOvertime(value);
	        } else if ("status".equals(column)) {
	            results = attendanceDAO.getFilteredDataByStatus(value);
	        } else if ("aew".equals(column)) {
	            results = attendanceDAO.getFilteredDataByAEW(value);
	        }
	        // Add more conditions for other columns as needed

	        return results;
	    }
	

	@Override
	public void updateAttendance(AttendanceVO attendance) {
		System.out.println("service");
		attendanceDAO.updateRecord(attendance);
	}

	@Override
	public AttendanceVO getLatestAttendance(String empId) {
		return attendanceDAO.getLatestRecord(empId);
	}
	

	@Override
	public List<AttendanceVO> getOvertimeDetailsByEmpId(String empId) {
	    return attendanceDAO.getOvertimeDetailsByEmpId(empId);
	}
	
	@Override
	public List<AttendanceVO> getTodayAttendanceList(String empId) {
		return attendanceDAO.getTodayAttendanceList(empId);
	}

	@Override
	public List<AttendanceVO> getTodayAllAttendanceList() {
		return attendanceDAO.getTodayAttendanceList();
	}
	
	
	@Override
	public void updateOvertimeDeatails(String empId, String gpsInformation, String startTimeString,
	        String endTimeString, String workType, String accessType, String ipAddress,
	        String timeSettingString, String no) {
	   
	    SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z");
	    SimpleDateFormat sdfTimesetting = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy");
	   
	       
	    try {
	        // Parse the start and end time strings into Date objects
	        Date startTime = sdf.parse(startTimeString);
	        Date endTime = sdf.parse(endTimeString);
	        Date timesetting =sdfTimesetting.parse(timeSettingString);
	       
	       
	        Calendar startCal = Calendar.getInstance();
	           startCal.setTime(startTime);
	           Calendar endCal = Calendar.getInstance();
	           endCal.setTime(endTime);
	           Calendar timeSettingCal = Calendar.getInstance();
	           timeSettingCal.setTime(timesetting);

	           // Create final start and end Date objects with the date from timeSetting and time from startTime/endTime
	           Calendar finalStartCal = (Calendar) timeSettingCal.clone();
	           finalStartCal.set(Calendar.HOUR_OF_DAY, startCal.get(Calendar.HOUR_OF_DAY));
	           finalStartCal.set(Calendar.MINUTE, startCal.get(Calendar.MINUTE));
	           finalStartCal.set(Calendar.SECOND, startCal.get(Calendar.SECOND));

	           Calendar finalEndCal = (Calendar) timeSettingCal.clone();
	           finalEndCal.set(Calendar.HOUR_OF_DAY, endCal.get(Calendar.HOUR_OF_DAY));
	           finalEndCal.set(Calendar.MINUTE, endCal.get(Calendar.MINUTE));
	           finalEndCal.set(Calendar.SECOND, endCal.get(Calendar.SECOND));

	           Date finalStartTime = finalStartCal.getTime();
	           Date finalEndTime = finalEndCal.getTime();
	       
	        // Calculate the duration in milliseconds
	        long durationMillis = endTime.getTime() - startTime.getTime();
	       
	        // Convert duration from milliseconds to total minutes
	        long durationTotalMinutes = durationMillis / 60000;
	        // Calculate hours and minutes from total minutes
	        long hours = durationTotalMinutes / 60;
	     
	        double minutes =  ((durationTotalMinutes % 60)/100.0);
	        System.out.println(minutes);
	                                   
	        Double durationHours = (hours + minutes);
	       
	        System.out.println(durationHours+ "ddddddddddddddddddddddddddddddddd");
	     
	       
	        // Convert String no to Long
	        Long number = Long.parseLong(no);
	       
	        // Now, you can set this durationHours and number as the overTime and an additional value in your AttendanceVO
	        AttendanceVO overtimeData = new AttendanceVO();
	        overtimeData.setStartTime(finalStartTime);
	        overtimeData.setEndTime(finalEndTime);
	        overtimeData.setOverTime(durationHours);
	        overtimeData.setWorkHour(durationHours); // Assuming you want to set the same value as work hours
	        overtimeData.setEmpId(empId);
	        overtimeData.setNo(number); // Replace 'setSomeLongValue' with the actual setter method name for the Long value in your AttendanceVO
	       
	        System.out.println(overtimeData);
	        attendanceDAO.updateOvertimeAndWorkhour(overtimeData);
	       
	        List<AttendanceVO> allOvertimeData = attendanceDAO.getAllOvertimeDataForDate(timesetting,empId);
	        System.out.println(allOvertimeData);
	        processOvertimeData(allOvertimeData);
	       
	       
	    } catch (ParseException e) {
	        e.printStackTrace();
	        // Handle parsing errors, possibly throw a custom exception or log error details
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        // Handle number format errors, possibly throw a custom exception or log error details
	    }
	}




	private void processOvertimeData(List<AttendanceVO> overtimeDataList) {
	   if (!overtimeDataList.isEmpty()) {
	       // Get the empId and startTime from the first object in the list
	       AttendanceVO firstAttendance = overtimeDataList.get(0);
	       String empId = firstAttendance.getEmpId();
	       Date startTime = firstAttendance.getStartTime();

	       // Log empId and startTime
	       System.out.println("EmpId: " + empId + ", StartTime: " + startTime);

	       // Fetch daily data for overtime based on empId and the date from startTime
	       AttendanceDailyVO dailyOvertimeData = attendanceDAO.fetchDailyDataForOvertime(empId, startTime);

	     
	      Integer totalMinutes =0;
	     
	       
	       for (AttendanceVO attendanceVO : overtimeDataList) {
	        int hours =0;
	       int minutes =0;
	       
	        double overTime = attendanceVO.getOverTime();
	       
	        hours = (int)overTime;
	       
	        minutes = (int) ((overTime-hours)*100);
	       
	        totalMinutes += minutes + (hours*60);
	       
	       }
	       
	    // Calculate hours and minutes separately
	       int hours = totalMinutes / 60;
	       int minutes = totalMinutes % 60;

	       // Construct the desired representation: hours + (minutes as decimal portion)
	       double totalOvertimeHours = hours + (minutes / 100.0);


	       // Convert total minutes back to hours and minutes

	        System.out.println(totalOvertimeHours);

	       // Update the dailyOvertimeData with the correctly formatted overtime
	       dailyOvertimeData.setOverTime(totalOvertimeHours);
	       
	     
	       

	       // Calculate and set the status
	       Double totalWorkHours = dailyOvertimeData.getWorkHour(); // Assuming getWorkHour() returns Double
	       Double statusCalculation = ((totalOvertimeHours + totalWorkHours) / 9) * 100;
	       Integer status = (int) Math.round(statusCalculation); // Casting and rounding to Integer

	       dailyOvertimeData.setStatus(status);

	       // Save or update the dailyOvertimeData
	       attendanceDAO.updateOverTimeForDailyData(dailyOvertimeData);
	   }
	}


	@Override
	public void updatePersonalAttendanceData(AttendanceDailyVO data) {
	// TODO Auto-generated method stub

	}

	@Override
	public void updatePersonalAttendanceData(String empId, String startTimeStr, String endTimeStr, String overTime,
	String timeSetting, String atndNo) {

	SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z");
	    SimpleDateFormat sdfTimesetting = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   
	       
	    try {
	        // Parse the start and end time strings into Date objects
	        Date startTime = sdf.parse(startTimeStr);
	        Date endTime = sdf.parse(endTimeStr);
	        Date timesettingdata =sdfTimesetting.parse(timeSetting);
	       
	       
	       
	        Calendar startCal = Calendar.getInstance();
	           startCal.setTime(startTime);
	           Calendar endCal = Calendar.getInstance();
	           endCal.setTime(endTime);
	           Calendar timeSettingCal = Calendar.getInstance();
	           timeSettingCal.setTime(timesettingdata);

	           // Create final start and end Date objects with the date from timeSetting and time from startTime/endTime
	           Calendar finalStartCal = (Calendar) timeSettingCal.clone();
	           finalStartCal.set(Calendar.HOUR_OF_DAY, startCal.get(Calendar.HOUR_OF_DAY));
	           finalStartCal.set(Calendar.MINUTE, startCal.get(Calendar.MINUTE));
	           finalStartCal.set(Calendar.SECOND, startCal.get(Calendar.SECOND));

	           Calendar finalEndCal = (Calendar) timeSettingCal.clone();
	           finalEndCal.set(Calendar.HOUR_OF_DAY, endCal.get(Calendar.HOUR_OF_DAY));
	           finalEndCal.set(Calendar.MINUTE, endCal.get(Calendar.MINUTE));
	           finalEndCal.set(Calendar.SECOND, endCal.get(Calendar.SECOND));
	           
	           Calendar finalTimeSettingCal = (Calendar) timeSettingCal.clone();
	           finalTimeSettingCal.set(Calendar.SECOND, 0);

	           Date finalStartTime = finalStartCal.getTime();
	           Date finalEndTime = finalEndCal.getTime();
	           
	           
	           
	          // Late & lateness calculation
	           int late = 0;
	           Double lateness = 0.0; // Lateness duration in minutes as double
	         
	           Calendar finalEndCalForComparison = Calendar.getInstance();
	           finalEndCalForComparison.setTime(finalEndTime);
	           
	           
	           System.out.println("Is startCal after finalTimeSettingCal? " + startCal.after(finalTimeSettingCal));
	           if(finalStartCal.after(finalTimeSettingCal)) {
	               // If the final start time is after the time setting, calculate lateness
	               late = 1;
	               long latenessDuration = finalStartCal.getTimeInMillis() - finalTimeSettingCal.getTimeInMillis();
	               // Convert latenessDuration from milliseconds to minutes as a double
	               lateness = latenessDuration / 60000.0; // 60000 milliseconds in a minute
	               
	           
	          // Calculate hours and minutes from total minutes
	          long hours = (long) (lateness / 60);
	       
	          double minutes = (lateness % 60)/100.0;
	                   
	          lateness = (hours + minutes);
	         
	           }

	           
	           
	           
	           // WorkHour calculation
	           long workHourDuration = endTime.getTime() - startTime.getTime();
	           System.out.println("work duration "+workHourDuration);
	           
	           long durationTotalMinutes = workHourDuration / 60000;
	        // Calculate hours and minutes from total minutes
	        long hours = durationTotalMinutes / 60;
	     
	        double minutes = (durationTotalMinutes % 60)/100.0;
	                 
	        Double workHour = (hours + minutes);
	       
	       
	       
	        // Status calculation
	        Double OverTimeData = Double.parseDouble(overTime); // Assuming getWorkHour() returns Double
	       Double statusCalculation = ((OverTimeData + workHour) / 9) * 100;
	       Integer status = (int) Math.round(statusCalculation);
	       
	       
	       
	       //parse atndNo
	       Long parsedAtndNo = Long.parseLong(atndNo);
	       
	       
	           
	           System.out.println("Final Start Time for Comparison: " + finalStartCal.getTime());
	           System.out.println("Time Setting for Comparison: " + finalTimeSettingCal.getTime());
	           System.out.println("Is Final Start Time after Time Setting? " + (finalStartCal.after(finalTimeSettingCal)));
	           System.out.println("Lateness Minutes: " + lateness);
	           System.out.println("Status: " + status);
	           
	                                                                       
	           System.out.println(finalStartTime);
	           System.out.println(finalEndTime);
	           System.out.println(late);
	           System.out.println(lateness);
	           System.out.println(workHour);
	           
	           
	           AttendanceDailyVO atndDaily = new AttendanceDailyVO();
	           atndDaily.setAtndNo(parsedAtndNo);
	           atndDaily.setStartTime(finalStartTime);
	           atndDaily.setEndTime(finalEndTime);
	           atndDaily.setLateness(late);
	           atndDaily.setLate(lateness);
	           atndDaily.setWorkHour(workHour);
	           atndDaily.setStatus(status);
	           
	           attendanceDAO.updatePersonalAttendanceData(atndDaily);
	                               
	       
	    } catch (ParseException e) {
	        e.printStackTrace();
	        // Handle parsing errors, possibly throw a custom exception or log error details
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        // Handle number format errors, possibly throw a custom exception or log error details
	    }
	}

	
	@Scheduled(cron = "0 49 09 * * ?")  //change the time to when previous attendance should save
	public void insertIntoDailyTable() {
	   Calendar calendar = Calendar.getInstance();
	   calendar.add(Calendar.DAY_OF_MONTH, -1); // Set to previous day
	   Date previousDay = calendar.getTime();
	   calculateAndSaveAverageAttendance(previousDay);
	}
	 
	public void calculateAndSaveAverageAttendance(Date date) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedDate = sdf.format(date);

	    // Fetch attendance records for the specified date
	    List<AttendanceVO> attendances = attendanceDAO.getAttendanceByDate(formattedDate);
	    if (attendances.isEmpty()) {
	        return; // No records to process
	    }

	    // Group attendance records by employee ID
	    Map<String, List<AttendanceVO>> attendanceByEmployee = new HashMap<>();
	    for (AttendanceVO attendance : attendances) {
	        attendanceByEmployee.computeIfAbsent(attendance.getEmpId(), k -> new ArrayList<>()).add(attendance);
	    }

	    // Process each employee's attendance records
	    for (Map.Entry<String, List<AttendanceVO>> entry : attendanceByEmployee.entrySet()) {
	        String empId = entry.getKey();
	        List<AttendanceVO> employeeAttendances = entry.getValue();

	        // Initialize variables for aggregating attendance information
	        double totalLate = 0, totalWorkHours = 0, totalOverTime = 0;
	        Integer totalAew = 0;
	        int lateness = 0, outsideWork = 0, training = 0, businessTrip = 0;

	        // Fetch user details
	        UserMgVO user = userService.getUserByEmpId(empId);
	        AttendanceDailyVO consolidatedAttendance = new AttendanceDailyVO();

	        // Initialize consolidatedAttendance with user details
	        if (user != null) {
	            consolidatedAttendance.setEmpId(user.getEmpId());
	            consolidatedAttendance.setName(user.getName());
	            consolidatedAttendance.setGroup(user.getGroup());
	            consolidatedAttendance.setDepartment(user.getDepartment());
	            consolidatedAttendance.setDesignation(user.getDesignation());
	            consolidatedAttendance.setYearOfWork(user.getYearOfWorking());
	            consolidatedAttendance.setCareer(user.getCareerExperience());
	        }

	        // Set initial values for consolidatedAttendance from the first session
	        AttendanceVO firstSession = employeeAttendances.get(0);
	        consolidatedAttendance.setStartTime(firstSession.getStartTime());
	        consolidatedAttendance.setEndTime(employeeAttendances.get(employeeAttendances.size() - 1).getEndTime());
	        consolidatedAttendance.setTimeSetting(firstSession.getTimeSetting()); // Ensure timeSetting is set to avoid NULL
	        consolidatedAttendance.setGpsInformation(firstSession.getGpsInformation());
	        consolidatedAttendance.setWorkType(firstSession.getWorkType());
	        consolidatedAttendance.setAccessType(firstSession.getAccessType());
	        consolidatedAttendance.setIpAddress(firstSession.getIpAddress());

	        // Loop through all attendance records to aggregate data
	        for (AttendanceVO session : employeeAttendances) {
	            totalLate += session.getLate();
	            totalAew += session.getAew();
	            if ("Overtime".equals(session.getWorkType())) {
	                // If the work type is Overtime, add the work hours to totalOverTime instead of totalWorkHours
	                totalOverTime += session.getWorkHour();
	            } else {
	                // For other work types, add to totalWorkHours
	                totalWorkHours += session.getWorkHour();
	            }

	            // Aggregate conditions
	            lateness |= session.getLateness();
	            outsideWork |= session.getOutsideWork();
	            training |= session.getTraining();
	            businessTrip |= session.getBusinessTrip();
	        }

	        // Set aggregated values in consolidatedAttendance
	        consolidatedAttendance.setLate(totalLate);
	        consolidatedAttendance.setAew(totalAew);
	        consolidatedAttendance.setLateness(lateness);
	        consolidatedAttendance.setOutsideWork(outsideWork);
	        consolidatedAttendance.setTraining(training);
	        consolidatedAttendance.setBusinessTrip(businessTrip);
	        consolidatedAttendance.setWorkHour(totalWorkHours);
	        consolidatedAttendance.setOverTime(totalOverTime);

	        // Calculate and set status based on total work hours or other criteria
	        double status = ((totalWorkHours+totalOverTime) / 9) * 100; // Assuming 480 represents a full workday in minutes
	        consolidatedAttendance.setStatus((int) status);

	        // Insert the consolidated attendance record into the database
	        attendanceDAO.insertDailyAverageAttendance(consolidatedAttendance);
	    }
	}

	@Scheduled(cron = "0 0 2 * * MON")
	public void generateWeeklyAttendance() {
	    // Calculate the start and end dates for the last week
	    Date[] lastWeekDates = calculateLastWeekDates();
	    Date startDate = lastWeekDates[0];
	    Date endDate = lastWeekDates[1];

	    // Fetch daily attendance data for the last complete week
	    List<AttendanceDailyVO> dailyAttendanceData = attendanceDAO.fetchDailyAttendanceData();

	    // Create a map to store aggregated data for each employee
	    Map<String, AttendanceAggregateVO> employeeDataMap = new HashMap<>();

	    // Iterate over the daily attendance data
	    for (AttendanceDailyVO dailyRecord : dailyAttendanceData) {
	        String empId = dailyRecord.getEmpId();

	        // Check if the employee data already exists in the map
	        AttendanceAggregateVO employeeData = employeeDataMap.get(empId);
	        if (employeeData == null) {
	            // If not, create a new instance and add it to the map
	            employeeData = new AttendanceAggregateVO();
	            employeeData.setEmpId(empId);
	            employeeData.setStartDate(startDate);
	            employeeData.setEndDate(endDate);
	            employeeDataMap.put(empId, employeeData);
	        }

	        // Initialize variables to hold the total start and end times in minutes for this employee
	        int totalStartMinutes = 0;
	        int totalEndMinutes = 0;
	        int recordCount = 0;
	        double totalWorkHours = 0.0;
	        Integer totallateness =0;
	        double totalLate =0.0;
	        double totaOverTime =0.0;
	        Integer totalOutsideWork =0;
	        Integer totalBusinessTrip =0;
	        Integer totalTraining =0;
	        long totalAew = 0;
	        Integer avgStatus =0;

	        // Iterate over the daily attendance data for this employee
	        for (AttendanceDailyVO innerDailyRecord : dailyAttendanceData) {
	            if (empId.equals(innerDailyRecord.getEmpId())) {
	                // Get the start and end times
	                Date startTime = innerDailyRecord.getStartTime();
	                Date endTime = innerDailyRecord.getEndTime();

	                // Convert start and end times to Calendar for easier manipulation
	                Calendar startCal = Calendar.getInstance();
	                startCal.setTime(startTime);
	                Calendar endCal = Calendar.getInstance();
	                endCal.setTime(endTime);

	                // Calculate the total minutes from midnight for start and end times
	                int startMinutes = startCal.get(Calendar.HOUR_OF_DAY) * 60 + startCal.get(Calendar.MINUTE);
	                int endMinutes = endCal.get(Calendar.HOUR_OF_DAY) * 60 + endCal.get(Calendar.MINUTE);

	                // Add start and end times to the totals
	                totalStartMinutes += startMinutes;
	                totalEndMinutes += endMinutes;
	                recordCount++;
	                
	                // Total WorkHour Calculation	             
	                double workHour = innerDailyRecord.getWorkHour();
	                int hours = (int) workHour;
	                int minutes = (int) ((workHour - hours) * 100);
	                totalWorkHours += (hours * 60) + minutes;
	                
	                //Total Lateness Calculation
	                totallateness+= innerDailyRecord.getLateness();
	                
	                //Total late calculation
	                double lateHour = innerDailyRecord.getLate();
	                int latehours = (int) lateHour;
	                int lateminutes = (int) ((lateHour - latehours) * 100);
	                totalLate += (latehours * 60) + lateminutes;
	                
	                
	                //Total overTime calculation
	                double overTimeHour = innerDailyRecord.getOverTime();
	                int overTimeHours = (int) overTimeHour;
	                int overTimeeMinutes = (int) ((overTimeHour - overTimeHours) * 100);
	                totaOverTime += (overTimeHours * 60) + overTimeeMinutes;
	                
	                //Total OutsideWork calculation
	                totalOutsideWork+= innerDailyRecord.getOutsideWork();
	                
	                //Total BusinessTrip calculation
	                totalBusinessTrip+= innerDailyRecord.getBusinessTrip();
	                
	                //Total Training calculation
	                totalTraining+= innerDailyRecord.getTraining();
	                
	                //Total Aew calculation
	                totalAew+= innerDailyRecord.getAew();
	                
	                //Total Status calculation
	                avgStatus += innerDailyRecord.getStatus();
	                
	               	                
	            }
	        }

	        // Calculate the average start and end times in minutes for this employee
	        int avgStartMinutes = recordCount != 0 ? totalStartMinutes / recordCount : 0;
	        int avgEndMinutes = recordCount != 0 ? totalEndMinutes / recordCount : 0;

	        // Convert average start and end times back to hours and minutes
	        int avgStartHour = avgStartMinutes / 60;
	        int avgStartMinute = avgStartMinutes % 60;
	        int avgEndHour = avgEndMinutes / 60;
	        int avgEndMinute = avgEndMinutes % 60;

	        // Format the average start and end times
	        String avgStartTime = String.format("%02d:%02d", avgStartHour, avgStartMinute);
	        String avgEndTime = String.format("%02d:%02d", avgEndHour, avgEndMinute);

	        // Set the average start and end times to the employee data
	        employeeData.setAvgStartTime(avgStartTime);
	        employeeData.setAvgEndTime(avgEndTime);
	        
	        // Total WorkHour Calculation
	        int totalWorkHoursInt = (int) totalWorkHours;
	        int totalHours = totalWorkHoursInt / 60;
	        int totalMinutes = totalWorkHoursInt % 60;
	        double ttlWorkHour = totalHours + (totalMinutes / 100.0);
	        
	        // Total Late Calculation
	        int totalLateInt = (int) totalLate;
	        int totalLateHours = totalLateInt / 60;
	        int totalLateMinutes = totalLateInt % 60;
	        double ttlLateHour = totalLateHours + (totalLateMinutes / 100.0);
	        
	        // Total OverTime Calculation
	        int totalOverTimeInt = (int) totaOverTime;
	        int totalOverTimeHours = totalOverTimeInt / 60;
	        int totalOverTimeMinutes = totalOverTimeInt % 60;
	        double ttlOverTimeHour = totalOverTimeHours + (totalOverTimeMinutes / 100.0);
	        
	        int avgWeekStatus = recordCount != 0 ? avgStatus / recordCount : 0;
	       
	        
	       
	        
	        
	        
	         
	        employeeData.setTtlWorkHour(ttlWorkHour);
	        employeeData.setTtlLateness(totallateness);
	        employeeData.setTtlLate(ttlLateHour);
	        employeeData.setTtlOverTime(ttlOverTimeHour);
	        employeeData.setTtlOutsideWork(totalOutsideWork);
	        employeeData.setTtlBusinessTrip(totalBusinessTrip);
	        employeeData.setTtlTraining(totalTraining);
	        employeeData.setTtlAew(totalAew);
	        employeeData.setAvgStatus(avgWeekStatus);
	    }
	    
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        
	            attendanceDAO.insertWeeklyAttendance(entry.getValue());
	        
	        
	    }

	    // Print the aggregated data for each employee
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        System.out.println("Employee ID: " + entry.getKey());
	        AttendanceAggregateVO employeeData = entry.getValue();
	        System.out.println("Start Date: " + employeeData.getStartDate());
	        System.out.println("End Date: " + employeeData.getEndDate());
	        System.out.println("Avg Start Time: " + employeeData.getAvgStartTime());
	        System.out.println("Avg End Time: " + employeeData.getAvgEndTime());
	        System.out.println("Total Work Hour: " + employeeData.getTtlWorkHour());
	        System.out.println("Total Lateness: " + employeeData.getTtlLateness());
	        System.out.println("Total Late: " + employeeData.getTtlLate());
	        System.out.println("Total Over Time: " + employeeData.getTtlOverTime());
	        System.out.println("Total Outside Work: " + employeeData.getTtlOutsideWork());
	        System.out.println("Total Business Trip: " + employeeData.getTtlBusinessTrip());
	        System.out.println("Total Training: " + employeeData.getTtlTraining());
	        System.out.println("Total AEW: " + employeeData.getTtlAew());
	        System.out.println("Avg Status: " + employeeData.getAvgStatus());
	        System.out.println("----------------------------");
	    }
	}

	private Date[] calculateLastWeekDates() {
	    Calendar calendar = Calendar.getInstance();

	    // Set the calendar to the current date
	    calendar.setTime(new Date());

	    // Adjust the calendar to the previous Monday
	    calendar.add(Calendar.WEEK_OF_YEAR, -1);
	    calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
	    setTimeToMidnight(calendar);
	    Date startDate = calendar.getTime();

	    // Adjust the calendar to the previous Sunday
	    calendar.add(Calendar.DAY_OF_YEAR, 6); // Move to the next Sunday after the previous Monday
	    setTimeToMidnight(calendar);
	    Date endDate = calendar.getTime();

	    return new Date[]{startDate, endDate};
	}

    private void setTimeToMidnight(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
    }
    
       
    
    @Scheduled(cron = "0 30 2 1 * *")
	public void generateMonthlyAttendance() {
	    
    	
    	 // Calculate the year and month for the last month
        Calendar lastMonth = Calendar.getInstance();
        lastMonth.add(Calendar.MONTH, -1);
        long year = lastMonth.get(Calendar.YEAR);
        long month = lastMonth.get(Calendar.MONTH) + 1; // Month is 0-based, so add 1
    	
    	
    	List<AttendanceDailyVO> dailyAttendanceData = attendanceDAO.fetchDailyAttendanceDataForMonthAggregate();
    	
    	System.out.println(dailyAttendanceData);
	   

	    // Fetch daily attendance data for the last complete week
	    

	    // Create a map to store aggregated data for each employee
	    Map<String, AttendanceAggregateVO> employeeDataMap = new HashMap<>();

	    // Iterate over the daily attendance data
	    for (AttendanceDailyVO dailyRecord : dailyAttendanceData) {
	        String empId = dailyRecord.getEmpId();

	        // Check if the employee data already exists in the map
	        AttendanceAggregateVO employeeData = employeeDataMap.get(empId);
	        if (employeeData == null) {
	            // If not, create a new instance and add it to the map
	            employeeData = new AttendanceAggregateVO();
	            employeeData.setEmpId(empId);
	            employeeData.setYear(year);
	            employeeData.setMonth(month);
	            employeeDataMap.put(empId, employeeData);
	        }

	        // Initialize variables to hold the total start and end times in minutes for this employee
	        int totalStartMinutes = 0;
	        int totalEndMinutes = 0;
	        int recordCount = 0;
	        double totalWorkHours = 0.0;
	        Integer totallateness =0;
	        double totalLate =0.0;
	        double totaOverTime =0.0;
	        Integer totalOutsideWork =0;
	        Integer totalBusinessTrip =0;
	        Integer totalTraining =0;
	        long totalAew = 0;
	        Integer avgStatus =0;

	        // Iterate over the daily attendance data for this employee
	        for (AttendanceDailyVO innerDailyRecord : dailyAttendanceData) {
	            if (empId.equals(innerDailyRecord.getEmpId())) {
	                // Get the start and end times
	                Date startTime = innerDailyRecord.getStartTime();
	                Date endTime = innerDailyRecord.getEndTime();

	                // Convert start and end times to Calendar for easier manipulation
	                Calendar startCal = Calendar.getInstance();
	                startCal.setTime(startTime);
	                Calendar endCal = Calendar.getInstance();
	                endCal.setTime(endTime);

	                // Calculate the total minutes from midnight for start and end times
	                int startMinutes = startCal.get(Calendar.HOUR_OF_DAY) * 60 + startCal.get(Calendar.MINUTE);
	                int endMinutes = endCal.get(Calendar.HOUR_OF_DAY) * 60 + endCal.get(Calendar.MINUTE);

	                // Add start and end times to the totals
	                totalStartMinutes += startMinutes;
	                totalEndMinutes += endMinutes;
	                recordCount++;
	                
	                // Total WorkHour Calculation	             
	                double workHour = innerDailyRecord.getWorkHour();
	                int hours = (int) workHour;
	                int minutes = (int) ((workHour - hours) * 100);
	                totalWorkHours += (hours * 60) + minutes;
	                
	                //Total Lateness Calculation
	                totallateness+= innerDailyRecord.getLateness();
	                
	                //Total late calculation
	                double lateHour = innerDailyRecord.getLate();
	                int latehours = (int) lateHour;
	                int lateminutes = (int) ((lateHour - latehours) * 100);
	                totalLate += (latehours * 60) + lateminutes;
	                
	                
	                //Total overTime calculation
	                double overTimeHour = innerDailyRecord.getOverTime();
	                int overTimeHours = (int) overTimeHour;
	                int overTimeeMinutes = (int) ((overTimeHour - overTimeHours) * 100);
	                totaOverTime += (overTimeHours * 60) + overTimeeMinutes;
	                
	                //Total OutsideWork calculation
	                totalOutsideWork+= innerDailyRecord.getOutsideWork();
	                
	                //Total BusinessTrip calculation
	                totalBusinessTrip+= innerDailyRecord.getBusinessTrip();
	                
	                //Total Training calculation
	                totalTraining+= innerDailyRecord.getTraining();
	                
	                //Total Aew calculation
	                totalAew+= innerDailyRecord.getAew();
	                
	                //Total Status calculation
	                avgStatus += innerDailyRecord.getStatus();
	                
	               	                
	            }
	        }

	        // Calculate the average start and end times in minutes for this employee
	        int avgStartMinutes = recordCount != 0 ? totalStartMinutes / recordCount : 0;
	        int avgEndMinutes = recordCount != 0 ? totalEndMinutes / recordCount : 0;

	        // Convert average start and end times back to hours and minutes
	        int avgStartHour = avgStartMinutes / 60;
	        int avgStartMinute = avgStartMinutes % 60;
	        int avgEndHour = avgEndMinutes / 60;
	        int avgEndMinute = avgEndMinutes % 60;

	        // Format the average start and end times
	        String avgStartTime = String.format("%02d:%02d", avgStartHour, avgStartMinute);
	        String avgEndTime = String.format("%02d:%02d", avgEndHour, avgEndMinute);

	        // Set the average start and end times to the employee data
	        employeeData.setAvgStartTime(avgStartTime);
	        employeeData.setAvgEndTime(avgEndTime);
	        
	        // Total WorkHour Calculation
	        int totalWorkHoursInt = (int) totalWorkHours;
	        int totalHours = totalWorkHoursInt / 60;
	        int totalMinutes = totalWorkHoursInt % 60;
	        double ttlWorkHour = totalHours + (totalMinutes / 100.0);
	        
	        // Total Late Calculation
	        int totalLateInt = (int) totalLate;
	        int totalLateHours = totalLateInt / 60;
	        int totalLateMinutes = totalLateInt % 60;
	        double ttlLateHour = totalLateHours + (totalLateMinutes / 100.0);
	        
	        // Total OverTime Calculation
	        int totalOverTimeInt = (int) totaOverTime;
	        int totalOverTimeHours = totalOverTimeInt / 60;
	        int totalOverTimeMinutes = totalOverTimeInt % 60;
	        double ttlOverTimeHour = totalOverTimeHours + (totalOverTimeMinutes / 100.0);
	        
	        int avgMonthStatus = recordCount != 0 ? avgStatus / recordCount : 0;
	       
	        
	       	         
	        employeeData.setTtlWorkHour(ttlWorkHour);
	        employeeData.setTtlLateness(totallateness);
	        employeeData.setTtlLate(ttlLateHour);
	        employeeData.setTtlOverTime(ttlOverTimeHour);
	        employeeData.setTtlOutsideWork(totalOutsideWork);
	        employeeData.setTtlBusinessTrip(totalBusinessTrip);
	        employeeData.setTtlTraining(totalTraining);
	        employeeData.setTtlAew(totalAew);
	        employeeData.setAvgStatus(avgMonthStatus);
	    }
	    
	    
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        
            attendanceDAO.insertMonthlyAttendance(entry.getValue());
               
    }
	    
	    
	    // Print the aggregated data for each employee
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        System.out.println("Employee ID: " + entry.getKey());
	        AttendanceAggregateVO employeeData = entry.getValue();
	        System.out.println("Year: " + employeeData.getYear());
	        System.out.println("Month: " + employeeData.getMonth());
	        System.out.println("Avg Start Time: " + employeeData.getAvgStartTime());
	        System.out.println("Avg End Time: " + employeeData.getAvgEndTime());
	        System.out.println("Total Work Hour: " + employeeData.getTtlWorkHour());
	        System.out.println("Total Lateness: " + employeeData.getTtlLateness());
	        System.out.println("Total Late: " + employeeData.getTtlLate());
	        System.out.println("Total Over Time: " + employeeData.getTtlOverTime());
	        System.out.println("Total Outside Work: " + employeeData.getTtlOutsideWork());
	        System.out.println("Total Business Trip: " + employeeData.getTtlBusinessTrip());
	        System.out.println("Total Training: " + employeeData.getTtlTraining());
	        System.out.println("Total AEW: " + employeeData.getTtlAew());
	        System.out.println("Avg Status: " + employeeData.getAvgStatus());
	        System.out.println("----------------------------");
	    }
	}
    
    
    
    
    
    
    @Scheduled(cron = "0 0 3 1 4,7,10,1 *")
	public void generateQuarterlyAttendance() {
	    
    	Calendar current = Calendar.getInstance();
    	
    	Long currentQuarter = getCurrentQuarterNumber();
        long year = current.get(Calendar.YEAR);
        
    	    	
    	if (currentQuarter == 4L) {
            year -= 1;
        }
    	
    	List<AttendanceDailyVO> dailyAttendanceData = attendanceDAO.fetchDailyAttendanceDataForQuarterlyAggregate();
    	
    	System.out.println(dailyAttendanceData);
	    

	    // Create a map to store aggregated data for each employee
	    Map<String, AttendanceAggregateVO> employeeDataMap = new HashMap<>();

	    // Iterate over the daily attendance data
	    for (AttendanceDailyVO dailyRecord : dailyAttendanceData) {
	        String empId = dailyRecord.getEmpId();

	        // Check if the employee data already exists in the map
	        AttendanceAggregateVO employeeData = employeeDataMap.get(empId);
	        if (employeeData == null) {
	            // If not, create a new instance and add it to the map
	            employeeData = new AttendanceAggregateVO();
	            employeeData.setEmpId(empId);
	            employeeData.setYear(year);
	            employeeData.setQuarter(currentQuarter);	            
	            employeeDataMap.put(empId, employeeData);
	        }

	        // Initialize variables to hold the total start and end times in minutes for this employee
	        int totalStartMinutes = 0;
	        int totalEndMinutes = 0;
	        int recordCount = 0;
	        double totalWorkHours = 0.0;
	        Integer totallateness =0;
	        double totalLate =0.0;
	        double totaOverTime =0.0;
	        Integer totalOutsideWork =0;
	        Integer totalBusinessTrip =0;
	        Integer totalTraining =0;
	        long totalAew = 0;
	        Integer avgStatus =0;

	        // Iterate over the daily attendance data for this employee
	        for (AttendanceDailyVO innerDailyRecord : dailyAttendanceData) {
	            if (empId.equals(innerDailyRecord.getEmpId())) {
	                // Get the start and end times
	                Date startTime = innerDailyRecord.getStartTime();
	                Date endTime = innerDailyRecord.getEndTime();

	                // Convert start and end times to Calendar for easier manipulation
	                Calendar startCal = Calendar.getInstance();
	                startCal.setTime(startTime);
	                Calendar endCal = Calendar.getInstance();
	                endCal.setTime(endTime);

	                // Calculate the total minutes from midnight for start and end times
	                int startMinutes = startCal.get(Calendar.HOUR_OF_DAY) * 60 + startCal.get(Calendar.MINUTE);
	                int endMinutes = endCal.get(Calendar.HOUR_OF_DAY) * 60 + endCal.get(Calendar.MINUTE);

	                // Add start and end times to the totals
	                totalStartMinutes += startMinutes;
	                totalEndMinutes += endMinutes;
	                recordCount++;
	                
	                // Total WorkHour Calculation	             
	                double workHour = innerDailyRecord.getWorkHour();
	                int hours = (int) workHour;
	                int minutes = (int) ((workHour - hours) * 100);
	                totalWorkHours += (hours * 60) + minutes;
	                
	                //Total Lateness Calculation
	                totallateness+= innerDailyRecord.getLateness();
	                
	                //Total late calculation
	                double lateHour = innerDailyRecord.getLate();
	                int latehours = (int) lateHour;
	                int lateminutes = (int) ((lateHour - latehours) * 100);
	                totalLate += (latehours * 60) + lateminutes;
	                
	                
	                //Total overTime calculation
	                double overTimeHour = innerDailyRecord.getOverTime();
	                int overTimeHours = (int) overTimeHour;
	                int overTimeeMinutes = (int) ((overTimeHour - overTimeHours) * 100);
	                totaOverTime += (overTimeHours * 60) + overTimeeMinutes;
	                
	                //Total OutsideWork calculation
	                totalOutsideWork+= innerDailyRecord.getOutsideWork();
	                
	                //Total BusinessTrip calculation
	                totalBusinessTrip+= innerDailyRecord.getBusinessTrip();
	                
	                //Total Training calculation
	                totalTraining+= innerDailyRecord.getTraining();
	                
	                //Total Aew calculation
	                totalAew+= innerDailyRecord.getAew();
	                
	                //Total Status calculation
	                avgStatus += innerDailyRecord.getStatus();
	                
	               	                
	            }
	        }

	        // Calculate the average start and end times in minutes for this employee
	        int avgStartMinutes = recordCount != 0 ? totalStartMinutes / recordCount : 0;
	        int avgEndMinutes = recordCount != 0 ? totalEndMinutes / recordCount : 0;

	        // Convert average start and end times back to hours and minutes
	        int avgStartHour = avgStartMinutes / 60;
	        int avgStartMinute = avgStartMinutes % 60;
	        int avgEndHour = avgEndMinutes / 60;
	        int avgEndMinute = avgEndMinutes % 60;

	        // Format the average start and end times
	        String avgStartTime = String.format("%02d:%02d", avgStartHour, avgStartMinute);
	        String avgEndTime = String.format("%02d:%02d", avgEndHour, avgEndMinute);

	        // Set the average start and end times to the employee data
	        employeeData.setAvgStartTime(avgStartTime);
	        employeeData.setAvgEndTime(avgEndTime);
	        
	        // Total WorkHour Calculation
	        int totalWorkHoursInt = (int) totalWorkHours;
	        int totalHours = totalWorkHoursInt / 60;
	        int totalMinutes = totalWorkHoursInt % 60;
	        double ttlWorkHour = totalHours + (totalMinutes / 100.0);
	        
	        // Total Late Calculation
	        int totalLateInt = (int) totalLate;
	        int totalLateHours = totalLateInt / 60;
	        int totalLateMinutes = totalLateInt % 60;
	        double ttlLateHour = totalLateHours + (totalLateMinutes / 100.0);
	        
	        // Total OverTime Calculation
	        int totalOverTimeInt = (int) totaOverTime;
	        int totalOverTimeHours = totalOverTimeInt / 60;
	        int totalOverTimeMinutes = totalOverTimeInt % 60;
	        double ttlOverTimeHour = totalOverTimeHours + (totalOverTimeMinutes / 100.0);
	        
	        int avgMonthStatus = recordCount != 0 ? avgStatus / recordCount : 0;
	       
	        
	       	         
	        employeeData.setTtlWorkHour(ttlWorkHour);
	        employeeData.setTtlLateness(totallateness);
	        employeeData.setTtlLate(ttlLateHour);
	        employeeData.setTtlOverTime(ttlOverTimeHour);
	        employeeData.setTtlOutsideWork(totalOutsideWork);
	        employeeData.setTtlBusinessTrip(totalBusinessTrip);
	        employeeData.setTtlTraining(totalTraining);
	        employeeData.setTtlAew(totalAew);
	        employeeData.setAvgStatus(avgMonthStatus);
	    }
	    
	    
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        
            attendanceDAO.insertQuarterlyAttendance(entry.getValue());
               
    }
	    
	    
	    // Print the aggregated data for each employee
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        System.out.println("Employee ID: " + entry.getKey());
	        AttendanceAggregateVO employeeData = entry.getValue();
	        System.out.println("Year: " + employeeData.getYear());	        
	        System.out.println("Quarter: " + employeeData.getQuarter());	        
	        System.out.println("Avg Start Time: " + employeeData.getAvgStartTime());
	        System.out.println("Avg End Time: " + employeeData.getAvgEndTime());
	        System.out.println("Total Work Hour: " + employeeData.getTtlWorkHour());
	        System.out.println("Total Lateness: " + employeeData.getTtlLateness());
	        System.out.println("Total Late: " + employeeData.getTtlLate());
	        System.out.println("Total Over Time: " + employeeData.getTtlOverTime());
	        System.out.println("Total Outside Work: " + employeeData.getTtlOutsideWork());
	        System.out.println("Total Business Trip: " + employeeData.getTtlBusinessTrip());
	        System.out.println("Total Training: " + employeeData.getTtlTraining());
	        System.out.println("Total AEW: " + employeeData.getTtlAew());
	        System.out.println("Avg Status: " + employeeData.getAvgStatus());
	        System.out.println("----------------------------");
	    }
	}
       
    private Long getCurrentQuarterNumber() {
        Calendar calendar = Calendar.getInstance();
        int currentMonth = calendar.get(Calendar.MONTH) + 1; // Months are 0-based in Calendar
        int currentDay = calendar.get(Calendar.DAY_OF_MONTH);

        if (currentMonth == 4 && currentDay == 1) {
            return 1L;
        } else if (currentMonth == 7 && currentDay == 1) {
            return 2L;
        } else if (currentMonth == 10 && currentDay == 1) {
            return 3L;
        } else if (currentMonth == 1 && currentDay == 1) {
            return 4L;
        }

        // Default case to handle unexpected scenarios (optional)
        return 0L;
    }

    @Scheduled(cron = "0 0 1 1 1 *")
	public void generateYearlyAttendance() {
	    
    	Calendar current = Calendar.getInstance();
    	
        long year = (current.get(Calendar.YEAR)-1);
        
    	     	
    	List<AttendanceDailyVO> dailyAttendanceData = attendanceDAO.fetchDailyAttendanceDataForYearlyAggregate();
    	
    	System.out.println(dailyAttendanceData);
	    

	    // Create a map to store aggregated data for each employee
	    Map<String, AttendanceAggregateVO> employeeDataMap = new HashMap<>();

	    // Iterate over the daily attendance data
	    for (AttendanceDailyVO dailyRecord : dailyAttendanceData) {
	        String empId = dailyRecord.getEmpId();

	        // Check if the employee data already exists in the map
	        AttendanceAggregateVO employeeData = employeeDataMap.get(empId);
	        if (employeeData == null) {
	            // If not, create a new instance and add it to the map
	            employeeData = new AttendanceAggregateVO();
	            employeeData.setEmpId(empId);
	            employeeData.setYear(year);	            
	            employeeDataMap.put(empId, employeeData);
	        }

	        // Initialize variables to hold the total start and end times in minutes for this employee
	        int totalStartMinutes = 0;
	        int totalEndMinutes = 0;
	        int recordCount = 0;
	        double totalWorkHours = 0.0;
	        Integer totallateness =0;
	        double totalLate =0.0;
	        double totaOverTime =0.0;
	        Integer totalOutsideWork =0;
	        Integer totalBusinessTrip =0;
	        Integer totalTraining =0;
	        long totalAew = 0;
	        Integer avgStatus =0;

	        // Iterate over the daily attendance data for this employee
	        for (AttendanceDailyVO innerDailyRecord : dailyAttendanceData) {
	            if (empId.equals(innerDailyRecord.getEmpId())) {
	                // Get the start and end times
	                Date startTime = innerDailyRecord.getStartTime();
	                Date endTime = innerDailyRecord.getEndTime();

	                // Convert start and end times to Calendar for easier manipulation
	                Calendar startCal = Calendar.getInstance();
	                startCal.setTime(startTime);
	                Calendar endCal = Calendar.getInstance();
	                endCal.setTime(endTime);

	                // Calculate the total minutes from midnight for start and end times
	                int startMinutes = startCal.get(Calendar.HOUR_OF_DAY) * 60 + startCal.get(Calendar.MINUTE);
	                int endMinutes = endCal.get(Calendar.HOUR_OF_DAY) * 60 + endCal.get(Calendar.MINUTE);

	                // Add start and end times to the totals
	                totalStartMinutes += startMinutes;
	                totalEndMinutes += endMinutes;
	                recordCount++;
	                
	                // Total WorkHour Calculation	             
	                double workHour = innerDailyRecord.getWorkHour();
	                int hours = (int) workHour;
	                int minutes = (int) ((workHour - hours) * 100);
	                totalWorkHours += (hours * 60) + minutes;
	                
	                //Total Lateness Calculation
	                totallateness+= innerDailyRecord.getLateness();
	                
	                //Total late calculation
	                double lateHour = innerDailyRecord.getLate();
	                int latehours = (int) lateHour;
	                int lateminutes = (int) ((lateHour - latehours) * 100);
	                totalLate += (latehours * 60) + lateminutes;
	                
	                
	                //Total overTime calculation
	                double overTimeHour = innerDailyRecord.getOverTime();
	                int overTimeHours = (int) overTimeHour;
	                int overTimeeMinutes = (int) ((overTimeHour - overTimeHours) * 100);
	                totaOverTime += (overTimeHours * 60) + overTimeeMinutes;
	                
	                //Total OutsideWork calculation
	                totalOutsideWork+= innerDailyRecord.getOutsideWork();
	                
	                //Total BusinessTrip calculation
	                totalBusinessTrip+= innerDailyRecord.getBusinessTrip();
	                
	                //Total Training calculation
	                totalTraining+= innerDailyRecord.getTraining();
	                
	                //Total Aew calculation
	                totalAew+= innerDailyRecord.getAew();
	                
	                //Total Status calculation
	                avgStatus += innerDailyRecord.getStatus();
	                
	               	                
	            }
	        }

	        // Calculate the average start and end times in minutes for this employee
	        int avgStartMinutes = recordCount != 0 ? totalStartMinutes / recordCount : 0;
	        int avgEndMinutes = recordCount != 0 ? totalEndMinutes / recordCount : 0;

	        // Convert average start and end times back to hours and minutes
	        int avgStartHour = avgStartMinutes / 60;
	        int avgStartMinute = avgStartMinutes % 60;
	        int avgEndHour = avgEndMinutes / 60;
	        int avgEndMinute = avgEndMinutes % 60;

	        // Format the average start and end times
	        String avgStartTime = String.format("%02d:%02d", avgStartHour, avgStartMinute);
	        String avgEndTime = String.format("%02d:%02d", avgEndHour, avgEndMinute);

	        // Set the average start and end times to the employee data
	        employeeData.setAvgStartTime(avgStartTime);
	        employeeData.setAvgEndTime(avgEndTime);
	        
	        // Total WorkHour Calculation
	        int totalWorkHoursInt = (int) totalWorkHours;
	        int totalHours = totalWorkHoursInt / 60;
	        int totalMinutes = totalWorkHoursInt % 60;
	        double ttlWorkHour = totalHours + (totalMinutes / 100.0);
	        
	        // Total Late Calculation
	        int totalLateInt = (int) totalLate;
	        int totalLateHours = totalLateInt / 60;
	        int totalLateMinutes = totalLateInt % 60;
	        double ttlLateHour = totalLateHours + (totalLateMinutes / 100.0);
	        
	        // Total OverTime Calculation
	        int totalOverTimeInt = (int) totaOverTime;
	        int totalOverTimeHours = totalOverTimeInt / 60;
	        int totalOverTimeMinutes = totalOverTimeInt % 60;
	        double ttlOverTimeHour = totalOverTimeHours + (totalOverTimeMinutes / 100.0);
	        
	        int avgMonthStatus = recordCount != 0 ? avgStatus / recordCount : 0;
	       
	        
	       	         
	        employeeData.setTtlWorkHour(ttlWorkHour);
	        employeeData.setTtlLateness(totallateness);
	        employeeData.setTtlLate(ttlLateHour);
	        employeeData.setTtlOverTime(ttlOverTimeHour);
	        employeeData.setTtlOutsideWork(totalOutsideWork);
	        employeeData.setTtlBusinessTrip(totalBusinessTrip);
	        employeeData.setTtlTraining(totalTraining);
	        employeeData.setTtlAew(totalAew);
	        employeeData.setAvgStatus(avgMonthStatus);
	    }
	    
	    
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        
            attendanceDAO.insertYearlyAttendance(entry.getValue());
               
    }
	    
	    
	    // Print the aggregated data for each employee
	    for (Map.Entry<String, AttendanceAggregateVO> entry : employeeDataMap.entrySet()) {
	        System.out.println("Employee ID: " + entry.getKey());
	        AttendanceAggregateVO employeeData = entry.getValue();
	        System.out.println("Year: " + employeeData.getYear());	        
	        System.out.println("Avg Start Time: " + employeeData.getAvgStartTime());
	        System.out.println("Avg End Time: " + employeeData.getAvgEndTime());
	        System.out.println("Total Work Hour: " + employeeData.getTtlWorkHour());
	        System.out.println("Total Lateness: " + employeeData.getTtlLateness());
	        System.out.println("Total Late: " + employeeData.getTtlLate());
	        System.out.println("Total Over Time: " + employeeData.getTtlOverTime());
	        System.out.println("Total Outside Work: " + employeeData.getTtlOutsideWork());
	        System.out.println("Total Business Trip: " + employeeData.getTtlBusinessTrip());
	        System.out.println("Total Training: " + employeeData.getTtlTraining());
	        System.out.println("Total AEW: " + employeeData.getTtlAew());
	        System.out.println("Avg Status: " + employeeData.getAvgStatus());
	        System.out.println("----------------------------");
	    }
	}
	 
}