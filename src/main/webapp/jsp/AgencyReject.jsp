<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.mobileseva.SendSMS"%>
<%@ page buffer="200kb" %>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<html>
<head>
<SCRIPT src="../js/inlineMsgMain.js"></SCRIPT>
<title>

</title>
<script>
 function closeAndRefresh() {
            window.parent.refreshpage();
        }

function submit_form() {

var REMARKS = document.form.REMARKS.value;
		if(REMARKS==""){
inlineMsg('REMARKS',"Please Enter Rejection Remarks",2);			
return (false);
}
document.form.ins.value='I';
form.submit();
}
</script>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>
<body> 
 <form name="form" id="form"  class="form" method="post" action="AgencyReject.jsp">
	 	
		

<%
DBCon db= new DBCon();
db.connect();
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String APP_ID1="";
String APP_NM="";
String MOB_NO="";
String REMARKS="";
String APP_ID = request.getParameter("APP_ID")==null?"": (String)  request.getParameter("APP_ID");
StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT AD.APP_ID,"      );
qrysb.append("     UPPER(AD.APP_NAME) AS APP_NAME,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.MACHINARY_COST,"      );
qrysb.append("     AD.WORKING_CAPITAL,"      );
qrysb.append("     AD.BANK_NAME,"      );
qrysb.append("     AD.BANK_POST_ADDR,"      );
qrysb.append("     AD.BANK_TALUK_BLOCK,"      );
qrysb.append("     AD.BANK_PINCD,"      );
qrysb.append("     AD.MTG_ID,"      );
qrysb.append("     AD.IFSC_CODE,"      );
qrysb.append("     AD.ONLINE_SUBDT,"      );
 qrysb.append("   CASE WHEN (NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0))=0 THEN"      );
 qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0)"      );
 qrysb.append("   ELSE NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0) END TOTAL_PROJCOST,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("     BD.BANK_REC_DT,"      );
qrysb.append("     BD.BANK_REMARKS,"      );
qrysb.append("     AD.BRANCH_NAME,"      );
qrysb.append("     AD.BANK_DISTRICT,"      );
qrysb.append("     AD.ACTIVITY_CD,"      );
qrysb.append("     CASE WHEN AD.IND_TYPE='M' THEN 'Manufacturing' WHEN AD.IND_TYPE='M' THEN 'Service' WHEN AD.IND_TYPE='T' THEN 'Trading' END IND_TYPE ,"      );
qrysb.append("     AD.BANK_F_DATE,"      );
qrysb.append("     AD.IFSC_CODE2,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     RBL.BANK_NAME AS BANK_NAME2,"      );
qrysb.append("     RBL.BRANCHNAME AS BRANCHNAME2 ,"      );
qrysb.append("     RBL.ADDRESS AS ADDRESS2,"      );
qrysb.append("     RBL.CENTRE AS CENTRE2,"      );
qrysb.append("     RBL.DISTRICT AS DISTRICT2,"      );
qrysb.append("     RBL.STATE AS STATE2,"      );
qrysb.append("     RBL.EMAIL AS EMAIL2,"      );
qrysb.append("  UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME,"      );
 qrysb.append("  UPPER(AD.PROD_DESC) AS PROD_DESC"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     RBIBANKLIST RBL, ACTIVITY_MAST AM "      );
qrysb.append("   WHERE AD.APP_ID   = BD.APP_ID(+) AND AM.ACTIVITY_CD=AD.ACTIVITY_CD "      );
qrysb.append("   AND AD.IFSC_CODE2 = RBL.IFSC_CODE(+)"      );
qrysb.append("   AND AD.OFF_CD     = MOM.OFF_CD"      );
qrysb.append("   AND AD.APP_ID LIKE '"+APP_ID+"'"      );
qrysb.append("   AND AD.ACT_ID = 4"      );
qrysb.append("   AND AD.MTG_ID IS NOT NULL AND AD.ACT_YN='Y' "      );
//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());

String APP_NAME = "";
String MOB_NO1 = "";
String MACHINARY_COST = "";
String BANK_POST_ADDR = "";
String BANK_TALUK_BLOCK = "";
String BANK_PINCD = "";
String MTG_ID = "";
String IFSC_CODE = "";
String ONLINE_SUBDT = "";
String DLTFC_CE = "";
String DLTFC_WC = "";
String PAN_NO = "";
String BANK_REC_DT = "";
String BANK_REMARKS = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";
String ACTIVITY_CD = "";
String IND_TYPE = "";
String BANK_F_DATE = "";
String IFSC_CODE2 = "";
String AADHAR_NO = "";
String BANK_NAME2 = "";
String BRANCHNAME2 = "";
String ADDRESS2 = "";
String CENTRE2 = "";
String DISTRICT2 = "";
String STATE2 = "";
String EMAIL2 = "";
String WORKING_CAPITAL="";
String BANK_NAME="";
String ACTIVITY_NAME="";
String PROD_DESC="";
String TOTAL_PROJCOST="";
  while(rsMain.next())
  { 
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
MACHINARY_COST=rsMain.getString("MACHINARY_COST")==null?"":rsMain.getString("MACHINARY_COST");
WORKING_CAPITAL=rsMain.getString("WORKING_CAPITAL")==null?"":rsMain.getString("WORKING_CAPITAL");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BANK_POST_ADDR=rsMain.getString("BANK_POST_ADDR")==null?"":rsMain.getString("BANK_POST_ADDR");
BANK_TALUK_BLOCK=rsMain.getString("BANK_TALUK_BLOCK")==null?"":rsMain.getString("BANK_TALUK_BLOCK");
BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
MTG_ID=rsMain.getString("MTG_ID")==null?"":rsMain.getString("MTG_ID");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
BANK_REC_DT=rsMain.getString("BANK_REC_DT")==null?"":rsMain.getString("BANK_REC_DT");
BANK_REMARKS=rsMain.getString("BANK_REMARKS")==null?"":rsMain.getString("BANK_REMARKS");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
BANK_DISTRICT=rsMain.getString("BANK_DISTRICT")==null?"":rsMain.getString("BANK_DISTRICT");
ACTIVITY_CD=rsMain.getString("ACTIVITY_CD")==null?"":rsMain.getString("ACTIVITY_CD");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
BANK_F_DATE=rsMain.getString("BANK_F_DATE")==null?"":rsMain.getString("BANK_F_DATE");
IFSC_CODE2=rsMain.getString("IFSC_CODE2")==null?"":rsMain.getString("IFSC_CODE2");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
BANK_NAME2=rsMain.getString("BANK_NAME2")==null?"":rsMain.getString("BANK_NAME2");
BRANCHNAME2=rsMain.getString("BRANCHNAME2")==null?"":rsMain.getString("BRANCHNAME2");
ADDRESS2=rsMain.getString("ADDRESS2")==null?"":rsMain.getString("ADDRESS2");
CENTRE2=rsMain.getString("CENTRE2")==null?"":rsMain.getString("CENTRE2");
DISTRICT2=rsMain.getString("DISTRICT2")==null?"":rsMain.getString("DISTRICT2");
STATE2=rsMain.getString("STATE2")==null?"":rsMain.getString("STATE2");
EMAIL2=rsMain.getString("EMAIL2")==null?"":rsMain.getString("EMAIL2");
ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
PROD_DESC=rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
TOTAL_PROJCOST=rsMain.getString("TOTAL_PROJCOST")==null?"":rsMain.getString("TOTAL_PROJCOST");
}
rsMain.close();
//db.close();
  %>
<p>    
  <table align="center">
  <tr>
    <th scope="row">Applicant id 
        <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>"> 
		 <input name="ins" type="hidden" id="ins" value="<%= ins %>">    </th>
    <td><%= APP_ID %></td>
    <th>Applicant name </th>
    <td><%= APP_NAME %><input name="APP_NAME" type="hidden" id="APP_NAME" value="<%= APP_NAME %>"></td>
  </tr>
  <tr>
    <th scope="row">Adhaar/ PAN No:</th>
    <td><%= AADHAR_NO %> / <%= PAN_NO %></td>
    <th>Mobile No: </th>
    <td><%= MOB_NO1 %><input name="MOB_NO1" type="hidden" id="MOB_NO1" value="<%= MOB_NO1 %>"></td>
  </tr>
  <tr>
    <th scope="row">Proposed Project Cost: </th>
    <td colspan="3"><%= TOTAL_PROJCOST %></td>
    </tr>
  <tr>
    <th scope="row">Industry Detail: </th>
    <td colspan="3"><%= ACTIVITY_NAME %>,<%= PROD_DESC %>,<%= IND_TYPE %></td>
    </tr>
  <tr>
    <th scope="row">Rejected Reason: </th>
    <td colspan="3" class="redLebel"><INPUT name="REMARKS" type="text" id="REMARKS" value="<%= REMARKS %>" size="50"  maxlength="50" /></td>
  </tr>
  <tr>
      <th colspan="4" class="redLebel"><div align="center">Once the application is returned to the applicant nothing can be changed/updated......
            
      </div></th>
    </tr>
    <tr>
      <th colspan="4">        <div align="center">
        <input name="Button" type="button" class="button"  onClick="submit_form();"  value="Return"> 
		 <input name="Button" type="button" class="button"   onClick="window.parent.HideModalWindow1();"  value="Cancel">      
      </div></th>
    </tr>
  </table>
  
 
     <%
				
			try {
			
			if (ins.equals("I")){
			//out.print(ins);		
	  APP_ID1 = request.getParameter("APP_ID")==null?"0":request.getParameter("APP_ID");
	  REMARKS = request.getParameter("REMARKS")==null?"0":request.getParameter("REMARKS");
	  MOB_NO = request.getParameter("MOB_NO1")==null?"0":request.getParameter("MOB_NO1");
	  
out.print(APP_ID1);
out.print(REMARKS);	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
              StringBuffer qryUpdate = new StringBuffer();
 qryUpdate.append("UPDATE APP_DETAIL SET  ACT_YN='N', REMARKS='"+REMARKS+"', APP_REC_DATE=SYSDATE  WHERE APP_ID='"+APP_ID1+"' AND ACT_ID=4 AND MTG_ID IS NOT NULL AND ACT_YN='Y'  ");

db.setSqlValue(qryUpdate.toString());
db.executeUpdate() ;
db.close();
	
	 values.clear();
    pstm.clear();
            //String SmsText=" "+APP_NM+ "('"+APP_ID1+"') ,Your PMEGP application has been returned for new submission.Contact to the concerned agency for further information and clarification. ";
            //SendSMS.sendBulkSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO, SmsText);
	response.sendRedirect("close.jsp");
	        
			}
			}catch (Exception e) {
				out.print(e.toString());
				
			}
			
			
			%>
      
 </form>
</body>
</html>