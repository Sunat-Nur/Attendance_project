package syst.hist.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import syst.hist.service.DownloadHistoryService;
import syst.hist.service.LoginHistoryService;
import syst.hist.vo.LoginHistoryVO;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/hist/loginHist")
@Controller
public class LoginHistoryController {

	@Autowired
    private LoginHistoryService loginHistoryService;
	
	@Autowired
	private DownloadHistoryService downloadHistroyService;

    @GetMapping("/loginHistory.do")
    public String loginHistory(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    
	    List<LoginHistoryVO> loginHist = loginHistoryService.getAllLoginHistories();
        model.addAttribute("loginHistoryList", loginHist);
        return "syst/hist/loginHistory"; // JSP page name
    }
   
    
    @GetMapping("/getLastAccess.do")
    public ResponseEntity<LoginHistoryVO> getLastAccess(@RequestParam String empId) {
        LoginHistoryVO lastAccess = loginHistoryService.findLastLoginForUser(empId);
        return ResponseEntity.ok(lastAccess);
    }

}

