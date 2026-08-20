package pkgPmegpNew;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CaptchaUtil {
    public static final String CAPTCHA_KEY = "captcha_key";
    public static boolean validateCaptcha(HttpServletRequest request, String userCaptcha) {
        if (userCaptcha == null || userCaptcha.trim().isEmpty()) {
            return false;
        }
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        String captcha = (String) session.getAttribute(CAPTCHA_KEY);
        if (captcha == null) {
            return false;
        }
        
        // Remove the captcha from session after validation
        session.removeAttribute(CAPTCHA_KEY);
        
        return captcha.equalsIgnoreCase(userCaptcha.trim());
    }
}