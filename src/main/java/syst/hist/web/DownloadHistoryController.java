package syst.hist.web;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import syst.hist.service.DownloadHistoryService;
import syst.hist.vo.DownloadHistoryVO;
import syst.user.service.UserService;
import syst.user.vo.UserMgVO;

@RequestMapping("/syst/hist/downloadHist")
@Controller
public class DownloadHistoryController {
	
	@Autowired
	private UserService userService;

    @Autowired
    private DownloadHistoryService downloadHistoryService;

    @GetMapping("/downloadHistory.do")
    public String showDownloadHistory(ModelMap model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }

        List<DownloadHistoryVO> downloadHistories = downloadHistoryService.getAllDownloadHistories();
        model.addAttribute("downloadHistories", downloadHistories);
        model.addAttribute("loggedInUser", loggedInUser);

        return "syst/hist/downloadHistory";
    }
    
    @PostMapping("/saveDownloadHistory.do")
    public ResponseEntity<?> saveDownloadHistory(HttpServletRequest request, String menuName, String fileName) {
        
        HttpSession session = request.getSession();
        UserMgVO loggedInUser = (UserMgVO) session.getAttribute("loggedInUser");
        
    	UserMgVO user = userService.getUserByEmpId(loggedInUser.getEmpId());
        
        if (user != null) {
      
            DownloadHistoryVO downloadHistory = new DownloadHistoryVO();
            
            downloadHistory.setMenuName(menuName);
            downloadHistory.setFileName(fileName);
            downloadHistory.setHistDate(new Date());
            downloadHistory.setEmpId(user.getEmpId());
            downloadHistory.setName(user.getName());
            downloadHistory.setDepartment(user.getDepartment());
            
            downloadHistoryService.insertDownloadHistory(downloadHistory);

            // Return a response entity with a success message or status
            return ResponseEntity.ok().body("Download history saved successfully.");
        } else {
            // Return a response entity with an error message for unauthorized access
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Not authorized person");
        }
    }
}
