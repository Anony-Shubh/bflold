<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>


<%

    String UserCode= request.getParameter("USERNAME")==null?"":(String)request.getParameter("USERNAME");
    String pw = request.getParameter("PASSWORD")==null?"":(String)request.getParameter("PASSWORD");
	

	
	 if(UserCode.equals("msme")&&pw.equals("msme"))
                {
                     response.sendRedirect("index.jsp"); 
					 session.setAttribute("slogin", "Y");

                } 
				
				else  {			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("indexlogin.jsp");
                    rd.forward(request, response); 
			}	
			
			//db.close();
%>