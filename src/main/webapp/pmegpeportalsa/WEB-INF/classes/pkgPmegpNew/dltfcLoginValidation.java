package pkgPmegpNew;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import pkgPmegpNew.printApplication;

public class dltfcLoginValidation extends HttpServlet {
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8"); 
       // response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String appID = request.getParameter("APP_ID")==null?"": (String) request.getParameter("APP_ID");
        String mobNo1 = request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1");
        String flag="Y";
        
        if (appID.equals("")){
        response.getWriter().write("Enter PMEGP e-Tracking Applicant ID"); 
                   flag="N";
        }
        
         if (mobNo1.equals("")){
           response.getWriter().write("Enter 10 Digit Registered Mobile Number"); 

           flag="N";
        }

        
        if (flag.equals("Y")) {
        if(printApplication.validate(appID, mobNo1) )
        {
        
         response.setContentType("text/PDF");
            response.setCharacterEncoding("UTF-8");
            RequestDispatcher rs = request.getRequestDispatcher("PMEGPGenAppFormHp.jsp");
            
            request.setAttribute("APP_ID", appID);
            rs.forward(request, response);
            
                    }
        else
        {
        
          
           response.getWriter().write(" Your PMEGP e-Tracking Applicant ID or Registered Mobile Number mismatch");
                   }
        
        }
    }  
}