<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<% 
 try{
 String state=request.getParameter("count"); 
 String buffer="<select name='DISTRICT' ><option value='-1\' >--Select District--</option>";    
  DBCon db= new DBCon();
 int srn =0;
db.connect(); 
 ResultSet rs = db.execSQL("Select district_cd, DECODE(aspir_dist_yn,'N',initCap(district_name),'Y',initCap(district_name)||'(ASPIRATIONAL DISTRICT)') as district_name from m_district where state_cd='"+state+"' and district_status='A'  order by district_name");  
   while(rs.next()){ 
   buffer=buffer+"<option value='"+rs.getString("district_cd")+"'>"+rs.getString("district_name")+"</option>";   
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
