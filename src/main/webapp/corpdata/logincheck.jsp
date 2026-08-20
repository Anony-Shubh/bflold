<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon, java.net.*"  %>
<%@ page import="in.gov.mgov.SMSServices"%>
    <%
	
  String username = request.getParameter("USERNAME")==null?"":(String) request.getParameter("USERNAME");

if ( username.equals("8552931388") || username.equals("9987402341")  || username.equals("7977242551") ) {

		try {
String RANDOM_NO="";
String TRID="";

       DBCon db= new DBCon();
                db.connect(); 
					 List values=new ArrayList();	
    List pstm=new ArrayList();

				ResultSet rs = db.execSQL("select RANDOM_PASSWORD('ybhjj') as RANDOM_NO,nvl(max(trid),0)+1 as TRID from CORPMODULE_OTPGEN");
	   while(rs.next()){ 
	  RANDOM_NO=rs.getString("RANDOM_NO")==null?"":rs.getString("RANDOM_NO");
	   TRID=rs.getString("TRID")==null?"":rs.getString("TRID");	   
	   }
	   rs.close();
	  
	   
	   		StringBuffer qryUpdate = new StringBuffer();

	   qryUpdate.append("  INSERT INTO CORPMODULE_OTPGEN(TRID,MOB_NO,OTP,RTIMESTAMP) VALUES(?,?,?,SYSDATE) ");
	   
	   values.add(TRID); pstm.add ("L");
values.add(username); pstm.add ("L");
values.add(RANDOM_NO); pstm.add ("L");

try{

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

}catch(Exception e){
out.print(e.toString());
}

 db.close();
String SmsText="Your OTP is "+RANDOM_NO+"";


session.setAttribute("SUSER",username);


		//    response.sendRedirect("index_otp.jsp");
	            	out.print(RANDOM_NO+"in");
		          request.setAttribute("RANDOM_NO", RANDOM_NO);
                    RequestDispatcher rd = request.getRequestDispatcher("index_otp.jsp");
                  rd.forward(request, response); 
				   
	}catch(Exception e){
out.print(e.toString());
}

	}else{			   
				   //session.invalidate();
                    request.setAttribute("errorMessage", "Invalid Mobile No.");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
			}	 
			
            %>
            
