package atnd.attendance.service;

import java.util.Date;
import java.util.List;

import atnd.attendance.vo.AttendanceAggregateVO;
import atnd.attendance.vo.AttendanceDailyVO;
import atnd.attendance.vo.AttendanceVO;

public interface AttendanceService {

void insertAttendance(AttendanceVO attendance);

void deletePersonalAttendance(Long no);

List<AttendanceDailyVO> getAllAttendances(String empId);

void updateAttendance(AttendanceVO attendance);

void calculateAndSaveAverageAttendance(Date currentDate1);

List<AttendanceDailyVO> getAllLatestAttendances();

List<AttendanceAggregateVO> getFilteredData(String column, String value);

void updateDailyAttendance(AttendanceDailyVO attendance);

AttendanceVO getLatestAttendance(String empId);

void insertIntoDailyTable();

List<AttendanceVO> getOvertimeDetailsByEmpId(String empId);

void generateWeeklyAttendance();
void generateMonthlyAttendance();
void generateQuarterlyAttendance();
void generateYearlyAttendance();

void updateOvertimeDeatails(String empId, String gpsInformation, String startTimeString, String endTimeString,
String workType, String accessType, String ipAddress, String timeSettingString, String no);

List<AttendanceVO> getTodayAttendanceList(String empId);

List<AttendanceVO> getTodayAllAttendanceList();

void updatePersonalAttendanceData(AttendanceDailyVO data);

void updatePersonalAttendanceData(String empId, String startTimeStr, String endTimeStr, String overTime,
String timeSetting, String atndNo);

}