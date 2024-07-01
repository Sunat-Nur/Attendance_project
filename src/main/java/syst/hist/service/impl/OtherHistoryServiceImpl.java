package syst.hist.service.impl;

import java.lang.reflect.Field;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import syst.hist.dao.OtherHistoryDAO;
import syst.hist.service.OtherHistoryService;
import syst.hist.vo.OtherHistoryVO;
import syst.user.vo.UserMgVO;


@Service("otherHistoryService")
public class OtherHistoryServiceImpl implements OtherHistoryService{

	@Autowired
    private OtherHistoryDAO otherHistoryDAO;


//	@Override
//	public void createOtherHistoryRecord(UserMgVO loggedInUser, String referrerUrl, String actionType, String parameter) {
//	   
//	OtherHistoryVO history = new OtherHistoryVO();
//	
//	   // Set the details of the logged-in user who is making the edit or delete
//	   history.setEmpId(loggedInUser.getEmpId()); // Logged-in user's email
//	   history.setName(loggedInUser.getName()); // Logged-in user's name
//	   history.setDeptName(loggedInUser.getDepartment());
//	
//	   // Obtain the current system IP address
//	   try {
//	       InetAddress localhost = InetAddress.getLocalHost();
//	       String ipAddress = localhost.getHostAddress();
//	       history.setIp(ipAddress); // IP address of the user
//	   } catch (UnknownHostException e) {
//	       // Handle the case where obtaining the IP address fails
//	       e.printStackTrace();
//	   }
//	
//	   history.setUrl(referrerUrl); // The URL or location of the edit
//	   history.setHistoryCfn(actionType); // Action type (Edit/Delete)
//	   history.setHistDate(new Date()); // Current date and time
//	   history.setParameter(parameter);
//	
//	   otherHistoryDAO.saveOtherHistory(history);
//	}
	
	
	@Override
	public void createOtherHistoryRecord(UserMgVO loggedInUser, String referrerUrl, String actionType, String menuName, Object objOrList) {
	   
	OtherHistoryVO history = new OtherHistoryVO();
	
	   // Set the details of the logged-in user who is making the edit or delete
	   history.setEmpId(loggedInUser.getEmpId()); // Logged-in user's email
	   history.setName(loggedInUser.getName()); // Logged-in user's name
	   history.setDeptName(loggedInUser.getDepartment());
	
	   // Obtain the current system IP address
	   try {
	       InetAddress localhost = InetAddress.getLocalHost();
	       String ipAddress = localhost.getHostAddress();
	       history.setIp(ipAddress); // IP address of the user
	   } catch (UnknownHostException e) {
	       // Handle the case where obtaining the IP address fails
	       e.printStackTrace();
	   }
	
	   history.setUrl(referrerUrl); // The URL or location of the edit
	   history.setHistoryCfn(actionType); // Action type (Edit/Delete)
	   history.setMenuName(menuName);
	   history.setHistDate(new Date()); // Current date and time
	   
	    String serializedUsers = serializeObjectOrList(objOrList);
	    if (serializedUsers != null) {
	        history.setParameter(serializedUsers);
	    }
	
	   otherHistoryDAO.saveOtherHistory(history);
	}
	
	
	private String serializeObjectOrList(Object objOrList) {
	    ObjectMapper mapper = new ObjectMapper();
	    try {
	        if (objOrList instanceof Collection) {
	            // It's a collection (e.g., List, Set)
	            return mapper.writeValueAsString(objOrList);
	        } else {
	            // It's a single object
	            Map<String, Object> fieldMap = new HashMap<>();
	            for (Field field : objOrList.getClass().getDeclaredFields()) {
	                field.setAccessible(true); // You might need this line if fields are private
	                fieldMap.put(field.getName(), field.get(objOrList));
	            }
	            return mapper.writeValueAsString(fieldMap);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}


 
	@Override
	public List<OtherHistoryVO> getAllOtherHistoryList() {
		return otherHistoryDAO.findAllOtherHistoryList();
	}

}

