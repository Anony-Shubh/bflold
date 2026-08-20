<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon, java.net.*"  %>
<%@ page import="in.gov.mgov.SMSServices"%>
    <%
	
  String username = request.getParameter("USERNAME")==null?"":(String) request.getParameter("USERNAME");
  String password = request.getParameter("PASSWORD")==null?"":(String) request.getParameter("PASSWORD");

if ( username.equals("geo123") && password.equals("geo123")) {

		response.sendRedirect("HOME.jsp");

	}else{			   
				   //session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username password");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
			}	 
			
            %>
            
