<%@ page  import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<% 
 int srn =0;
   DBCon db= new DBCon();
db.connect(); 
String vStatecd= (String) session.getAttribute("state_cd");


String MTG_ID="";
String MT_DATE="";
String MTG_PLACE="";
String DISTRICT_NAME="";
String vMTG_ID=request.getParameter("MTG_ID")==null?"0":(String) request.getParameter("MTG_ID");

String qryString="";
if (vMTG_ID.equals("0")) {
 qryString="SELECT AME.MTG_ID,TO_CHAR(AME.MT_DATE,'DD-MON-RRRR') AS MT_DATE,AME.MTG_PLACE, MD.DISTRICT_NAME FROM APP_MEETING_MAST AME,M_DISTRICT MD WHERE AME.DISTRICT_CD = MD.DISTRICT_CD AND STATE_CD='"+vStatecd+"' ORDER BY AME.MT_DATE DESC";  
 }else {
     qryString="SELECT AME.MTG_ID,TO_CHAR(AME.MT_DATE,'DD-MON-RRRR') AS MT_DATE,AME.MTG_PLACE, MD.DISTRICT_NAME FROM APP_MEETING_MAST AME,M_DISTRICT MD WHERE AME.DISTRICT_CD = MD.DISTRICT_CD AND AME.MTG_ID="+vMTG_ID+" ORDER BY AME.MT_DATE DESC";  
}


  ResultSet rs = db.execSQL(qryString);  

  %>
  
   <table border="1" cellpadding="3" cellspacing="3" bordercolor="#990000" >
  <tr>
    <td><strong>Select</strong></td>
    <td><strong>ID</strong></td>
    <td><strong>Date</strong></td>
    <td><strong>Place</strong></td>
    <td><strong>District</strong></td>
  </tr>
  
  
  <%
  String sel="";
   while(rs.next()){ 
   MTG_ID=rs.getString("MTG_ID");
MT_DATE=rs.getString("MT_DATE");
 MTG_PLACE=rs.getString("MTG_PLACE");
 DISTRICT_NAME=rs.getString("DISTRICT_NAME");
  
  sel=MTG_ID.equals(vMTG_ID)?"checked":"";
 %> 
  
 
  <tr>
   <td><input name="MTG_ID" id="MTG_ID" type="radio" onclick="showHint('<%= MTG_ID %>');" value="<%= MTG_ID %>" <%= sel %> /></td>
    <td><%= MTG_ID %></td>
    <td><%= MT_DATE %></td>
    <td><%= MTG_PLACE %></td>
    <td><%= DISTRICT_NAME %></td>
  </tr>
 

  <%
   }
   rs.close();
   db.close();   
 %> 
 </table>
