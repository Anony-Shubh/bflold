<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>


<% 
 try{
 String state=request.getParameter("count")==null?"":(String) request.getParameter("count"); 
// String state=request.getParameter("STATE_CDC"); 
String buffer="  <select name=\"DISTRICT_NAME\" id=\"DISTRICT_NAME\">   <option value=\"\" selected>-Select-</option> "; 
 //String buffer="<select name='DISTRICT_NAME' onchange=\"showOffice(this.value);copy_dist();\" ><option value='\' >--Select District--</option>";    
  DBCon db= new DBCon();
 int srn =0;
db.connect(); 
 ResultSet rs = db.execSQL("SELECT MD.DISTRICT_CD, md.DISTRICT_NAME FROM m_district md,m_state ms WHERE  md.state_cd = ms.state_cd and md.DISTRICT_STATUS='A' AND md.STATE_CD='"+state+"'");  
   while(rs.next()){ 
buffer=buffer+"<option value='"+rs.getString(1)+"' >"+rs.getString(2)+"</option>"; 
  

 
   }
   rs.close();
   db.close();   
 buffer=buffer+"</select>";   
 response.getWriter().println(buffer);  
 } 
 catch(Exception e){ 
     out.print(e); 
 } 
 
 %> 
