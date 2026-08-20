<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,kvic.inputvalid.*"  %>


<% 
 try{
 jspinputvalid js = new jspinputvalid();
 
 String state=js.getOnlyText((String)request.getParameter("STATE"),2);

 String buffer="<select name='DISTRICT' onchange=\"showOffice(this.value);copy_dist();\" ><option value='-1\' >--Select District--</option>";    
  DBCon db= new DBCon();
 int srn =0;
db.connect(); 
 ResultSet rs = db.execSQL("Select district_cd, initCap(district_name) as district_name from m_district where state_cd='"+state+"' and district_status='A'  order by district_name");  
   while(rs.next()){ 
   buffer=buffer+"<option value='"+rs.getString("district_cd")+"' if( UNIT_DIST_CD.equals('"+rs.getString("district_cd")+"')){out.print(selected);} >"+rs.getString("district_name")+"</option>";   
   }
   rs.close();
   db.close();   
 buffer=buffer+"</select>";   
 response.getWriter().println(buffer);  
 } 
 catch(Exception e){ 
    // out.print(e); 
 } 
 
 %> 
