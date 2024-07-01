package syst.main.web;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import syst.hist.service.LoginHistoryService;
import syst.hist.vo.LoginHistoryVO;
import syst.menu.service.MenuService;
import syst.menu.vo.MenuVO;
import syst.user.service.UserService;
import syst.user.vo.UserMgVO;

@Controller
@RequestMapping("/syst/main")
public class mainController {
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LoginHistoryService loginHistoryService;
	
	@GetMapping("/home.do")
	public String loadHeader(Model model, HttpServletRequest request) {
	    UserMgVO loggedInUser = (UserMgVO) request.getSession().getAttribute("loggedInUser");
	    
	    if (loggedInUser == null) {
	    	return "redirect:/syst/main/login.do";
	    }
	    	
	        model.addAttribute("loggedInUser", loggedInUser);

	        // Fetch the last login record for the user
	        LoginHistoryVO lastLogin = loginHistoryService.findLastLoginForUser(loggedInUser.getEmpId());
	        if (lastLogin != null) {
	            model.addAttribute("lastAccess", lastLogin.getHistDate());
	        }
	    return "atnd/calendar/calendarPage";
	}



    @GetMapping("/login.do")
    public String loadLoginPage() {
    	return "syst/main/login";
    }
    
	 @GetMapping("/logout.do")
    public String logout(HttpSession session) {

        if (session != null) {
            session.invalidate();
        }

        return "redirect:/syst/main/login.do";
    }
    
    
	 @PostMapping("/login.do")
	 public String login(@RequestParam("empId") String empId,
	                     @RequestParam("password") String password,
	                     HttpServletRequest request, Model model) {
	     UserMgVO user = userService.findByEmpIdAndPassword(empId, password);
	     
	     if (user != null) {
	         // Convert both expected and retrieved status to lowercase for case-insensitive comparison
	         String expectedStatus = "approved";
	         String actualStatus = user.getRegisterStatus().toLowerCase();
	         
	         if (actualStatus.equals(expectedStatus)) {
	             HttpSession session = request.getSession();
	             session.setAttribute("loggedInUser", user);
	             
	             // Create a new LoginHistoryVO object
	             LoginHistoryVO loginHistory = new LoginHistoryVO();
	             
	             // Fetch and set the server's IP address
	             String serverIpAddress = getServerIpAddress();
	             loginHistory.setIp(serverIpAddress); // server IP address
	             
	             // Set the login history details
	             loginHistory.setHistDate(new Date()); // current date and time
	             loginHistory.setEmpId(user.getEmpId()); // employee ID from the logged-in user
	             loginHistory.setName(user.getName()); // name from the logged-in user
	             loginHistory.setDeptName(user.getDepartment()); // department from the logged-in user
	             
	             // Save the login history
	             loginHistoryService.saveLoginHistory(loginHistory);
	             
	             session.setAttribute("lastAccess", loginHistoryService.findLastLoginForUser(empId).getHistDate());
	             
	             return "redirect:/syst/main/home.do";
	         }
	     }
	     
	     // If user is null or register status is not approved, show error message
	     model.addAttribute("errorMessage", "Invalid Employee ID or Password.");
	     return "syst/main/login";
	 }
	
	public String getServerIpAddress() {
		   try {
		       InetAddress ip = InetAddress.getLocalHost();
		       return ip.getHostAddress();
		   } catch (UnknownHostException e) {
		       e.printStackTrace();
		       return "Unable to fetch IP address";
		   }
	}
	
	
	@GetMapping("/forgotPassword.do")
	public String loadForgotPasswordPage() {
	   return "syst/main/forgotPassword";
	}

	
	@PostMapping("/forgotPassword.do")
	   public String resetPassword(@RequestParam("email") String email, ModelMap model) throws Exception {
	       // Generate token
	       String token = UUID.randomUUID().toString();

	       // Update the register token for the user with the given email in the database
	       userService.updateRegisterTokenForUser(email, token);

	       // Create and send the password reset email
	       SimpleMailMessage passwordResetEmail = new SimpleMailMessage();
	       passwordResetEmail.setTo(email); // Send the email to the provided email address
	       passwordResetEmail.setSubject("Password Reset Request");
	       passwordResetEmail.setText("To reset your password, click the link below:\n" +
	               "http://india-intra.grcworks.kr/webProject/syst/main/resetPassword.do?token=" + token);
	       mailSender.send(passwordResetEmail);

	       // Redirect to login page after sending the email
	       return "redirect:/syst/main/login.do";
	   }
	
	  @PostMapping("/checkPasswordExists.do")
	   @ResponseBody
	   public Map<String, Boolean> checkPasswordExists(@RequestParam("token") String token, @RequestParam("password") String password) {
	       boolean exists = userService.passwordExists(token, password);
	       Map<String, Boolean> response = new HashMap<>();
	       response.put("exists", exists);
	       return response;
	   }
	

		@GetMapping("/resetPassword.do")
		public String showResetPasswordPage(@RequestParam("token") String token, ModelMap model) {
		    if (!userService.isValidToken(token)) {
		        model.addAttribute("error", "Invalid or expired token");
		        return "/error/invalidToken";
		    }
		   
		    model.addAttribute("token", token);
		    return "/syst/main/resetPassword";
		}

		@PostMapping("/resetPassword.do")
		public String resetPassword(@RequestParam("token") String token, @RequestParam("password") String password) {
			System.out.println(password); // Debug print, remove or use logging in production
			System.out.println(token); // Debug print, remove or use logging in production
			userService.resetPassword(token, password);
			return "redirect:/syst/main/login.do";
		}
		
		{}
	
}
