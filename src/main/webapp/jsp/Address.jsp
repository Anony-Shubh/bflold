<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<% 

 String subid=request.getParameter("subid")==null?"":(String)request.getParameter("subid");
 String APP_ID=request.getParameter("appid")==null?"":(String)request.getParameter("appid");
 
 
String VAL1="";
 
String VAL2="";
 
String VAL3="";
String AGENCY_TYPE="";
String EMAIL="";
String OFF_EMAIL_ADDR="";
String OFF_NAME1="";
String BR_NAME="";


  DBCon db= new DBCon();
db.connect();


 ResultSet rs = db.execSQL(" SELECT MOM.OFF_EMAIL_ADDR,MOM.AGENCY_TYPE,BRM.BR_NAME,MOM.OFF_NAME1, BRM.EMAIL FROM APP_DETAIL AD,BANK_BR_MAST BRM ,MAS_OFF_MAST MOM WHERE AD.OFF_CD = MOM.OFF_CD AND AD.IFSC_CODE=BRM.BR_IFSL_CODE  AND AD.APP_ID   = '"+APP_ID+"' "); 
 

 while (rs.next()){

OFF_EMAIL_ADDR=rs.getString("OFF_EMAIL_ADDR")==null?"":rs.getString("OFF_EMAIL_ADDR");
AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
EMAIL=rs.getString("EMAIL")==null?"":rs.getString("EMAIL");
OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");  
BR_NAME=rs.getString("BR_NAME")==null?"":rs.getString("BR_NAME"); 
 } 


  if (subid.equals("1")){
VAL1="AG";
VAL3=AGENCY_TYPE+","+OFF_NAME1;
}
else if (subid.equals("2")){
VAL1="BK";	
VAL3=BR_NAME;
}

else if (subid.equals("3")){
VAL1="CO";
VAL3="Central Office Mumbai";
}
else if (subid.equals("4")){
VAL1="DIT";

VAL3="DIT Mumbai";
}

 // out.print(VAL1); 
//out.print(VAL3); 
  try{
 
 String buffer="<select name='EMAIL_TO' id='EMAIL_TO'><option value='-1\' >--Select--</option>";    
 
 int srn =0;

 

   buffer=buffer+"<option value='"+VAL1+"'>"+VAL3+"</option>";   
 
   rs.close();
   db.close();   
 buffer=buffer+"</select>";   
 response.getWriter().println(buffer);  
 } 
 catch(Exception e){ 
     out.print(e); 
 } 

 %> 