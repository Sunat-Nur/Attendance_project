package syst.hist.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import syst.hist.service.DownloadHistoryService;
import syst.hist.service.OtherHistoryService;
import syst.hist.vo.OtherHistoryVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/hist/otherHist")
@Controller
public class OtherHistoryController {

	@Autowired
	private OtherHistoryService otherHistoryService;
	
	@Autowired
	private DownloadHistoryService downloadHistoryService;
	
	@GetMapping("/otherHistory.do")
	public String otherHistoryPage(ModelMap model, HttpServletRequest request) {
		
		    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
		    
		    if (loggedInUser == null) {
		    	return "redirect:/syst/main/login.do";
		    }
        
		  List<OtherHistoryVO> otherHistoryList = otherHistoryService.getAllOtherHistoryList();
		  model.addAttribute("otherHistoryList", otherHistoryList);
		  return "syst/hist/otherHistory";
	}
	
}

