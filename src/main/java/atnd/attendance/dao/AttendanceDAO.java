package atnd.attendance.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import atnd.attendance.vo.AttendanceAggregateVO;
import atnd.attendance.vo.AttendanceDailyVO;
import atnd.attendance.vo.AttendanceVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("attendanceDAO")
public class AttendanceDAO extends EgovAbstractDAO {
	
	public void insertRecord(AttendanceVO attendance) {
		insert("attendance.insertRecord", attendance);
	}
	
	public List<AttendanceVO> getAttendanceByDate(String date) {
        return (List<AttendanceVO>) list("attendance.getAttendanceByDate", date);
    }
	
    public void updateRecord(AttendanceVO attendance) {
    	update("attendance.updateAttendanceRecord", attendance);
    }

    public AttendanceVO getLatestRecord(String empId) {
    	return (AttendanceVO) select("attendance.getLatestRecord", empId);
    }
	
	public void updateDailyAttendance(AttendanceDailyVO attendanceDailyVO) {
	    System.out.println("DAO");
	    update("dailyAttendance.updateAttendanceList", attendanceDailyVO);
	}

	public void deleteById(Long no) {
	   delete("dailyAttendance.deletePersonalAttendance",no);
	}

	public List<AttendanceDailyVO> getAllAttendanceList(String empId) {
		return (List<AttendanceDailyVO>) list("dailyAttendance.getAllAttendance",empId);
	}

	public void updateAttendance(AttendanceDailyVO attendance) {
	    update("dailyAttendance.updateAttendanceList", attendance);
	}

    public void insertDailyAverageAttendance(AttendanceDailyVO averageAttendance) {
        insert("dailyAttendance.insertDailyAverageAttendance", averageAttendance);
    }
    
    public List<AttendanceDailyVO> getAllLatestAttendances() {
		return (List<AttendanceDailyVO>) list("dailyAttendance.selectAllLatestAttendances");
	}  
    
	public void updateOverTimeForDailyData(AttendanceDailyVO dailyOvertimeData) {
		update("dailyAttendance.updateOverTimeForDailyData", dailyOvertimeData);
	}
	
	
	public List<AttendanceVO> getOvertimeDetailsByEmpId(String empId) {
		return (List<AttendanceVO>) list("attendance.getOvertimeDetailsByEmpId", empId);
    }

	public void updateOvertimeAndWorkhour(AttendanceVO overtimeData) {
		update("attendance.updateOvertimeAndWorkhour", overtimeData);
	}
	
	public List<AttendanceVO> getAllOvertimeDataForDate(Date timesetting, String empId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("timesetting", timesetting);
	    params.put("empId", empId);
	    return (List<AttendanceVO>) list("attendance.getAllOvertimeDataForDate", params);
	}

	public AttendanceDailyVO fetchDailyDataForOvertime(String empId, Date startTime) {
		Map<String, Object> params = new HashMap<>();
	    params.put("startTime", startTime);
	    params.put("empId", empId);
		return (AttendanceDailyVO) select("dailyAttendance.fetchDailyDataForOvertime", params);
	}

	public List<AttendanceVO> getTodayAttendanceList(String empId) {
		return (List<AttendanceVO>) list("attendance.getTodayAttendanceList", empId);
	}

	public List<AttendanceVO> getTodayAttendanceList() {
		return (List<AttendanceVO>) list("attendance.getTodayAllAttendanceList");
	}

	public void updatePersonalAttendanceData(AttendanceDailyVO atndDaily) {
		update("dailyAttendance.updatePersonalAttendanceData", atndDaily);
		
	}
    

    	public List<AttendanceAggregateVO> getFilteredDataByStartTime(String value) {
    	if ("Last 5 days AVG".equals(value)) {
    	           return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_AVG_START_TIME");
    	       } else if ("Weekly AVG".equals(value)) {
    	        System.out.println("Column passed to SQL query: " + value);
    	           return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_AVG_START_TIME");
    	       } else if ("Monthly AVG".equals(value)) {
    	           return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_AVG_START_TIME");
    	       } else if ("Quarterly AVG".equals(value)) {
    	           return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_AVG_START_TIME");
    	       } else if ("Yearly AVG".equals(value)) {
    	           return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_AVG_START_TIME");
    	       } else {
    	           
    	           return new ArrayList<>();
    	       }
    	   }

    	   

    	public List<AttendanceAggregateVO> getFilteredDataByEndTime(String value) {
    	   if ("Last 5 days AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_AVG_END_TIME");
    	   } else if ("Weekly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_AVG_END_TIME");
    	   } else if ("Monthly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_AVG_END_TIME");
    	   } else if ("Quarterly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_AVG_END_TIME");
    	   } else if ("Yearly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_AVG_END_TIME");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByWorkHour(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_WORK_HOUR");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_WORK_HOUR");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_WORK_HOUR");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_WORK_HOUR");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_WORK_HOUR");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}
    	
    	public List<AttendanceAggregateVO> getFilteredDataByLate(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_LATE");
    	   } else if ("Weekly Total".equals(value)) {
    	    System.out.println("Column passed to SQL query: " + value);
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_LATE");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_LATE");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_LATE");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_LATE");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}

    	public List<AttendanceAggregateVO> getFilteredDataByLateness(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_LATENESS");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_LATENESS");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_LATENESS");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_LATENESS");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_LATENESS");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByOutsideWork(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_OUTSIDE_WORK");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_OUTSIDE_WORK");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_OUTSIDE_WORK");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_OUTSIDE_WORK");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_OUTSIDE_WORK");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByBusinessTrip(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_BUSINESS_TRIP");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_BUSINESS_TRIP");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_BUSINESS_TRIP");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_BUSINESS_TRIP");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_BUSINESS_TRIP");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByTraining(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_TRAINING");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_TRAINING");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_TRAINING");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_TRAINING");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_TRAINING");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByOvertime(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_OVERTIME");
    	   } else if ("Weekly Total".equals(value)) {
    	    System.out.println("Column passed to SQL query: " + value);
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_OVERTIME");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_OVERTIME");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_OVERTIME");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_OVERTIME");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}


    	public List<AttendanceAggregateVO> getFilteredDataByStatus(String value) {
    	   if ("Last 5 days AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_AVG_STATUS");
    	   } else if ("Weekly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_AVG_STATUS");
    	   } else if ("Monthly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_AVG_STATUS");
    	   } else if ("Quarterly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_AVG_STATUS");
    	   } else if ("Yearly AVG".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_AVG_STATUS");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}



    	public List<AttendanceAggregateVO> getFilteredDataByAEW(String value) {
    	   if ("Last 5 days Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByLast5Days_TOTAL_AEW");
    	   } else if ("Weekly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("weeklyAttendance.getLatestDataByColumn_TOTAL_AEW");
    	   } else if ("Monthly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("monthlyAttendance.getLatestDataByColumn_TOTAL_AEW");
    	   } else if ("Quarterly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("quarterlyAttendance.getLatestDataByColumn_TOTAL_AEW");
    	   } else if ("Yearly Total".equals(value)) {
    	       return (List<AttendanceAggregateVO>) list("annuallyAttendance.getLatestDataByColumn_TOTAL_AEW");
    	   } else {
    	       
    	       return new ArrayList<>();
    	   }
    	}
    	
    	
    	
    	public List<AttendanceDailyVO> fetchDailyAttendanceData() {
    	    return (List<AttendanceDailyVO>) list("dailyAttendance.fetchDailyAttendanceData");
    	}

    	
    	
    	
//    	public void generateWeeklyAttendance() {
//    		   
//    	   List<AttendanceAggregateVO> weeklyAttendanceData = (List<AttendanceAggregateVO>) list("weeklyAttendance.generateWeeklyAttendance");      
//    	   if (weeklyAttendanceData != null && !weeklyAttendanceData.isEmpty()) {
//    	       for (AttendanceAggregateVO attendanceRecord : weeklyAttendanceData) {            
//    	           insert("weeklyAttendance.insertWeeklyAverageAttendance", attendanceRecord);
//    	       }
//    	   }
//    	}
    	
    	
    	public void insertWeeklyAttendance(AttendanceAggregateVO weeklyAttendance)  {
            insert("weeklyAttendance.insertWeeklyAttendance", weeklyAttendance);
        }
    	
    	
    	public List<AttendanceDailyVO> fetchDailyAttendanceDataForMonthAggregate() {
    	    return (List<AttendanceDailyVO>) list("dailyAttendance.fetchDailyAttendanceDataForMonthAggregate");
    	}
    	
    	public void insertMonthlyAttendance(AttendanceAggregateVO monthlyAttendance)  {
            insert("monthlyAttendance.insertMonthlyAttendance", monthlyAttendance);
        }
    	
    	
    	public List<AttendanceDailyVO> fetchDailyAttendanceDataForQuarterlyAggregate() {
    	    return (List<AttendanceDailyVO>) list("dailyAttendance.fetchDailyAttendanceDataForQuarterlyAggregate");
    	}
    	
    	public void insertQuarterlyAttendance(AttendanceAggregateVO quarterlyAttendance)  {
            insert("quarterlyAttendance.insertQuarterlyAttendance", quarterlyAttendance);
        }
    	
    	public List<AttendanceDailyVO> fetchDailyAttendanceDataForYearlyAggregate() {
    	    return (List<AttendanceDailyVO>) list("dailyAttendance.fetchDailyAttendanceDataForYearlyAggregate");
    	}
    	
    	public void insertYearlyAttendance(AttendanceAggregateVO yearlyAttendance)  {
            insert("annuallyAttendance.insertYearlyAttendance", yearlyAttendance);
        }
    
}
