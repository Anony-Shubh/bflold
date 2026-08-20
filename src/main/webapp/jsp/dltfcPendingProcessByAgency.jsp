<%@ page contentType="text/html; charset=iso-8859-1"  language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="JavaScript">
function SubmitForm() {
	MTG_ID =document.upform.MTG_ID.value;  
   if  (MTG_ID=="") {
  inlineMsg('MTG_ID','Please Select Meeting Date.',2);
    return false;
  }
  
 document.upform.ins.value='I';
 document.upform.submit();

}//end of function


</script>

</head>

<form id="upform" name="upform"  method="post">
    
<%
// modified to inclide new meeting ids in the dropdown list 12-10-2016 by j
String SOFF_CD =(String) session.getAttribute("off_cd"); 
//j
String [] vBillid=request.getParameterValues("billid");
if (vBillid == null) {
out.print ("<center><h1> No Application has been Selected.........<br> <br> Please Select Check Box to select Application.....</h1></center>");
}else{
String vwhercls ="";
 DBCon db= new DBCon();
 db.connect(); 

if (vBillid != null && vBillid.length != 0) {
for (int i = 0; i < vBillid.length; i++) {
vwhercls="'"+vBillid[i]+"'"+","+vwhercls ; 
}//end of for loop
vwhercls=vwhercls+"'"+"-"+"'";
}//end of if

	 StringBuffer qrysb = new StringBuffer();

qrysb.append("  SELECT TO_CHAR(TRUNC(AMM.MT_DATE), 'DD-MON-RRRR') AS MT_DATE,MTG_PLACE,"      );
qrysb.append("  SUM(CASE WHEN AD.MTG_ID  IS NOT NULL AND AD.OFF_CD="+SOFF_CD+" THEN"      );
qrysb.append("   1 ELSE 0 END)  NO_OF_APP_PLACE, AMM.MTG_ID"      );
qrysb.append("   FROM APP_MEETING_MAST AMM, APP_DETAIL AD"      );
qrysb.append("    WHERE AMM.MTG_ID = AD.MTG_ID(+)"      );
qrysb.append("     AND   AMM.DISTRICT_CD IN (SELECT DISTRICT_CD FROM MAS_OFF_MAST WHERE OFF_CD="+SOFF_CD+" )"      );
qrysb.append("     AND TRUNC(AMM.MT_DATE) >= TRUNC(SYSDATE)"      );
qrysb.append("    GROUP BY AMM.MTG_ID,"      );
qrysb.append("     AMM.MT_DATE, MTG_PLACE ORDER BY MT_DATE DESC"      );


	    ResultSet rs = db.execSQL(qrysb.toString());


  // ResultSet rs = db.execSQL("SELECT AMM.MTG_ID, TO_CHAR(AMM.MT_DATE,'DD-MON-RRRR') AS MT_DATE, SUM(DECODE(AD.MTG_ID,NULL,0,1)) AS NO_OF_APP_PLACED FROM APP_MEETING_MAST AMM ,APP_DETAIL AD WHERE  AMM.MT_DATE BETWEEN TRUNC(SYSDATE-100) AND TRUNC(SYSDATE)+45 AND AMM.MTG_ID=AD.MTG_ID (+) AND AMM.OFF_CD=35  GROUP BY AMM.OFF_CD,AMM.MTG_ID,AMM.MT_DATE ORDER BY MT_DATE DESC");	  
	   String appqry="SELECT APP_ID, APP_NAME FROM APP_DETAIL WHERE APP_ID IN ("+vwhercls+")";
	    ResultSet rsApp = db.execSQL(appqry);
	%>
<table border="1" align="center">
               <tr>
                 <th colspan="3"><div align="center">DLTFC Meeting 
                     <input name="ins" type="hidden" id="ins" value="">
                 </div></th>
               
	<%//}
   //rs.close();
 
   %> 	
   
               <tr>
                 <th colspan="3" nowrap >Note: Only future Meeting Date will be display </th>
               </tr>
               <tr>
                 <th colspan="3" nowrap >Select Meeting Date: 
                   <select name="MTG_ID" id="MTG_ID">
                     <option value="">-Select Meeting Date-</option>
                     <%
				String MTG_ID="";
				 String MT_DATE="";
				 String NO_OF_APP_PLACED="";
				  String MTG_PLACE="";
				  while (rs.next()) {
				  MT_DATE=rs.getString(1);
				  MTG_PLACE=rs.getString(2);
				  NO_OF_APP_PLACED=rs.getString(3);
				  MTG_ID=rs.getString(4); 
				   %>
                     <option value=" <%=  MTG_ID %> ">ID:<%=  MTG_ID %> Date:<%= MT_DATE %>,Place:<%= MTG_PLACE %> (<%= NO_OF_APP_PLACED %>)</option>
                     <% 
				   } 
				   rs.close();
				   %>
                   </select></th>
               </tr>
               <tr>
                 <td colspan="3" nowrap class="GreenLebel" ><div align="center">Applications Selected for Meeting </div></td>
               </tr>
               <tr>
                 <th ><div align="center">Sr No. </div></th>
                 <th  ><div align="center">Applicant ID </div></th>
                 <th  ><div align="center">Name</div></th>
               </tr>
			   <%  
			   String APP_ID="";
			   String APP_NAME="";
			   int cnt=0;
			   while (rsApp.next()) {
			   APP_ID=rsApp.getString(1);
			   APP_NAME=rsApp.getString(2);
			   cnt=cnt+1;
			   %>
    <tr>
      <td class="redLebel" ><div align="center"> <%= cnt %></div></td>
      <td class="redLebel" ><div align="center"><%= APP_ID %></div></td>
      <td class="redLebel" ><%= APP_NAME %></td>
    </tr>
	<% }
	rsApp.close();
	 %>
    <tr>
      <th colspan="3" nowrap ><div align="center">
        <input name="Button" type="button" class="button" value="Submit" onClick="SubmitForm();">
      </div></th>
    </tr> 
</table>
<%

 if ((String)request.getParameter("ins")!=null){

  try {
  List values=new ArrayList();
List pstm=new ArrayList();
MTG_ID=(String)request.getParameter("MTG_ID")==null?"":(String)request.getParameter("MTG_ID").trim();

String vqry="UPDATE APP_DETAIL SET MTG_ID="+MTG_ID+",DLTFC_PROC_DT=SYSDATE WHERE APP_ID IN ("+vwhercls+") AND ACT_ID IN(2,7)  ";
/*
values.add (MTG_ID);pstm.add ("L");
values.add (vwhercls);pstm.add ("L");
*/
db.setSqlValue( vqry);
db.setValues(values,pstm);
db.executeUpdate() ;
response.sendRedirect("dltfcProcMsg.jsp");
}catch (Exception e){
out.print (e.toString());
}
  
  }//end of ins.
  
db.close();

%>
</form>
<% } %>
</html>