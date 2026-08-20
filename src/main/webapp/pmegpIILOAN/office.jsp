<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<% 
 String state=request.getParameter("state")==null?"":(String)request.getParameter("state");
 String distcd=request.getParameter("distcd")==null?"":(String)request.getParameter("distcd");
 String orgcd=request.getParameter("orgcd")==null?"":(String)request.getParameter("orgcd");
 String OFF_CD="0";
int cont=0;
String buffer="";
if (state.equals("")||state.equals("-1") ){
 buffer=buffer+"<strong>Select State</strong>";
 }else if (distcd.equals("")||distcd.equals("-1") ){
 buffer=buffer+"<strong>Select District</strong>";
 }else if (orgcd.equals("")||orgcd.equals("-1") ){
 buffer=buffer+"<strong>Select Sponsoring Agency</strong>";
 } else {
 String off_desc=orgcd.equals("KV")?"Khadi and Village Industries Commission":"";
  DBCon db= new DBCon();
db.connect();
 ResultSet rs = db.execSQL("SELECT nvl(OFF_TEL_NO,'--') as OFF_TEL_NO, nvl(OFF_EMAIL_ADDR,'--') as OFF_EMAIL_ADDR, mom.off_cd,motc.off_type_long_desc,mom.off_addr1||','||mom.off_addr2 as addr, mom.city ,mom.pincode ,initCap(md.district_name) as dist,initCap(ms.state_nm)  as state FROM mas_off_mast mom ,DATAENTRY_USER DU,mas_off_type_cdmast motc ,m_district md, m_state ms where  MOM.USER_ID=DU.USER_ID AND mom.off_type_cd=motc.off_type_cd and mom.off_type_cd in (3,2,5,22,27) and mom.district_cd=md.district_cd and md.state_cd=ms.state_cd  and mom.org_cd='"+orgcd+"' and md.state_cd='"+state+"' AND MD.DISTRICT_CD="+distcd+" AND DU.ACT_YN='Y' ");  
   buffer=buffer+ "  <table border=\"0\" align=\"left\" cellpadding=\"3\" cellspacing=\"2\" >";
  
   while(rs.next()){
   cont=cont+1; 
      
   OFF_CD=rs.getString("off_cd");
   
  
 
 buffer=buffer+ " <tr> ";
  buffer=buffer+ "  <td width=\"26\"  scope=\"col\">("+cont+")</td>";
  buffer=buffer+ "  <td width=\"73\" bgcolor=\"#99CCFF\" scope=\"col\"> ";
   buffer=buffer+ "   <input name=\"OFF_CD\" type=\"radio\" value='"+rs.getString("off_cd")+"' title=\"Select Sponsoring Office\" /> ";
  buffer=buffer+ "  </td> ";
   buffer=buffer+ " <td width=\"212\" bgcolor=\"#FFFFCC\"  scope=\"col\">"+rs.getString("off_type_long_desc")+" </td> ";
 buffer=buffer+ " </tr> ";
  buffer=buffer+ " <tr> ";
  buffer=buffer+ "  <td rowspan=\"8\" scope=\"col\">.</td>";
  buffer=buffer+ "  <td colspan=\"2\" bgcolor=\"#FFFFE6\" scope=\"col\">"+off_desc+" </td>";
  buffer=buffer+ "</tr> ";
 buffer=buffer+ " <tr> ";
   buffer=buffer+ " <td colspan=\"2\" bgcolor=\"#FFFFCC\" scope=\"col\">"+rs.getString("addr")+" </td> ";
 buffer=buffer+ " </tr> ";
 buffer=buffer+ " <tr> ";
   buffer=buffer+ " <td colspan=\"2\" bgcolor=\"#FFFFE6\" scope=\"col\">"+rs.getString("city")+"</td> ";
 buffer=buffer+ " </tr> ";
 buffer=buffer+ " <tr> ";
  buffer=buffer+ "  <td scope=\"col\">District:</td> ";
  buffer=buffer+ "  <td bgcolor=\"#FFFFCC\" scope=\"col\">"+rs.getString("dist")+"</td>";
 buffer=buffer+ " </tr> ";
  buffer=buffer+ "<tr> ";
   buffer=buffer+ " <td scope=\"col\">Pin:</td> ";
   buffer=buffer+ " <td bgcolor=\"#FFFFE6\" scope=\"col\">"+rs.getString("pincode")+"</td> ";
  buffer=buffer+ "</tr> ";
 buffer=buffer+ " <tr> ";
   buffer=buffer+ " <td scope=\"col\">State:</td> ";
    buffer=buffer+ "<td bgcolor=\"#FFFFCC\" scope=\"col\">"+rs.getString("state")+"</td> ";
 buffer=buffer+ " </tr> ";
  buffer=buffer+ "<tr> ";
   buffer=buffer+ " <td scope=\"col\">Ph No: </td> ";
   buffer=buffer+ " <td bgcolor=\"#FFFFE6\" scope=\"col\">"+rs.getString("OFF_TEL_NO")+"</td> ";
  buffer=buffer+ "</tr> ";
 buffer=buffer+ " <tr> ";
   buffer=buffer+ " <td scope=\"col\">eMail:</td> ";
   buffer=buffer+ " <td bgcolor=\"#FFFFCC\" scope=\"col\">"+rs.getString("OFF_EMAIL_ADDR")+"</td> ";
  buffer=buffer+ "</tr> ";
  
   
   }//WHILE LOOP
  
   buffer=buffer+ " </table> "; 
    if (cont==0){buffer=buffer+"<strong>No Office Found in Selected District,State and sponsoring Agency </strong>"; }  

   
   }//main if
response.getWriter().println(buffer);  

//rs.close();
//db.close();
 %> 