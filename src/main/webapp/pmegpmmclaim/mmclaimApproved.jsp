<%@ page contentType="text/html; charset=iso-8859-1"  language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="JavaScript">
function SubmitForm() {
  
 document.upform.ins.value='I';
 document.upform.submit();

}//end of function


</script>

</head>

<form id="upform" name="upform"  method="post">
    
<%
// modified to inclide new meeting ids in the dropdown list 12-10-2016 by j
//String SOFF_CD =(String) session.getAttribute("sOffCd"); 
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

	 

  // ResultSet rs = db.execSQL("SELECT AMM.MTG_ID, TO_CHAR(AMM.MT_DATE,'DD-MON-RRRR') AS MT_DATE, SUM(DECODE(AD.MTG_ID,NULL,0,1)) AS NO_OF_APP_PLACED FROM APP_MEETING_MAST AMM ,APP_DETAIL AD WHERE  AMM.MT_DATE BETWEEN TRUNC(SYSDATE-100) AND TRUNC(SYSDATE)+45 AND AMM.MTG_ID=AD.MTG_ID (+) AND AMM.OFF_CD=35  GROUP BY AMM.OFF_CD,AMM.MTG_ID,AMM.MT_DATE ORDER BY MT_DATE DESC");	  
	  StringBuffer appqry = new StringBuffer(); 
	  
	appqry.append("    SELECT AD.APP_ID,   AD.APP_NAME,   BBM.BR_IFSL_CODE, "      );
    appqry.append("  TO_CHAR(BD.MM_CLAIM_DT, 'DD-MON-RRRR') AS MM_CLAIM_DT,     BD.MM_CLAIM_AMT, MU.USER_DETAIL     FROM BANK_DATAENTRY BD,    APP_DETAIL AD,"      );
   appqry.append("  BANK_BR_MAST BBM,MMCLAIM_USER MU, MM_REMARKS_TRANS MRT,    BANK_APP_STATUS BAS     WHERE AD.APP_ID       = BD.APP_ID  AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
  appqry.append(" AND BD.REMTRID        = MRT.REMTR_ID   AND MRT.PACT_ID       = BAS.ACT_ID   AND MRT.USER_ID       = MU.USER_ID"      );
 appqry.append("  AND AD.APP_ID IN ("+vwhercls+") ORDER BY BD.MM_CLAIM_DT ASC "      );
	   
	    ResultSet rsApp = db.execSQL(appqry.toString());
	   //String appqry="SELECT APP_ID, APP_NAME FROM APP_DETAIL WHERE APP_ID IN ("+vwhercls+")";
	    //ResultSet rsApp = db.execSQL(appqry);
	%>
<table border="1" align="center">
               <tr>
                 <th colspan="7"><div align="center"> LIST OF APPLICATION TO BE APPROVED
                     <input name="ins" type="hidden" id="ins" value="">
                 </div></th>
               
	
   
              
               <tr>
                 <td colspan="7" nowrap class="GreenLebel" ><div align="center">Applications Selected for Approval </div></td>
               </tr>
               <tr>
                 <th ><div align="center">Sr No. </div></th>
                 <th  ><div align="center">Applicant ID </div></th>
                 <th  ><div align="center">Applicant Name</div></th>
				 <th  ><div align="center">IFSC_CODE</div></th>
				 <th  ><div align="center">MM_Claim_Date</div></th>
				 <th  ><div align="center">MM_Calim Amount</div></th>
				 <th  ><div align="center">Approved By</div></th>
				 
               </tr>
			   <%  
			   String APP_ID="";
			   String APP_NAME="";
			   String BR_IFSL_CODE="";
			   String MM_CLAIM_DT="";
			   String MM_CLAIM_AMT="";
			   String USER_DETAIL="";
			   int cnt=0;
			   while (rsApp.next()) {
			   APP_ID=rsApp.getString(1);
			   APP_NAME=rsApp.getString(2);
			   BR_IFSL_CODE=rsApp.getString(3);
			   MM_CLAIM_DT=rsApp.getString(4);
			   MM_CLAIM_AMT=rsApp.getString(5);
			   USER_DETAIL=rsApp.getString(6);
			   cnt=cnt+1;
			   %>
    <tr>
      <td class="redLebel" ><div align="center"> <%= cnt %></div></td>
      <td class="redLebel" ><div align="center"><%= APP_ID %></div></td>
      <td class="redLebel" ><%= APP_NAME %></td>
	   <td class="redLebel" ><%= BR_IFSL_CODE %></td>
	    <td class="redLebel" ><%= MM_CLAIM_DT %></td>
		 <td class="redLebel" ><%= MM_CLAIM_AMT %></td>
		  <td class="redLebel" ><%= USER_DETAIL %></td>
    </tr>
	<% }
	rsApp.close();
	 %>
    <tr>
      <th colspan="7" nowrap ><div align="center">
        <input name="Button" type="button" class="button" value="Submit" onClick="SubmitForm();">
      </div></th>
    </tr> 
</table>
<%
try {
			
		 if ((String)request.getParameter("ins")!=null){
				 List values=new ArrayList();
List pstm=new ArrayList();
			String vqry="UPDATE BANK_DATAENTRY SET APPRV_YN='A'  WHERE APP_ID IN ("+vwhercls+")  ";	
				
				db.setSqlValue( vqry);
db.setValues(values,pstm);
db.executeUpdate() ;
response.sendRedirect("savemsg.jsp");
}
}
catch (Exception e){
out.print (e.toString());
}
  
  
  

%>
</form>
<% } %>
</html>