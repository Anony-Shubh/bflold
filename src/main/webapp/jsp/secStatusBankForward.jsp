<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="in.gov.mgov.mobileseva.SendSMS"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>



<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script language="javascript">
function submit_form () {
 document.form.ins.value='I'; 
 document.form.submit()
}

</script>
</head>
<body>
<form   name="form" id ="form" method="post" >
<%
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String msgStr="";
String OFF_CD = (String) session.getAttribute("off_cd");
if (OFF_CD.equals("")){
response.sendRedirect("loginPage.jsp");
}
String ACT_ID = "";
String MTG_ID = "";
String APP_NAME = "";
String ACTIVITY_NAME = "";
String PROD_DESC = "";
String PROP_CE = "";
String PROP_WC = "";
String PROP_PROJ_TOTAL = "";
String MT_DATE = "";
String ONLINE_SUBDT = "";
String FORD_DT_DLTFC = "";
String UNIT_DIST = "";
String MTG_PLACE = "";
String MTG_DIST = "";
String ACT_DESC = "";
String AGENCY_REMARKS="";
String DLTFC_REMARK="";

String DLTFC_CE = "";
String DLTFC_WC = "";
String BANK_DISTRICT = "";
String BRANCH_NAME = "";
String BANK_F_DATE = "";
String BANK_NAME = "";
String BANK_POST_ADDR = "";
String IFSC_CODE = "";
String EMAIL = "";
String DLTFC_TOTAL="";
String MOB_NO1="";
String ACT_YN="";

DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT"      );
qrysb.append("   AD.APP_ID,"      );
qrysb.append("   AD.ACT_ID,AD.MOB_NO1,"      );
qrysb.append("   UPPER(AD.APP_NAME) AS APP_NAME,AD.REMARKS AS AGENCY_REMARKS,"      );
qrysb.append("   AM.ACTIVITY_NAME,AD.PROD_DESC,  "      );
qrysb.append("   NVL(AD.MACHINARY_COST,0) AS PROP_CE,"      );
qrysb.append("   NVL(AD.WORKING_CAPITAL,0) AS PROP_WC,"      );
qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS PROP_PROJ_TOTAL,"      );

qrysb.append("   to_Char(AD.ONLINE_SUBDT,'dd-mon-yyyy') as ONLINE_SUBDT,"      );

qrysb.append("   B.DISTRICT_NAME AS UNIT_DIST,"      );

qrysb.append("  AD.BANK_DISTRICT, " );
 qrysb.append("   AD.BRANCH_NAME, " );
 qrysb.append("   AD.BANK_F_DATE, " );
  qrysb.append("  AD.BANK_NAME, " );
 qrysb.append("   AD.BANK_POST_ADDR, " );
 qrysb.append("   AD.IFSC_CODE, EMAIL," );
qrysb.append("   ASM.ACT_DESC   "      );
qrysb.append("   FROM  RBIBANKLIST RBL, M_DISTRICT B,APP_DETAIL_SECOND AD, "      );
qrysb.append("   APP_STATUS_MAST ASM, M_DISTRICT UMD,ACTIVITY_MAST AM"      );
qrysb.append("   WHERE AD.OFF_CD=?"      );
qrysb.append("   AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AD.APP_ID=? AND  AD.IFSC_CODE = RBL.IFSC_CODE"  );
qrysb.append("   AND AD.ACT_ID=ASM.ACT_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD=UMD.DISTRICT_CD"      );


//out.print (qrysb.toString());
List valuesq = new ArrayList();
valuesq.add(OFF_CD);
valuesq.add(APP_ID);

   ResultSet rsApp = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

while (rsApp.next()){

APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");

APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC");
PROP_CE=rsApp.getString("PROP_CE")==null?"":rsApp.getString("PROP_CE");
PROP_WC=rsApp.getString("PROP_WC")==null?"":rsApp.getString("PROP_WC");
PROP_PROJ_TOTAL=rsApp.getString("PROP_PROJ_TOTAL")==null?"":rsApp.getString("PROP_PROJ_TOTAL");

ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");

UNIT_DIST=rsApp.getString("UNIT_DIST")==null?"":rsApp.getString("UNIT_DIST");

ACT_DESC=rsApp.getString("ACT_DESC")==null?"":rsApp.getString("ACT_DESC");
AGENCY_REMARKS=rsApp.getString("AGENCY_REMARKS")==null?"":rsApp.getString("AGENCY_REMARKS");


BANK_DISTRICT=rsApp.getString("BANK_DISTRICT")==null?"":rsApp.getString("BANK_DISTRICT");
BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");
BANK_F_DATE=rsApp.getString("BANK_F_DATE")==null?"":rsApp.getString("BANK_F_DATE");
BANK_NAME=rsApp.getString("BANK_NAME")==null?"":rsApp.getString("BANK_NAME");
BANK_POST_ADDR=rsApp.getString("BANK_POST_ADDR")==null?"":rsApp.getString("BANK_POST_ADDR");
IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
EMAIL=rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");

MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
}

rsApp.close();
%>
  <div>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">Foward to Bank Status Updation </div></th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins">
        Applicant Id :        </th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr >
      <th>Industry/Activity:</th>
      <th colspan="3"><%=ACTIVITY_NAME %> (<%=PROD_DESC %>) </th>
    </tr>
    <tr >
      <th rowspan="2">Proposed Project Cost by Applicant: </th>
      <th><div align="center">Capital Expenditure (CE) </div></th>
      <th><div align="center">Working Capital (WC) </div></th>
      <th><div align="center">Total (CE+WC)</div></th>
    </tr>
    <tr >
      <td><div align="center">Rs. <%=  PROP_CE %></div></td>
      <td><div align="center">Rs.<%=  PROP_WC %></div></td>
      <td><div align="center">Rs.<%=  PROP_PROJ_TOTAL  %></div></td>
    </tr>
    
    
    
    <tr>
      <th>Forwarding Date to Bank: </th>
      <th colspan="3">
	  <%
	  if (BANK_F_DATE.equals("")) {
	  %>
	   <input name="Button" type="button" class="button"  onClick="submit_form();" value="Forward to Bank">
	  <%
	  }else{
	  out.print (BANK_F_DATE);
	  }
	 
	  %>	  </th>
    </tr>
    <tr>
      <th>IFS Code: </th>
      <td colspan="3"><%= IFSC_CODE %></td>
    </tr>
    <tr>
      <th>Bank Name: </th>
      <td colspan="3"><%= BANK_NAME %></td>
    </tr>
    <tr>
      <th>Branch Name </th>
      <td colspan="3"><%= BRANCH_NAME %></td>
    </tr>
    <tr>
      <th>Bank Address: </th>
      <td colspan="3"><%= BANK_POST_ADDR %></td>
    </tr>
    <tr>
      <th>District:</th>
      <td colspan="3"><%= BANK_DISTRICT %></td>
    </tr>
    <tr>
      <th>Bank eMail Id: </th>
      <td colspan="3"><%= EMAIL %></td>
    </tr>
    
    <tr>
      <th colspan="4"><div align="center"><span class="redLebel">(Note: On Change of Status, Automatically message will be sent to applicant and Financing Branch through SMS/eMail) </span></div></th>
    </tr>
  
     <input name="APPID" type="hidden" value="<%=APP_ID%>" id="APPID"/>
   <input name="APP_NM" type="hidden" value="<%=APP_NAME%>" id="APP_NM"/>
   <input name="IFSC" type="hidden" value="<%=IFSC_CODE%>" id="IFSC"/>
   <input name="MOBNO" type="hidden" value="<%=MOB_NO1%>" id="MOBNO"/> 
    
 <%

if ((String)request.getParameter("ins")!=null){


APP_NAME=(String) request.getParameter("APP_NM")==null?"":(String) request.getParameter("APP_NM").trim();
APP_ID=(String) request.getParameter("APPID")==null?"":(String) request.getParameter("APPID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"2":(String) request.getParameter("ACT_ID").trim();
IFSC_CODE=(String) request.getParameter("IFSC")==null?"0":(String) request.getParameter("IFSC").trim();
MOB_NO1=(String) request.getParameter("MOBNO")==null?"0":(String) request.getParameter("MOBNO").trim();
//out.print(APP_ID);


	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qrybank = new StringBuffer();
qrybank.append("  SELECT ACT_YN FROM RBIBANKLIST WHERE IFSC_CODE='"+IFSC_CODE+"' ");

 ResultSet rsbank = db.execSQL(qrybank.toString());
  
while (rsbank.next()){

ACT_YN=rsbank.getString("ACT_YN")==null?"":rsbank.getString("ACT_YN");
}
out.print(ACT_YN);
if (ACT_YN.equals("Y")){

			StringBuffer qryUpdate = new StringBuffer();
String vTodayDt ="";

qryUpdate.append(" UPDATE APP_DETAIL_SECOND SET ACT_ID=5,BANK_F_DATE =SYSDATE  WHERE APP_ID=? ");

values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
if(MOB_NO1.length()==10){
//out.print(MOB_NO1);

String sms_string="Dear "+APP_NAME+"  your PMEGP application "+APP_ID +" has been forwarded online to Your Financing Branch ("+IFSC_CODE+"). Contact Your Financing Bank. - KVIC";
//String sms_string="Dear "+APP_NAME+"  your PMEGP application "+APP_ID +" has been forwarded online to Financing Branch ("+IFSC_CODE+") as per your application.Please contact the //branch Manager.- KVIC" ;
	//SendSMS.sendSingleSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO1, sms_string);
	 //SMSServices.sendSingleSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO1, sms_string);
	 // SMSServices sms1=new SMSServices();
	  SMSServices sms1=new SMSServices();	 
	try {
     String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007712276697694958");	
}catch (Exception e) {}

	// SendSMS.sendSingleSMS("KVICDIT", "Panda@1974", "KVICIT", MOBNO, sms_string);
    // sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d");
	 
	 
}
db.close();
response.sendRedirect("savemsg.jsp");
}

else {
	msgStr="Above Selected Bank is Closed...Please Select another Bank and Forward.";
}}
%>
  <tr>
      <th colspan="4"><div align="center"></div></th>
    </tr>
	
	  <tr>
	    <th colspan="4" class="warning"> <div align="center"><%=msgStr%></div></th>
    </tr>
	  <tr> 
	  <th colspan="4"> <div align="center">
          <input name="Button2" type="button" class="button" tabindex="42" onClick="" value="Cancel">
          
      </div></th>
    </tr>
  </table>
</form>
</body>
</html>
