<%-- 
    Document   : logindb
    Created on : Oct 21, 2016, 11:08:26 AM
    Author     : Administrator
--%>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<HTML>
     <HEAD>
          <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <TITLE>Redirecting login</TITLE>
     </HEAD>
     <BODY>
    <%
             
        String username = request.getParameter("USERNAME");
        String password = request.getParameter("PASSWORD");
		String SESSZONE ="";
		String SESSZONENM ="";
      
            try{
               
                if(username.equals("kvichq")&&password.equals("kvichq123"))
                {
                     response.sendRedirect("ho/dashboard.jsp"); 
					  session.setAttribute("username",username);
                }
				
				
				else
				
               session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("view2.jsp");
                    rd.forward(request, response);   
            
              }
                catch(Exception e){
                    System.out.print(e);
                }  
                	%>           
     </BODY>
</HTML>

