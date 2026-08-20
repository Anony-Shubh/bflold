<%@page import="java.sql.*"%>
<!DOCTYPE html>
<HTML>
     <HEAD>
          <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <TITLE></TITLE>
     </HEAD>
     <BODY>
    <%
             
        String username = request.getParameter("USERNAME");
        String password = request.getParameter("PASSWORD");
      
            try{
               
                if(username.equals("edpview")&&password.equals("edp@1234"))
                {
                     response.sendRedirect("searchapp.jsp"); 
					  session.setAttribute("username",username);
                }
				
				else
				
               session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response);   
            
              }
                catch(Exception e){
                    System.out.print(e);
                }  
                	%>           
     </BODY>
</HTML>

