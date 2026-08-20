<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>

    <%
	
	
             
List values=new ArrayList();
        String username = request.getParameter("USERNAME")==null?"":(String) request.getParameter("USERNAME");
        String password = request.getParameter("PASSWORD")==null?"":(String) request.getParameter("PASSWORD");
	

				
				
if(username.equals("test")&& password.equals("test")){
					response.sendRedirect("pmegpeportal/bnf/index.jsp"); 

}
	else{			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
			}	
			
			//   db.close();
					
	   
            %>
            
